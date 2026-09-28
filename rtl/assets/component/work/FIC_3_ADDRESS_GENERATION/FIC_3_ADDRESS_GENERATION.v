//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:44 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FIC_3_ADDRESS_GENERATION
module FIC_3_ADDRESS_GENERATION(
    // Inputs
    APB_MASTER_high_out_high_prdata,
    APB_MASTER_high_out_high_pready,
    APB_MASTER_high_out_high_pslverr,
    APB_MMASTER_in_paddr,
    APB_MMASTER_in_penable,
    APB_MMASTER_in_psel,
    APB_MMASTER_in_pwdata,
    APB_MMASTER_in_pwrite,
    APBmslave0_PRDATAS0,
    APBmslave0_PREADYS0,
    APBmslave0_PSLVERRS0,
    APBmslave16_PRDATAS16,
    APBmslave16_PREADYS16,
    APBmslave16_PSLVERRS16,
    APBmslave1_PRDATAS1,
    APBmslave1_PREADYS1,
    APBmslave1_PSLVERRS1,
    APBmslave2_PRDATAS2,
    APBmslave2_PREADYS2,
    APBmslave2_PSLVERRS2,
    APBmslave3_PRDATAS3,
    APBmslave3_PREADYS3,
    APBmslave3_PSLVERRS3,
    FIC_3_0x4000_04xx_PRDATAS4,
    FIC_3_0x4000_04xx_PREADYS4,
    FIC_3_0x4000_04xx_PSLVERRS4,
    // Outputs
    APB_MASTER_high_out_high_paddr,
    APB_MASTER_high_out_high_penable,
    APB_MASTER_high_out_high_psel,
    APB_MASTER_high_out_high_pwdata,
    APB_MASTER_high_out_high_pwrite,
    APB_MMASTER_in_prdata,
    APB_MMASTER_in_pready,
    APB_MMASTER_in_pslverr,
    APBmslave0_PADDRS,
    APBmslave0_PENABLES,
    APBmslave0_PSELS0,
    APBmslave0_PWDATAS,
    APBmslave0_PWRITES,
    APBmslave16_PADDRS,
    APBmslave16_PENABLES,
    APBmslave16_PSELS16,
    APBmslave16_PWDATAS,
    APBmslave16_PWRITES,
    APBmslave1_PSELS1,
    APBmslave2_PSELS2,
    APBmslave3_PSELS3,
    FIC_3_0x4000_04xx_PSELS4
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_MASTER_high_out_high_prdata;
input         APB_MASTER_high_out_high_pready;
input         APB_MASTER_high_out_high_pslverr;
input  [31:0] APB_MMASTER_in_paddr;
input         APB_MMASTER_in_penable;
input         APB_MMASTER_in_psel;
input  [31:0] APB_MMASTER_in_pwdata;
input         APB_MMASTER_in_pwrite;
input  [31:0] APBmslave0_PRDATAS0;
input         APBmslave0_PREADYS0;
input         APBmslave0_PSLVERRS0;
input  [31:0] APBmslave16_PRDATAS16;
input         APBmslave16_PREADYS16;
input         APBmslave16_PSLVERRS16;
input  [31:0] APBmslave1_PRDATAS1;
input         APBmslave1_PREADYS1;
input         APBmslave1_PSLVERRS1;
input  [31:0] APBmslave2_PRDATAS2;
input         APBmslave2_PREADYS2;
input         APBmslave2_PSLVERRS2;
input  [31:0] APBmslave3_PRDATAS3;
input         APBmslave3_PREADYS3;
input         APBmslave3_PSLVERRS3;
input  [31:0] FIC_3_0x4000_04xx_PRDATAS4;
input         FIC_3_0x4000_04xx_PREADYS4;
input         FIC_3_0x4000_04xx_PSLVERRS4;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_MASTER_high_out_high_paddr;
output        APB_MASTER_high_out_high_penable;
output        APB_MASTER_high_out_high_psel;
output [31:0] APB_MASTER_high_out_high_pwdata;
output        APB_MASTER_high_out_high_pwrite;
output [31:0] APB_MMASTER_in_prdata;
output        APB_MMASTER_in_pready;
output        APB_MMASTER_in_pslverr;
output [31:0] APBmslave0_PADDRS;
output        APBmslave0_PENABLES;
output        APBmslave0_PSELS0;
output [31:0] APBmslave0_PWDATAS;
output        APBmslave0_PWRITES;
output [31:0] APBmslave16_PADDRS;
output        APBmslave16_PENABLES;
output        APBmslave16_PSELS16;
output [31:0] APBmslave16_PWDATAS;
output        APBmslave16_PWRITES;
output        APBmslave1_PSELS1;
output        APBmslave2_PSELS2;
output        APBmslave3_PSELS3;
output        FIC_3_0x4000_04xx_PSELS4;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB_ARBITER_0_APB_MASTER_low_PADDR;
wire          APB_ARBITER_0_APB_MASTER_low_PENABLE;
wire   [31:0] APB_ARBITER_0_APB_MASTER_low_PRDATA;
wire          APB_ARBITER_0_APB_MASTER_low_PREADY;
wire          APB_ARBITER_0_APB_MASTER_low_PSELx;
wire          APB_ARBITER_0_APB_MASTER_low_PSLVERR;
wire   [31:0] APB_ARBITER_0_APB_MASTER_low_PWDATA;
wire          APB_ARBITER_0_APB_MASTER_low_PWRITE;
wire   [31:0] APB_MMASTER_in_paddr;
wire          APB_MMASTER_in_penable;
wire   [31:0] APB_MMASTER_PRDATA;
wire          APB_MMASTER_PREADY;
wire          APB_MMASTER_in_psel;
wire          APB_MMASTER_PSLVERR;
wire   [31:0] APB_MMASTER_in_pwdata;
wire          APB_MMASTER_in_pwrite;
wire   [31:0] APB_PASS_THROUGH_0_APB_INITIATOR_PADDR;
wire          APB_PASS_THROUGH_0_APB_INITIATOR_PENABLE;
wire   [31:0] APB_PASS_THROUGH_0_APB_INITIATOR_PRDATA;
wire          APB_PASS_THROUGH_0_APB_INITIATOR_PREADY;
wire          APB_PASS_THROUGH_0_APB_INITIATOR_PSELx;
wire          APB_PASS_THROUGH_0_APB_INITIATOR_PSLVERR;
wire   [31:0] APB_PASS_THROUGH_0_APB_INITIATOR_PWDATA;
wire          APB_PASS_THROUGH_0_APB_INITIATOR_PWRITE;
wire   [31:0] FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE;
wire   [31:0] FIC_3_0x4xxx_xxxx_0_APBmslave0_PRDATA;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PREADY;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PSELx;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PSLVERR;
wire   [31:0] FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE;
wire   [31:0] FIC_3_0x5xxx_xxxx_PADDR;
wire          FIC_3_0x5xxx_xxxx_PENABLE;
wire   [31:0] APB_MASTER_high_out_high_prdata;
wire          APB_MASTER_high_out_high_pready;
wire          FIC_3_0x5xxx_xxxx_PSELx;
wire          APB_MASTER_high_out_high_pslverr;
wire   [31:0] FIC_3_0x5xxx_xxxx_PWDATA;
wire          FIC_3_0x5xxx_xxxx_PWRITE;
wire   [31:0] APBmslave16_PRDATAS16;
wire          APBmslave16_PREADYS16;
wire          FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx;
wire          APBmslave16_PSLVERRS16;
wire   [31:0] FIC_3_0x4000_00xx_PADDR;
wire          FIC_3_0x4000_00xx_PENABLE;
wire   [31:0] APBmslave0_PRDATAS0;
wire          APBmslave0_PREADYS0;
wire          FIC_3_0x4000_00xx_PSELx;
wire          APBmslave0_PSLVERRS0;
wire   [31:0] FIC_3_0x4000_00xx_PWDATA;
wire          FIC_3_0x4000_00xx_PWRITE;
wire   [31:0] APBmslave1_PRDATAS1;
wire          APBmslave1_PREADYS1;
wire          FIC_3_0x4000_01xx_PSELx;
wire          APBmslave1_PSLVERRS1;
wire   [31:0] APBmslave2_PRDATAS2;
wire          APBmslave2_PREADYS2;
wire          FIC_3_0x4000_02xx_PSELx;
wire          APBmslave2_PSLVERRS2;
wire   [31:0] APBmslave3_PRDATAS3;
wire          APBmslave3_PREADYS3;
wire          FIC_3_0x4000_03xx_PSELx;
wire          APBmslave3_PSLVERRS3;
wire   [31:0] FIC_3_0x4000_04xx_PRDATAS4;
wire          FIC_3_0x4000_04xx_PREADYS4;
wire          FIC_3_0x4000_04xx_PSELx;
wire          FIC_3_0x4000_04xx_PSLVERRS4;
wire          FIC_3_0x5xxx_xxxx_PENABLE_net_0;
wire          FIC_3_0x5xxx_xxxx_PSELx_net_0;
wire          FIC_3_0x5xxx_xxxx_PWRITE_net_0;
wire          APB_MMASTER_PREADY_net_0;
wire          APB_MMASTER_PSLVERR_net_0;
wire          FIC_3_0x4000_00xx_PENABLE_net_0;
wire          FIC_3_0x4000_00xx_PSELx_net_0;
wire          FIC_3_0x4000_00xx_PWRITE_net_0;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE_net_0;
wire          FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx_net_0;
wire          FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE_net_0;
wire          FIC_3_0x4000_01xx_PSELx_net_0;
wire          FIC_3_0x4000_02xx_PSELx_net_0;
wire          FIC_3_0x4000_03xx_PSELx_net_0;
wire          FIC_3_0x4000_04xx_PSELx_net_0;
wire   [31:0] FIC_3_0x5xxx_xxxx_PADDR_net_0;
wire   [31:0] FIC_3_0x5xxx_xxxx_PWDATA_net_0;
wire   [31:0] APB_MMASTER_PRDATA_net_0;
wire   [31:0] FIC_3_0x4000_00xx_PADDR_net_0;
wire   [31:0] FIC_3_0x4000_00xx_PWDATA_net_0;
wire   [31:0] FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR_net_0;
wire   [31:0] FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FIC_3_0x5xxx_xxxx_PENABLE_net_0              = FIC_3_0x5xxx_xxxx_PENABLE;
assign APB_MASTER_high_out_high_penable             = FIC_3_0x5xxx_xxxx_PENABLE_net_0;
assign FIC_3_0x5xxx_xxxx_PSELx_net_0                = FIC_3_0x5xxx_xxxx_PSELx;
assign APB_MASTER_high_out_high_psel                = FIC_3_0x5xxx_xxxx_PSELx_net_0;
assign FIC_3_0x5xxx_xxxx_PWRITE_net_0               = FIC_3_0x5xxx_xxxx_PWRITE;
assign APB_MASTER_high_out_high_pwrite              = FIC_3_0x5xxx_xxxx_PWRITE_net_0;
assign APB_MMASTER_PREADY_net_0                     = APB_MMASTER_PREADY;
assign APB_MMASTER_in_pready                        = APB_MMASTER_PREADY_net_0;
assign APB_MMASTER_PSLVERR_net_0                    = APB_MMASTER_PSLVERR;
assign APB_MMASTER_in_pslverr                       = APB_MMASTER_PSLVERR_net_0;
assign FIC_3_0x4000_00xx_PENABLE_net_0              = FIC_3_0x4000_00xx_PENABLE;
assign APBmslave0_PENABLES                          = FIC_3_0x4000_00xx_PENABLE_net_0;
assign FIC_3_0x4000_00xx_PSELx_net_0                = FIC_3_0x4000_00xx_PSELx;
assign APBmslave0_PSELS0                            = FIC_3_0x4000_00xx_PSELx_net_0;
assign FIC_3_0x4000_00xx_PWRITE_net_0               = FIC_3_0x4000_00xx_PWRITE;
assign APBmslave0_PWRITES                           = FIC_3_0x4000_00xx_PWRITE_net_0;
assign FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE_net_0 = FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE;
assign APBmslave16_PENABLES                         = FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE_net_0;
assign FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx_net_0    = FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx;
assign APBmslave16_PSELS16                          = FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx_net_0;
assign FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE_net_0  = FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE;
assign APBmslave16_PWRITES                          = FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE_net_0;
assign FIC_3_0x4000_01xx_PSELx_net_0                = FIC_3_0x4000_01xx_PSELx;
assign APBmslave1_PSELS1                            = FIC_3_0x4000_01xx_PSELx_net_0;
assign FIC_3_0x4000_02xx_PSELx_net_0                = FIC_3_0x4000_02xx_PSELx;
assign APBmslave2_PSELS2                            = FIC_3_0x4000_02xx_PSELx_net_0;
assign FIC_3_0x4000_03xx_PSELx_net_0                = FIC_3_0x4000_03xx_PSELx;
assign APBmslave3_PSELS3                            = FIC_3_0x4000_03xx_PSELx_net_0;
assign FIC_3_0x4000_04xx_PSELx_net_0                = FIC_3_0x4000_04xx_PSELx;
assign FIC_3_0x4000_04xx_PSELS4                     = FIC_3_0x4000_04xx_PSELx_net_0;
assign FIC_3_0x5xxx_xxxx_PADDR_net_0                = FIC_3_0x5xxx_xxxx_PADDR;
assign APB_MASTER_high_out_high_paddr[31:0]         = FIC_3_0x5xxx_xxxx_PADDR_net_0;
assign FIC_3_0x5xxx_xxxx_PWDATA_net_0               = FIC_3_0x5xxx_xxxx_PWDATA;
assign APB_MASTER_high_out_high_pwdata[31:0]        = FIC_3_0x5xxx_xxxx_PWDATA_net_0;
assign APB_MMASTER_PRDATA_net_0                     = APB_MMASTER_PRDATA;
assign APB_MMASTER_in_prdata[31:0]                  = APB_MMASTER_PRDATA_net_0;
assign FIC_3_0x4000_00xx_PADDR_net_0                = FIC_3_0x4000_00xx_PADDR;
assign APBmslave0_PADDRS[31:0]                      = FIC_3_0x4000_00xx_PADDR_net_0;
assign FIC_3_0x4000_00xx_PWDATA_net_0               = FIC_3_0x4000_00xx_PWDATA;
assign APBmslave0_PWDATAS[31:0]                     = FIC_3_0x4000_00xx_PWDATA_net_0;
assign FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR_net_0   = FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR;
assign APBmslave16_PADDRS[31:0]                     = FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR_net_0;
assign FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA_net_0  = FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA;
assign APBmslave16_PWDATAS[31:0]                    = FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------APB_ARBITER
APB_ARBITER #( 
        .select_bit ( 28 ) )
APB_ARBITER_0(
        // Inputs
        .in_penable       ( APB_MMASTER_in_penable ),
        .in_psel          ( APB_MMASTER_in_psel ),
        .in_paddr         ( APB_MMASTER_in_paddr ),
        .in_pwrite        ( APB_MMASTER_in_pwrite ),
        .in_pwdata        ( APB_MMASTER_in_pwdata ),
        .out_low_prdata   ( APB_ARBITER_0_APB_MASTER_low_PRDATA ),
        .out_low_pready   ( APB_ARBITER_0_APB_MASTER_low_PREADY ),
        .out_low_pslverr  ( APB_ARBITER_0_APB_MASTER_low_PSLVERR ),
        .out_high_prdata  ( APB_MASTER_high_out_high_prdata ),
        .out_high_pready  ( APB_MASTER_high_out_high_pready ),
        .out_high_pslverr ( APB_MASTER_high_out_high_pslverr ),
        // Outputs
        .in_prdata        ( APB_MMASTER_PRDATA ),
        .in_pready        ( APB_MMASTER_PREADY ),
        .in_pslverr       ( APB_MMASTER_PSLVERR ),
        .out_low_penable  ( APB_ARBITER_0_APB_MASTER_low_PENABLE ),
        .out_low_psel     ( APB_ARBITER_0_APB_MASTER_low_PSELx ),
        .out_low_paddr    ( APB_ARBITER_0_APB_MASTER_low_PADDR ),
        .out_low_pwrite   ( APB_ARBITER_0_APB_MASTER_low_PWRITE ),
        .out_low_pwdata   ( APB_ARBITER_0_APB_MASTER_low_PWDATA ),
        .out_high_penable ( FIC_3_0x5xxx_xxxx_PENABLE ),
        .out_high_psel    ( FIC_3_0x5xxx_xxxx_PSELx ),
        .out_high_paddr   ( FIC_3_0x5xxx_xxxx_PADDR ),
        .out_high_pwrite  ( FIC_3_0x5xxx_xxxx_PWRITE ),
        .out_high_pwdata  ( FIC_3_0x5xxx_xxxx_PWDATA ) 
        );

//--------APB_PASS_THROUGH
APB_PASS_THROUGH APB_PASS_THROUGH_0(
        // Inputs
        .target_penable    ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE ),
        .target_psel       ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PSELx ),
        .target_paddr      ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR ),
        .target_pwrite     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE ),
        .target_pwdata     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA ),
        .initiator_prdata  ( APB_PASS_THROUGH_0_APB_INITIATOR_PRDATA ),
        .initiator_pready  ( APB_PASS_THROUGH_0_APB_INITIATOR_PREADY ),
        .initiator_pslverr ( APB_PASS_THROUGH_0_APB_INITIATOR_PSLVERR ),
        // Outputs
        .target_prdata     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PRDATA ),
        .target_pready     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PREADY ),
        .target_pslverr    ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PSLVERR ),
        .initiator_penable ( APB_PASS_THROUGH_0_APB_INITIATOR_PENABLE ),
        .initiator_psel    ( APB_PASS_THROUGH_0_APB_INITIATOR_PSELx ),
        .initiator_paddr   ( APB_PASS_THROUGH_0_APB_INITIATOR_PADDR ),
        .initiator_pwrite  ( APB_PASS_THROUGH_0_APB_INITIATOR_PWRITE ),
        .initiator_pwdata  ( APB_PASS_THROUGH_0_APB_INITIATOR_PWDATA ) 
        );

//--------FIC_3_0x4xxx_xxxx
FIC_3_0x4xxx_xxxx FIC_3_0x4xxx_xxxx_0(
        // Inputs
        .PADDR      ( APB_ARBITER_0_APB_MASTER_low_PADDR ),
        .PSEL       ( APB_ARBITER_0_APB_MASTER_low_PSELx ),
        .PENABLE    ( APB_ARBITER_0_APB_MASTER_low_PENABLE ),
        .PWRITE     ( APB_ARBITER_0_APB_MASTER_low_PWRITE ),
        .PWDATA     ( APB_ARBITER_0_APB_MASTER_low_PWDATA ),
        .PRDATAS0   ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PRDATA ),
        .PREADYS0   ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PREADY ),
        .PSLVERRS0  ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PSLVERR ),
        .PRDATAS16  ( APBmslave16_PRDATAS16 ),
        .PREADYS16  ( APBmslave16_PREADYS16 ),
        .PSLVERRS16 ( APBmslave16_PSLVERRS16 ),
        // Outputs
        .PRDATA     ( APB_ARBITER_0_APB_MASTER_low_PRDATA ),
        .PREADY     ( APB_ARBITER_0_APB_MASTER_low_PREADY ),
        .PSLVERR    ( APB_ARBITER_0_APB_MASTER_low_PSLVERR ),
        .PADDRS     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PADDR ),
        .PSELS0     ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PSELx ),
        .PENABLES   ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PENABLE ),
        .PWRITES    ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PWRITE ),
        .PWDATAS    ( FIC_3_0x4xxx_xxxx_0_APBmslave0_PWDATA ),
        .PSELS16    ( FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx ) 
        );

//--------FIC_3_0x4000_0xxx
FIC_3_0x4000_0xxx FIC_3_0x4000_0xxx_0(
        // Inputs
        .PADDR     ( APB_PASS_THROUGH_0_APB_INITIATOR_PADDR ),
        .PSEL      ( APB_PASS_THROUGH_0_APB_INITIATOR_PSELx ),
        .PENABLE   ( APB_PASS_THROUGH_0_APB_INITIATOR_PENABLE ),
        .PWRITE    ( APB_PASS_THROUGH_0_APB_INITIATOR_PWRITE ),
        .PWDATA    ( APB_PASS_THROUGH_0_APB_INITIATOR_PWDATA ),
        .PRDATAS0  ( APBmslave0_PRDATAS0 ),
        .PREADYS0  ( APBmslave0_PREADYS0 ),
        .PSLVERRS0 ( APBmslave0_PSLVERRS0 ),
        .PRDATAS1  ( APBmslave1_PRDATAS1 ),
        .PREADYS1  ( APBmslave1_PREADYS1 ),
        .PSLVERRS1 ( APBmslave1_PSLVERRS1 ),
        .PRDATAS2  ( APBmslave2_PRDATAS2 ),
        .PREADYS2  ( APBmslave2_PREADYS2 ),
        .PSLVERRS2 ( APBmslave2_PSLVERRS2 ),
        .PRDATAS3  ( APBmslave3_PRDATAS3 ),
        .PREADYS3  ( APBmslave3_PREADYS3 ),
        .PSLVERRS3 ( APBmslave3_PSLVERRS3 ),
        .PRDATAS4  ( FIC_3_0x4000_04xx_PRDATAS4 ),
        .PREADYS4  ( FIC_3_0x4000_04xx_PREADYS4 ),
        .PSLVERRS4 ( FIC_3_0x4000_04xx_PSLVERRS4 ),
        // Outputs
        .PRDATA    ( APB_PASS_THROUGH_0_APB_INITIATOR_PRDATA ),
        .PREADY    ( APB_PASS_THROUGH_0_APB_INITIATOR_PREADY ),
        .PSLVERR   ( APB_PASS_THROUGH_0_APB_INITIATOR_PSLVERR ),
        .PADDRS    ( FIC_3_0x4000_00xx_PADDR ),
        .PSELS0    ( FIC_3_0x4000_00xx_PSELx ),
        .PENABLES  ( FIC_3_0x4000_00xx_PENABLE ),
        .PWRITES   ( FIC_3_0x4000_00xx_PWRITE ),
        .PWDATAS   ( FIC_3_0x4000_00xx_PWDATA ),
        .PSELS1    ( FIC_3_0x4000_01xx_PSELx ),
        .PSELS2    ( FIC_3_0x4000_02xx_PSELx ),
        .PSELS3    ( FIC_3_0x4000_03xx_PSELx ),
        .PSELS4    ( FIC_3_0x4000_04xx_PSELx ) 
        );


endmodule
