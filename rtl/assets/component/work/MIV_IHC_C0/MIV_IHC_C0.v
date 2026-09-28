//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:45 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of MIV_IHC_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS095T-1FCSG325E
# Create and Configure the core component MIV_IHC_C0
create_and_configure_core -core_vlnv {Microchip:MiV:MIV_IHC:2.0.100} -component_name {MIV_IHC_C0} -params {\
"H0_IHCIM_EN:true"  \
"H0_MONITOR_EN:false"  \
"H0_TO_H1_CH_EN:true"  \
"H0_TO_H2_CH_EN:true"  \
"H0_TO_H3_CH_EN:true"  \
"H0_TO_H4_CH_EN:true"  \
"H0_TO_H5_CH_EN:false"  \
"H1_IHCIM_EN:true"  \
"H1_TO_H2_CH_EN:true"  \
"H1_TO_H3_CH_EN:true"  \
"H1_TO_H4_CH_EN:true"  \
"H1_TO_H5_CH_EN:false"  \
"H2_IHCIM_EN:true"  \
"H2_TO_H3_CH_EN:true"  \
"H2_TO_H4_CH_EN:true"  \
"H2_TO_H5_CH_EN:false"  \
"H3_IHCIM_EN:true"  \
"H3_TO_H4_CH_EN:true"  \
"H3_TO_H5_CH_EN:false"  \
"H4_IHCIM_EN:true"  \
"H4_TO_H5_CH_EN:false"  \
"H5_IHCIM_EN:false"  \
"INF_0_CDC_EN:false"  \
"INF_0_H0_ACCESS:false"  \
"INF_0_H1_ACCESS:false"  \
"INF_0_H2_ACCESS:false"  \
"INF_0_H3_ACCESS:false"  \
"INF_0_H4_ACCESS:false"  \
"INF_0_H5_ACCESS:false"  \
"INF_0_TYPE:1"  \
"INF_0_TYPE_MIRROR:true"  \
"INF_1_CDC_EN:false"  \
"INF_1_H0_ACCESS:false"  \
"INF_1_H1_ACCESS:false"  \
"INF_1_H2_ACCESS:false"  \
"INF_1_H3_ACCESS:false"  \
"INF_1_H4_ACCESS:false"  \
"INF_1_H5_ACCESS:false"  \
"INF_1_TYPE:0"  \
"INF_1_TYPE_MIRROR:false"  \
"INF_2_CDC_EN:false"  \
"INF_2_H0_ACCESS:false"  \
"INF_2_H1_ACCESS:false"  \
"INF_2_H2_ACCESS:false"  \
"INF_2_H3_ACCESS:false"  \
"INF_2_H4_ACCESS:false"  \
"INF_2_H5_ACCESS:false"  \
"INF_2_TYPE:0"  \
"INF_2_TYPE_MIRROR:false"  \
"MPU_EN:false"   }
# Exporting Component Description of MIV_IHC_C0 to TCL done
*/

// MIV_IHC_C0
module MIV_IHC_C0(
    // Inputs
    APB_0_PADDR,
    APB_0_PCLK,
    APB_0_PENABLE,
    APB_0_PRESETn,
    APB_0_PSEL,
    APB_0_PWDATA,
    APB_0_PWRITE,
    CORE_CLK,
    CORE_RESETN,
    // Outputs
    APB_0_PRDATA,
    APB_0_PREADY,
    APB_0_PSLVERR,
    APP_IRQ_H0,
    APP_IRQ_H1,
    APP_IRQ_H2,
    APP_IRQ_H3,
    APP_IRQ_H4
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_0_PADDR;
input         APB_0_PCLK;
input         APB_0_PENABLE;
input         APB_0_PRESETn;
input         APB_0_PSEL;
input  [31:0] APB_0_PWDATA;
input         APB_0_PWRITE;
input         CORE_CLK;
input         CORE_RESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_0_PRDATA;
output        APB_0_PREADY;
output        APB_0_PSLVERR;
output        APP_IRQ_H0;
output        APP_IRQ_H1;
output        APP_IRQ_H2;
output        APP_IRQ_H3;
output        APP_IRQ_H4;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB_0_PADDR;
wire          APB_0_PENABLE;
wire   [31:0] APB_0_M_INITIATOR_PRDATA;
wire          APB_0_M_INITIATOR_PREADY;
wire          APB_0_PSEL;
wire          APB_0_M_INITIATOR_PSLVERR;
wire   [31:0] APB_0_PWDATA;
wire          APB_0_PWRITE;
wire          APB_0_PCLK;
wire          APB_0_PRESETn;
wire          APP_IRQ_H0_net_0;
wire          APP_IRQ_H1_net_0;
wire          APP_IRQ_H2_net_0;
wire          APP_IRQ_H3_net_0;
wire          APP_IRQ_H4_net_0;
wire          CORE_CLK;
wire          CORE_RESETN;
wire          APP_IRQ_H4_net_1;
wire          APP_IRQ_H3_net_1;
wire          APP_IRQ_H2_net_1;
wire          APP_IRQ_H1_net_1;
wire          APP_IRQ_H0_net_1;
wire   [31:0] APB_0_M_INITIATOR_PRDATA_net_0;
wire          APB_0_M_INITIATOR_PREADY_net_0;
wire          APB_0_M_INITIATOR_PSLVERR_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [31:0] APB_1_PADDR_const_net_0;
wire   [31:0] APB_1_PWDATA_const_net_0;
wire   [31:0] AXI_0_AWADDR_const_net_0;
wire   [2:0]  AXI_0_AWPROT_const_net_0;
wire   [31:0] AXI_0_WDATA_const_net_0;
wire   [3:0]  AXI_0_WSTRB_const_net_0;
wire   [31:0] AXI_0_ARADDR_const_net_0;
wire   [2:0]  AXI_0_ARPROT_const_net_0;
wire   [31:0] AXI_1_AWADDR_const_net_0;
wire   [2:0]  AXI_1_AWPROT_const_net_0;
wire   [31:0] AXI_1_WDATA_const_net_0;
wire   [3:0]  AXI_1_WSTRB_const_net_0;
wire   [31:0] AXI_1_ARADDR_const_net_0;
wire   [2:0]  AXI_1_ARPROT_const_net_0;
wire   [31:0] APB_2_PADDR_const_net_0;
wire   [31:0] APB_2_PWDATA_const_net_0;
wire   [31:0] AXI_2_AWADDR_const_net_0;
wire   [2:0]  AXI_2_AWPROT_const_net_0;
wire   [31:0] AXI_2_WDATA_const_net_0;
wire   [3:0]  AXI_2_WSTRB_const_net_0;
wire   [31:0] AXI_2_ARADDR_const_net_0;
wire   [2:0]  AXI_2_ARPROT_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                  = 1'b0;
assign APB_1_PADDR_const_net_0  = 32'h00000000;
assign APB_1_PWDATA_const_net_0 = 32'h00000000;
assign AXI_0_AWADDR_const_net_0 = 32'h00000000;
assign AXI_0_AWPROT_const_net_0 = 3'h0;
assign AXI_0_WDATA_const_net_0  = 32'h00000000;
assign AXI_0_WSTRB_const_net_0  = 4'hF;
assign AXI_0_ARADDR_const_net_0 = 32'h00000000;
assign AXI_0_ARPROT_const_net_0 = 3'h0;
assign AXI_1_AWADDR_const_net_0 = 32'h00000000;
assign AXI_1_AWPROT_const_net_0 = 3'h0;
assign AXI_1_WDATA_const_net_0  = 32'h00000000;
assign AXI_1_WSTRB_const_net_0  = 4'hF;
assign AXI_1_ARADDR_const_net_0 = 32'h00000000;
assign AXI_1_ARPROT_const_net_0 = 3'h0;
assign APB_2_PADDR_const_net_0  = 32'h00000000;
assign APB_2_PWDATA_const_net_0 = 32'h00000000;
assign AXI_2_AWADDR_const_net_0 = 32'h00000000;
assign AXI_2_AWPROT_const_net_0 = 3'h0;
assign AXI_2_WDATA_const_net_0  = 32'h00000000;
assign AXI_2_WSTRB_const_net_0  = 4'hF;
assign AXI_2_ARADDR_const_net_0 = 32'h00000000;
assign AXI_2_ARPROT_const_net_0 = 3'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APP_IRQ_H4_net_1                = APP_IRQ_H4_net_0;
assign APP_IRQ_H4                      = APP_IRQ_H4_net_1;
assign APP_IRQ_H3_net_1                = APP_IRQ_H3_net_0;
assign APP_IRQ_H3                      = APP_IRQ_H3_net_1;
assign APP_IRQ_H2_net_1                = APP_IRQ_H2_net_0;
assign APP_IRQ_H2                      = APP_IRQ_H2_net_1;
assign APP_IRQ_H1_net_1                = APP_IRQ_H1_net_0;
assign APP_IRQ_H1                      = APP_IRQ_H1_net_1;
assign APP_IRQ_H0_net_1                = APP_IRQ_H0_net_0;
assign APP_IRQ_H0                      = APP_IRQ_H0_net_1;
assign APB_0_M_INITIATOR_PRDATA_net_0  = APB_0_M_INITIATOR_PRDATA;
assign APB_0_PRDATA[31:0]              = APB_0_M_INITIATOR_PRDATA_net_0;
assign APB_0_M_INITIATOR_PREADY_net_0  = APB_0_M_INITIATOR_PREADY;
assign APB_0_PREADY                    = APB_0_M_INITIATOR_PREADY_net_0;
assign APB_0_M_INITIATOR_PSLVERR_net_0 = APB_0_M_INITIATOR_PSLVERR;
assign APB_0_PSLVERR                   = APB_0_M_INITIATOR_PSLVERR_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------MIV_IHC_C0_MIV_IHC_C0_0_MIV_IHC   -   Microchip:MiV:MIV_IHC:2.0.100
MIV_IHC_C0_MIV_IHC_C0_0_MIV_IHC #( 
        .FAMILY            ( 27 ),
        .H0_IHCIM_EN       ( 1 ),
        .H0_MONITOR_EN     ( 0 ),
        .H0_TO_H1_CH_EN    ( 1 ),
        .H0_TO_H2_CH_EN    ( 1 ),
        .H0_TO_H3_CH_EN    ( 1 ),
        .H0_TO_H4_CH_EN    ( 1 ),
        .H0_TO_H5_CH_EN    ( 0 ),
        .H1_IHCIM_EN       ( 1 ),
        .H1_TO_H2_CH_EN    ( 1 ),
        .H1_TO_H3_CH_EN    ( 1 ),
        .H1_TO_H4_CH_EN    ( 1 ),
        .H1_TO_H5_CH_EN    ( 0 ),
        .H2_IHCIM_EN       ( 1 ),
        .H2_TO_H3_CH_EN    ( 1 ),
        .H2_TO_H4_CH_EN    ( 1 ),
        .H2_TO_H5_CH_EN    ( 0 ),
        .H3_IHCIM_EN       ( 1 ),
        .H3_TO_H4_CH_EN    ( 1 ),
        .H3_TO_H5_CH_EN    ( 0 ),
        .H4_IHCIM_EN       ( 1 ),
        .H4_TO_H5_CH_EN    ( 0 ),
        .H5_IHCIM_EN       ( 0 ),
        .INF_0_CDC_EN      ( 0 ),
        .INF_0_H0_ACCESS   ( 0 ),
        .INF_0_H1_ACCESS   ( 0 ),
        .INF_0_H2_ACCESS   ( 0 ),
        .INF_0_H3_ACCESS   ( 0 ),
        .INF_0_H4_ACCESS   ( 0 ),
        .INF_0_H5_ACCESS   ( 0 ),
        .INF_0_TYPE        ( 1 ),
        .INF_0_TYPE_MIRROR ( 1 ),
        .INF_1_CDC_EN      ( 0 ),
        .INF_1_H0_ACCESS   ( 0 ),
        .INF_1_H1_ACCESS   ( 0 ),
        .INF_1_H2_ACCESS   ( 0 ),
        .INF_1_H3_ACCESS   ( 0 ),
        .INF_1_H4_ACCESS   ( 0 ),
        .INF_1_H5_ACCESS   ( 0 ),
        .INF_1_TYPE        ( 0 ),
        .INF_1_TYPE_MIRROR ( 0 ),
        .INF_2_CDC_EN      ( 0 ),
        .INF_2_H0_ACCESS   ( 0 ),
        .INF_2_H1_ACCESS   ( 0 ),
        .INF_2_H2_ACCESS   ( 0 ),
        .INF_2_H3_ACCESS   ( 0 ),
        .INF_2_H4_ACCESS   ( 0 ),
        .INF_2_H5_ACCESS   ( 0 ),
        .INF_2_TYPE        ( 0 ),
        .INF_2_TYPE_MIRROR ( 0 ),
        .MPU_EN            ( 0 ) )
MIV_IHC_C0_0(
        // Inputs
        .CORE_CLK      ( CORE_CLK ),
        .CORE_RESETN   ( CORE_RESETN ),
        .APB_0_PADDR   ( APB_0_PADDR ),
        .APB_0_PCLK    ( APB_0_PCLK ),
        .APB_0_PENABLE ( APB_0_PENABLE ),
        .APB_0_PRESETn ( APB_0_PRESETn ),
        .APB_0_PSEL    ( APB_0_PSEL ),
        .APB_0_PWDATA  ( APB_0_PWDATA ),
        .APB_0_PWRITE  ( APB_0_PWRITE ),
        .AXI_0_ACLK    ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_ARADDR  ( AXI_0_ARADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_0_ARESETn ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_ARVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_AWADDR  ( AXI_0_AWADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_0_AWVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_BREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_RREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_WDATA   ( AXI_0_WDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_0_WSTRB   ( AXI_0_WSTRB_const_net_0 ), // tied to 4'hF from definition
        .AXI_0_WVALID  ( GND_net ), // tied to 1'b0 from definition
        .APB_1_PADDR   ( APB_1_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_1_PCLK    ( GND_net ), // tied to 1'b0 from definition
        .APB_1_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_1_PRESETn ( GND_net ), // tied to 1'b0 from definition
        .APB_1_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_1_PWDATA  ( APB_1_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_1_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_ACLK    ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_ARADDR  ( AXI_1_ARADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_1_ARESETn ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_ARPROT  ( AXI_1_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .AXI_1_ARVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_AWADDR  ( AXI_1_AWADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_1_AWVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_BREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_RREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_1_WDATA   ( AXI_1_WDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_1_WSTRB   ( AXI_1_WSTRB_const_net_0 ), // tied to 4'hF from definition
        .AXI_1_WVALID  ( GND_net ), // tied to 1'b0 from definition
        .AXI_0_AWPROT  ( AXI_0_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .AXI_0_ARPROT  ( AXI_0_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .AXI_1_AWPROT  ( AXI_1_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .APB_2_PADDR   ( APB_2_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_2_PCLK    ( GND_net ), // tied to 1'b0 from definition
        .APB_2_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_2_PRESETn ( GND_net ), // tied to 1'b0 from definition
        .APB_2_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_2_PWDATA  ( APB_2_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_2_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_ACLK    ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_ARADDR  ( AXI_2_ARADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_2_ARESETn ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_ARPROT  ( AXI_2_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .AXI_2_ARVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_AWADDR  ( AXI_2_AWADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_2_AWPROT  ( AXI_2_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .AXI_2_AWVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_BREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_RREADY  ( GND_net ), // tied to 1'b0 from definition
        .AXI_2_WDATA   ( AXI_2_WDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_2_WSTRB   ( AXI_2_WSTRB_const_net_0 ), // tied to 4'hF from definition
        .AXI_2_WVALID  ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .APB_0_PRDATA  ( APB_0_M_INITIATOR_PRDATA ),
        .APB_0_PREADY  ( APB_0_M_INITIATOR_PREADY ),
        .APB_0_PSLVERR ( APB_0_M_INITIATOR_PSLVERR ),
        .AXI_0_ARREADY (  ),
        .AXI_0_AWREADY (  ),
        .AXI_0_BRESP   (  ),
        .AXI_0_BVALID  (  ),
        .AXI_0_RDATA   (  ),
        .AXI_0_RRESP   (  ),
        .AXI_0_RVALID  (  ),
        .AXI_0_WREADY  (  ),
        .APB_1_PRDATA  (  ),
        .APB_1_PREADY  (  ),
        .APB_1_PSLVERR (  ),
        .AXI_1_ARREADY (  ),
        .AXI_1_AWREADY (  ),
        .AXI_1_BRESP   (  ),
        .AXI_1_BVALID  (  ),
        .AXI_1_RDATA   (  ),
        .AXI_1_RRESP   (  ),
        .AXI_1_RVALID  (  ),
        .AXI_1_WREADY  (  ),
        .APB_2_PRDATA  (  ),
        .APB_2_PREADY  (  ),
        .APB_2_PSLVERR (  ),
        .AXI_2_ARREADY (  ),
        .AXI_2_AWREADY (  ),
        .AXI_2_BRESP   (  ),
        .AXI_2_BVALID  (  ),
        .AXI_2_RDATA   (  ),
        .AXI_2_RRESP   (  ),
        .AXI_2_RVALID  (  ),
        .AXI_2_WREADY  (  ),
        .APP_IRQ_H5    (  ),
        .APP_IRQ_H4    ( APP_IRQ_H4_net_0 ),
        .APP_IRQ_H3    ( APP_IRQ_H3_net_0 ),
        .APP_IRQ_H2    ( APP_IRQ_H2_net_0 ),
        .APP_IRQ_H1    ( APP_IRQ_H1_net_0 ),
        .APP_IRQ_H0    ( APP_IRQ_H0_net_0 ),
        .MON_IRQ_H5    (  ),
        .MON_IRQ_H4    (  ),
        .MON_IRQ_H3    (  ),
        .MON_IRQ_H2    (  ),
        .MON_IRQ_H1    (  ) 
        );


endmodule
