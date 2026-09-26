`timescale 1ns / 1ps

module gemm_dma_top #(
    parameter AXI_ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 32
)(
    input  wire                         clk,
    input  wire                         rst_n,

    // =========================================================================
    // AXI4-Lite Slave Interface (CPU Control from MSS FIC)
    // =========================================================================
    input  wire [AXI_ADDR_WIDTH-1:0]    s_axi_awaddr,
    input  wire                         s_axi_awvalid,
    output reg                          s_axi_awready,

    input  wire [AXI_DATA_WIDTH-1:0]    s_axi_wdata,
    input  wire [3:0]                   s_axi_wstrb,
    input  wire                         s_axi_wvalid,
    output reg                          s_axi_wready,

    output reg  [1:0]                   s_axi_bresp,
    output reg                          s_axi_bvalid,
    input  wire                         s_axi_bready,

    input  wire [AXI_ADDR_WIDTH-1:0]    s_axi_araddr,
    input  wire                         s_axi_arvalid,
    output reg                          s_axi_arready,

    output reg  [AXI_DATA_WIDTH-1:0]    s_axi_rdata,
    output reg  [1:0]                   s_axi_rresp,
    output reg                          s_axi_rvalid,
    input  wire                         s_axi_rready,

    // =========================================================================
    // AXI4 Master Interface (DMA to PolarFire SoC DDR Memory)
    // =========================================================================
    // Write Address Channel
    output reg  [AXI_ADDR_WIDTH-1:0]    m_axi_awaddr,
    output reg  [7:0]                   m_axi_awlen,
    output wire [2:0]                   m_axi_awsize,
    output wire [1:0]                   m_axi_awburst,
    output wire                         m_axi_awlock,
    output wire [3:0]                   m_axi_awcache,
    output wire [2:0]                   m_axi_awprot,
    output wire [3:0]                   m_axi_awqos,
    output reg                          m_axi_awvalid,
    input  wire                         m_axi_awready,

    // Write Data Channel
    output reg  [AXI_DATA_WIDTH-1:0]    m_axi_wdata,
    output wire [3:0]                   m_axi_wstrb,
    output reg                          m_axi_wlast,
    output reg                          m_axi_wvalid,
    input  wire                         m_axi_wready,

    // Write Response Channel
    input  wire [1:0]                   m_axi_bresp,
    input  wire                         m_axi_bvalid,
    output reg                          m_axi_bready,

    // Read Address Channel
    output reg  [AXI_ADDR_WIDTH-1:0]    m_axi_araddr,
    output reg  [7:0]                   m_axi_arlen,
    output wire [2:0]                   m_axi_arsize,
    output wire [1:0]                   m_axi_arburst,
    output wire                         m_axi_arlock,
    output wire [3:0]                   m_axi_arcache,
    output wire [2:0]                   m_axi_arprot,
    output wire [3:0]                   m_axi_arqos,
    output reg                          m_axi_arvalid,
    input  wire                         m_axi_arready,

    // Read Data Channel
    input  wire [AXI_DATA_WIDTH-1:0]    m_axi_rdata,
    input  wire [1:0]                   m_axi_rresp,
    input  wire                         m_axi_rlast,
    input  wire                         m_axi_rvalid,
    output reg                          m_axi_rready,

    // =========================================================================
    // Interrupt and Board Status
    // =========================================================================
    output reg                          irq,
    output wire                         led_busy,
    output wire                         led_done
);

    // Constant AXI attributes (INCR burst, 4-byte size)
    assign m_axi_awsize  = 3'b010; // 4 bytes (32-bit)
    assign m_axi_awburst = 2'b01;  // INCR
    assign m_axi_awlock  = 1'b0;
    assign m_axi_awcache = 4'b0011;
    assign m_axi_awprot  = 3'b000;
    assign m_axi_awqos   = 4'b0000;
    assign m_axi_wstrb   = 4'hF;

    assign m_axi_arsize  = 3'b010; // 4 bytes (32-bit)
    assign m_axi_arburst = 2'b01;  // INCR
    assign m_axi_arlock  = 1'b0;
    assign m_axi_arcache = 4'b0011;
    assign m_axi_arprot  = 3'b000;
    assign m_axi_arqos   = 4'b0000;

    // =========================================================================
    // Control & Status Registers
    // =========================================================================
    reg [31:0] ctrl_reg;       // [0]: start, [1]: irq_en, [2]: accum_en
    reg [31:0] src_addr_a_reg; // DDR address of Matrix A (256 bytes)
    reg [31:0] src_addr_b_reg; // DDR address of Matrix B (256 bytes)
    reg [31:0] dst_addr_c_reg; // DDR address of Matrix C (1024 bytes)
    reg [31:0] hw_cycle_cnt;   // Timer for performance benchmarking
    reg        dma_busy;
    reg        dma_done;
    reg        dma_err;

    wire [31:0] status_reg = {29'd0, dma_err, dma_done, dma_busy};

    assign led_busy = dma_busy;
    assign led_done = dma_done;

    // Internal SRAMs (64 x 32-bit = 256 bytes each for A and B)
    reg [31:0] mat_a_mem [0:63];
    reg [31:0] mat_b_mem [0:63];
    wire [16*16*32-1:0] mat_c_flat;

    // =========================================================================
    // AXI4-Lite Slave Logic (Register Read/Write)
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_axi_awready   <= 1'b0;
            s_axi_wready    <= 1'b0;
            s_axi_bvalid    <= 1'b0;
            s_axi_bresp     <= 2'b00;
            ctrl_reg        <= 32'd0;
            src_addr_a_reg  <= 32'd0;
            src_addr_b_reg  <= 32'd0;
            dst_addr_c_reg  <= 32'd0;
        end else begin
            // Write Address & Data handshake
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
                        case (s_axi_awaddr[7:0])
                            8'h00: ctrl_reg       <= s_axi_wdata;
                            8'h08: src_addr_a_reg <= s_axi_wdata;
                            8'h0C: src_addr_b_reg <= s_axi_wdata;
                            8'h10: dst_addr_c_reg <= s_axi_wdata;
                            default: ;
                        endcase
                    end
                    // Optional direct MMIO access to internal buffers when DMA idle
                    4'h1: if (!dma_busy) mat_a_mem[s_axi_awaddr[7:2]] <= s_axi_wdata;
                    4'h2: if (!dma_busy) mat_b_mem[s_axi_awaddr[7:2]] <= s_axi_wdata;
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

    // Slave Read Channel
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
                            8'h08: s_axi_rdata <= src_addr_a_reg;
                            8'h0C: s_axi_rdata <= src_addr_b_reg;
                            8'h10: s_axi_rdata <= dst_addr_c_reg;
                            8'h14: s_axi_rdata <= hw_cycle_cnt;
                            default: s_axi_rdata <= 32'hDEAD_BEEF;
                        endcase
                    end
                    4'h1: s_axi_rdata <= mat_a_mem[s_axi_araddr[7:2]];
                    4'h2: s_axi_rdata <= mat_b_mem[s_axi_araddr[7:2]];
                    4'h3: s_axi_rdata <= mat_c_flat[s_axi_araddr[9:2]*32 +: 32];
                    default: s_axi_rdata <= 32'h0000_0000;
                endcase
            end else if (s_axi_rready && s_axi_rvalid) begin
                s_axi_rvalid <= 1'b0;
            end
        end
    end

    // =========================================================================
    // Systolic Core Streaming Logic
    // =========================================================================
    reg         core_start;
    reg         core_clear_acc;
    wire        core_busy;
    wire        core_done;
    wire [31:0] core_cycle_cnt;
    reg [127:0] active_row_in;
    reg [127:0] active_col_in;

    // Extract column 'core_cycle_cnt' from Matrix A and row 'core_cycle_cnt' from Matrix B
    integer r_idx, c_idx;
    always @(*) begin
        if (core_busy && (core_cycle_cnt < 32'd16)) begin
            for (r_idx = 0; r_idx < 16; r_idx = r_idx + 1) begin
                active_row_in[r_idx*8 +: 8] = mat_a_mem[(r_idx << 2) | (core_cycle_cnt[3:2])][core_cycle_cnt[1:0]*8 +: 8];
            end
            for (c_idx = 0; c_idx < 16; c_idx = c_idx + 1) begin
                active_col_in[c_idx*8 +: 8] = mat_b_mem[(core_cycle_cnt << 2) | (c_idx >> 2)][c_idx[1:0]*8 +: 8];
            end
        end else begin
            active_row_in = 128'd0;
            active_col_in = 128'd0;
        end
    end

    gemm_systolic_core #(.DIM(16)) u_core (
        .clk(clk),
        .rst_n(rst_n),
        .start(core_start),
        .clear_acc(core_clear_acc),
        .row_in(active_row_in),
        .col_in(active_col_in),
        .busy(core_busy),
        .done(core_done),
        .cycle_cnt(core_cycle_cnt),
        .mat_c_flat(mat_c_flat)
    );

    // =========================================================================
    // AXI4 Master DMA State Machine
    // =========================================================================
    localparam S_IDLE            = 4'd0;
    localparam S_READ_A_ADDR     = 4'd1;
    localparam S_READ_A_DATA     = 4'd2;
    localparam S_READ_B_ADDR     = 4'd3;
    localparam S_READ_B_DATA     = 4'd4;
    localparam S_COMPUTE_START   = 4'd5;
    localparam S_COMPUTE_RUN     = 4'd6;
    localparam S_WRITE_C_ADDR    = 4'd7;
    localparam S_WRITE_C_DATA    = 4'd8;
    localparam S_WRITE_C_RESP    = 4'd9;
    localparam S_DONE            = 4'd10;

    reg [3:0] state;
    reg [5:0] word_idx;   // 0 to 63 beats per burst
    reg [1:0] burst_idx;  // 4 bursts for Matrix C (4 x 64 = 256 words)

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= S_IDLE;
            m_axi_arvalid  <= 1'b0;
            m_axi_araddr   <= 32'd0;
            m_axi_arlen    <= 8'd0;
            m_axi_rready   <= 1'b0;
            m_axi_awvalid  <= 1'b0;
            m_axi_awaddr   <= 32'd0;
            m_axi_awlen    <= 8'd0;
            m_axi_wvalid   <= 1'b0;
            m_axi_wdata    <= 32'd0;
            m_axi_wlast    <= 1'b0;
            m_axi_bready   <= 1'b0;
            dma_busy       <= 1'b0;
            dma_done       <= 1'b0;
            dma_err        <= 1'b0;
            irq            <= 1'b0;
            hw_cycle_cnt   <= 32'd0;
            core_start     <= 1'b0;
            core_clear_acc <= 1'b0;
            word_idx       <= 6'd0;
            burst_idx      <= 2'd0;
        end else begin
            case (state)
                S_IDLE: begin
                    core_start <= 1'b0;
                    if (ctrl_reg[0]) begin // START pulse
                        dma_busy     <= 1'b1;
                        dma_done     <= 1'b0;
                        dma_err      <= 1'b0;
                        irq          <= 1'b0;
                        hw_cycle_cnt <= 32'd0;
                        word_idx     <= 6'd0;

                        // Initiate Burst Read of Matrix A (64 words)
                        m_axi_araddr  <= src_addr_a_reg;
                        m_axi_arlen   <= 8'd63; // 64 beats
                        m_axi_arvalid <= 1'b1;
                        state         <= S_READ_A_ADDR;
                    end
                end

                // -------------------------------------------------------------
                // Phase 1: DMA Read Matrix A
                // -------------------------------------------------------------
                S_READ_A_ADDR: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        state         <= S_READ_A_DATA;
                    end
                end

                S_READ_A_DATA: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_rvalid && m_axi_rready) begin
                        mat_a_mem[word_idx] <= m_axi_rdata;
                        if (m_axi_rlast || (word_idx == 6'd63)) begin
                            m_axi_rready  <= 1'b0;
                            word_idx      <= 6'd0;
                            // Initiate Burst Read of Matrix B (64 words)
                            m_axi_araddr  <= src_addr_b_reg;
                            m_axi_arlen   <= 8'd63; // 64 beats
                            m_axi_arvalid <= 1'b1;
                            state         <= S_READ_B_ADDR;
                        end else begin
                            word_idx <= word_idx + 6'd1;
                        end
                    end
                end

                // -------------------------------------------------------------
                // Phase 2: DMA Read Matrix B
                // -------------------------------------------------------------
                S_READ_B_ADDR: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        state         <= S_READ_B_DATA;
                    end
                end

                S_READ_B_DATA: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_rvalid && m_axi_rready) begin
                        mat_b_mem[word_idx] <= m_axi_rdata;
                        if (m_axi_rlast || (word_idx == 6'd63)) begin
                            m_axi_rready   <= 1'b0;
                            word_idx       <= 6'd0;
                            core_start     <= 1'b1;
                            core_clear_acc <= ~ctrl_reg[2]; // Clear if accum_en == 0
                            state          <= S_COMPUTE_START;
                        end else begin
                            word_idx <= word_idx + 6'd1;
                        end
                    end
                end

                // -------------------------------------------------------------
                // Phase 3: Systolic Array Computation (46 cycles)
                // -------------------------------------------------------------
                S_COMPUTE_START: begin
                    hw_cycle_cnt   <= hw_cycle_cnt + 32'd1;
                    core_start     <= 1'b0;
                    core_clear_acc <= 1'b0;
                    state          <= S_COMPUTE_RUN;
                end

                S_COMPUTE_RUN: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (core_done) begin
                        // Computation complete! Start Burst Write for Matrix C
                        burst_idx     <= 2'd0;
                        word_idx      <= 6'd0;
                        m_axi_awaddr  <= dst_addr_c_reg;
                        m_axi_awlen   <= 8'd63; // 64 beats
                        m_axi_awvalid <= 1'b1;
                        state         <= S_WRITE_C_ADDR;
                    end
                end

                // -------------------------------------------------------------
                // Phase 4: DMA Write Matrix C (4 x 64 beats = 256 words = 1024B)
                // -------------------------------------------------------------
                S_WRITE_C_ADDR: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_awready && m_axi_awvalid) begin
                        m_axi_awvalid <= 1'b0;
                        m_axi_wvalid  <= 1'b1;
                        m_axi_wdata   <= mat_c_flat[(burst_idx*64 + 0)*32 +: 32];
                        m_axi_wlast   <= 1'b0;
                        word_idx      <= 6'd0;
                        state         <= S_WRITE_C_DATA;
                    end
                end

                S_WRITE_C_DATA: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_wready && m_axi_wvalid) begin
                        if (word_idx == 6'd63) begin
                            m_axi_wvalid <= 1'b0;
                            m_axi_wlast  <= 1'b0;
                            m_axi_bready <= 1'b1;
                            state        <= S_WRITE_C_RESP;
                        end else begin
                            word_idx    <= word_idx + 6'd1;
                            m_axi_wdata <= mat_c_flat[(burst_idx*64 + (word_idx + 6'd1))*32 +: 32];
                            m_axi_wlast <= (word_idx + 6'd1 == 6'd63);
                        end
                    end
                end

                S_WRITE_C_RESP: begin
                    hw_cycle_cnt <= hw_cycle_cnt + 32'd1;
                    if (m_axi_bvalid && m_axi_bready) begin
                        m_axi_bready <= 1'b0;
                        if (burst_idx == 2'd3) begin
                            // All 4 bursts finished
                            state <= S_DONE;
                        end else begin
                            burst_idx     <= burst_idx + 2'd1;
                            m_axi_awaddr  <= dst_addr_c_reg + ((burst_idx + 2'd1) << 8); // + 256 bytes (64 words)
                            m_axi_awlen   <= 8'd63;
                            m_axi_awvalid <= 1'b1;
                            state         <= S_WRITE_C_ADDR;
                        end
                    end
                end

                // -------------------------------------------------------------
                // Completion
                // -------------------------------------------------------------
                S_DONE: begin
                    dma_busy <= 1'b0;
                    dma_done <= 1'b1;
                    if (ctrl_reg[1])
                        irq <= 1'b1;
                    state <= S_IDLE;
                end

                default: state <= S_IDLE;
            endcase
        end
    end

endmodule
