`timescale 1ns / 1ps

module gemm_top (
    input  wire clk,         // Physical pin R18
    input  wire rst_n,       // Physical pin T19 (SW1)
    output wire led_busy,    // Physical pin T18 (LED1)
    output wire led_done     // Physical pin V17 (LED2)
);

    // Internal buffered clock
    wire clk_buf;
    CLKINT u_clk_buf (
        .A(clk),
        .Y(clk_buf)
    );

    // Dummy test transaction signals to keep the AXI IP fully alive
    reg [15:0] s_axi_awaddr;
    reg        s_axi_awvalid;
    wire       s_axi_awready;
    reg [31:0] s_axi_wdata;
    reg        s_axi_wvalid;
    wire       s_axi_wready;
    wire [1:0] s_axi_bresp;
    wire       s_axi_bvalid;
    reg        s_axi_bready;

    reg [15:0] s_axi_araddr;
    reg        s_axi_arvalid;
    wire       s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rvalid;
    reg         s_axi_rready;

    // Simple test FSM to auto-trigger GEMM on reset release
    reg [3:0] state;
    always @(posedge clk_buf or negedge rst_n) begin
        if (!rst_n) begin
            state         <= 4'd0;
            s_axi_awaddr  <= 16'd0;
            s_axi_awvalid <= 1'b0;
            s_axi_wdata   <= 32'd0;
            s_axi_wvalid  <= 1'b0;
            s_axi_bready  <= 1'b1;
            s_axi_araddr  <= 16'd0;
            s_axi_arvalid <= 1'b0;
            s_axi_rready  <= 1'b1;
        end else begin
            case (state)
                4'd0: begin // Write START to CTRL_REG (0x0000)
                    s_axi_awaddr  <= 16'h0000;
                    s_axi_awvalid <= 1'b1;
                    s_axi_wdata   <= 32'h0000_0001;
                    s_axi_wvalid  <= 1'b1;
                    if (s_axi_awready && s_axi_wready) begin
                        s_axi_awvalid <= 1'b0;
                        s_axi_wvalid  <= 1'b0;
                        state         <= 4'd1;
                    end
                end
                4'd1: begin // Read STATUS_REG (0x0004)
                    s_axi_araddr  <= 16'h0004;
                    s_axi_arvalid <= 1'b1;
                    if (s_axi_arready) begin
                        s_axi_arvalid <= 1'b0;
                        state         <= 4'd2;
                    end
                end
                default: ;
            endcase
        end
    end

    // Instance of the GEMM AXI core
    gemm_axi_slave u_gemm_axi (
        .clk(clk_buf),
        .rst_n(rst_n),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(4'hF),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready)
    );

    // Map status signals to output pins
    assign led_busy = u_gemm_axi.busy_wire;
    assign led_done = u_gemm_axi.done_wire;

endmodule
