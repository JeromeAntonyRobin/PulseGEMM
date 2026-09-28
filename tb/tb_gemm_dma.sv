`timescale 1ns / 1ps

module tb_gemm_dma;

    reg clk;
    reg rst_n;

    // AXI4-Lite Slave wires
    reg  [31:0] s_axi_awaddr;
    reg         s_axi_awvalid;
    wire        s_axi_awready;
    reg  [31:0] s_axi_wdata;
    reg  [3:0]  s_axi_wstrb;
    reg         s_axi_wvalid;
    wire        s_axi_wready;
    wire [1:0]  s_axi_bresp;
    wire        s_axi_bvalid;
    reg         s_axi_bready;

    reg  [31:0] s_axi_araddr;
    reg         s_axi_arvalid;
    wire        s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rvalid;
    reg         s_axi_rready;

    // AXI4 Master wires
    wire [31:0] m_axi_awaddr;
    wire [7:0]  m_axi_awlen;
    wire [2:0]  m_axi_awsize;
    wire [1:0]  m_axi_awburst;
    wire        m_axi_awlock;
    wire [3:0]  m_axi_awcache;
    wire [2:0]  m_axi_awprot;
    wire [3:0]  m_axi_awqos;
    wire        m_axi_awvalid;
    reg         m_axi_awready;

    wire [31:0] m_axi_wdata;
    wire [3:0]  m_axi_wstrb;
    wire        m_axi_wlast;
    wire        m_axi_wvalid;
    reg         m_axi_wready;

    reg  [1:0]  m_axi_bresp;
    reg         m_axi_bvalid;
    wire        m_axi_bready;

    wire [31:0] m_axi_araddr;
    wire [7:0]  m_axi_arlen;
    wire [2:0]  m_axi_arsize;
    wire [1:0]  m_axi_arburst;
    wire        m_axi_arlock;
    wire [3:0]  m_axi_arcache;
    wire [2:0]  m_axi_arprot;
    wire [3:0]  m_axi_arqos;
    wire        m_axi_arvalid;
    reg         m_axi_arready;

    reg  [31:0] m_axi_rdata;
    reg  [1:0]  m_axi_rresp;
    reg         m_axi_rlast;
    reg         m_axi_rvalid;
    wire        m_axi_rready;

    wire irq, led_busy, led_done;

    // Clock generation (50 MHz -> 20ns period)
    always #10 clk = ~clk;

    // Instantiate DUT
    gemm_dma_top #(
        .AXI_ADDR_WIDTH(32),
        .AXI_DATA_WIDTH(32)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
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
        .s_axi_rready(s_axi_rready),
        .m_axi_awaddr(m_axi_awaddr),
        .m_axi_awlen(m_axi_awlen),
        .m_axi_awsize(m_axi_awsize),
        .m_axi_awburst(m_axi_awburst),
        .m_axi_awlock(m_axi_awlock),
        .m_axi_awcache(m_axi_awcache),
        .m_axi_awprot(m_axi_awprot),
        .m_axi_awqos(m_axi_awqos),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_awready(m_axi_awready),
        .m_axi_wdata(m_axi_wdata),
        .m_axi_wstrb(m_axi_wstrb),
        .m_axi_wlast(m_axi_wlast),
        .m_axi_wvalid(m_axi_wvalid),
        .m_axi_wready(m_axi_wready),
        .m_axi_bresp(m_axi_bresp),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_araddr(m_axi_araddr),
        .m_axi_arlen(m_axi_arlen),
        .m_axi_arsize(m_axi_arsize),
        .m_axi_arburst(m_axi_arburst),
        .m_axi_arlock(m_axi_arlock),
        .m_axi_arcache(m_axi_arcache),
        .m_axi_arprot(m_axi_arprot),
        .m_axi_arqos(m_axi_arqos),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_arready(m_axi_arready),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rlast(m_axi_rlast),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_rready(m_axi_rready),
        .irq(irq),
        .led_busy(led_busy),
        .led_done(led_done)
    );

    // =========================================================================
    // Emulated DDR Memory Responder
    // =========================================================================
    reg [31:0] ddr_mem [0:4095]; // 16 KB simulated DDR memory space
    // Base addresses in ddr_mem word indices:
    // 0x8000_0000 -> offset 0
    // 0x8000_0100 -> offset 64
    // 0x8000_0200 -> offset 128
    function integer get_mem_word_idx(input [31:0] byte_addr);
        get_mem_word_idx = (byte_addr - 32'h8000_0000) >> 2;
    endfunction

    // Emulated AXI Read channel
    reg [31:0] rd_addr;
    reg [7:0]  rd_len;
    reg [7:0]  rd_beat;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            m_axi_arready <= 1'b1;
            m_axi_rvalid  <= 1'b0;
            m_axi_rdata   <= 32'd0;
            m_axi_rlast   <= 1'b0;
            m_axi_rresp   <= 2'b00;
            rd_beat       <= 8'd0;
        end else begin
            if (m_axi_arvalid && m_axi_arready) begin
                rd_addr       <= m_axi_araddr;
                rd_len        <= m_axi_arlen;
                rd_beat       <= 8'd0;
                m_axi_arready <= 1'b0;
                m_axi_rvalid  <= 1'b1;
                m_axi_rdata   <= ddr_mem[get_mem_word_idx(m_axi_araddr)];
                m_axi_rlast   <= (m_axi_arlen == 0);
            end else if (m_axi_rvalid && m_axi_rready) begin
                if (rd_beat == rd_len) begin
                    m_axi_rvalid  <= 1'b0;
                    m_axi_rlast   <= 1'b0;
                    m_axi_arready <= 1'b1;
                end else begin
                    rd_beat      <= rd_beat + 8'd1;
                    m_axi_rdata  <= ddr_mem[get_mem_word_idx(rd_addr) + rd_beat + 1];
                    m_axi_rlast  <= (rd_beat + 8'd1 == rd_len);
                end
            end
        end
    end

    // Emulated AXI Write channel
    reg [31:0] wr_addr;
    reg [7:0]  wr_len;
    reg [7:0]  wr_beat;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            m_axi_awready <= 1'b1;
            m_axi_wready  <= 1'b0;
            m_axi_bvalid  <= 1'b0;
            m_axi_bresp   <= 2'b00;
            wr_beat       <= 8'd0;
        end else begin
            if (m_axi_awvalid && m_axi_awready) begin
                wr_addr       <= m_axi_awaddr;
                wr_len        <= m_axi_awlen;
                wr_beat       <= 8'd0;
                m_axi_awready <= 1'b0;
                m_axi_wready  <= 1'b1;
            end else if (m_axi_wvalid && m_axi_wready) begin
                ddr_mem[get_mem_word_idx(wr_addr) + wr_beat] <= m_axi_wdata;
                if (m_axi_wlast || (wr_beat == wr_len)) begin
                    m_axi_wready <= 1'b0;
                    m_axi_bvalid <= 1'b1;
                end else begin
                    wr_beat <= wr_beat + 8'd1;
                end
            end

            if (m_axi_bvalid && m_axi_bready) begin
                m_axi_bvalid  <= 1'b0;
                m_axi_awready <= 1'b1;
            end
        end
    end

    // AXI-Lite write task
    task axi_write(input [31:0] addr, input [31:0] data);
    begin
        @(posedge clk);
        s_axi_awaddr  <= addr;
        s_axi_awvalid <= 1'b1;
        s_axi_wdata   <= data;
        s_axi_wstrb   <= 4'hF;
        s_axi_wvalid  <= 1'b1;
        s_axi_bready  <= 1'b1;

        wait (s_axi_awready && s_axi_wready);
        @(posedge clk);
        s_axi_awvalid <= 1'b0;
        s_axi_wvalid  <= 1'b0;

        wait (s_axi_bvalid);
        @(posedge clk);
        s_axi_bready  <= 1'b0;
    end
    endtask

    // Test matrix golden models
    reg signed [7:0]  mat_A [0:15][0:15];
    reg signed [7:0]  mat_B [0:15][0:15];
    reg signed [31:0] golden_C [0:15][0:15];

    integer r, c, k;
    integer errors;
    reg signed [31:0] hw_val;

    initial begin
        clk           = 0;
        rst_n         = 0;
        s_axi_awaddr  = 0;
        s_axi_awvalid = 0;
        s_axi_wdata   = 0;
        s_axi_wstrb   = 0;
        s_axi_wvalid  = 0;
        s_axi_bready  = 0;
        s_axi_araddr  = 0;
        s_axi_arvalid = 0;
        s_axi_rready  = 0;
        errors        = 0;

        #100;
        rst_n = 1;
        #50;

        $display("===============================================================");
        $display("   TESTBENCH: GEMM AXI DMA ACCELERATOR FOR POLARFIRE SOC       ");
        $display("===============================================================");

        // 1. Initialize Matrices with distinct signed values
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                mat_A[r][c] = (r * 3 - c * 2) % 15;
                mat_B[r][c] = (r == c) ? 8'sd2 : ((r + c) % 5) - 8'sd2;
            end
        end

        // 2. Compute Golden Matrix C
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                golden_C[r][c] = 32'sd0;
                for (k = 0; k < 16; k = k + 1) begin
                    golden_C[r][c] = golden_C[r][c] + (mat_A[r][k] * mat_B[k][c]);
                end
            end
        end

        // 3. Load Matrix A into DDR Memory (0x8000_0000, 64 words)
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 4; c = c + 1) begin
                ddr_mem[r*4 + c] = {
                    mat_A[r][c*4 + 3],
                    mat_A[r][c*4 + 2],
                    mat_A[r][c*4 + 1],
                    mat_A[r][c*4 + 0]
                };
            end
        end

        // 4. Load Matrix B into DDR Memory (0x8000_0100, 64 words)
        // 0x100 bytes = offset 64 words
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 4; c = c + 1) begin
                ddr_mem[64 + r*4 + c] = {
                    mat_B[r][c*4 + 3],
                    mat_B[r][c*4 + 2],
                    mat_B[r][c*4 + 1],
                    mat_B[r][c*4 + 0]
                };
            end
        end

        // 5. Configure GEMM DMA Registers via AXI-Lite
        $display("[TB] Configuring DMA Registers via AXI-Lite...");
        axi_write(32'h08, 32'h8000_0000); // SRC_ADDR_A
        axi_write(32'h0C, 32'h8000_0100); // SRC_ADDR_B
        axi_write(32'h10, 32'h8000_0200); // DST_ADDR_C (offset 128 words)
        axi_write(32'h00, 32'h0000_0001); // START = 1

        $display("[TB] GEMM DMA Triggered. Waiting for completion...");

        // 6. Wait for Hardware DONE
        wait (led_done == 1'b1);
        $display("[TB] GEMM DMA Finished! Total hardware execution cycles: %0d", dut.hw_cycle_cnt);

        #100;

        // 7. Verify Result in DDR Memory against Golden Model
        $display("[TB] Verifying computed Matrix C in DDR memory (256 words)...");
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                hw_val = ddr_mem[128 + r*16 + c];
                if (hw_val !== golden_C[r][c]) begin
                    $display("ERROR at C[%0d][%0d]: HW = %0d, Expected = %0d", r, c, hw_val, golden_C[r][c]);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0) begin
            $display("===============================================================");
            $display("   SUCCESS: ALL 256 MATRIX ACCUMULATORS MATCH GOLDEN OUTPUT!   ");
            $display("===============================================================");
        end else begin
            $display("===============================================================");
            $display("   FAILURE: %0d MISMATCHES DETECTED!                           ", errors);
            $display("===============================================================");
        end

        $finish;
    end

endmodule
