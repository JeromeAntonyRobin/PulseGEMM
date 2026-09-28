//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:44 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CORE_I2C_C0_0_WRAPPER
module CORE_I2C_C0_0_WRAPPER(
    // Inputs
    APBslave_PADDR,
    APBslave_PENABLE,
    APBslave_PSEL,
    APBslave_PWDATA,
    APBslave_PWRITE,
    PCLK,
    PRESETN,
    // Outputs
    APBslave_PRDATA,
    INT,
    // Inouts
    COREI2C_C0_SCL,
    COREI2C_C0_SDA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [8:0] APBslave_PADDR;
input        APBslave_PENABLE;
input        APBslave_PSEL;
input  [7:0] APBslave_PWDATA;
input        APBslave_PWRITE;
input        PCLK;
input        PRESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0] APBslave_PRDATA;
output       INT;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout        COREI2C_C0_SCL;
inout        COREI2C_C0_SDA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [8:0] APBslave_PADDR;
wire         APBslave_PENABLE;
wire   [7:0] APBslave_PRDATA_net_0;
wire         APBslave_PSEL;
wire   [7:0] APBslave_PWDATA;
wire         APBslave_PWRITE;
wire         COREI2C_C0_0_SCL_BIBUF_Y;
wire   [0:0] COREI2C_C0_0_SCLO0to0;
wire         COREI2C_C0_0_SDA_BIBUF_Y;
wire   [0:0] COREI2C_C0_0_SDAO0to0;
wire         COREI2C_C0_SCL;
wire         COREI2C_C0_SDA;
wire   [0:0] INT_net_0;
wire         PCLK;
wire         PRESETN;
wire         INT_net_1;
wire   [7:0] APBslave_PRDATA_net_1;
wire   [0:0] INT_net_2;
wire   [0:0] SCLI_net_0;
wire   [0:0] SCLO_net_0;
wire   [0:0] SDAI_net_0;
wire   [0:0] SDAO_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         GND_net;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire   [0:0] SCLO_OUT_PRE_INV0_0;
wire   [0:0] SDAO_OUT_PRE_INV1_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign COREI2C_C0_0_SCLO0to0[0] = ~ SCLO_OUT_PRE_INV0_0[0];
assign COREI2C_C0_0_SDAO0to0[0] = ~ SDAO_OUT_PRE_INV1_0[0];
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign INT_net_1             = INT_net_0[0];
assign INT                   = INT_net_1;
assign APBslave_PRDATA_net_1 = APBslave_PRDATA_net_0;
assign APBslave_PRDATA[7:0]  = APBslave_PRDATA_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign INT_net_0[0]           = INT_net_2[0];
assign SCLO_OUT_PRE_INV0_0[0] = SCLO_net_0[0];
assign SDAO_OUT_PRE_INV1_0[0] = SDAO_net_0[0];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign SCLI_net_0[0] = { COREI2C_C0_0_SCL_BIBUF_Y };
assign SDAI_net_0[0] = { COREI2C_C0_0_SDA_BIBUF_Y };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------COREI2C_C0
COREI2C_C0 COREI2C_C0_0(
        // Inputs
        .PCLK    ( PCLK ),
        .PRESETN ( PRESETN ),
        .SCLI    ( SCLI_net_0 ),
        .SDAI    ( SDAI_net_0 ),
        .PADDR   ( APBslave_PADDR ),
        .PENABLE ( APBslave_PENABLE ),
        .PSEL    ( APBslave_PSEL ),
        .PWDATA  ( APBslave_PWDATA ),
        .PWRITE  ( APBslave_PWRITE ),
        // Outputs
        .INT     ( INT_net_2 ),
        .SCLO    ( SCLO_net_0 ),
        .SDAO    ( SDAO_net_0 ),
        .PRDATA  ( APBslave_PRDATA_net_0 ) 
        );

//--------BIBUF
BIBUF COREI2C_C0_0_SCL_BIBUF(
        // Inputs
        .D   ( GND_net ),
        .E   ( COREI2C_C0_0_SCLO0to0 ),
        // Outputs
        .Y   ( COREI2C_C0_0_SCL_BIBUF_Y ),
        // Inouts
        .PAD ( COREI2C_C0_SCL ) 
        );

//--------BIBUF
BIBUF COREI2C_C0_0_SDA_BIBUF(
        // Inputs
        .D   ( GND_net ),
        .E   ( COREI2C_C0_0_SDAO0to0 ),
        // Outputs
        .Y   ( COREI2C_C0_0_SDA_BIBUF_Y ),
        // Inouts
        .PAD ( COREI2C_C0_SDA ) 
        );


endmodule
