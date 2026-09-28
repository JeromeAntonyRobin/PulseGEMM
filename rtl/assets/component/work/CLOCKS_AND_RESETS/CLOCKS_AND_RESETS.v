//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:40 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CLOCKS_AND_RESETS
module CLOCKS_AND_RESETS(
    // Inputs
    EXT_RST_N,
    MSS_DLL_LOCKS,
    MSS_TO_FABRIC_RESETN,
    REF_CLK_50MHz,
    // Outputs
    FIC_0_CLK,
    FIC_1_CLK,
    FIC_2_CLK,
    FIC_3_CLK,
    MSS_RESETN,
    RESETN_FIC2_CLK,
    RESETN_FIC_0_CLK,
    RESETN_FIC_1_CLK,
    RESETN_FIC_3_CLK
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  EXT_RST_N;
input  MSS_DLL_LOCKS;
input  MSS_TO_FABRIC_RESETN;
input  REF_CLK_50MHz;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output FIC_0_CLK;
output FIC_1_CLK;
output FIC_2_CLK;
output FIC_3_CLK;
output MSS_RESETN;
output RESETN_FIC2_CLK;
output RESETN_FIC_0_CLK;
output RESETN_FIC_1_CLK;
output RESETN_FIC_3_CLK;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   AND3_0_Y;
wire   AND4_FABRIC_PLL_POWERDOWN_Y;
wire   CCC_FIC_x_CLK_PLL_LOCK_0;
wire   CLKINT_REF_CLK_50MHz_Y;
wire   EXT_RST_N;
wire   FIC_0_CLK_net_0;
wire   FIC_1_CLK_net_0;
wire   FIC_2_CLK_net_0;
wire   FIC_3_CLK_net_0;
wire   INIT_MONITOR_0_DEVICE_INIT_DONE;
wire   INIT_MONITOR_0_FABRIC_POR_N;
wire   MSS_DLL_LOCKS;
wire   MSS_TO_FABRIC_RESETN;
wire   REF_CLK_50MHz;
wire   RESET_FIC_0_CLK_PLL_POWERDOWN_B;
wire   RESET_FIC_1_CLK_PLL_POWERDOWN_B;
wire   RESET_FIC_2_CLK_PLL_POWERDOWN_B;
wire   RESET_FIC_3_CLK_PLL_POWERDOWN_B;
wire   RESETN_FIC2_CLK_net_0;
wire   RESETN_FIC_0_CLK_net_0;
wire   RESETN_FIC_1_CLK_net_0;
wire   RESETN_FIC_3_CLK_net_0;
wire   FIC_0_CLK_net_1;
wire   FIC_1_CLK_net_1;
wire   FIC_2_CLK_net_1;
wire   FIC_3_CLK_net_1;
wire   EXT_RST_N_net_0;
wire   RESETN_FIC2_CLK_net_1;
wire   RESETN_FIC_0_CLK_net_1;
wire   RESETN_FIC_1_CLK_net_1;
wire   RESETN_FIC_3_CLK_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   VCC_net;
wire   GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FIC_0_CLK_net_1        = FIC_0_CLK_net_0;
assign FIC_0_CLK              = FIC_0_CLK_net_1;
assign FIC_1_CLK_net_1        = FIC_1_CLK_net_0;
assign FIC_1_CLK              = FIC_1_CLK_net_1;
assign FIC_2_CLK_net_1        = FIC_2_CLK_net_0;
assign FIC_2_CLK              = FIC_2_CLK_net_1;
assign FIC_3_CLK_net_1        = FIC_3_CLK_net_0;
assign FIC_3_CLK              = FIC_3_CLK_net_1;
assign EXT_RST_N_net_0        = EXT_RST_N;
assign MSS_RESETN             = EXT_RST_N_net_0;
assign RESETN_FIC2_CLK_net_1  = RESETN_FIC2_CLK_net_0;
assign RESETN_FIC2_CLK        = RESETN_FIC2_CLK_net_1;
assign RESETN_FIC_0_CLK_net_1 = RESETN_FIC_0_CLK_net_0;
assign RESETN_FIC_0_CLK       = RESETN_FIC_0_CLK_net_1;
assign RESETN_FIC_1_CLK_net_1 = RESETN_FIC_1_CLK_net_0;
assign RESETN_FIC_1_CLK       = RESETN_FIC_1_CLK_net_1;
assign RESETN_FIC_3_CLK_net_1 = RESETN_FIC_3_CLK_net_0;
assign RESETN_FIC_3_CLK       = RESETN_FIC_3_CLK_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND3
AND3 AND3_0(
        // Inputs
        .A ( EXT_RST_N ),
        .B ( MSS_DLL_LOCKS ),
        .C ( MSS_TO_FABRIC_RESETN ),
        // Outputs
        .Y ( AND3_0_Y ) 
        );

//--------AND4
AND4 AND4_FABRIC_PLL_POWERDOWN(
        // Inputs
        .A ( RESET_FIC_0_CLK_PLL_POWERDOWN_B ),
        .B ( RESET_FIC_1_CLK_PLL_POWERDOWN_B ),
        .C ( RESET_FIC_2_CLK_PLL_POWERDOWN_B ),
        .D ( RESET_FIC_3_CLK_PLL_POWERDOWN_B ),
        // Outputs
        .Y ( AND4_FABRIC_PLL_POWERDOWN_Y ) 
        );

//--------PF_CCC_C0
PF_CCC_C0 CCC_FIC_x_CLK(
        // Inputs
        .REF_CLK_0         ( CLKINT_REF_CLK_50MHz_Y ),
        .PLL_POWERDOWN_N_0 ( AND4_FABRIC_PLL_POWERDOWN_Y ),
        // Outputs
        .OUT0_FABCLK_0     ( FIC_0_CLK_net_0 ),
        .OUT1_FABCLK_0     ( FIC_1_CLK_net_0 ),
        .OUT2_FABCLK_0     ( FIC_2_CLK_net_0 ),
        .OUT3_FABCLK_0     ( FIC_3_CLK_net_0 ),
        .PLL_LOCK_0        ( CCC_FIC_x_CLK_PLL_LOCK_0 ) 
        );

//--------CLKINT
CLKINT CLKINT_REF_CLK_50MHz(
        // Inputs
        .A ( REF_CLK_50MHz ),
        // Outputs
        .Y ( CLKINT_REF_CLK_50MHz_Y ) 
        );

//--------INIT_MONITOR
INIT_MONITOR INIT_MONITOR_0(
        // Outputs
        .FABRIC_POR_N               ( INIT_MONITOR_0_FABRIC_POR_N ),
        .PCIE_INIT_DONE             (  ),
        .USRAM_INIT_DONE            (  ),
        .SRAM_INIT_DONE             (  ),
        .DEVICE_INIT_DONE           ( INIT_MONITOR_0_DEVICE_INIT_DONE ),
        .XCVR_INIT_DONE             (  ),
        .USRAM_INIT_FROM_SNVM_DONE  (  ),
        .USRAM_INIT_FROM_UPROM_DONE (  ),
        .USRAM_INIT_FROM_SPI_DONE   (  ),
        .SRAM_INIT_FROM_SNVM_DONE   (  ),
        .SRAM_INIT_FROM_UPROM_DONE  (  ),
        .SRAM_INIT_FROM_SPI_DONE    (  ),
        .AUTOCALIB_DONE             (  ) 
        );

//--------CORERESET
CORERESET RESET_FIC_0_CLK(
        // Inputs
        .CLK                ( FIC_0_CLK_net_0 ),
        .EXT_RST_N          ( AND3_0_Y ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( CCC_FIC_x_CLK_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_MONITOR_0_DEVICE_INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    ( RESET_FIC_0_CLK_PLL_POWERDOWN_B ),
        .FABRIC_RESET_N     ( RESETN_FIC_0_CLK_net_0 ) 
        );

//--------CORERESET
CORERESET RESET_FIC_1_CLK(
        // Inputs
        .CLK                ( FIC_1_CLK_net_0 ),
        .EXT_RST_N          ( AND3_0_Y ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( CCC_FIC_x_CLK_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_MONITOR_0_DEVICE_INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    ( RESET_FIC_1_CLK_PLL_POWERDOWN_B ),
        .FABRIC_RESET_N     ( RESETN_FIC_1_CLK_net_0 ) 
        );

//--------CORERESET
CORERESET RESET_FIC_2_CLK(
        // Inputs
        .CLK                ( FIC_2_CLK_net_0 ),
        .EXT_RST_N          ( AND3_0_Y ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( CCC_FIC_x_CLK_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_MONITOR_0_DEVICE_INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    ( RESET_FIC_2_CLK_PLL_POWERDOWN_B ),
        .FABRIC_RESET_N     ( RESETN_FIC2_CLK_net_0 ) 
        );

//--------CORERESET
CORERESET RESET_FIC_3_CLK(
        // Inputs
        .CLK                ( FIC_3_CLK_net_0 ),
        .EXT_RST_N          ( AND3_0_Y ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( CCC_FIC_x_CLK_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_MONITOR_0_DEVICE_INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    ( RESET_FIC_3_CLK_PLL_POWERDOWN_B ),
        .FABRIC_RESET_N     ( RESETN_FIC_3_CLK_net_0 ) 
        );


endmodule
