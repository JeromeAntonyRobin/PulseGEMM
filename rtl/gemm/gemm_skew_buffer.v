`timescale 1ns / 1ps

module gemm_skew_buffer #(
    parameter DIM = 16
)(
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 clear,
    input  wire                 en,
    input  wire [DIM*8-1:0]     row_in,
    input  wire [DIM*8-1:0]     col_in,
    output wire [DIM*8-1:0]     row_skewed,
    output wire [DIM*8-1:0]     col_skewed
);

    genvar i;
    generate
        // Skew Matrix A rows: Row i delayed by i clock cycles
        for (i = 0; i < DIM; i = i + 1) begin : GEN_ROW_SKEW
            if (i == 0) begin : SKEW_0
                assign row_skewed[7:0] = row_in[7:0];
            end else begin : SKEW_N
                reg [7:0] delay_pipe [0:i-1];
                integer k;
                always @(posedge clk or negedge rst_n) begin
                    if (!rst_n) begin
                        for (k = 0; k < i; k = k + 1)
                            delay_pipe[k] <= 8'd0;
                    end else if (clear) begin
                        for (k = 0; k < i; k = k + 1)
                            delay_pipe[k] <= 8'd0;
                    end else if (en) begin
                        delay_pipe[0] <= row_in[i*8 +: 8];
                        for (k = 1; k < i; k = k + 1)
                            delay_pipe[k] <= delay_pipe[k-1];
                    end
                end
                assign row_skewed[i*8 +: 8] = delay_pipe[i-1];
            end
        end

        // Skew Matrix B columns: Col j delayed by j clock cycles
        for (i = 0; i < DIM; i = i + 1) begin : GEN_COL_SKEW
            if (i == 0) begin : SKEW_0
                assign col_skewed[7:0] = col_in[7:0];
            end else begin : SKEW_N
                reg [7:0] delay_pipe [0:i-1];
                integer k;
                always @(posedge clk or negedge rst_n) begin
                    if (!rst_n) begin
                        for (k = 0; k < i; k = k + 1)
                            delay_pipe[k] <= 8'd0;
                    end else if (clear) begin
                        for (k = 0; k < i; k = k + 1)
                            delay_pipe[k] <= 8'd0;
                    end else if (en) begin
                        delay_pipe[0] <= col_in[i*8 +: 8];
                        for (k = 1; k < i; k = k + 1)
                            delay_pipe[k] <= delay_pipe[k-1];
                    end
                end
                assign col_skewed[i*8 +: 8] = delay_pipe[i-1];
            end
        end
    endgenerate

endmodule
