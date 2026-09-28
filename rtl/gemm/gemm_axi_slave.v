`timescale 1ns / 1ps

module gemm_axi_slave #(
    parameter ADDR_WIDTH = 16,
    parameter DATA_WIDTH = 32
)(
    input  wire                    clk,
    input  wire                    rst_n,

    // AXI4-Lite Write Address Channel
    input  wire [ADDR_WIDTH-1:0]   s_axi_awaddr,
    input  wire                    s_axi_awvalid,
    output reg                     s_axi_awready,

    // AXI4-Lite Write Data Channel
    input  wire [DATA_WIDTH-1:0]   s_axi_wdata,
    input  wire [3:0]              s_axi_wstrb,
    input  wire                    s_axi_wvalid,
    output reg                     s_axi_wready,

    // AXI4-Lite Write Response Channel
    output reg  [1:0]              s_axi_bresp,
    output reg                     s_axi_bvalid,
    input  wire                    s_axi_bready,

    // AXI4-Lite Read Address Channel
    input  wire [ADDR_WIDTH-1:0]   s_axi_araddr,
    input  wire                    s_axi_arvalid,
    output reg                     s_axi_arready,

    // AXI4-Lite Read Data Channel
    output reg  [DATA_WIDTH-1:0]   s_axi_rdata,
    output reg  [1:0]              s_axi_rresp,
    output reg                     s_axi_rvalid,
    input  wire                    s_axi_rready
);

    // Control & Status Registers
    reg [31:0] ctrl_reg;
    wire [31:0] status_reg;
    wire [31:0] cycle_cnt_wire;
    wire        busy_wire;
    wire        done_wire;

    assign status_reg = {30'd0, done_wire, busy_wire};

    // Internal RAM Arrays: 64 words (256 bytes) each for INT8 matrices A and B
    reg [31:0] mat_a_ram [0:63];
    reg [31:0] mat_b_ram [0:63];
    wire [16*16*32-1:0] mat_c_flat;

    // AXI4-Lite Write Channel Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_axi_awready <= 1'b0;
            s_axi_wready  <= 1'b0;
            s_axi_bvalid  <= 1'b0;
            s_axi_bresp   <= 2'b00;
            ctrl_reg      <= 32'd0;
        end else begin
            if (~s_axi_awready && s_axi_awvalid && ~s_axi_wready && s_axi_wvalid) begin
                s_axi_awready <= 1'b1;
                s_axi_wready  <= 1'b1;
            end else begin
                s_axi_awready <= 1'b0;
                s_axi_wready  <= 1'b0;
            end

            if (s_axi_awready && s_axi_awvalid && s_axi_wready && s_axi_wvalid) begin
                s_axi_bvalid <= 1'b1;
                s_axi_bresp  <= 2'b00;

                case (s_axi_awaddr[15:12])
                    4'h0: begin
                        if (s_axi_awaddr[7:0] == 8'h00)
                            ctrl_reg <= s_axi_wdata;
                    end
                    // Prevent memory corruption if CPU writes while hardware GEMM is running
                    4'h1: if (!busy_wire) mat_a_ram[s_axi_awaddr[7:2]] <= s_axi_wdata;
                    4'h2: if (!busy_wire) mat_b_ram[s_axi_awaddr[7:2]] <= s_axi_wdata;
                    default: ;
                endcase
            end else if (s_axi_bready && s_axi_bvalid) begin
                s_axi_bvalid <= 1'b0;
            end

            // Self-clearing start pulse
            if (ctrl_reg[0])
                ctrl_reg[0] <= 1'b0;
        end
    end

    // AXI4-Lite Read Channel Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_axi_arready <= 1'b0;
            s_axi_rvalid  <= 1'b0;
            s_axi_rresp   <= 2'b00;
            s_axi_rdata   <= 32'd0;
        end else begin
            if (~s_axi_arready && s_axi_arvalid) begin
                s_axi_arready <= 1'b1;
            end else begin
                s_axi_arready <= 1'b0;
            end

            if (s_axi_arready && s_axi_arvalid) begin
                s_axi_rvalid <= 1'b1;
                s_axi_rresp  <= 2'b00;

                case (s_axi_araddr[15:12])
                    4'h0: begin
                        case (s_axi_araddr[7:0])
                            8'h00: s_axi_rdata <= ctrl_reg;
                            8'h04: s_axi_rdata <= status_reg;
                            8'h08: s_axi_rdata <= cycle_cnt_wire;
                            default: s_axi_rdata <= 32'hDEAD_BEEF;
                        endcase
                    end
                    4'h1: s_axi_rdata <= mat_a_ram[s_axi_araddr[7:2]];
                    4'h2: s_axi_rdata <= mat_b_ram[s_axi_araddr[7:2]];
                    4'h3: s_axi_rdata <= mat_c_flat[s_axi_araddr[9:2]*32 +: 32];
                    default: s_axi_rdata <= 32'h0000_0000;
                endcase
            end else if (s_axi_rready && s_axi_rvalid) begin
                s_axi_rvalid <= 1'b0;
            end
        end
    end

    // Matrix Streaming & Input Vector Packing
    reg [3:0] fetch_idx;
    reg [127:0] active_row_in;
    reg [127:0] active_col_in;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            fetch_idx     <= 4'd0;
            active_row_in <= 128'd0;
            active_col_in <= 128'd0;
        end else if (ctrl_reg[0]) begin
            fetch_idx     <= 4'd0;
            active_row_in <= 128'd0;
            active_col_in <= 128'd0;
        end else if (busy_wire) begin
            if (fetch_idx < 4'd15)
                fetch_idx <= fetch_idx + 4'd1;

            // Pack 16 elements (4 words x 4 bytes) for Row A and Col B into 128-bit streaming vectors
            active_row_in <= {
                mat_a_ram[{fetch_idx, 2'b11}],
                mat_a_ram[{fetch_idx, 2'b10}],
                mat_a_ram[{fetch_idx, 2'b01}],
                mat_a_ram[{fetch_idx, 2'b00}]
            };

            active_col_in <= {
                mat_b_ram[{fetch_idx, 2'b11}],
                mat_b_ram[{fetch_idx, 2'b10}],
                mat_b_ram[{fetch_idx, 2'b01}],
                mat_b_ram[{fetch_idx, 2'b00}]
            };
        end else begin
            active_row_in <= 128'd0;
            active_col_in <= 128'd0;
        end
    end

    // Systolic Core Instance
    gemm_systolic_core #(.DIM(16)) core_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start(ctrl_reg[0]),
        .clear_acc(ctrl_reg[2]),
        .row_in(active_row_in),
        .col_in(active_col_in),
        .busy(busy_wire),
        .done(done_wire),
        .cycle_cnt(cycle_cnt_wire),
        .mat_c_flat(mat_c_flat)
    );

endmodule
