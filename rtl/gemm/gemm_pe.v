`timescale 1ns / 1ps

module gemm_pe (
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 clear_acc,
    input  wire                 en,
    input  wire signed [7:0]    a_in,
    input  wire signed [7:0]    b_in,
    output reg  signed [7:0]    a_out,
    output reg  signed [7:0]    b_out,
    output reg  signed [31:0]   accum_out
);

    wire signed [15:0] mult_res;
    assign mult_res = a_in * b_in;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_out     <= 8'sd0;
            b_out     <= 8'sd0;
            accum_out <= 32'sd0;
        end else if (clear_acc) begin
            a_out     <= 8'sd0;
            b_out     <= 8'sd0;
            accum_out <= 32'sd0;
        end else if (en) begin
            a_out     <= a_in;
            b_out     <= b_in;
            accum_out <= accum_out + {{16{mult_res[15]}}, mult_res};
        end
    end

endmodule
