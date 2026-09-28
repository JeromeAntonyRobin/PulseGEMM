//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:45 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FIC_3_PERIPHERALS
module FIC_3_PERIPHERALS(
    // Inputs
    APB_MMASTER_in_paddr,
    APB_MMASTER_in_penable,
    APB_MMASTER_in_psel,
    APB_MMASTER_in_pwdata,
    APB_MMASTER_in_pwrite,
    CoreUARTapb_RX,
    PCLK,
    PLL0_SW_DRI_INTERRUPT,
    PLL0_SW_DRI_RDATA,
    PRESETN,
    PSTRB,
    // Outputs
    APB_MMASTER_in_prdata,
    APB_MMASTER_in_pready,
    APB_MMASTER_in_pslverr,
    CORE_I2C_C0_INT,
    CoreUARTapb_TX,
    FRAMING_ERR,
    GPIO_OUT,
    IHC_MP_APP_E51_IRQ,
    IHC_MP_APP_U54_1_IRQ,
    IHC_MP_APP_U54_2_IRQ,
    IHC_MP_APP_U54_3_IRQ,
    IHC_MP_APP_U54_4_IRQ,
    OVERFLOW,
    PARITY_ERR,
    PLL0_SW_DRI_CTRL,
    PWM_0,
    Q0_LANE0_DRI_DRI_ARST_N,
    Q0_LANE0_DRI_DRI_CLK,
    Q0_LANE0_DRI_DRI_WDATA,
    RXRDY,
    SPISCLKO,
    SPISDO,
    SPISS,
    TXRDY,
    // Inouts
    COREI2C_C0_SCL,
    COREI2C_C0_SDA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_MMASTER_in_paddr;
input         APB_MMASTER_in_penable;
input         APB_MMASTER_in_psel;
input  [31:0] APB_MMASTER_in_pwdata;
input         APB_MMASTER_in_pwrite;
input         CoreUARTapb_RX;
input         PCLK;
input         PLL0_SW_DRI_INTERRUPT;
input  [32:0] PLL0_SW_DRI_RDATA;
input         PRESETN;
input  [3:0]  PSTRB;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_MMASTER_in_prdata;
output        APB_MMASTER_in_pready;
output        APB_MMASTER_in_pslverr;
output        CORE_I2C_C0_INT;
output        CoreUARTapb_TX;
output        FRAMING_ERR;
output [6:0]  GPIO_OUT;
output        IHC_MP_APP_E51_IRQ;
output        IHC_MP_APP_U54_1_IRQ;
output        IHC_MP_APP_U54_2_IRQ;
output        IHC_MP_APP_U54_3_IRQ;
output        IHC_MP_APP_U54_4_IRQ;
output        OVERFLOW;
output        PARITY_ERR;
output [10:0] PLL0_SW_DRI_CTRL;
output        PWM_0;
output        Q0_LANE0_DRI_DRI_ARST_N;
output        Q0_LANE0_DRI_DRI_CLK;
output [32:0] Q0_LANE0_DRI_DRI_WDATA;
output        RXRDY;
output        SPISCLKO;
output        SPISDO;
output        SPISS;
output        TXRDY;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         COREI2C_C0_SCL;
inout         COREI2C_C0_SDA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB_MMASTER_in_paddr;
wire          APB_MMASTER_in_penable;
wire   [31:0] APB_MMASTER_PRDATA;
wire          APB_MMASTER_PREADY;
wire          APB_MMASTER_in_psel;
wire          APB_MMASTER_PSLVERR;
wire   [31:0] APB_MMASTER_in_pwdata;
wire          APB_MMASTER_in_pwrite;
wire          CORE_I2C_C0_INT_net_0;
wire          COREI2C_C0_SCL;
wire          COREI2C_C0_SDA;
wire          CoreUARTapb_RX;
wire          CoreUARTapb_TX_net_0;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PADDR;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PENABLE;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PRDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSLVERR;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWRITE;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PENABLE;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PRDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSLVERR;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWRITE;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PRDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSLVERR;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PRDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSLVERR;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSLVERR;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PRDATA;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PREADY;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSELx;
wire          FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSLVERR;
wire          FRAMING_ERR_net_0;
wire   [6:0]  GPIO_OUT_net_0;
wire          IHC_MP_APP_E51_IRQ_net_0;
wire          IHC_MP_APP_U54_1_IRQ_net_0;
wire          IHC_MP_APP_U54_2_IRQ_net_0;
wire          IHC_MP_APP_U54_3_IRQ_net_0;
wire          IHC_MP_APP_U54_4_IRQ_net_0;
wire          OVERFLOW_net_0;
wire          PARITY_ERR_net_0;
wire          PCLK;
wire          PLL0_SW_DRI_DRI_ARST_N;
wire          PLL0_SW_DRI_DRI_CLK;
wire   [10:0] PLL0_SW_DRI_DRI_CTRL;
wire          PLL0_SW_DRI_INTERRUPT;
wire   [32:0] PLL0_SW_DRI_RDATA;
wire   [32:0] PLL0_SW_DRI_DRI_WDATA;
wire          PRESETN;
wire   [3:0]  PSTRB;
wire   [0:0]  PWM_0_net_0;
wire          RXRDY_net_0;
wire          SPISCLKO_net_0;
wire          SPISDO_net_0;
wire   [0:0]  SPISS_net_0;
wire          TXRDY_net_0;
wire          APB_MMASTER_PREADY_net_0;
wire          APB_MMASTER_PSLVERR_net_0;
wire          CORE_I2C_C0_INT_net_1;
wire          CoreUARTapb_TX_net_1;
wire          FRAMING_ERR_net_1;
wire          OVERFLOW_net_1;
wire          PARITY_ERR_net_1;
wire          RXRDY_net_1;
wire          TXRDY_net_1;
wire          IHC_MP_APP_E51_IRQ_net_1;
wire          IHC_MP_APP_U54_1_IRQ_net_1;
wire          IHC_MP_APP_U54_2_IRQ_net_1;
wire          IHC_MP_APP_U54_3_IRQ_net_1;
wire          IHC_MP_APP_U54_4_IRQ_net_1;
wire          PWM_0_net_1;
wire          PLL0_SW_DRI_DRI_ARST_N_net_0;
wire          PLL0_SW_DRI_DRI_CLK_net_0;
wire          SPISCLKO_net_1;
wire          SPISDO_net_1;
wire          SPISS_net_1;
wire   [31:0] APB_MMASTER_PRDATA_net_0;
wire   [6:0]  GPIO_OUT_net_1;
wire   [10:0] PLL0_SW_DRI_DRI_CTRL_net_0;
wire   [32:0] PLL0_SW_DRI_DRI_WDATA_net_0;
wire   [1:1]  SPISS_slice_0;
wire   [2:2]  SPISS_slice_1;
wire   [3:3]  SPISS_slice_2;
wire   [4:4]  SPISS_slice_3;
wire   [5:5]  SPISS_slice_4;
wire   [6:6]  SPISS_slice_5;
wire   [7:7]  SPISS_slice_6;
wire   [0:0]  PWM_net_0;
wire   [7:0]  SPISS_net_2;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [6:0]  GPIO_IN_const_net_0;
wire          VCC_net;
wire          GND_net;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR;
wire   [28:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0;
wire   [28:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0_28to0;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0_7to0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1_7to0;
wire   [8:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2;
wire   [8:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2_8to0;
wire   [4:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3;
wire   [4:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3_4to0;
wire   [6:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4;
wire   [6:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4_6to0;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0_7to0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1_7to0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0;
wire   [31:8] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_31to8;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_7to0;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA;
wire   [31:0] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0;
wire   [31:8] FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_31to8;
wire   [7:0]  FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GPIO_IN_const_net_0 = 7'h00;
assign VCC_net             = 1'b1;
assign GND_net             = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB_MMASTER_PREADY_net_0     = APB_MMASTER_PREADY;
assign APB_MMASTER_in_pready        = APB_MMASTER_PREADY_net_0;
assign APB_MMASTER_PSLVERR_net_0    = APB_MMASTER_PSLVERR;
assign APB_MMASTER_in_pslverr       = APB_MMASTER_PSLVERR_net_0;
assign CORE_I2C_C0_INT_net_1        = CORE_I2C_C0_INT_net_0;
assign CORE_I2C_C0_INT              = CORE_I2C_C0_INT_net_1;
assign CoreUARTapb_TX_net_1         = CoreUARTapb_TX_net_0;
assign CoreUARTapb_TX               = CoreUARTapb_TX_net_1;
assign FRAMING_ERR_net_1            = FRAMING_ERR_net_0;
assign FRAMING_ERR                  = FRAMING_ERR_net_1;
assign OVERFLOW_net_1               = OVERFLOW_net_0;
assign OVERFLOW                     = OVERFLOW_net_1;
assign PARITY_ERR_net_1             = PARITY_ERR_net_0;
assign PARITY_ERR                   = PARITY_ERR_net_1;
assign RXRDY_net_1                  = RXRDY_net_0;
assign RXRDY                        = RXRDY_net_1;
assign TXRDY_net_1                  = TXRDY_net_0;
assign TXRDY                        = TXRDY_net_1;
assign IHC_MP_APP_E51_IRQ_net_1     = IHC_MP_APP_E51_IRQ_net_0;
assign IHC_MP_APP_E51_IRQ           = IHC_MP_APP_E51_IRQ_net_1;
assign IHC_MP_APP_U54_1_IRQ_net_1   = IHC_MP_APP_U54_1_IRQ_net_0;
assign IHC_MP_APP_U54_1_IRQ         = IHC_MP_APP_U54_1_IRQ_net_1;
assign IHC_MP_APP_U54_2_IRQ_net_1   = IHC_MP_APP_U54_2_IRQ_net_0;
assign IHC_MP_APP_U54_2_IRQ         = IHC_MP_APP_U54_2_IRQ_net_1;
assign IHC_MP_APP_U54_3_IRQ_net_1   = IHC_MP_APP_U54_3_IRQ_net_0;
assign IHC_MP_APP_U54_3_IRQ         = IHC_MP_APP_U54_3_IRQ_net_1;
assign IHC_MP_APP_U54_4_IRQ_net_1   = IHC_MP_APP_U54_4_IRQ_net_0;
assign IHC_MP_APP_U54_4_IRQ         = IHC_MP_APP_U54_4_IRQ_net_1;
assign PWM_0_net_1                  = PWM_0_net_0[0];
assign PWM_0                        = PWM_0_net_1;
assign PLL0_SW_DRI_DRI_ARST_N_net_0 = PLL0_SW_DRI_DRI_ARST_N;
assign Q0_LANE0_DRI_DRI_ARST_N      = PLL0_SW_DRI_DRI_ARST_N_net_0;
assign PLL0_SW_DRI_DRI_CLK_net_0    = PLL0_SW_DRI_DRI_CLK;
assign Q0_LANE0_DRI_DRI_CLK         = PLL0_SW_DRI_DRI_CLK_net_0;
assign SPISCLKO_net_1               = SPISCLKO_net_0;
assign SPISCLKO                     = SPISCLKO_net_1;
assign SPISDO_net_1                 = SPISDO_net_0;
assign SPISDO                       = SPISDO_net_1;
assign SPISS_net_1                  = SPISS_net_0[0];
assign SPISS                        = SPISS_net_1;
assign APB_MMASTER_PRDATA_net_0     = APB_MMASTER_PRDATA;
assign APB_MMASTER_in_prdata[31:0]  = APB_MMASTER_PRDATA_net_0;
assign GPIO_OUT_net_1               = GPIO_OUT_net_0;
assign GPIO_OUT[6:0]                = GPIO_OUT_net_1;
assign PLL0_SW_DRI_DRI_CTRL_net_0   = PLL0_SW_DRI_DRI_CTRL;
assign PLL0_SW_DRI_CTRL[10:0]       = PLL0_SW_DRI_DRI_CTRL_net_0;
assign PLL0_SW_DRI_DRI_WDATA_net_0  = PLL0_SW_DRI_DRI_WDATA;
assign Q0_LANE0_DRI_DRI_WDATA[32:0] = PLL0_SW_DRI_DRI_WDATA_net_0;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign PWM_0_net_0[0]   = PWM_net_0[0];
assign SPISS_net_0[0]   = SPISS_net_2[0:0];
assign SPISS_slice_0[1] = SPISS_net_2[1:1];
assign SPISS_slice_1[2] = SPISS_net_2[2:2];
assign SPISS_slice_2[3] = SPISS_net_2[3:3];
assign SPISS_slice_3[4] = SPISS_net_2[4:4];
assign SPISS_slice_4[5] = SPISS_net_2[5:5];
assign SPISS_slice_5[6] = SPISS_net_2[6:6];
assign SPISS_slice_6[7] = SPISS_net_2[7:7];
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0_28to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0_28to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR[28:0];

assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR[7:0];
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR[7:0];
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2_8to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2_8to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR[8:0];
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3_4to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3_4to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR[4:0];
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4_6to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4_6to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR[6:0];

assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA[7:0];
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA[7:0];

assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_31to8, FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_31to8 = 24'h0;
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA[7:0];

assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0 = { FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_31to8, FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_7to0 };
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_31to8 = 24'h0;
assign FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0_7to0 = FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORE_I2C_C0_0_WRAPPER
CORE_I2C_C0_0_WRAPPER CORE_I2C_C0_0_WRAPPER_1(
        // Inputs
        .APBslave_PENABLE ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .APBslave_PSEL    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PSELx ),
        .APBslave_PWRITE  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        .PCLK             ( PCLK ),
        .PRESETN          ( PRESETN ),
        .APBslave_PADDR   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_2 ),
        .APBslave_PWDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_0 ),
        // Outputs
        .INT              ( CORE_I2C_C0_INT_net_0 ),
        .APBslave_PRDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA ),
        // Inouts
        .COREI2C_C0_SCL   ( COREI2C_C0_SCL ),
        .COREI2C_C0_SDA   ( COREI2C_C0_SDA ) 
        );

//--------GPIO
GPIO COREGPIO_C0(
        // Inputs
        .PRESETN  ( PRESETN ),
        .PCLK     ( PCLK ),
        .GPIO_IN  ( GPIO_IN_const_net_0 ),
        .PADDR    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_1 ),
        .PSEL     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSELx ),
        .PENABLE  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .PWRITE   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        .PWDATA   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA ),
        // Outputs
        .INT      (  ),
        .GPIO_OUT ( GPIO_OUT_net_0 ),
        .PRDATA   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PRDATA ),
        .PREADY   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PREADY ),
        .PSLVERR  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSLVERR ) 
        );

//--------CoreUARTapb_C0
CoreUARTapb_C0 CoreUARTapb_C0_0(
        // Inputs
        .PCLK        ( PCLK ),
        .PRESETN     ( PRESETN ),
        .RX          ( CoreUARTapb_RX ),
        .PADDR       ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_3 ),
        .PSEL        ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSELx ),
        .PENABLE     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .PWRITE      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        .PWDATA      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA_1 ),
        // Outputs
        .TXRDY       ( TXRDY_net_0 ),
        .RXRDY       ( RXRDY_net_0 ),
        .PARITY_ERR  ( PARITY_ERR_net_0 ),
        .OVERFLOW    ( OVERFLOW_net_0 ),
        .TX          ( CoreUARTapb_TX_net_0 ),
        .FRAMING_ERR ( FRAMING_ERR_net_0 ),
        .PRDATA      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA ),
        .PREADY      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PREADY ),
        .PSLVERR     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSLVERR ) 
        );

//--------FIC_3_ADDRESS_GENERATION
FIC_3_ADDRESS_GENERATION FIC_3_ADDRESS_GENERATION_1(
        // Inputs
        .APB_MASTER_high_out_high_pready  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PREADY ),
        .APB_MASTER_high_out_high_pslverr ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSLVERR ),
        .APB_MMASTER_in_penable           ( APB_MMASTER_in_penable ),
        .APB_MMASTER_in_psel              ( APB_MMASTER_in_psel ),
        .APB_MMASTER_in_pwrite            ( APB_MMASTER_in_pwrite ),
        .APBmslave0_PREADYS0              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PREADY ),
        .APBmslave0_PSLVERRS0             ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSLVERR ),
        .APBmslave16_PREADYS16            ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PREADY ),
        .APBmslave16_PSLVERRS16           ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSLVERR ),
        .APBmslave1_PREADYS1              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PREADY ),
        .APBmslave1_PSLVERRS1             ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSLVERR ),
        .APBmslave2_PREADYS2              ( VCC_net ), // tied to 1'b1 from definition
        .APBmslave2_PSLVERRS2             ( GND_net ), // tied to 1'b0 from definition
        .APBmslave3_PREADYS3              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PREADY ),
        .APBmslave3_PSLVERRS3             ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSLVERR ),
        .FIC_3_0x4000_04xx_PREADYS4       ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PREADY ),
        .FIC_3_0x4000_04xx_PSLVERRS4      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSLVERR ),
        .APB_MASTER_high_out_high_prdata  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PRDATA ),
        .APB_MMASTER_in_paddr             ( APB_MMASTER_in_paddr ),
        .APB_MMASTER_in_pwdata            ( APB_MMASTER_in_pwdata ),
        .APBmslave0_PRDATAS0              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PRDATA ),
        .APBmslave16_PRDATAS16            ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PRDATA ),
        .APBmslave1_PRDATAS1              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PRDATA ),
        .APBmslave2_PRDATAS2              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PRDATA_0 ),
        .APBmslave3_PRDATAS3              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PRDATA_0 ),
        .FIC_3_0x4000_04xx_PRDATAS4       ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PRDATA ),
        // Outputs
        .APB_MASTER_high_out_high_penable ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PENABLE ),
        .APB_MASTER_high_out_high_psel    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSELx ),
        .APB_MASTER_high_out_high_pwrite  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWRITE ),
        .APB_MMASTER_in_pready            ( APB_MMASTER_PREADY ),
        .APB_MMASTER_in_pslverr           ( APB_MMASTER_PSLVERR ),
        .APBmslave0_PENABLES              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .APBmslave0_PSELS0                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSELx ),
        .APBmslave0_PWRITES               ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        .APBmslave16_PENABLES             ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PENABLE ),
        .APBmslave16_PSELS16              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx ),
        .APBmslave16_PWRITES              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWRITE ),
        .APBmslave1_PSELS1                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_01xx_PSELx ),
        .APBmslave2_PSELS2                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_02xx_PSELx ),
        .APBmslave3_PSELS3                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_03xx_PSELx ),
        .FIC_3_0x4000_04xx_PSELS4         ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSELx ),
        .APB_MASTER_high_out_high_paddr   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PADDR ),
        .APB_MASTER_high_out_high_pwdata  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWDATA ),
        .APB_MMASTER_in_prdata            ( APB_MMASTER_PRDATA ),
        .APBmslave0_PADDRS                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR ),
        .APBmslave0_PWDATAS               ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA ),
        .APBmslave16_PADDRS               ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR ),
        .APBmslave16_PWDATAS              ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWDATA ) 
        );

//--------MIV_IHC_C0
MIV_IHC_C0 MIV_IHC_C0_0(
        // Inputs
        .CORE_CLK      ( PCLK ),
        .CORE_RESETN   ( PRESETN ),
        .APB_0_PCLK    ( PCLK ),
        .APB_0_PRESETn ( PRESETN ),
        .APB_0_PADDR   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PADDR ),
        .APB_0_PENABLE ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PENABLE ),
        .APB_0_PWRITE  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWRITE ),
        .APB_0_PWDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PWDATA ),
        .APB_0_PSEL    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSELx ),
        // Outputs
        .APP_IRQ_H4    ( IHC_MP_APP_U54_4_IRQ_net_0 ),
        .APP_IRQ_H3    ( IHC_MP_APP_U54_3_IRQ_net_0 ),
        .APP_IRQ_H2    ( IHC_MP_APP_U54_2_IRQ_net_0 ),
        .APP_IRQ_H1    ( IHC_MP_APP_U54_1_IRQ_net_0 ),
        .APP_IRQ_H0    ( IHC_MP_APP_E51_IRQ_net_0 ),
        .APB_0_PRDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PRDATA ),
        .APB_0_PREADY  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PREADY ),
        .APB_0_PSLVERR ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x5xxx_xxxx_PSLVERR ) 
        );

//--------corepwm_C0
corepwm_C0 PWM(
        // Inputs
        .PCLK    ( PCLK ),
        .PRESETN ( PRESETN ),
        .PADDR   ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_0 ),
        .PENABLE ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .PSEL    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSELx ),
        .PWDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA ),
        .PWRITE  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        // Outputs
        .PWM     ( PWM_net_0 ),
        .PRDATA  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PRDATA ),
        .PREADY  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PREADY ),
        .PSLVERR ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PSLVERR ) 
        );

//--------RECONFIGURATION_INTERFACE
RECONFIGURATION_INTERFACE RECONFIGURATION_INTERFACE_0(
        // Inputs
        .PCLK                  ( PCLK ),
        .PSTRB                 ( PSTRB ),
        .PRESETN               ( PRESETN ),
        .PLL0_SW_DRI_RDATA     ( PLL0_SW_DRI_RDATA ),
        .PLL0_SW_DRI_INTERRUPT ( PLL0_SW_DRI_INTERRUPT ),
        .PSEL                  ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSELx ),
        .PENABLE               ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PENABLE ),
        .PWRITE                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWRITE ),
        .PADDR                 ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PADDR_0 ),
        .PWDATA                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PWDATA ),
        // Outputs
        .PINTERRUPT            (  ),
        .PTIMEOUT              (  ),
        .BUSERROR              (  ),
        .DRI_CLK               ( PLL0_SW_DRI_DRI_CLK ),
        .DRI_WDATA             ( PLL0_SW_DRI_DRI_WDATA ),
        .DRI_ARST_N            ( PLL0_SW_DRI_DRI_ARST_N ),
        .PLL0_SW_DRI_CTRL      ( PLL0_SW_DRI_DRI_CTRL ),
        .PRDATA                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PRDATA ),
        .PREADY                ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PREADY ),
        .PSLVERR               ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x43xx_xxxx_0x48xx_xxxx_PSLVERR ) 
        );

//--------SPI_FOR_7_SEG
SPI_FOR_7_SEG SPI_FOR_7_SEG_0(
        // Inputs
        .PCLK       ( PCLK ),
        .PRESETN    ( PRESETN ),
        .SPISSI     ( VCC_net ),
        .SPISDI     ( GND_net ),
        .SPICLKI    ( GND_net ),
        .PADDR      ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PADDR_4 ),
        .PSEL       ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSELx ),
        .PENABLE    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PENABLE ),
        .PWRITE     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWRITE ),
        .PWDATA     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_00xx_PWDATA ),
        // Outputs
        .SPIINT     (  ),
        .SPIRXAVAIL (  ),
        .SPITXRFM   (  ),
        .SPISS      ( SPISS_net_2 ),
        .SPISCLKO   ( SPISCLKO_net_0 ),
        .SPIOEN     (  ),
        .SPISDO     ( SPISDO_net_0 ),
        .SPIMODE    (  ),
        .PRDATA     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PRDATA ),
        .PREADY     ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PREADY ),
        .PSLVERR    ( FIC_3_ADDRESS_GENERATION_1_FIC_3_0x4000_04xx_PSLVERR ) 
        );


endmodule
