//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:45 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of corepwm_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS095T-1FCSG325E
# Create and Configure the core component corepwm_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:corepwm:4.5.100} -component_name {corepwm_C0} -params {\
"APB_DWIDTH:32"  \
"CONFIG_MODE:0"  \
"DAC_MODE1:false"  \
"DAC_MODE2:false"  \
"DAC_MODE3:false"  \
"DAC_MODE4:false"  \
"DAC_MODE5:false"  \
"DAC_MODE6:false"  \
"DAC_MODE7:false"  \
"DAC_MODE8:false"  \
"DAC_MODE9:false"  \
"DAC_MODE10:false"  \
"DAC_MODE11:false"  \
"DAC_MODE12:false"  \
"DAC_MODE13:false"  \
"DAC_MODE14:false"  \
"DAC_MODE15:false"  \
"DAC_MODE16:false"  \
"FIXED_PERIOD:1"  \
"FIXED_PERIOD_EN:false"  \
"FIXED_PRESCALE:0"  \
"FIXED_PRESCALE_EN:false"  \
"FIXED_PWM_NEG_EN1:false"  \
"FIXED_PWM_NEG_EN2:false"  \
"FIXED_PWM_NEG_EN3:false"  \
"FIXED_PWM_NEG_EN4:false"  \
"FIXED_PWM_NEG_EN5:false"  \
"FIXED_PWM_NEG_EN6:false"  \
"FIXED_PWM_NEG_EN7:false"  \
"FIXED_PWM_NEG_EN8:false"  \
"FIXED_PWM_NEG_EN9:false"  \
"FIXED_PWM_NEG_EN10:false"  \
"FIXED_PWM_NEG_EN11:false"  \
"FIXED_PWM_NEG_EN12:false"  \
"FIXED_PWM_NEG_EN13:false"  \
"FIXED_PWM_NEG_EN14:false"  \
"FIXED_PWM_NEG_EN15:false"  \
"FIXED_PWM_NEG_EN16:false"  \
"FIXED_PWM_NEGEDGE1:0"  \
"FIXED_PWM_NEGEDGE2:0"  \
"FIXED_PWM_NEGEDGE3:0"  \
"FIXED_PWM_NEGEDGE4:0"  \
"FIXED_PWM_NEGEDGE5:0"  \
"FIXED_PWM_NEGEDGE6:0"  \
"FIXED_PWM_NEGEDGE7:0"  \
"FIXED_PWM_NEGEDGE8:0"  \
"FIXED_PWM_NEGEDGE9:0"  \
"FIXED_PWM_NEGEDGE10:0"  \
"FIXED_PWM_NEGEDGE11:0"  \
"FIXED_PWM_NEGEDGE12:0"  \
"FIXED_PWM_NEGEDGE13:0"  \
"FIXED_PWM_NEGEDGE14:0"  \
"FIXED_PWM_NEGEDGE15:0"  \
"FIXED_PWM_NEGEDGE16:0"  \
"FIXED_PWM_POS_EN1:false"  \
"FIXED_PWM_POS_EN2:true"  \
"FIXED_PWM_POS_EN3:true"  \
"FIXED_PWM_POS_EN4:true"  \
"FIXED_PWM_POS_EN5:true"  \
"FIXED_PWM_POS_EN6:true"  \
"FIXED_PWM_POS_EN7:true"  \
"FIXED_PWM_POS_EN8:true"  \
"FIXED_PWM_POS_EN9:true"  \
"FIXED_PWM_POS_EN10:true"  \
"FIXED_PWM_POS_EN11:true"  \
"FIXED_PWM_POS_EN12:true"  \
"FIXED_PWM_POS_EN13:true"  \
"FIXED_PWM_POS_EN14:true"  \
"FIXED_PWM_POS_EN15:true"  \
"FIXED_PWM_POS_EN16:true"  \
"FIXED_PWM_POSEDGE1:0"  \
"FIXED_PWM_POSEDGE2:0"  \
"FIXED_PWM_POSEDGE3:0"  \
"FIXED_PWM_POSEDGE4:0"  \
"FIXED_PWM_POSEDGE5:0"  \
"FIXED_PWM_POSEDGE6:0"  \
"FIXED_PWM_POSEDGE7:0"  \
"FIXED_PWM_POSEDGE8:0"  \
"FIXED_PWM_POSEDGE9:0"  \
"FIXED_PWM_POSEDGE10:0"  \
"FIXED_PWM_POSEDGE11:0"  \
"FIXED_PWM_POSEDGE12:0"  \
"FIXED_PWM_POSEDGE13:0"  \
"FIXED_PWM_POSEDGE14:0"  \
"FIXED_PWM_POSEDGE15:0"  \
"FIXED_PWM_POSEDGE16:0"  \
"PWM_NUM:1"  \
"PWM_STRETCH_VALUE1:false"  \
"PWM_STRETCH_VALUE2:false"  \
"PWM_STRETCH_VALUE3:false"  \
"PWM_STRETCH_VALUE4:false"  \
"PWM_STRETCH_VALUE5:false"  \
"PWM_STRETCH_VALUE6:false"  \
"PWM_STRETCH_VALUE7:false"  \
"PWM_STRETCH_VALUE8:false"  \
"PWM_STRETCH_VALUE9:false"  \
"PWM_STRETCH_VALUE10:false"  \
"PWM_STRETCH_VALUE11:false"  \
"PWM_STRETCH_VALUE12:false"  \
"PWM_STRETCH_VALUE13:false"  \
"PWM_STRETCH_VALUE14:false"  \
"PWM_STRETCH_VALUE15:false"  \
"PWM_STRETCH_VALUE16:false"  \
"SEPARATE_PWM_CLK:false"  \
"SHADOW_REG_EN1:false"  \
"SHADOW_REG_EN2:false"  \
"SHADOW_REG_EN3:false"  \
"SHADOW_REG_EN4:false"  \
"SHADOW_REG_EN5:false"  \
"SHADOW_REG_EN6:false"  \
"SHADOW_REG_EN7:false"  \
"SHADOW_REG_EN8:false"  \
"SHADOW_REG_EN9:false"  \
"SHADOW_REG_EN10:false"  \
"SHADOW_REG_EN11:false"  \
"SHADOW_REG_EN12:false"  \
"SHADOW_REG_EN13:false"  \
"SHADOW_REG_EN14:false"  \
"SHADOW_REG_EN15:false"  \
"SHADOW_REG_EN16:false"  \
"TACH_EDGE1:false"  \
"TACH_EDGE2:false"  \
"TACH_EDGE3:false"  \
"TACH_EDGE4:false"  \
"TACH_EDGE5:false"  \
"TACH_EDGE6:false"  \
"TACH_EDGE7:false"  \
"TACH_EDGE8:false"  \
"TACH_EDGE9:false"  \
"TACH_EDGE10:false"  \
"TACH_EDGE11:false"  \
"TACH_EDGE12:false"  \
"TACH_EDGE13:false"  \
"TACH_EDGE14:false"  \
"TACH_EDGE15:false"  \
"TACH_EDGE16:false"  \
"TACH_NUM:1"  \
"TACHINT_ACT_LEVEL:false"   }
# Exporting Component Description of corepwm_C0 to TCL done
*/

// corepwm_C0
module corepwm_C0(
    // Inputs
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    // Outputs
    PRDATA,
    PREADY,
    PSLVERR,
    PWM
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [7:0]  PADDR;
input         PCLK;
input         PENABLE;
input         PRESETN;
input         PSEL;
input  [31:0] PWDATA;
input         PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] PRDATA;
output        PREADY;
output        PSLVERR;
output [0:0]  PWM;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [7:0]  PADDR;
wire          PENABLE;
wire   [31:0] APBslave_PRDATA;
wire          APBslave_PREADY;
wire          PSEL;
wire          APBslave_PSLVERR;
wire   [31:0] PWDATA;
wire          PWRITE;
wire          PCLK;
wire          PRESETN;
wire   [0:0]  PWM_net_0;
wire   [0:0]  PWM_net_1;
wire   [31:0] APBslave_PRDATA_net_0;
wire          APBslave_PREADY_net_0;
wire          APBslave_PSLVERR_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net    = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign PWM_net_1[0]           = PWM_net_0[0];
assign PWM[0:0]               = PWM_net_1[0];
assign APBslave_PRDATA_net_0  = APBslave_PRDATA;
assign PRDATA[31:0]           = APBslave_PRDATA_net_0;
assign APBslave_PREADY_net_0  = APBslave_PREADY;
assign PREADY                 = APBslave_PREADY_net_0;
assign APBslave_PSLVERR_net_0 = APBslave_PSLVERR;
assign PSLVERR                = APBslave_PSLVERR_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------corepwm   -   Actel:DirectCore:corepwm:4.5.100
corepwm #( 
        .APB_DWIDTH          ( 32 ),
        .CONFIG_MODE         ( 0 ),
        .DAC_MODE1           ( 0 ),
        .DAC_MODE2           ( 0 ),
        .DAC_MODE3           ( 0 ),
        .DAC_MODE4           ( 0 ),
        .DAC_MODE5           ( 0 ),
        .DAC_MODE6           ( 0 ),
        .DAC_MODE7           ( 0 ),
        .DAC_MODE8           ( 0 ),
        .DAC_MODE9           ( 0 ),
        .DAC_MODE10          ( 0 ),
        .DAC_MODE11          ( 0 ),
        .DAC_MODE12          ( 0 ),
        .DAC_MODE13          ( 0 ),
        .DAC_MODE14          ( 0 ),
        .DAC_MODE15          ( 0 ),
        .DAC_MODE16          ( 0 ),
        .FAMILY              ( 27 ),
        .FIXED_PERIOD        ( 1 ),
        .FIXED_PERIOD_EN     ( 0 ),
        .FIXED_PRESCALE      ( 0 ),
        .FIXED_PRESCALE_EN   ( 0 ),
        .FIXED_PWM_NEG_EN1   ( 0 ),
        .FIXED_PWM_NEG_EN2   ( 0 ),
        .FIXED_PWM_NEG_EN3   ( 0 ),
        .FIXED_PWM_NEG_EN4   ( 0 ),
        .FIXED_PWM_NEG_EN5   ( 0 ),
        .FIXED_PWM_NEG_EN6   ( 0 ),
        .FIXED_PWM_NEG_EN7   ( 0 ),
        .FIXED_PWM_NEG_EN8   ( 0 ),
        .FIXED_PWM_NEG_EN9   ( 0 ),
        .FIXED_PWM_NEG_EN10  ( 0 ),
        .FIXED_PWM_NEG_EN11  ( 0 ),
        .FIXED_PWM_NEG_EN12  ( 0 ),
        .FIXED_PWM_NEG_EN13  ( 0 ),
        .FIXED_PWM_NEG_EN14  ( 0 ),
        .FIXED_PWM_NEG_EN15  ( 0 ),
        .FIXED_PWM_NEG_EN16  ( 0 ),
        .FIXED_PWM_NEGEDGE1  ( 0 ),
        .FIXED_PWM_NEGEDGE2  ( 0 ),
        .FIXED_PWM_NEGEDGE3  ( 0 ),
        .FIXED_PWM_NEGEDGE4  ( 0 ),
        .FIXED_PWM_NEGEDGE5  ( 0 ),
        .FIXED_PWM_NEGEDGE6  ( 0 ),
        .FIXED_PWM_NEGEDGE7  ( 0 ),
        .FIXED_PWM_NEGEDGE8  ( 0 ),
        .FIXED_PWM_NEGEDGE9  ( 0 ),
        .FIXED_PWM_NEGEDGE10 ( 0 ),
        .FIXED_PWM_NEGEDGE11 ( 0 ),
        .FIXED_PWM_NEGEDGE12 ( 0 ),
        .FIXED_PWM_NEGEDGE13 ( 0 ),
        .FIXED_PWM_NEGEDGE14 ( 0 ),
        .FIXED_PWM_NEGEDGE15 ( 0 ),
        .FIXED_PWM_NEGEDGE16 ( 0 ),
        .FIXED_PWM_POS_EN1   ( 0 ),
        .FIXED_PWM_POS_EN2   ( 1 ),
        .FIXED_PWM_POS_EN3   ( 1 ),
        .FIXED_PWM_POS_EN4   ( 1 ),
        .FIXED_PWM_POS_EN5   ( 1 ),
        .FIXED_PWM_POS_EN6   ( 1 ),
        .FIXED_PWM_POS_EN7   ( 1 ),
        .FIXED_PWM_POS_EN8   ( 1 ),
        .FIXED_PWM_POS_EN9   ( 1 ),
        .FIXED_PWM_POS_EN10  ( 1 ),
        .FIXED_PWM_POS_EN11  ( 1 ),
        .FIXED_PWM_POS_EN12  ( 1 ),
        .FIXED_PWM_POS_EN13  ( 1 ),
        .FIXED_PWM_POS_EN14  ( 1 ),
        .FIXED_PWM_POS_EN15  ( 1 ),
        .FIXED_PWM_POS_EN16  ( 1 ),
        .FIXED_PWM_POSEDGE1  ( 0 ),
        .FIXED_PWM_POSEDGE2  ( 0 ),
        .FIXED_PWM_POSEDGE3  ( 0 ),
        .FIXED_PWM_POSEDGE4  ( 0 ),
        .FIXED_PWM_POSEDGE5  ( 0 ),
        .FIXED_PWM_POSEDGE6  ( 0 ),
        .FIXED_PWM_POSEDGE7  ( 0 ),
        .FIXED_PWM_POSEDGE8  ( 0 ),
        .FIXED_PWM_POSEDGE9  ( 0 ),
        .FIXED_PWM_POSEDGE10 ( 0 ),
        .FIXED_PWM_POSEDGE11 ( 0 ),
        .FIXED_PWM_POSEDGE12 ( 0 ),
        .FIXED_PWM_POSEDGE13 ( 0 ),
        .FIXED_PWM_POSEDGE14 ( 0 ),
        .FIXED_PWM_POSEDGE15 ( 0 ),
        .FIXED_PWM_POSEDGE16 ( 0 ),
        .PWM_NUM             ( 1 ),
        .PWM_STRETCH_VALUE1  ( 0 ),
        .PWM_STRETCH_VALUE2  ( 0 ),
        .PWM_STRETCH_VALUE3  ( 0 ),
        .PWM_STRETCH_VALUE4  ( 0 ),
        .PWM_STRETCH_VALUE5  ( 0 ),
        .PWM_STRETCH_VALUE6  ( 0 ),
        .PWM_STRETCH_VALUE7  ( 0 ),
        .PWM_STRETCH_VALUE8  ( 0 ),
        .PWM_STRETCH_VALUE9  ( 0 ),
        .PWM_STRETCH_VALUE10 ( 0 ),
        .PWM_STRETCH_VALUE11 ( 0 ),
        .PWM_STRETCH_VALUE12 ( 0 ),
        .PWM_STRETCH_VALUE13 ( 0 ),
        .PWM_STRETCH_VALUE14 ( 0 ),
        .PWM_STRETCH_VALUE15 ( 0 ),
        .PWM_STRETCH_VALUE16 ( 0 ),
        .SEPARATE_PWM_CLK    ( 0 ),
        .SHADOW_REG_EN1      ( 0 ),
        .SHADOW_REG_EN2      ( 0 ),
        .SHADOW_REG_EN3      ( 0 ),
        .SHADOW_REG_EN4      ( 0 ),
        .SHADOW_REG_EN5      ( 0 ),
        .SHADOW_REG_EN6      ( 0 ),
        .SHADOW_REG_EN7      ( 0 ),
        .SHADOW_REG_EN8      ( 0 ),
        .SHADOW_REG_EN9      ( 0 ),
        .SHADOW_REG_EN10     ( 0 ),
        .SHADOW_REG_EN11     ( 0 ),
        .SHADOW_REG_EN12     ( 0 ),
        .SHADOW_REG_EN13     ( 0 ),
        .SHADOW_REG_EN14     ( 0 ),
        .SHADOW_REG_EN15     ( 0 ),
        .SHADOW_REG_EN16     ( 0 ),
        .TACH_EDGE1          ( 0 ),
        .TACH_EDGE2          ( 0 ),
        .TACH_EDGE3          ( 0 ),
        .TACH_EDGE4          ( 0 ),
        .TACH_EDGE5          ( 0 ),
        .TACH_EDGE6          ( 0 ),
        .TACH_EDGE7          ( 0 ),
        .TACH_EDGE8          ( 0 ),
        .TACH_EDGE9          ( 0 ),
        .TACH_EDGE10         ( 0 ),
        .TACH_EDGE11         ( 0 ),
        .TACH_EDGE12         ( 0 ),
        .TACH_EDGE13         ( 0 ),
        .TACH_EDGE14         ( 0 ),
        .TACH_EDGE15         ( 0 ),
        .TACH_EDGE16         ( 0 ),
        .TACH_NUM            ( 1 ),
        .TACHINT_ACT_LEVEL   ( 0 ) )
corepwm_C0_0(
        // Inputs
        .PADDR   ( PADDR ),
        .PCLK    ( PCLK ),
        .PENABLE ( PENABLE ),
        .PRESETN ( PRESETN ),
        .PSEL    ( PSEL ),
        .PWDATA  ( PWDATA ),
        .TACHIN  ( GND_net ), // tied to 1'b0 from definition
        .PWRITE  ( PWRITE ),
        .PWM_CLK ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .PRDATA  ( APBslave_PRDATA ),
        .PREADY  ( APBslave_PREADY ),
        .PSLVERR ( APBslave_PSLVERR ),
        .TACHINT (  ),
        .PWM     ( PWM_net_0 ) 
        );


endmodule
