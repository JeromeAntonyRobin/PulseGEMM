`timescale 1ns / 1ps

module gemm_dma_top #(
    parameter AXI_ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 32,
    parameter M_AXI_DATA_WIDTH = 64
)(
    input  wire                         clk,
    input  wire                         rst_n,

    // AXI4-Lite Slave Interface
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

    // AXI4 Master Interface
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
    output reg  [M_AXI_DATA_WIDTH-1:0]  m_axi_wdata,
    output wire [7:0]                   m_axi_wstrb,
    output reg                          m_axi_wlast,
    output reg                          m_axi_wvalid,
    input  wire                         m_axi_wready,
    input  wire [1:0]                   m_axi_bresp,
    input  wire                         m_axi_bvalid,
    output reg                          m_axi_bready,

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
    input  wire [M_AXI_DATA_WIDTH-1:0]  m_axi_rdata,
    input  wire [1:0]                   m_axi_rresp,
    input  wire                         m_axi_rlast,
    input  wire                         m_axi_rvalid,
    output reg                          m_axi_rready,

    output reg                          irq,
    output wire                         led_busy,
    output wire                         led_done
);

    assign m_axi_awsize  = 3'b011; // 8 bytes
    assign m_axi_awburst = 2'b01;  // INCR
    assign m_axi_awlock  = 1'b0;
    assign m_axi_awcache = 4'b0011;
    assign m_axi_awprot  = 3'b000;
    assign m_axi_awqos   = 4'b0000;
    assign m_axi_wstrb   = 8'hFF;

    assign m_axi_arsize  = 3'b011; // 8 bytes
    assign m_axi_arburst = 2'b01;  // INCR
    assign m_axi_arlock  = 1'b0;
    assign m_axi_arcache = 4'b0011;
    assign m_axi_arprot  = 3'b000;
    assign m_axi_arqos   = 4'b0000;

    // Registers
    reg [31:0] ctrl_reg;
    reg [31:0] src_addr_a_reg;
    reg [31:0] src_addr_b_reg;
    reg [31:0] dst_addr_c_reg;
    reg [15:0] stride_a_reg;
    reg [15:0] stride_b_reg;
    reg [15:0] stride_c_reg;
    reg [31:0] bounds_reg;

    reg        dma_busy;
    reg        dma_done;
    reg        dma_err;

    wire [4:0] tile_M = bounds_reg[20:16];
    wire [15:0] k_total = bounds_reg[15:0]; // redefined to K_TOTAL
    wire [4:0] tile_N = bounds_reg[28:24];

    assign led_busy = dma_busy;
    assign led_done = dma_done;

    reg [31:0] perf_fetch_a_cycles;
    reg [31:0] perf_fetch_b_cycles;
    reg [31:0] perf_compute_cycles;
    reg [31:0] perf_store_c_cycles;

    // AXI Lite Logic (Unchanged)
    always @(posedge clk) begin
        if (!rst_n) begin
            s_axi_awready <= 1'b0;
            s_axi_wready  <= 1'b0;
            s_axi_bvalid  <= 1'b0;
            s_axi_arready <= 1'b0;
            s_axi_rvalid  <= 1'b0;
            ctrl_reg <= 0;
            src_addr_a_reg <= 0;
            src_addr_b_reg <= 0;
            dst_addr_c_reg <= 0;
            stride_a_reg <= 0;
            stride_b_reg <= 0;
            stride_c_reg <= 0;
            bounds_reg <= 0;
        end else begin
            if (ctrl_reg[3]) begin
                perf_fetch_a_cycles <= 0;
                perf_fetch_b_cycles <= 0;
                perf_compute_cycles <= 0;
                perf_store_c_cycles <= 0;
                ctrl_reg[3] <= 1'b0;
            end
            
            if (s_axi_awvalid && s_axi_wvalid && !s_axi_awready && !s_axi_wready) begin
                s_axi_awready <= 1'b1;
                s_axi_wready  <= 1'b1;
                s_axi_bvalid  <= 1'b1;
                s_axi_bresp   <= 2'b00;
                case (s_axi_awaddr[7:0])
                    8'h00: ctrl_reg <= s_axi_wdata;
                    8'h08: src_addr_a_reg <= s_axi_wdata;
                    8'h0C: src_addr_b_reg <= s_axi_wdata;
                    8'h10: dst_addr_c_reg <= s_axi_wdata;
                    8'h14: stride_a_reg <= s_axi_wdata[15:0];
                    8'h18: stride_b_reg <= s_axi_wdata[15:0];
                    8'h1C: stride_c_reg <= s_axi_wdata[15:0];
                    8'h20: bounds_reg <= s_axi_wdata;
                endcase
            end else begin
                s_axi_awready <= 1'b0;
                s_axi_wready  <= 1'b0;
                if (s_axi_bvalid && s_axi_bready) s_axi_bvalid <= 1'b0;
            end

            if (s_axi_arvalid && !s_axi_arready) begin
                s_axi_arready <= 1'b1;
                s_axi_rvalid  <= 1'b1;
                s_axi_rresp   <= 2'b00;
                case (s_axi_araddr[7:0])
                    8'h00: s_axi_rdata <= ctrl_reg;
                    8'h04: s_axi_rdata <= {29'd0, dma_done, dma_err, dma_busy};
                    8'h08: s_axi_rdata <= src_addr_a_reg;
                    8'h0C: s_axi_rdata <= src_addr_b_reg;
                    8'h10: s_axi_rdata <= dst_addr_c_reg;
                    8'h14: s_axi_rdata <= perf_fetch_a_cycles;
                    8'h18: s_axi_rdata <= perf_fetch_b_cycles;
                    8'h1C: s_axi_rdata <= perf_compute_cycles;
                    8'h20: s_axi_rdata <= perf_store_c_cycles;
                    default: s_axi_rdata <= 32'd0;
                endcase
            end else begin
                s_axi_arready <= 1'b0;
                if (s_axi_rvalid && s_axi_rready) s_axi_rvalid <= 1'b0;
            end

            if (ctrl_reg[0]) ctrl_reg[0] <= 1'b0;
        end
    end

    // Ping-Pong Buffers
    reg [7:0] buf_a_ping [0:255];
    reg [7:0] buf_a_pong [0:255];
    reg [7:0] buf_b_ping [0:255];
    reg [7:0] buf_b_pong [0:255];

    // Systolic Array
    reg         core_start;
    reg         core_clear_acc;
    wire        core_busy;
    wire        core_done;
    wire [31:0] core_cycle_cnt;
    wire [16*16*32-1:0] mat_c_flat;

    reg [127:0] active_row_in;
    reg [127:0] active_col_in;
    
    reg comp_buf_sel; // 0: ping, 1: pong
    
    integer r_i, c_i;
    always @(*) begin
        if (core_busy && (core_cycle_cnt < 32'd16)) begin
            for (r_i = 0; r_i < 16; r_i = r_i + 1) begin
                if (comp_buf_sel == 1'b0)
                    active_row_in[r_i*8 +: 8] = buf_a_ping[r_i*16 + core_cycle_cnt[3:0]];
                else
                    active_row_in[r_i*8 +: 8] = buf_a_pong[r_i*16 + core_cycle_cnt[3:0]];
            end
            for (c_i = 0; c_i < 16; c_i = c_i + 1) begin
                if (comp_buf_sel == 1'b0)
                    active_col_in[c_i*8 +: 8] = buf_b_ping[core_cycle_cnt[3:0]*16 + c_i];
                else
                    active_col_in[c_i*8 +: 8] = buf_b_pong[core_cycle_cnt[3:0]*16 + c_i];
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

    // Dual FSM Coordination
    reg dma_buf_sel; // 0: ping, 1: pong
    reg [1:0] filled_tiles;
    reg dma_push_req;
    reg comp_pop_req;
    reg compute_all_done;
    
    // K-loop Tracking
    reg [15:0] k_rem_dma;
    reg [15:0] k_rem_comp;
    wire [4:0] cur_tile_k_dma = (k_rem_dma > 16) ? 5'd16 : k_rem_dma[4:0];
    wire [4:0] cur_tile_k_comp = (k_rem_comp > 16) ? 5'd16 : k_rem_comp[4:0];

    always @(posedge clk) begin
        if (!rst_n) begin
            filled_tiles <= 0;
        end else begin
            if (ctrl_reg[0]) begin
                filled_tiles <= 0;
            end else begin
                case ({dma_push_req, comp_pop_req})
                    2'b10: filled_tiles <= filled_tiles + 1'b1;
                    2'b01: filled_tiles <= filled_tiles - 1'b1;
                    default: filled_tiles <= filled_tiles;
                endcase
            end
        end
    end

    // DMA FSM
    reg [3:0] dma_state;
    localparam DMA_IDLE = 0, DMA_FETCH_A_ADDR = 1, DMA_FETCH_A_DATA = 2,
               DMA_FETCH_B_ADDR = 3, DMA_FETCH_B_DATA = 4, DMA_PUSH = 5,
               DMA_WAIT_COMP = 6, DMA_STORE_C_ADDR = 7, DMA_STORE_C_DATA = 8,
               DMA_STORE_C_RESP = 9, DMA_DONE = 10;
               
    reg [4:0] dma_row_cnt;
    reg [3:0] dma_beat_cnt;
    reg [31:0] cur_addr_a;
    reg [31:0] cur_addr_b;

    always @(posedge clk) begin
        if (!rst_n) begin
            dma_state <= DMA_IDLE;
            m_axi_arvalid <= 0;
            m_axi_rready <= 0;
            m_axi_awvalid <= 0;
            m_axi_wvalid <= 0;
            m_axi_bready <= 0;
            dma_busy <= 0;
            dma_done <= 0;
            dma_push_req <= 0;
        end else begin
            dma_push_req <= 0;
            case (dma_state)
                DMA_IDLE: begin
                    if (ctrl_reg[0]) begin // start
                        dma_busy <= 1'b1;
                        dma_done <= 1'b0;
                        k_rem_dma <= k_total;
                        cur_addr_a <= src_addr_a_reg;
                        cur_addr_b <= src_addr_b_reg;
                        dma_buf_sel <= 0;
                        dma_state <= DMA_FETCH_A_ADDR;
                        dma_row_cnt <= 0;
                        
                    end
                end
                
                DMA_FETCH_A_ADDR: begin
                    if (filled_tiles < 2) begin // Space available in ping-pong buffers
                        if (dma_row_cnt < tile_M) begin
                            m_axi_araddr <= cur_addr_a + (dma_row_cnt * stride_a_reg);
                            m_axi_arlen <= (cur_tile_k_dma > 8) ? 8'd1 : 8'd0;
                            m_axi_arvalid <= 1'b1;
                            dma_beat_cnt <= 0;
                            dma_state <= DMA_FETCH_A_DATA;
                        end else begin
                            dma_row_cnt <= 0;
                            dma_state <= DMA_FETCH_B_ADDR;
                        end
                    end
                end
                
                DMA_FETCH_A_DATA: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready <= 1'b1;
                    end
                    if (m_axi_rvalid && m_axi_rready) begin
                        if (dma_buf_sel == 0) begin
                            if (dma_beat_cnt == 0) begin
                                buf_a_ping[dma_row_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_a_ping[dma_row_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_a_ping[dma_row_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_a_ping[dma_row_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_a_ping[dma_row_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_a_ping[dma_row_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_a_ping[dma_row_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_a_ping[dma_row_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_a_ping[dma_row_cnt*16 + 8] <= m_axi_rdata[7:0];
                                buf_a_ping[dma_row_cnt*16 + 9] <= m_axi_rdata[15:8];
                                buf_a_ping[dma_row_cnt*16 + 10] <= m_axi_rdata[23:16];
                                buf_a_ping[dma_row_cnt*16 + 11] <= m_axi_rdata[31:24];
                                buf_a_ping[dma_row_cnt*16 + 12] <= m_axi_rdata[39:32];
                                buf_a_ping[dma_row_cnt*16 + 13] <= m_axi_rdata[47:40];
                                buf_a_ping[dma_row_cnt*16 + 14] <= m_axi_rdata[55:48];
                                buf_a_ping[dma_row_cnt*16 + 15] <= m_axi_rdata[63:56];
                            end
                        end else begin
                            if (dma_beat_cnt == 0) begin
                                buf_a_pong[dma_row_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_a_pong[dma_row_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_a_pong[dma_row_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_a_pong[dma_row_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_a_pong[dma_row_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_a_pong[dma_row_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_a_pong[dma_row_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_a_pong[dma_row_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_a_pong[dma_row_cnt*16 + 8] <= m_axi_rdata[7:0];
                                buf_a_pong[dma_row_cnt*16 + 9] <= m_axi_rdata[15:8];
                                buf_a_pong[dma_row_cnt*16 + 10] <= m_axi_rdata[23:16];
                                buf_a_pong[dma_row_cnt*16 + 11] <= m_axi_rdata[31:24];
                                buf_a_pong[dma_row_cnt*16 + 12] <= m_axi_rdata[39:32];
                                buf_a_pong[dma_row_cnt*16 + 13] <= m_axi_rdata[47:40];
                                buf_a_pong[dma_row_cnt*16 + 14] <= m_axi_rdata[55:48];
                                buf_a_pong[dma_row_cnt*16 + 15] <= m_axi_rdata[63:56];
                            end
                        end
                        
                        if (m_axi_rlast || (dma_beat_cnt == m_axi_arlen)) begin
                            m_axi_rready <= 1'b0;
                            dma_row_cnt <= dma_row_cnt + 5'd1;
                            dma_state <= DMA_FETCH_A_ADDR;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 4'd1;
                        end
                    end
                end

                DMA_FETCH_B_ADDR: begin
                    if (dma_row_cnt < cur_tile_k_dma) begin
                        m_axi_araddr <= cur_addr_b + (dma_row_cnt * stride_b_reg);
                        m_axi_arlen <= (tile_N > 8) ? 8'd1 : 8'd0;
                        m_axi_arvalid <= 1'b1;
                        dma_beat_cnt <= 0;
                        dma_state <= DMA_FETCH_B_DATA;
                    end else begin
                        dma_state <= DMA_PUSH;
                    end
                end

                DMA_FETCH_B_DATA: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready <= 1'b1;
                    end
                    if (m_axi_rvalid && m_axi_rready) begin
                        if (dma_buf_sel == 0) begin
                            if (dma_beat_cnt == 0) begin
                                buf_b_ping[dma_row_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_b_ping[dma_row_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_b_ping[dma_row_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_b_ping[dma_row_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_b_ping[dma_row_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_b_ping[dma_row_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_b_ping[dma_row_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_b_ping[dma_row_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_b_ping[dma_row_cnt*16 + 8] <= m_axi_rdata[7:0];
                                buf_b_ping[dma_row_cnt*16 + 9] <= m_axi_rdata[15:8];
                                buf_b_ping[dma_row_cnt*16 + 10] <= m_axi_rdata[23:16];
                                buf_b_ping[dma_row_cnt*16 + 11] <= m_axi_rdata[31:24];
                                buf_b_ping[dma_row_cnt*16 + 12] <= m_axi_rdata[39:32];
                                buf_b_ping[dma_row_cnt*16 + 13] <= m_axi_rdata[47:40];
                                buf_b_ping[dma_row_cnt*16 + 14] <= m_axi_rdata[55:48];
                                buf_b_ping[dma_row_cnt*16 + 15] <= m_axi_rdata[63:56];
                            end
                        end else begin
                            if (dma_beat_cnt == 0) begin
                                buf_b_pong[dma_row_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_b_pong[dma_row_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_b_pong[dma_row_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_b_pong[dma_row_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_b_pong[dma_row_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_b_pong[dma_row_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_b_pong[dma_row_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_b_pong[dma_row_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_b_pong[dma_row_cnt*16 + 8] <= m_axi_rdata[7:0];
                                buf_b_pong[dma_row_cnt*16 + 9] <= m_axi_rdata[15:8];
                                buf_b_pong[dma_row_cnt*16 + 10] <= m_axi_rdata[23:16];
                                buf_b_pong[dma_row_cnt*16 + 11] <= m_axi_rdata[31:24];
                                buf_b_pong[dma_row_cnt*16 + 12] <= m_axi_rdata[39:32];
                                buf_b_pong[dma_row_cnt*16 + 13] <= m_axi_rdata[47:40];
                                buf_b_pong[dma_row_cnt*16 + 14] <= m_axi_rdata[55:48];
                                buf_b_pong[dma_row_cnt*16 + 15] <= m_axi_rdata[63:56];
                            end
                        end

                        if (m_axi_rlast || (dma_beat_cnt == m_axi_arlen)) begin
                            m_axi_rready <= 1'b0;
                            dma_row_cnt <= dma_row_cnt + 5'd1;
                            dma_state <= DMA_FETCH_B_ADDR;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 4'd1;
                        end
                    end
                end

                DMA_PUSH: begin
                    dma_push_req <= 1'b1;
                    cur_addr_a <= cur_addr_a + 16;
                    cur_addr_b <= cur_addr_b + (16 * stride_b_reg);
                    k_rem_dma <= k_rem_dma - cur_tile_k_dma;
                    dma_buf_sel <= ~dma_buf_sel;
                    dma_row_cnt <= 0;
                    
                    if (k_rem_dma > cur_tile_k_dma) begin
                        dma_state <= DMA_FETCH_A_ADDR;
                    end else begin
                        dma_state <= DMA_WAIT_COMP;
                    end
                end

                DMA_WAIT_COMP: begin
                    if (compute_all_done) begin
                        if (ctrl_reg[2]) begin // Store C requested
                            dma_row_cnt <= 0;
                            dma_state <= DMA_STORE_C_ADDR;
                        end else begin
                            dma_state <= DMA_DONE;
                        end
                    end
                end

                DMA_STORE_C_ADDR: begin
                    if (dma_row_cnt < tile_M) begin
                        m_axi_awaddr <= dst_addr_c_reg + ((dma_row_cnt * stride_c_reg) << 2);
                        m_axi_awlen <= (tile_N > 0) ? ((tile_N + 1) >> 1) - 1 : 8'd0;
                        m_axi_awvalid <= 1'b1;
                        dma_beat_cnt <= 0;
                        m_axi_wdata <= {mat_c_flat[(dma_row_cnt * 16 + 1)*32 +: 32], mat_c_flat[(dma_row_cnt * 16 + 0)*32 +: 32]};
                        m_axi_wlast <= (((tile_N + 1) >> 1) == 1);
                        dma_state <= DMA_STORE_C_DATA;
                    end else begin
                        dma_state <= DMA_DONE;
                    end
                end

                DMA_STORE_C_DATA: begin
                    if (m_axi_awready && m_axi_awvalid) begin
                        m_axi_awvalid <= 1'b0;
                        m_axi_wvalid <= 1'b1;
                    end
                    if (m_axi_wready && m_axi_wvalid) begin
                        if (dma_beat_cnt == m_axi_awlen) begin
                            m_axi_wvalid <= 1'b0;
                            m_axi_wlast <= 1'b0;
                            m_axi_bready <= 1'b1;
                            dma_state <= DMA_STORE_C_RESP;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 4'd1;
                            m_axi_wdata <= {mat_c_flat[(dma_row_cnt * 16 + (dma_beat_cnt + 1)*2 + 1)*32 +: 32],
                                            mat_c_flat[(dma_row_cnt * 16 + (dma_beat_cnt + 1)*2 + 0)*32 +: 32]};
                            m_axi_wlast <= ((dma_beat_cnt + 1) == m_axi_awlen);
                        end
                    end
                end

                DMA_STORE_C_RESP: begin
                    if (m_axi_bvalid && m_axi_bready) begin
                        m_axi_bready <= 1'b0;
                        dma_row_cnt <= dma_row_cnt + 5'd1;
                        dma_state <= DMA_STORE_C_ADDR;
                    end
                end

                DMA_DONE: begin
                    dma_busy <= 1'b0;
                    dma_done <= 1'b1;
                    dma_state <= DMA_IDLE;
                end
            endcase
        end
    end

    // Compute FSM
    reg [2:0] comp_state;
    localparam COMP_IDLE = 0, COMP_WAIT = 1, COMP_START = 2, COMP_RUN = 3, COMP_POP = 4;
    
    always @(posedge clk) begin
        if (!rst_n) begin
            comp_state <= COMP_IDLE;
            comp_pop_req <= 0;
            core_start <= 0;
            core_clear_acc <= 0;
            compute_all_done <= 0;
            comp_buf_sel <= 0;
        end else begin
            comp_pop_req <= 0;
            case (comp_state)
                COMP_IDLE: begin
                    if (ctrl_reg[0]) begin
                        k_rem_comp <= k_total;
                        compute_all_done <= 0;
                        comp_buf_sel <= 0;
                        comp_state <= COMP_WAIT;
                    end
                end
                
                COMP_WAIT: begin
                    if (filled_tiles > 0) begin
                        comp_state <= COMP_START;
                    end
                end
                
                COMP_START: begin
                    core_start <= 1'b1;
                    core_clear_acc <= (k_rem_comp == k_total) ? ctrl_reg[1] : 1'b0;
                    comp_state <= COMP_RUN;
                end
                
                COMP_RUN: begin
                    core_start <= 1'b0;
                    core_clear_acc <= 1'b0;
                    if (core_done) begin
                        comp_state <= COMP_POP;
                    end
                end
                
                COMP_POP: begin
                    comp_pop_req <= 1'b1;
                    k_rem_comp <= k_rem_comp - cur_tile_k_comp;
                    comp_buf_sel <= ~comp_buf_sel;
                    if (k_rem_comp > cur_tile_k_comp) begin
                        comp_state <= COMP_WAIT;
                    end else begin
                        compute_all_done <= 1'b1;
                        comp_state <= COMP_IDLE;
                    end
                end
            endcase
        end
    end

endmodule
