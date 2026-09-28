`timescale 1ns / 1ps

// ==========================================================================
// gemm_dma_top.v - GEMM DMA Top with Burst-Mode Fetch Optimization
// Changes:
//  1. dma_state extended to 5 bits (new burst states 15-18)
//  2. dma_beat_cnt extended to 8 bits (support up to 255 beats per burst)
//  3. B-burst: when stride_b==1, fetch all K rows of B in ONE AR transaction
//     instead of 16 separate ones (~16x fewer AXI handshakes for FC layers)
//  4. A-burst: when stride_a==cur_tile_k_dma (packed A), same optimization
//  5. ping-pong filled_tiles reset on ctrl_reg[0] edge
//  6. Soft-reset (ctrl_reg[4]) preserved from previous revision
// ==========================================================================
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

    // AXI4 Master Interface (64-bit data)
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
    output wire [7:0]                   m_axi_wstrb,   // 8 bytes for 64-bit bus
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

    // Fixed AXI master parameters
    assign m_axi_awsize  = 3'b011; // 8 bytes per beat
    assign m_axi_awburst = 2'b01;  // INCR
    assign m_axi_awlock  = 1'b0;
    assign m_axi_awcache = 4'b0011;
    assign m_axi_awprot  = 3'b000;
    assign m_axi_awqos   = 4'b0000;
    assign m_axi_wstrb   = 8'hFF;  // all 8 bytes valid (64-bit bus, 8 byte-enables)

    assign m_axi_arsize  = 3'b011; // 8 bytes per beat
    assign m_axi_arburst = 2'b01;  // INCR
    assign m_axi_arlock  = 1'b0;
    assign m_axi_arcache = 4'b0011;
    assign m_axi_arprot  = 3'b000;
    assign m_axi_arqos   = 4'b0000;

    // Control / Configuration Registers
    reg [31:0] ctrl_reg;
    reg [31:0] src_addr_a_reg;
    reg [31:0] src_addr_b_reg;
    reg [31:0] dst_addr_c_reg;
    reg [15:0] stride_a_reg;
    reg [15:0] stride_b_reg;
    reg [15:0] stride_c_reg;
    reg [31:0] bounds_reg;
    reg [15:0] tile_n_count_reg;

    reg        dma_busy;
    reg        dma_done;
    reg        dma_err;

    wire [4:0]  tile_M   = bounds_reg[20:16];
    wire [15:0] k_total  = bounds_reg[15:0];
    wire [4:0]  tile_N   = bounds_reg[28:24];

    assign led_busy = dma_busy;
    assign led_done = dma_done;

    // Performance Counters
    reg [31:0] perf_fetch_a_cycles;
    reg [31:0] perf_fetch_b_cycles;
    reg [31:0] perf_compute_cycles;
    reg [31:0] perf_store_c_cycles;

    // -----------------------------------------------------------------------
    // AXI-Lite Slave (Register File Access)
    // -----------------------------------------------------------------------
    always @(posedge clk) begin
        if (!rst_n) begin
            s_axi_awready <= 1'b0;
            s_axi_wready  <= 1'b0;
            s_axi_bvalid  <= 1'b0;
            s_axi_arready <= 1'b0;
            s_axi_rvalid  <= 1'b0;
            ctrl_reg          <= 0;
            src_addr_a_reg    <= 0;
            src_addr_b_reg    <= 0;
            dst_addr_c_reg    <= 0;
            stride_a_reg      <= 0;
            stride_b_reg      <= 0;
            stride_c_reg      <= 0;
            bounds_reg        <= 0;
            tile_n_count_reg  <= 16'd1;
        end else begin
            // Self-clearing control bits
            if (ctrl_reg[3]) ctrl_reg[3] <= 1'b0;
            if (ctrl_reg[4]) ctrl_reg[4] <= 1'b0;

            // Write path
            if (s_axi_awvalid && s_axi_wvalid && !s_axi_awready && !s_axi_wready) begin
                s_axi_awready <= 1'b1;
                s_axi_wready  <= 1'b1;
                s_axi_bvalid  <= 1'b1;
                s_axi_bresp   <= 2'b00;
                case (s_axi_awaddr[7:0])
                    8'h00: ctrl_reg          <= s_axi_wdata;
                    8'h08: src_addr_a_reg    <= s_axi_wdata;
                    8'h0C: src_addr_b_reg    <= s_axi_wdata;
                    8'h10: dst_addr_c_reg    <= s_axi_wdata;
                    8'h14: stride_a_reg      <= s_axi_wdata[15:0];
                    8'h18: stride_b_reg      <= s_axi_wdata[15:0];
                    8'h1C: stride_c_reg      <= s_axi_wdata[15:0];
                    8'h20: bounds_reg        <= s_axi_wdata;
                    8'h24: tile_n_count_reg  <= s_axi_wdata[15:0];
                endcase
            end else begin
                s_axi_awready <= 1'b0;
                s_axi_wready  <= 1'b0;
                if (s_axi_bvalid && s_axi_bready) s_axi_bvalid <= 1'b0;
            end

            // Read path
            if (s_axi_arvalid && !s_axi_arready) begin
                s_axi_arready <= 1'b1;
                s_axi_rvalid  <= 1'b1;
                s_axi_rresp   <= 2'b00;
                case (s_axi_araddr[7:0])
                    8'h00: s_axi_rdata <= ctrl_reg;
                    8'h04: s_axi_rdata <= {k_rem_dma[6:0], dma_row_cnt[4:0],
                                           comp_state[2:0], dma_state[4:0],
                                           filled_tiles[1:0], 7'd0,
                                           dma_done, dma_err, dma_busy};
                    8'h08: s_axi_rdata <= src_addr_a_reg;
                    8'h0C: s_axi_rdata <= src_addr_b_reg;
                    8'h10: s_axi_rdata <= dst_addr_c_reg;
                    8'h14: s_axi_rdata <= perf_fetch_a_cycles;
                    8'h18: s_axi_rdata <= perf_fetch_b_cycles;
                    8'h1C: s_axi_rdata <= perf_compute_cycles;
                    8'h20: s_axi_rdata <= perf_store_c_cycles;
                    8'h24: s_axi_rdata <= {16'd0, tile_n_count_reg};
                    default: s_axi_rdata <= 32'd0;
                endcase
            end else begin
                s_axi_arready <= 1'b0;
                if (s_axi_rvalid && s_axi_rready) s_axi_rvalid <= 1'b0;
            end

            if (ctrl_reg[0]) ctrl_reg[0] <= 1'b0;
        end
    end

    // -----------------------------------------------------------------------
    // Ping-Pong Tile Buffers (256 bytes each = 16 rows × 16 cols of int8)
    // -----------------------------------------------------------------------
    reg [7:0] buf_a_ping [0:255];
    reg [7:0] buf_a_pong [0:255];
    reg [7:0] buf_b_ping [0:255];
    reg [7:0] buf_b_pong [0:255];

    // -----------------------------------------------------------------------
    // Systolic Array Core
    // -----------------------------------------------------------------------
    reg         core_start;
    reg         core_clear_acc;
    wire        core_busy;
    wire        core_done;
    wire [31:0] core_cycle_cnt;
    wire [16*16*32-1:0] mat_c_flat;

    reg [127:0] active_row_in;
    reg [127:0] active_col_in;

    reg comp_buf_sel; // 0=ping, 1=pong

    integer r_i, c_i;
    always @(*) begin
        if (core_busy && (core_cycle_cnt < 32'd16)) begin
            for (r_i = 0; r_i < 16; r_i = r_i + 1)
                active_row_in[r_i*8 +: 8] = (comp_buf_sel == 1'b0)
                    ? buf_a_ping[r_i*16 + core_cycle_cnt[3:0]]
                    : buf_a_pong[r_i*16 + core_cycle_cnt[3:0]];
            for (c_i = 0; c_i < 16; c_i = c_i + 1)
                active_col_in[c_i*8 +: 8] = (comp_buf_sel == 1'b0)
                    ? buf_b_ping[core_cycle_cnt[3:0]*16 + c_i]
                    : buf_b_pong[core_cycle_cnt[3:0]*16 + c_i];
        end else begin
            active_row_in = 128'd0;
            active_col_in = 128'd0;
        end
    end

    wire sys_rst_n = rst_n && !ctrl_reg[4]; // soft-reset

    gemm_systolic_core #(.DIM(16)) u_core (
        .clk       (clk),
        .rst_n     (sys_rst_n),
        .start     (core_start),
        .clear_acc (core_clear_acc),
        .row_in    (active_row_in),
        .col_in    (active_col_in),
        .busy      (core_busy),
        .done      (core_done),
        .cycle_cnt (core_cycle_cnt),
        .mat_c_flat(mat_c_flat)
    );

    // -----------------------------------------------------------------------
    // DMA FSM State Declarations
    // -----------------------------------------------------------------------
    reg [4:0] dma_state;  // 5-bit to support burst states 15-18

    localparam DMA_IDLE             = 5'd0,
               DMA_FETCH_A_ADDR     = 5'd1,
               DMA_FETCH_A_DATA     = 5'd2,
               DMA_FETCH_B_ADDR     = 5'd3,
               DMA_FETCH_B_DATA     = 5'd4,
               DMA_PUSH             = 5'd5,
               DMA_WAIT_COMP        = 5'd6,
               DMA_STORE_C_ADDR     = 5'd7,
               DMA_STORE_C_DATA     = 5'd8,
               DMA_STORE_C_RESP     = 5'd9,
               DMA_DONE             = 5'd10,
               // 11 = unused
               DMA_FETCH_A_WAIT     = 5'd12, // wait arready (A row-by-row)
               DMA_FETCH_B_WAIT     = 5'd13, // wait arready (B row-by-row)
               DMA_STORE_C_WAIT     = 5'd14, // wait awready (C row-by-row)
               // New burst states:
               DMA_FETCH_A_BURST_WAIT = 5'd15,
               DMA_FETCH_A_BURST_DATA = 5'd16,
               DMA_FETCH_B_BURST_WAIT = 5'd17,
               DMA_FETCH_B_BURST_DATA = 5'd18;

    // Compute FSM
    reg [2:0] comp_state;
    localparam COMP_IDLE = 3'd0, COMP_WAIT = 3'd1, COMP_START = 3'd2,
               COMP_RUN  = 3'd3, COMP_POP  = 3'd4;

    // -----------------------------------------------------------------------
    // Ping-Pong Coordination
    // -----------------------------------------------------------------------
    reg dma_buf_sel;
    reg [1:0] filled_tiles;
    wire dma_push_req = (dma_state == DMA_PUSH);
    wire comp_pop_req = (comp_state == COMP_POP);
    reg  compute_all_done;
    reg  flag_store_c;
    reg  flag_clear_acc;
    reg  dma_n_loop_restart;

    // K-loop tracking
    reg [15:0] k_rem_dma;
    reg [15:0] k_rem_comp;
    wire [4:0]  cur_tile_k_dma  = (k_rem_dma  > 16) ? 5'd16 : k_rem_dma[4:0];
    wire [4:0]  cur_tile_k_comp = (k_rem_comp > 16) ? 5'd16 : k_rem_comp[4:0];
    wire [15:0] next_k_rem_dma  = (k_rem_dma  > cur_tile_k_dma)  ? (k_rem_dma  - cur_tile_k_dma)  : 16'd0;
    wire [15:0] next_k_rem_comp = (k_rem_comp > cur_tile_k_comp) ? (k_rem_comp - cur_tile_k_comp) : 16'd0;

    // -----------------------------------------------------------------------
    // Burst-Mode Optimization Wires
    // -----------------------------------------------------------------------
    // A-burst: ALL tile_M rows fetched in a SINGLE AR transaction
    //  Condition: stride_a_reg == cur_tile_k_dma  (A rows are contiguous)
    //  e.g. when driver pre-packs a 16×K_chunk tile with stride = K_chunk
    wire        a_burst_ok   = (stride_a_reg == {11'd0, cur_tile_k_dma});
    wire        a_beats_two  = (cur_tile_k_dma > 5'd8);  // 1 or 2 beats per row
    // arlen = tile_M * beats_per_row - 1
    wire [7:0]  a_burst_arlen = a_beats_two
                    ? (({3'd0, tile_M} << 1) - 8'd1)
                    :  ({3'd0, tile_M}        - 8'd1);

    // B-burst: when stride_b == 1 (every row is 1 byte, rows are contiguous)
    //  Covers FC layer column vectors regardless of tile_N.
    //  One burst of ceil(K/8) beats fetches all K bytes; byte k → buf_b[k*16+0].
    wire        b_burst_ok   = (stride_b_reg == 16'd1);
    // arlen = ceil(cur_tile_k_dma / 8) - 1  (integer: (K-1)/8)
    wire [7:0]  b_burst_arlen = (cur_tile_k_dma > 5'd8) ? 8'd1 : 8'd0;

    // filled_tiles counter (combinational push/pop, no registered race)
    always @(posedge clk) begin
        if (!sys_rst_n || ctrl_reg[0] || dma_n_loop_restart) begin
            filled_tiles <= 2'd0;
        end else begin
            case ({dma_push_req, comp_pop_req})
                2'b10: filled_tiles <= filled_tiles + 1'b1;
                2'b01: filled_tiles <= (filled_tiles > 0) ? filled_tiles - 1'b1 : 2'd0;
                default: filled_tiles <= filled_tiles;
            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Performance Counters
    // -----------------------------------------------------------------------
    always @(posedge clk) begin
        if (!sys_rst_n || ctrl_reg[3]) begin
            perf_fetch_a_cycles <= 0;
            perf_fetch_b_cycles <= 0;
            perf_compute_cycles <= 0;
            perf_store_c_cycles <= 0;
        end else begin
            if (dma_state == DMA_FETCH_A_ADDR || dma_state == DMA_FETCH_A_DATA ||
                dma_state == DMA_FETCH_A_WAIT  ||
                dma_state == DMA_FETCH_A_BURST_WAIT || dma_state == DMA_FETCH_A_BURST_DATA)
                perf_fetch_a_cycles <= perf_fetch_a_cycles + 1;
            if (dma_state == DMA_FETCH_B_ADDR || dma_state == DMA_FETCH_B_DATA ||
                dma_state == DMA_FETCH_B_WAIT  ||
                dma_state == DMA_FETCH_B_BURST_WAIT || dma_state == DMA_FETCH_B_BURST_DATA)
                perf_fetch_b_cycles <= perf_fetch_b_cycles + 1;
            if (comp_state != COMP_IDLE)
                perf_compute_cycles <= perf_compute_cycles + 1;
            if (dma_state == DMA_STORE_C_ADDR || dma_state == DMA_STORE_C_DATA ||
                dma_state == DMA_STORE_C_RESP  || dma_state == DMA_STORE_C_WAIT)
                perf_store_c_cycles <= perf_store_c_cycles + 1;
        end
    end

    // -----------------------------------------------------------------------
    // DMA FSM
    // -----------------------------------------------------------------------
    reg [4:0] dma_row_cnt;
    reg [7:0] dma_beat_cnt;  // extended to 8 bits for burst mode (up to 255 beats)
    reg [31:0] cur_addr_a;
    reg [31:0] cur_addr_b;
    reg [31:0] cur_addr_c;
    reg [15:0] n_rem;

    always @(posedge clk) begin
        if (!sys_rst_n) begin
            dma_state    <= DMA_IDLE;
            m_axi_arvalid <= 0;
            m_axi_rready  <= 0;
            m_axi_awvalid <= 0;
            m_axi_wvalid  <= 0;
            m_axi_bready  <= 0;
            dma_busy      <= 0;
            dma_done      <= 0;
            dma_err       <= 0;
            cur_addr_a    <= 0;
            cur_addr_b    <= 0;
            cur_addr_c    <= 0;
            n_rem         <= 0;
            dma_row_cnt   <= 0;
            dma_beat_cnt  <= 0;
            dma_n_loop_restart <= 0;
        end else begin
            dma_n_loop_restart <= 0;

            case (dma_state)

                // ----------------------------------------------------------
                DMA_IDLE: begin
                    if (ctrl_reg[0]) begin
                        dma_busy      <= 1'b1;
                        dma_done      <= 1'b0;
                        k_rem_dma     <= k_total;
                        cur_addr_a    <= src_addr_a_reg;
                        cur_addr_b    <= src_addr_b_reg;
                        cur_addr_c    <= dst_addr_c_reg;
                        dma_buf_sel   <= 0;
                        dma_row_cnt   <= 0;
                        flag_clear_acc <= ctrl_reg[1];
                        flag_store_c  <= ctrl_reg[2];
                        n_rem <= (tile_n_count_reg > 0) ? tile_n_count_reg - 1 : 0;
                        dma_state     <= DMA_FETCH_A_ADDR;
                    end
                end

                // ----------------------------------------------------------
                // FETCH A — row-by-row or single-burst (a_burst_ok)
                // ----------------------------------------------------------
                DMA_FETCH_A_ADDR: begin
                    if (dma_row_cnt < tile_M) begin
                        if (dma_row_cnt > 0 || filled_tiles < 2) begin
                            if (a_burst_ok && dma_row_cnt == 0) begin
                                // ---- BURST PATH: all tile_M rows in one AR ----
                                m_axi_araddr  <= cur_addr_a;
                                m_axi_arlen   <= a_burst_arlen;
                                m_axi_arvalid <= 1'b1;
                                dma_beat_cnt  <= 0;
                                dma_state     <= DMA_FETCH_A_BURST_WAIT;
                            end else begin
                                // ---- ROW-BY-ROW PATH ----
                                m_axi_araddr  <= cur_addr_a + (dma_row_cnt * stride_a_reg);
                                m_axi_arlen   <= (cur_tile_k_dma > 5'd8) ? 8'd1 : 8'd0;
                                m_axi_arvalid <= 1'b1;
                                dma_beat_cnt  <= 0;
                                dma_state     <= DMA_FETCH_A_WAIT;
                            end
                        end
                        // else: stall — both ping-pong buffers full
                    end else begin
                        dma_row_cnt <= 0;
                        dma_state   <= DMA_FETCH_B_ADDR;
                    end
                end

                DMA_FETCH_A_WAIT: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        dma_state     <= DMA_FETCH_A_DATA;
                    end
                end

                DMA_FETCH_A_DATA: begin
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
                                buf_a_ping[dma_row_cnt*16 + 8]  <= m_axi_rdata[7:0];
                                buf_a_ping[dma_row_cnt*16 + 9]  <= m_axi_rdata[15:8];
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
                                buf_a_pong[dma_row_cnt*16 + 8]  <= m_axi_rdata[7:0];
                                buf_a_pong[dma_row_cnt*16 + 9]  <= m_axi_rdata[15:8];
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
                            dma_row_cnt  <= dma_row_cnt + 5'd1;
                            dma_state    <= DMA_FETCH_A_ADDR;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 8'd1;
                        end
                    end
                end

                // A burst: wait for arready then receive all tile_M row beats at once
                DMA_FETCH_A_BURST_WAIT: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        dma_state     <= DMA_FETCH_A_BURST_DATA;
                    end
                end

                // A burst data:
                //  a_beats_two=1 (K>8): row = beat>>1, col_base = beat[0]*8
                //    → index = (beat>>1)*16 + beat[0]*8 + j = beat*8 + j
                //  a_beats_two=0 (K<=8): row = beat, col_base = 0
                //    → index = beat*16 + j
                DMA_FETCH_A_BURST_DATA: begin
                    if (m_axi_rvalid && m_axi_rready) begin
                        if (dma_buf_sel == 0) begin
                            if (a_beats_two) begin
                                buf_a_ping[dma_beat_cnt*8 + 0] <= m_axi_rdata[7:0];
                                buf_a_ping[dma_beat_cnt*8 + 1] <= m_axi_rdata[15:8];
                                buf_a_ping[dma_beat_cnt*8 + 2] <= m_axi_rdata[23:16];
                                buf_a_ping[dma_beat_cnt*8 + 3] <= m_axi_rdata[31:24];
                                buf_a_ping[dma_beat_cnt*8 + 4] <= m_axi_rdata[39:32];
                                buf_a_ping[dma_beat_cnt*8 + 5] <= m_axi_rdata[47:40];
                                buf_a_ping[dma_beat_cnt*8 + 6] <= m_axi_rdata[55:48];
                                buf_a_ping[dma_beat_cnt*8 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_a_ping[dma_beat_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_a_ping[dma_beat_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_a_ping[dma_beat_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_a_ping[dma_beat_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_a_ping[dma_beat_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_a_ping[dma_beat_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_a_ping[dma_beat_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_a_ping[dma_beat_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end
                        end else begin
                            if (a_beats_two) begin
                                buf_a_pong[dma_beat_cnt*8 + 0] <= m_axi_rdata[7:0];
                                buf_a_pong[dma_beat_cnt*8 + 1] <= m_axi_rdata[15:8];
                                buf_a_pong[dma_beat_cnt*8 + 2] <= m_axi_rdata[23:16];
                                buf_a_pong[dma_beat_cnt*8 + 3] <= m_axi_rdata[31:24];
                                buf_a_pong[dma_beat_cnt*8 + 4] <= m_axi_rdata[39:32];
                                buf_a_pong[dma_beat_cnt*8 + 5] <= m_axi_rdata[47:40];
                                buf_a_pong[dma_beat_cnt*8 + 6] <= m_axi_rdata[55:48];
                                buf_a_pong[dma_beat_cnt*8 + 7] <= m_axi_rdata[63:56];
                            end else begin
                                buf_a_pong[dma_beat_cnt*16 + 0] <= m_axi_rdata[7:0];
                                buf_a_pong[dma_beat_cnt*16 + 1] <= m_axi_rdata[15:8];
                                buf_a_pong[dma_beat_cnt*16 + 2] <= m_axi_rdata[23:16];
                                buf_a_pong[dma_beat_cnt*16 + 3] <= m_axi_rdata[31:24];
                                buf_a_pong[dma_beat_cnt*16 + 4] <= m_axi_rdata[39:32];
                                buf_a_pong[dma_beat_cnt*16 + 5] <= m_axi_rdata[47:40];
                                buf_a_pong[dma_beat_cnt*16 + 6] <= m_axi_rdata[55:48];
                                buf_a_pong[dma_beat_cnt*16 + 7] <= m_axi_rdata[63:56];
                            end
                        end

                        if (m_axi_rlast || dma_beat_cnt == a_burst_arlen) begin
                            m_axi_rready <= 1'b0;
                            dma_row_cnt  <= 0;   // ready for B fetch
                            dma_state    <= DMA_FETCH_B_ADDR;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 8'd1;
                        end
                    end
                end

                // ----------------------------------------------------------
                // FETCH B — row-by-row or single-burst (b_burst_ok)
                // ----------------------------------------------------------
                DMA_FETCH_B_ADDR: begin
                    if (dma_row_cnt < cur_tile_k_dma) begin
                        if (b_burst_ok && dma_row_cnt == 0) begin
                            // ---- BURST PATH: all K rows (stride_b=1 → contiguous) ----
                            // arlen = ceil(K/8) - 1: 2 beats for K=16, 1 for K≤8
                            m_axi_araddr  <= cur_addr_b;
                            m_axi_arlen   <= b_burst_arlen;
                            m_axi_arvalid <= 1'b1;
                            dma_beat_cnt  <= 0;
                            dma_state     <= DMA_FETCH_B_BURST_WAIT;
                        end else begin
                            // ---- ROW-BY-ROW PATH ----
                            m_axi_araddr  <= cur_addr_b + (dma_row_cnt * stride_b_reg);
                            m_axi_arlen   <= (tile_N > 5'd8) ? 8'd1 : 8'd0;
                            m_axi_arvalid <= 1'b1;
                            dma_beat_cnt  <= 0;
                            dma_state     <= DMA_FETCH_B_WAIT;
                        end
                    end else begin
                        dma_state <= DMA_PUSH;
                    end
                end

                DMA_FETCH_B_WAIT: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        dma_state     <= DMA_FETCH_B_DATA;
                    end
                end

                DMA_FETCH_B_DATA: begin
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
                                buf_b_ping[dma_row_cnt*16 + 8]  <= m_axi_rdata[7:0];
                                buf_b_ping[dma_row_cnt*16 + 9]  <= m_axi_rdata[15:8];
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
                                buf_b_pong[dma_row_cnt*16 + 8]  <= m_axi_rdata[7:0];
                                buf_b_pong[dma_row_cnt*16 + 9]  <= m_axi_rdata[15:8];
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
                            dma_row_cnt  <= dma_row_cnt + 5'd1;
                            dma_state    <= DMA_FETCH_B_ADDR;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 8'd1;
                        end
                    end
                end

                // B burst: stride_b==1 → K rows are K contiguous bytes in DDR
                // Burst reads ceil(K/8) beats; byte k → row k col 0 of buf_b.
                // Works for any tile_N (only col 0 is valid; driver uses stride=1 or
                // reads only col 0 via stride_c=tile_N for the sliding-window FC case).
                DMA_FETCH_B_BURST_WAIT: begin
                    if (m_axi_arready && m_axi_arvalid) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        dma_state     <= DMA_FETCH_B_BURST_DATA;
                    end
                end

                DMA_FETCH_B_BURST_DATA: begin
                    if (m_axi_rvalid && m_axi_rready) begin
                        // beat 0 → rows 0-7 col 0 (indices 0,16,32,48,64,80,96,112)
                        // beat 1 → rows 8-15 col 0 (indices 128,144,160,176,192,208,224,240)
                        if (dma_buf_sel == 0) begin
                            buf_b_ping[dma_beat_cnt[0]*128 +   0] <= m_axi_rdata[7:0];
                            buf_b_ping[dma_beat_cnt[0]*128 +  16] <= m_axi_rdata[15:8];
                            buf_b_ping[dma_beat_cnt[0]*128 +  32] <= m_axi_rdata[23:16];
                            buf_b_ping[dma_beat_cnt[0]*128 +  48] <= m_axi_rdata[31:24];
                            buf_b_ping[dma_beat_cnt[0]*128 +  64] <= m_axi_rdata[39:32];
                            buf_b_ping[dma_beat_cnt[0]*128 +  80] <= m_axi_rdata[47:40];
                            buf_b_ping[dma_beat_cnt[0]*128 +  96] <= m_axi_rdata[55:48];
                            buf_b_ping[dma_beat_cnt[0]*128 + 112] <= m_axi_rdata[63:56];
                        end else begin
                            buf_b_pong[dma_beat_cnt[0]*128 +   0] <= m_axi_rdata[7:0];
                            buf_b_pong[dma_beat_cnt[0]*128 +  16] <= m_axi_rdata[15:8];
                            buf_b_pong[dma_beat_cnt[0]*128 +  32] <= m_axi_rdata[23:16];
                            buf_b_pong[dma_beat_cnt[0]*128 +  48] <= m_axi_rdata[31:24];
                            buf_b_pong[dma_beat_cnt[0]*128 +  64] <= m_axi_rdata[39:32];
                            buf_b_pong[dma_beat_cnt[0]*128 +  80] <= m_axi_rdata[47:40];
                            buf_b_pong[dma_beat_cnt[0]*128 +  96] <= m_axi_rdata[55:48];
                            buf_b_pong[dma_beat_cnt[0]*128 + 112] <= m_axi_rdata[63:56];
                        end

                        if (m_axi_rlast || dma_beat_cnt == b_burst_arlen) begin
                            m_axi_rready <= 1'b0;
                            dma_state    <= DMA_PUSH;  // all K rows done → push
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 8'd1;
                        end
                    end
                end

                // ----------------------------------------------------------
                // PUSH: signal a new tile is ready, advance pointers
                // ----------------------------------------------------------
                DMA_PUSH: begin
                    cur_addr_a  <= cur_addr_a + 32'd16;
                    cur_addr_b  <= cur_addr_b + (32'd16 * {16'd0, stride_b_reg});
                    k_rem_dma   <= next_k_rem_dma;
                    dma_buf_sel <= ~dma_buf_sel;
                    dma_row_cnt <= 0;

                    if (next_k_rem_dma > 0) begin
                        dma_state <= DMA_FETCH_A_ADDR;
                    end else begin
                        dma_state <= DMA_WAIT_COMP;
                    end
                end

                // ----------------------------------------------------------
                DMA_WAIT_COMP: begin
                    if (compute_all_done) begin
                        if (flag_store_c) begin
                            dma_row_cnt <= 0;
                            dma_state   <= DMA_STORE_C_ADDR;
                        end else begin
                            dma_state <= DMA_DONE;
                        end
                    end
                end

                // ----------------------------------------------------------
                // STORE C — per-row write bursts (unchanged)
                // ----------------------------------------------------------
                DMA_STORE_C_ADDR: begin
                    if (dma_row_cnt < tile_M) begin
                        m_axi_awaddr  <= cur_addr_c + ((dma_row_cnt * stride_c_reg) << 2);
                        m_axi_awlen   <= (tile_N > 0) ? ((tile_N + 1) >> 1) - 8'd1 : 8'd0;
                        m_axi_awvalid <= 1'b1;
                        dma_beat_cnt  <= 0;
                        m_axi_wdata   <= {mat_c_flat[(dma_row_cnt * 16 + 1)*32 +: 32],
                                          mat_c_flat[(dma_row_cnt * 16 + 0)*32 +: 32]};
                        m_axi_wlast   <= (((tile_N + 1) >> 1) == 1);
                        dma_state     <= DMA_STORE_C_WAIT;
                    end else begin
                        dma_state <= DMA_DONE;
                    end
                end

                DMA_STORE_C_WAIT: begin
                    if (m_axi_awready && m_axi_awvalid) begin
                        m_axi_awvalid <= 1'b0;
                        m_axi_wvalid  <= 1'b1;
                        dma_state     <= DMA_STORE_C_DATA;
                    end
                end

                DMA_STORE_C_DATA: begin
                    if (m_axi_wready && m_axi_wvalid) begin
                        if (dma_beat_cnt == m_axi_awlen) begin
                            m_axi_wvalid <= 1'b0;
                            m_axi_wlast  <= 1'b0;
                            m_axi_bready <= 1'b1;
                            dma_state    <= DMA_STORE_C_RESP;
                        end else begin
                            dma_beat_cnt <= dma_beat_cnt + 8'd1;
                            m_axi_wdata  <= {mat_c_flat[(dma_row_cnt*16 + (dma_beat_cnt+1)*2 + 1)*32 +: 32],
                                             mat_c_flat[(dma_row_cnt*16 + (dma_beat_cnt+1)*2 + 0)*32 +: 32]};
                            m_axi_wlast  <= ((dma_beat_cnt + 1) == m_axi_awlen);
                        end
                    end
                end

                DMA_STORE_C_RESP: begin
                    if (m_axi_bvalid && m_axi_bready) begin
                        m_axi_bready <= 1'b0;
                        dma_row_cnt  <= dma_row_cnt + 5'd1;
                        dma_state    <= DMA_STORE_C_ADDR;
                    end
                end

                // ----------------------------------------------------------
                DMA_DONE: begin
                    if (n_rem > 0) begin
                        n_rem              <= n_rem - 1;
                        k_rem_dma          <= k_total;
                        cur_addr_a         <= src_addr_a_reg;
                        cur_addr_c         <= cur_addr_c + ({16'd0,tile_M} * {16'd0,stride_c_reg} << 2);
                        dma_buf_sel        <= 0;
                        dma_row_cnt        <= 0;
                        dma_done           <= 1'b0;
                        flag_clear_acc     <= ctrl_reg[1];
                        dma_n_loop_restart <= 1'b1;
                        dma_state          <= DMA_FETCH_A_ADDR;
                    end else begin
                        dma_busy  <= 1'b0;
                        dma_done  <= 1'b1;
                        dma_state <= DMA_IDLE;
                    end
                end

            endcase
        end
    end

    // -----------------------------------------------------------------------
    // Compute FSM (unchanged from ping-pong fix)
    // -----------------------------------------------------------------------
    reg wait_for_busy;

    always @(posedge clk) begin
        if (!sys_rst_n) begin
            comp_state       <= COMP_IDLE;
            core_start       <= 0;
            core_clear_acc   <= 0;
            compute_all_done <= 0;
            comp_buf_sel     <= 0;
            wait_for_busy    <= 0;
            k_rem_comp       <= 0;
        end else begin
            case (comp_state)
                COMP_IDLE: begin
                    if (ctrl_reg[0] || dma_n_loop_restart) begin
                        k_rem_comp       <= k_total;
                        compute_all_done <= 0;
                        comp_buf_sel     <= 0;
                        wait_for_busy    <= 0;
                        comp_state       <= COMP_WAIT;
                    end
                end
                COMP_WAIT: begin
                    if (filled_tiles > 0) comp_state <= COMP_START;
                end
                COMP_START: begin
                    core_start     <= 1'b1;
                    core_clear_acc <= (k_rem_comp == k_total) ? flag_clear_acc : 1'b0;
                    wait_for_busy  <= 1'b1;
                    comp_state     <= COMP_RUN;
                end
                COMP_RUN: begin
                    core_start     <= 1'b0;
                    core_clear_acc <= 1'b0;
                    if (wait_for_busy) begin
                        if (core_busy) wait_for_busy <= 1'b0;
                    end else if (core_done) begin
                        comp_state <= COMP_POP;
                    end
                end
                COMP_POP: begin
                    k_rem_comp   <= next_k_rem_comp;
                    comp_buf_sel <= ~comp_buf_sel;
                    if (next_k_rem_comp > 0) begin
                        comp_state <= COMP_WAIT;
                    end else begin
                        compute_all_done <= 1'b1;
                        comp_state       <= COMP_IDLE;
                    end
                end
            endcase
        end
    end

endmodule
