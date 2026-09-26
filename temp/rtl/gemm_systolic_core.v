`timescale 1ns / 1ps

module gemm_systolic_core #(
    parameter DIM = 16
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   start,
    input  wire                   clear_acc,
    input  wire [DIM*8-1:0]       row_in,
    input  wire [DIM*8-1:0]       col_in,
    output reg                    busy,
    output reg                    done,
    output reg  [31:0]            cycle_cnt,
    output wire [DIM*DIM*32-1:0]  mat_c_flat
);

    localparam TOTAL_CYCLES = (3 * DIM) - 2; // 46 cycles for 16x16

    wire [DIM*8-1:0] row_skewed;
    wire [DIM*8-1:0] col_skewed;

    // Triangular skew buffer
    gemm_skew_buffer #(.DIM(DIM)) u_skew (
        .clk(clk),
        .rst_n(rst_n),
        .clear(start),
        .en(busy),
        .row_in(row_in),
        .col_in(col_in),
        .row_skewed(row_skewed),
        .col_skewed(col_skewed)
    );

    // 2D Array Interconnect Wires
    wire signed [7:0]  a_wire   [0:DIM-1][0:DIM];
    wire signed [7:0]  b_wire   [0:DIM][0:DIM-1];
    wire signed [31:0] acc_wire [0:DIM-1][0:DIM-1];

    genvar r, c;
    generate
        for (r = 0; r < DIM; r = r + 1) begin : GEN_ROW_INPUT
            assign a_wire[r][0] = row_skewed[r*8 +: 8];
        end
        for (c = 0; c < DIM; c = c + 1) begin : GEN_COL_INPUT
            assign b_wire[0][c] = col_skewed[c*8 +: 8];
        end

        for (r = 0; r < DIM; r = r + 1) begin : GEN_ROWS
            for (c = 0; c < DIM; c = c + 1) begin : GEN_COLS
                gemm_pe pe_inst (
                    .clk(clk),
                    .rst_n(rst_n),
                    .clear_acc(clear_acc),
                    .en(busy),
                    .a_in(a_wire[r][c]),
                    .b_in(b_wire[r][c]),
                    .a_out(a_wire[r][c+1]),
                    .b_out(b_wire[r+1][c]),
                    .accum_out(acc_wire[r][c])
                );
                assign mat_c_flat[(r*DIM + c)*32 +: 32] = acc_wire[r][c];
            end
        end
    endgenerate

    // Control FSM
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            busy      <= 1'b0;
            done      <= 1'b0;
            cycle_cnt <= 32'd0;
        end else begin
            if (start && !busy) begin
                busy      <= 1'b1;
                done      <= 1'b0;
                cycle_cnt <= 32'd0;
            end else if (busy) begin
                if (cycle_cnt >= (TOTAL_CYCLES - 1)) begin
                    busy <= 1'b0;
                    done <= 1'b1;
                end else begin
                    cycle_cnt <= cycle_cnt + 32'd1;
                end
            end
        end
    end

endmodule
