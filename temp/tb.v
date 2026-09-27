`timescale 1ns / 1ps

module tb;
    reg clk;
    reg rst_n;
    reg start;
    reg clear_acc;

    // Simulate mat_a_mem and mat_b_mem
    reg [31:0] mat_a_mem [0:63];
    reg [31:0] mat_b_mem [0:63];

    wire busy;
    wire done;
    wire [31:0] cycle_cnt;
    wire [16*16*32-1:0] mat_c_flat;

    // A and B inputs
    reg [127:0] active_row_in;
    reg [127:0] active_col_in;

    // Initialize Memory
    integer i, j;
    initial begin
        clk = 0;
        rst_n = 0;
        start = 0;
        clear_acc = 0;

        // Same initialization as C code
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                mat_a_mem[(i*16 + j)/4][(j%4)*8 +: 8] = (i*3 - j*2) % 15;
                if (i == j)
                    mat_b_mem[(i*16 + j)/4][(j%4)*8 +: 8] = 2;
                else
                    mat_b_mem[(i*16 + j)/4][(j%4)*8 +: 8] = ((i + j) % 5) - 2;
            end
        end

        #20 rst_n = 1;
        #10 clear_acc = 1;
        #10 clear_acc = 0;
        #10 start = 1;
        #10 start = 0;

        wait(done);
        #10;
        
        $display("HW C[0][0]: %d", $signed(mat_c_flat[0*32 +: 32]));
        $display("HW C[0][1]: %d", $signed(mat_c_flat[1*32 +: 32]));
        $display("HW C[0][2]: %d", $signed(mat_c_flat[2*32 +: 32]));
        $finish;
    end

    always #5 clk = ~clk;

    integer r_idx, c_idx;
    always @(*) begin
        if (busy && (cycle_cnt < 32'd16)) begin
            for (r_idx = 0; r_idx < 16; r_idx = r_idx + 1) begin
                active_row_in[r_idx*8 +: 8] = $signed(mat_a_mem[(r_idx*16 + cycle_cnt[3:0]) >> 2][((r_idx*16 + cycle_cnt[3:0]) & 2'd3)*8 +: 8]);
            end
            for (c_idx = 0; c_idx < 16; c_idx = c_idx + 1) begin
                active_col_in[c_idx*8 +: 8] = $signed(mat_b_mem[(cycle_cnt[3:0]*16 + c_idx) >> 2][((cycle_cnt[3:0]*16 + c_idx) & 2'd3)*8 +: 8]);
            end
        end else begin
            active_row_in = 128'd0;
            active_col_in = 128'd0;
        end
    end

    gemm_systolic_core #(.DIM(16)) u_core (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .clear_acc(clear_acc),
        .row_in(active_row_in),
        .col_in(active_col_in),
        .busy(busy),
        .done(done),
        .cycle_cnt(cycle_cnt),
        .mat_c_flat(mat_c_flat)
    );
endmodule
