//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:46 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// MPFS_DISCOVERY_KIT
module MPFS_DISCOVERY_KIT(
    // Inputs
    DIP1,
    DIP2,
    DIP3,
    DIP4,
    DIP5,
    DIP6,
    DIP7,
    DIP8,
    FTDI_UART_D_TXD,
    MBUS_SPI_MISO,
    MBUS_UART_TXD,
    MMUART_1_RXD,
    MMUART_4_RXD,
    REFCLK,
    REFCLK_N,
    REF_CLK_50MHz,
    SD_CD,
    SGMII_RX0_N,
    SGMII_RX0_P,
    SPI_1_DI,
    SWITCH1,
    SWITCH2,
    mBUS_INT,
    // Outputs
    A,
    ACT_N,
    BA,
    BG0,
    CAS_N,
    CK0,
    CK0_N,
    CKE0,
    CS0_N,
    DM,
    FTDI_UART_D_RXD,
    GPIO_1_20_OUT,
    GPIO_1_9_OUT,
    LED1,
    LED2,
    LED3,
    LED4,
    LED5,
    LED6,
    LED7,
    MAC_0_MDC,
    MBUS_AN,
    MBUS_PWM,
    MBUS_RST,
    MBUS_SPI_MOSI,
    MBUS_UART_RXD,
    MMUART_1_TXD,
    MMUART_4_TXD,
    ODT0,
    RAS_N,
    RESET_N,
    SD_CLK,
    SD_VOLT_CMD_DIR,
    SD_VOLT_DIR_0,
    SD_VOLT_DIR_1_3,
    SD_VOLT_EN,
    SD_VOLT_SEL,
    SGMII_TX0_N,
    SGMII_TX0_P,
    SPISCLKO,
    SPISDO,
    SPISS,
    SPI_1_DO,
    VSC_RESETN,
    VSC_TXDIS_SRESETN,
    WE_N,
    // Inouts
    DQ,
    DQS,
    DQS_N,
    MBUS_I2C_SCL,
    MBUS_I2C_SDA,
    MBUS_SPI_CLK,
    MBUS_SPI_CS,
    MDIO_PAD,
    RPI_GPIO12,
    RPI_GPIO13,
    RPI_GPIO16,
    RPI_GPIO17,
    RPI_GPIO18,
    RPI_GPIO19,
    RPI_GPIO20,
    RPI_GPIO21,
    RPI_GPIO22,
    RPI_GPIO23,
    RPI_GPIO24,
    RPI_GPIO25,
    RPI_GPIO26,
    RPI_GPIO27,
    RPI_GPIO4,
    RPI_GPIO5,
    RPI_GPIO6,
    RPI_I2C_SCL,
    RPI_I2C_SDA,
    SD_CMD,
    SD_DATA0,
    SD_DATA1,
    SD_DATA2,
    SD_DATA3,
    SPI_1_CLK,
    SPI_1_SS0
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         DIP1;
input         DIP2;
input         DIP3;
input         DIP4;
input         DIP5;
input         DIP6;
input         DIP7;
input         DIP8;
input         FTDI_UART_D_TXD;
input         MBUS_SPI_MISO;
input         MBUS_UART_TXD;
input         MMUART_1_RXD;
input         MMUART_4_RXD;
input         REFCLK;
input         REFCLK_N;
input         REF_CLK_50MHz;
input         SD_CD;
input         SGMII_RX0_N;
input         SGMII_RX0_P;
input         SPI_1_DI;
input         SWITCH1;
input         SWITCH2;
input         mBUS_INT;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [13:0] A;
output        ACT_N;
output [1:0]  BA;
output        BG0;
output        CAS_N;
output        CK0;
output        CK0_N;
output        CKE0;
output        CS0_N;
output [1:0]  DM;
output        FTDI_UART_D_RXD;
output        GPIO_1_20_OUT;
output        GPIO_1_9_OUT;
output        LED1;
output        LED2;
output        LED3;
output        LED4;
output        LED5;
output        LED6;
output        LED7;
output        MAC_0_MDC;
output        MBUS_AN;
output        MBUS_PWM;
output        MBUS_RST;
output        MBUS_SPI_MOSI;
output        MBUS_UART_RXD;
output        MMUART_1_TXD;
output        MMUART_4_TXD;
output        ODT0;
output        RAS_N;
output        RESET_N;
output        SD_CLK;
output        SD_VOLT_CMD_DIR;
output        SD_VOLT_DIR_0;
output        SD_VOLT_DIR_1_3;
output        SD_VOLT_EN;
output        SD_VOLT_SEL;
output        SGMII_TX0_N;
output        SGMII_TX0_P;
output        SPISCLKO;
output        SPISDO;
output        SPISS;
output        SPI_1_DO;
output        VSC_RESETN;
output        VSC_TXDIS_SRESETN;
output        WE_N;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [15:0] DQ;
inout  [1:0]  DQS;
inout  [1:0]  DQS_N;
inout         MBUS_I2C_SCL;
inout         MBUS_I2C_SDA;
inout         MBUS_SPI_CLK;
inout         MBUS_SPI_CS;
inout         MDIO_PAD;
inout         RPI_GPIO12;
inout         RPI_GPIO13;
inout         RPI_GPIO16;
inout         RPI_GPIO17;
inout         RPI_GPIO18;
inout         RPI_GPIO19;
inout         RPI_GPIO20;
inout         RPI_GPIO21;
inout         RPI_GPIO22;
inout         RPI_GPIO23;
inout         RPI_GPIO24;
inout         RPI_GPIO25;
inout         RPI_GPIO26;
inout         RPI_GPIO27;
inout         RPI_GPIO4;
inout         RPI_GPIO5;
inout         RPI_GPIO6;
inout         RPI_I2C_SCL;
inout         RPI_I2C_SDA;
inout         SD_CMD;
inout         SD_DATA0;
inout         SD_DATA1;
inout         SD_DATA2;
inout         SD_DATA3;
inout         SPI_1_CLK;
inout         SPI_1_SS0;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [13:0] A_net_0;
wire          ACT_N_net_0;
wire   [1:0]  BA_net_0;
wire          BG0_net_0;
wire          CAS_N_net_0;
wire          CK0_net_0;
wire          CK0_N_net_0;
wire          CKE0_net_0;
wire          CLOCKS_AND_RESETS_0_FIC_0_CLK;
wire          CLOCKS_AND_RESETS_0_FIC_1_CLK;
wire          CLOCKS_AND_RESETS_0_FIC_2_CLK;
wire          CLOCKS_AND_RESETS_0_FIC_3_CLK;
wire          CLOCKS_AND_RESETS_0_MSS_RESETN;
wire          CLOCKS_AND_RESETS_0_RESETN_FIC_0_CLK;
wire          CLOCKS_AND_RESETS_0_RESETN_FIC_3_CLK;
wire          CS0_N_net_0;
wire   [1:0]  DM_net_0;
wire   [15:0] DQ;
wire   [1:0]  DQS;
wire   [1:0]  DQS_N;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARBURST;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARCACHE;
wire   [7:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARLEN;
wire   [2:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARPROT;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARQOS;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_ARREADY;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARREGION;
wire   [2:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARSIZE;
wire   [0:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARUSER;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_ARVALID;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWBURST;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWCACHE;
wire   [7:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWLEN;
wire   [2:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWPROT;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWQOS;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_AWREADY;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWREGION;
wire   [2:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWSIZE;
wire   [0:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWUSER;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_AWVALID;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_BREADY;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_BRESP;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_BVALID;
wire   [63:0] FIC_0_PERIPHERALS_0_AXI4mslave0_RDATA;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_RLAST;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_RREADY;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_RRESP;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_RVALID;
wire   [63:0] FIC_0_PERIPHERALS_0_AXI4mslave0_WDATA;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_WLAST;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_WREADY;
wire   [7:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_WSTRB;
wire   [0:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_WUSER;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_WVALID;
wire          FIC_3_PERIPHERALS_0_CORE_I2C_C0_INT;
wire          FIC_3_PERIPHERALS_0_FRAMING_ERR;
wire   [0:0]  FIC_3_PERIPHERALS_0_GPIO_OUT0to0;
wire   [1:1]  FIC_3_PERIPHERALS_0_GPIO_OUT1to1;
wire   [2:2]  FIC_3_PERIPHERALS_0_GPIO_OUT2to2;
wire   [3:3]  FIC_3_PERIPHERALS_0_GPIO_OUT3to3;
wire   [4:4]  FIC_3_PERIPHERALS_0_GPIO_OUT4to4;
wire   [5:5]  FIC_3_PERIPHERALS_0_GPIO_OUT5to5;
wire   [6:6]  FIC_3_PERIPHERALS_0_GPIO_OUT6to6;
wire          FIC_3_PERIPHERALS_0_IHC_MP_APP_E51_IRQ;
wire          FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_1_IRQ;
wire          FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_2_IRQ;
wire          FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_3_IRQ;
wire          FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_4_IRQ;
wire          FIC_3_PERIPHERALS_0_OVERFLOW;
wire          FIC_3_PERIPHERALS_0_PARITY_ERR;
wire          FIC_3_PERIPHERALS_0_RXRDY;
wire          FIC_3_PERIPHERALS_0_TXRDY;
wire          FTDI_UART_D_RXD_net_0;
wire          FTDI_UART_D_TXD;
wire          GPIO_1_9_OUT_net_0;
wire          GPIO_1_20_OUT_net_0;
wire          LED1_net_0;
wire          LED2_net_0;
wire          LED3_net_0;
wire          LED4_net_0;
wire          LED5_net_0;
wire          LED6_net_0;
wire          LED7_net_0;
wire          MAC_0_MDC_net_0;
wire          MBUS_I2C_SCL;
wire          MBUS_I2C_SDA;
wire          mBUS_INT;
wire          MBUS_PWM_net_0;
wire          MBUS_SPI_CLK;
wire          MBUS_SPI_CS;
wire          MBUS_SPI_MISO;
wire          MBUS_SPI_MOSI_net_0;
wire          MBUS_UART_RXD_net_0;
wire          MBUS_UART_TXD;
wire          MDIO_PAD;
wire          MMUART_1_RXD;
wire          MMUART_1_TXD_net_0;
wire          MMUART_4_RXD;
wire          MMUART_4_TXD_net_0;
wire   [37:0] MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARADDR;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARBURST;
wire   [3:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARCACHE;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARID;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLEN;
wire   [2:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARPROT;
wire   [3:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARQOS;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARREADY;
wire   [2:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARSIZE;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARVALID;
wire   [37:0] MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWADDR;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWBURST;
wire   [3:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWCACHE;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWID;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLEN;
wire   [2:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWPROT;
wire   [3:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWQOS;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWREADY;
wire   [2:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWSIZE;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWVALID;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BID;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BREADY;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BRESP;
wire   [0:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BUSER;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BVALID;
wire   [63:0] MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RDATA;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RID;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RLAST;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RREADY;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RRESP;
wire   [0:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RUSER;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RVALID;
wire   [63:0] MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WDATA;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WLAST;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WREADY;
wire   [7:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WSTRB;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WVALID;
wire   [31:0] MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PADDR;
wire          MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PENABLE;
wire   [31:0] MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PRDATA;
wire          MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PREADY;
wire          MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSELx;
wire          MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSLVERR;
wire   [31:0] MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWDATA;
wire          MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWRITE;
wire   [3:0]  MSS_WRAPPER_0_FIC_3_APB_M_PSTRB;
wire          MSS_WRAPPER_0_GPIO_2_26_OUT;
wire          MSS_WRAPPER_0_GPIO_2_27_OUT;
wire          MSS_WRAPPER_0_GPIO_2_28_OUT;
wire          MSS_WRAPPER_0_GPIO_2_M2F_17;
wire          MSS_WRAPPER_0_GPIO_2_M2F_18;
wire          MSS_WRAPPER_0_GPIO_2_M2F_19;
wire          MSS_WRAPPER_0_GPIO_2_M2F_20;
wire          MSS_WRAPPER_0_GPIO_2_M2F_21;
wire          MSS_WRAPPER_0_GPIO_2_M2F_22;
wire          MSS_WRAPPER_0_GPIO_2_M2F_23;
wire          MSS_WRAPPER_0_MSS_DLL_LOCKS;
wire          MSS_WRAPPER_0_MSS_RESET_N_M2F;
wire          ODT0_net_0;
wire          RAS_N_net_0;
wire          REF_CLK_50MHz;
wire          REFCLK;
wire          REFCLK_N;
wire          RESET_N_net_0;
wire          RPI_GPIO4;
wire          RPI_GPIO5;
wire          RPI_GPIO6;
wire          RPI_GPIO12;
wire          RPI_GPIO13;
wire          RPI_GPIO16;
wire          RPI_GPIO17;
wire          RPI_GPIO18;
wire          RPI_GPIO19;
wire          RPI_GPIO20;
wire          RPI_GPIO21;
wire          RPI_GPIO22;
wire          RPI_GPIO23;
wire          RPI_GPIO24;
wire          RPI_GPIO25;
wire          RPI_GPIO26;
wire          RPI_GPIO27;
wire          RPI_I2C_SCL;
wire          RPI_I2C_SDA;
wire          SD_CD;
wire          SD_CLK_net_0;
wire          SD_CMD;
wire          SD_DATA0;
wire          SD_DATA1;
wire          SD_DATA2;
wire          SD_DATA3;
wire          SD_VOLT_CMD_DIR_net_0;
wire          SD_VOLT_DIR_0_net_0;
wire          SD_VOLT_DIR_1_3_net_0;
wire          SD_VOLT_EN_net_0;
wire          SD_VOLT_SEL_net_0;
wire          SGMII_RX0_N;
wire          SGMII_RX0_P;
wire          SGMII_TX0_N_net_0;
wire          SGMII_TX0_P_net_0;
wire          SPI_1_CLK;
wire          SPI_1_DI;
wire          SPI_1_DO_net_0;
wire          SPI_1_SS0;
wire          SPISCLKO_net_0;
wire          SPISDO_net_0;
wire          SPISS_net_0;
wire          SWITCH2;
wire          WE_N_net_0;
wire          ACT_N_net_1;
wire          BG0_net_1;
wire          CAS_N_net_1;
wire          CK0_N_net_1;
wire          CK0_net_1;
wire          CKE0_net_1;
wire          CS0_N_net_1;
wire          FTDI_UART_D_RXD_net_1;
wire          GPIO_1_20_OUT_net_1;
wire          GPIO_1_9_OUT_net_1;
wire          LED1_net_1;
wire          LED2_net_1;
wire          LED3_net_1;
wire          LED4_net_1;
wire          LED5_net_1;
wire          LED6_net_1;
wire          LED7_net_1;
wire          MAC_0_MDC_net_1;
wire          MBUS_PWM_net_1;
wire          MBUS_SPI_MOSI_net_1;
wire          MBUS_UART_RXD_net_1;
wire          MMUART_1_TXD_net_1;
wire          MMUART_4_TXD_net_1;
wire          ODT0_net_1;
wire          RAS_N_net_1;
wire          RESET_N_net_1;
wire          SD_CLK_net_1;
wire          SD_VOLT_CMD_DIR_net_1;
wire          SD_VOLT_DIR_0_net_1;
wire          SD_VOLT_DIR_1_3_net_1;
wire          SD_VOLT_EN_net_1;
wire          SD_VOLT_SEL_net_1;
wire          SGMII_TX0_N_net_1;
wire          SGMII_TX0_P_net_1;
wire          SPISCLKO_net_1;
wire          SPISDO_net_1;
wire          SPISS_net_1;
wire          SPI_1_DO_net_1;
wire          WE_N_net_1;
wire   [13:0] A_net_1;
wire   [1:0]  BA_net_1;
wire   [1:0]  DM_net_1;
wire   [6:0]  GPIO_OUT_net_0;
wire   [63:0] MSS_INT_F2M_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [58:16]MSS_INT_F2M_const_net_0;
wire   [3:0]  AXI4mmaster0_MASTER0_AWREGION_const_net_0;
wire   [3:0]  AXI4mmaster0_MASTER0_ARREGION_const_net_0;
wire   [32:0] PLL0_SW_DRI_RDATA_const_net_0;
wire   [7:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0;
wire   [1:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0;
wire   [7:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0;
wire   [63:0] FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0;
wire   [1:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0;
wire   [37:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0;
wire   [1:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0;
wire   [63:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0;
wire   [37:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0;
wire   [1:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0;
wire   [37:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0;
wire   [1:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0;
wire   [63:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0;
wire   [37:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0;
wire   [1:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire          DIP1;
wire          DIP1_IN_POST_INV0_0;
wire          DIP2;
wire          DIP2_IN_POST_INV1_0;
wire          DIP3;
wire          DIP3_IN_POST_INV2_0;
wire          DIP4;
wire          DIP4_IN_POST_INV3_0;
wire          DIP5;
wire          DIP5_IN_POST_INV4_0;
wire          DIP6;
wire          DIP6_IN_POST_INV5_0;
wire          DIP7;
wire          DIP7_IN_POST_INV6_0;
wire          DIP8;
wire          DIP8_IN_POST_INV7_0;
wire          SWITCH1;
wire          SWITCH1_IN_POST_INV8_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR;
wire   [37:0] FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0;
wire   [31:0] FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_31to0;
wire   [37:32]FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_37to32;
wire   [8:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARID;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0_3to0;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0;
wire   [0:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0_0to0;
wire   [31:0] FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR;
wire   [37:0] FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0;
wire   [31:0] FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_31to0;
wire   [37:32]FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_37to32;
wire   [8:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWID;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0_3to0;
wire   [1:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK;
wire          FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0;
wire   [0:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0_0to0;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_BID;
wire   [8:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_3to0;
wire   [8:4]  FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_8to4;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_RID;
wire   [8:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0;
wire   [3:0]  FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_3to0;
wire   [8:4]  FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_8to4;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0;
wire   [0:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0;
wire   [1:1]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1;
wire          MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK;
wire   [1:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0;
wire   [0:0]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0;
wire   [1:1]  MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                                             = 1'b1;
assign GND_net                                             = 1'b0;
assign MSS_INT_F2M_const_net_0                             = 43'h00000000000;
assign AXI4mmaster0_MASTER0_AWREGION_const_net_0           = 4'h0;
assign AXI4mmaster0_MASTER0_ARREGION_const_net_0           = 4'h0;
assign PLL0_SW_DRI_RDATA_const_net_0                       = 33'h000000000;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0   = 8'h00;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0 = 2'h0;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0   = 8'h00;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0 = 64'h0000000000000000;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0 = 2'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0     = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0   = 38'h0000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0    = 8'h00;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0  = 2'h3;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0  = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0    = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0    = 64'h0000000000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0    = 8'hFF;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0     = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0   = 38'h0000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0    = 8'h00;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0  = 2'h3;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0  = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0    = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0     = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0   = 38'h0000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0    = 8'h00;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0  = 2'h3;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0  = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0    = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0    = 64'h0000000000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0    = 8'hFF;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0     = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0   = 38'h0000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0    = 8'h00;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0  = 2'h3;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0  = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0    = 4'h0;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign DIP1_IN_POST_INV0_0    = ~ DIP1;
assign DIP2_IN_POST_INV1_0    = ~ DIP2;
assign DIP3_IN_POST_INV2_0    = ~ DIP3;
assign DIP4_IN_POST_INV3_0    = ~ DIP4;
assign DIP5_IN_POST_INV4_0    = ~ DIP5;
assign DIP6_IN_POST_INV5_0    = ~ DIP6;
assign DIP7_IN_POST_INV6_0    = ~ DIP7;
assign DIP8_IN_POST_INV7_0    = ~ DIP8;
assign SWITCH1_IN_POST_INV8_0 = ~ SWITCH1;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign MBUS_AN               = 1'b1;
assign MBUS_RST              = 1'b1;
assign VSC_RESETN            = 1'b1;
assign VSC_TXDIS_SRESETN     = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign ACT_N_net_1           = ACT_N_net_0;
assign ACT_N                 = ACT_N_net_1;
assign BG0_net_1             = BG0_net_0;
assign BG0                   = BG0_net_1;
assign CAS_N_net_1           = CAS_N_net_0;
assign CAS_N                 = CAS_N_net_1;
assign CK0_N_net_1           = CK0_N_net_0;
assign CK0_N                 = CK0_N_net_1;
assign CK0_net_1             = CK0_net_0;
assign CK0                   = CK0_net_1;
assign CKE0_net_1            = CKE0_net_0;
assign CKE0                  = CKE0_net_1;
assign CS0_N_net_1           = CS0_N_net_0;
assign CS0_N                 = CS0_N_net_1;
assign FTDI_UART_D_RXD_net_1 = FTDI_UART_D_RXD_net_0;
assign FTDI_UART_D_RXD       = FTDI_UART_D_RXD_net_1;
assign GPIO_1_20_OUT_net_1   = GPIO_1_20_OUT_net_0;
assign GPIO_1_20_OUT         = GPIO_1_20_OUT_net_1;
assign GPIO_1_9_OUT_net_1    = GPIO_1_9_OUT_net_0;
assign GPIO_1_9_OUT          = GPIO_1_9_OUT_net_1;
assign LED1_net_1            = LED1_net_0;
assign LED1                  = LED1_net_1;
assign LED2_net_1            = LED2_net_0;
assign LED2                  = LED2_net_1;
assign LED3_net_1            = LED3_net_0;
assign LED3                  = LED3_net_1;
assign LED4_net_1            = LED4_net_0;
assign LED4                  = LED4_net_1;
assign LED5_net_1            = LED5_net_0;
assign LED5                  = LED5_net_1;
assign LED6_net_1            = LED6_net_0;
assign LED6                  = LED6_net_1;
assign LED7_net_1            = LED7_net_0;
assign LED7                  = LED7_net_1;
assign MAC_0_MDC_net_1       = MAC_0_MDC_net_0;
assign MAC_0_MDC             = MAC_0_MDC_net_1;
assign MBUS_PWM_net_1        = MBUS_PWM_net_0;
assign MBUS_PWM              = MBUS_PWM_net_1;
assign MBUS_SPI_MOSI_net_1   = MBUS_SPI_MOSI_net_0;
assign MBUS_SPI_MOSI         = MBUS_SPI_MOSI_net_1;
assign MBUS_UART_RXD_net_1   = MBUS_UART_RXD_net_0;
assign MBUS_UART_RXD         = MBUS_UART_RXD_net_1;
assign MMUART_1_TXD_net_1    = MMUART_1_TXD_net_0;
assign MMUART_1_TXD          = MMUART_1_TXD_net_1;
assign MMUART_4_TXD_net_1    = MMUART_4_TXD_net_0;
assign MMUART_4_TXD          = MMUART_4_TXD_net_1;
assign ODT0_net_1            = ODT0_net_0;
assign ODT0                  = ODT0_net_1;
assign RAS_N_net_1           = RAS_N_net_0;
assign RAS_N                 = RAS_N_net_1;
assign RESET_N_net_1         = RESET_N_net_0;
assign RESET_N               = RESET_N_net_1;
assign SD_CLK_net_1          = SD_CLK_net_0;
assign SD_CLK                = SD_CLK_net_1;
assign SD_VOLT_CMD_DIR_net_1 = SD_VOLT_CMD_DIR_net_0;
assign SD_VOLT_CMD_DIR       = SD_VOLT_CMD_DIR_net_1;
assign SD_VOLT_DIR_0_net_1   = SD_VOLT_DIR_0_net_0;
assign SD_VOLT_DIR_0         = SD_VOLT_DIR_0_net_1;
assign SD_VOLT_DIR_1_3_net_1 = SD_VOLT_DIR_1_3_net_0;
assign SD_VOLT_DIR_1_3       = SD_VOLT_DIR_1_3_net_1;
assign SD_VOLT_EN_net_1      = SD_VOLT_EN_net_0;
assign SD_VOLT_EN            = SD_VOLT_EN_net_1;
assign SD_VOLT_SEL_net_1     = SD_VOLT_SEL_net_0;
assign SD_VOLT_SEL           = SD_VOLT_SEL_net_1;
assign SGMII_TX0_N_net_1     = SGMII_TX0_N_net_0;
assign SGMII_TX0_N           = SGMII_TX0_N_net_1;
assign SGMII_TX0_P_net_1     = SGMII_TX0_P_net_0;
assign SGMII_TX0_P           = SGMII_TX0_P_net_1;
assign SPISCLKO_net_1        = SPISCLKO_net_0;
assign SPISCLKO              = SPISCLKO_net_1;
assign SPISDO_net_1          = SPISDO_net_0;
assign SPISDO                = SPISDO_net_1;
assign SPISS_net_1           = SPISS_net_0;
assign SPISS                 = SPISS_net_1;
assign SPI_1_DO_net_1        = SPI_1_DO_net_0;
assign SPI_1_DO              = SPI_1_DO_net_1;
assign WE_N_net_1            = WE_N_net_0;
assign WE_N                  = WE_N_net_1;
assign A_net_1               = A_net_0;
assign A[13:0]               = A_net_1;
assign BA_net_1              = BA_net_0;
assign BA[1:0]               = BA_net_1;
assign DM_net_1              = DM_net_0;
assign DM[1:0]               = DM_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign FIC_3_PERIPHERALS_0_GPIO_OUT0to0[0] = GPIO_OUT_net_0[0:0];
assign FIC_3_PERIPHERALS_0_GPIO_OUT1to1[1] = GPIO_OUT_net_0[1:1];
assign FIC_3_PERIPHERALS_0_GPIO_OUT2to2[2] = GPIO_OUT_net_0[2:2];
assign FIC_3_PERIPHERALS_0_GPIO_OUT3to3[3] = GPIO_OUT_net_0[3:3];
assign FIC_3_PERIPHERALS_0_GPIO_OUT4to4[4] = GPIO_OUT_net_0[4:4];
assign FIC_3_PERIPHERALS_0_GPIO_OUT5to5[5] = GPIO_OUT_net_0[5:5];
assign FIC_3_PERIPHERALS_0_GPIO_OUT6to6[6] = GPIO_OUT_net_0[6:6];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { FIC_3_PERIPHERALS_0_IHC_MP_APP_E51_IRQ , FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_1_IRQ , FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_2_IRQ , FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_3_IRQ , FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_4_IRQ , 43'h00000000000 , FIC_3_PERIPHERALS_0_FRAMING_ERR , FIC_3_PERIPHERALS_0_OVERFLOW , FIC_3_PERIPHERALS_0_PARITY_ERR , FIC_3_PERIPHERALS_0_TXRDY , FIC_3_PERIPHERALS_0_RXRDY , SWITCH1_IN_POST_INV8_0 , DIP4_IN_POST_INV3_0 , DIP3_IN_POST_INV2_0 , DIP2_IN_POST_INV1_0 , DIP1_IN_POST_INV0_0 , 1'b0 , FIC_3_PERIPHERALS_0_CORE_I2C_C0_INT , mBUS_INT , 1'b0 , 1'b0 , MSS_WRAPPER_0_GPIO_2_28_OUT };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_37to32, FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_31to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_31to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR[31:0];
assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0_37to32 = 6'h0;

assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0_3to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0_3to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_ARID[3:0];

assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0_0to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0_0to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK[0:0];

assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_37to32, FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_31to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_31to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR[31:0];
assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0_37to32 = 6'h0;

assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0_3to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0_3to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_AWID[3:0];

assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0_0to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0_0to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK[0:0];

assign FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_8to4, FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_3to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_3to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_BID[3:0];
assign FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0_8to4 = 5'h0;

assign FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0 = { FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_8to4, FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_3to0 };
assign FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_3to0 = FIC_0_PERIPHERALS_0_AXI4mslave0_RID[3:0];
assign FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0_8to4 = 5'h0;

assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0 = { MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1, MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0 };
assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0 = MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK;
assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1 = 1'b0;

assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0 = { MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1, MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0 };
assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0 = MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK;
assign MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1 = 1'b0;

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CLOCKS_AND_RESETS
CLOCKS_AND_RESETS CLOCKS_AND_RESETS_0(
        // Inputs
        .EXT_RST_N            ( SWITCH2 ),
        .MSS_DLL_LOCKS        ( MSS_WRAPPER_0_MSS_DLL_LOCKS ),
        .MSS_TO_FABRIC_RESETN ( MSS_WRAPPER_0_MSS_RESET_N_M2F ),
        .REF_CLK_50MHz        ( REF_CLK_50MHz ),
        // Outputs
        .FIC_0_CLK            ( CLOCKS_AND_RESETS_0_FIC_0_CLK ),
        .FIC_1_CLK            ( CLOCKS_AND_RESETS_0_FIC_1_CLK ),
        .FIC_2_CLK            ( CLOCKS_AND_RESETS_0_FIC_2_CLK ),
        .FIC_3_CLK            ( CLOCKS_AND_RESETS_0_FIC_3_CLK ),
        .MSS_RESETN           ( CLOCKS_AND_RESETS_0_MSS_RESETN ),
        .RESETN_FIC2_CLK      (  ),
        .RESETN_FIC_0_CLK     ( CLOCKS_AND_RESETS_0_RESETN_FIC_0_CLK ),
        .RESETN_FIC_1_CLK     (  ),
        .RESETN_FIC_3_CLK     ( CLOCKS_AND_RESETS_0_RESETN_FIC_3_CLK ) 
        );

//--------FIC_0_PERIPHERALS
FIC_0_PERIPHERALS FIC_0_PERIPHERALS_0(
        // Inputs
        .ACLK                          ( CLOCKS_AND_RESETS_0_FIC_0_CLK ),
        .ARESETN                       ( CLOCKS_AND_RESETS_0_RESETN_FIC_0_CLK ),
        .AXI4mmaster0_MASTER0_ARVALID  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARVALID ),
        .AXI4mmaster0_MASTER0_AWVALID  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWVALID ),
        .AXI4mmaster0_MASTER0_BREADY   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BREADY ),
        .AXI4mmaster0_MASTER0_RREADY   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RREADY ),
        .AXI4mmaster0_MASTER0_WLAST    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WLAST ),
        .AXI4mmaster0_MASTER0_WVALID   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WVALID ),
        .AXI4mslave0_SLAVE0_ARREADY    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARREADY ),
        .AXI4mslave0_SLAVE0_AWREADY    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWREADY ),
        .AXI4mslave0_SLAVE0_BVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_BVALID ),
        .AXI4mslave0_SLAVE0_RLAST      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RLAST ),
        .AXI4mslave0_SLAVE0_RVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_RVALID ),
        .AXI4mslave0_SLAVE0_WREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_WREADY ),
        .AXI4mmaster0_MASTER0_ARADDR   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARADDR ),
        .AXI4mmaster0_MASTER0_ARBURST  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARBURST ),
        .AXI4mmaster0_MASTER0_ARCACHE  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARCACHE ),
        .AXI4mmaster0_MASTER0_ARID     ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARID ),
        .AXI4mmaster0_MASTER0_ARLEN    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLEN ),
        .AXI4mmaster0_MASTER0_ARLOCK   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK_0 ),
        .AXI4mmaster0_MASTER0_ARPROT   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARPROT ),
        .AXI4mmaster0_MASTER0_ARQOS    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARQOS ),
        .AXI4mmaster0_MASTER0_ARREGION ( AXI4mmaster0_MASTER0_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .AXI4mmaster0_MASTER0_ARSIZE   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARSIZE ),
        .AXI4mmaster0_MASTER0_ARUSER   ( GND_net ), // tied to 1'b0 from definition
        .AXI4mmaster0_MASTER0_AWADDR   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWADDR ),
        .AXI4mmaster0_MASTER0_AWBURST  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWBURST ),
        .AXI4mmaster0_MASTER0_AWCACHE  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWCACHE ),
        .AXI4mmaster0_MASTER0_AWID     ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWID ),
        .AXI4mmaster0_MASTER0_AWLEN    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLEN ),
        .AXI4mmaster0_MASTER0_AWLOCK   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK_0 ),
        .AXI4mmaster0_MASTER0_AWPROT   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWPROT ),
        .AXI4mmaster0_MASTER0_AWQOS    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWQOS ),
        .AXI4mmaster0_MASTER0_AWREGION ( AXI4mmaster0_MASTER0_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .AXI4mmaster0_MASTER0_AWSIZE   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWSIZE ),
        .AXI4mmaster0_MASTER0_AWUSER   ( GND_net ), // tied to 1'b0 from definition
        .AXI4mmaster0_MASTER0_WDATA    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WDATA ),
        .AXI4mmaster0_MASTER0_WSTRB    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WSTRB ),
        .AXI4mmaster0_MASTER0_WUSER    ( GND_net ), // tied to 1'b0 from definition
        .AXI4mslave0_SLAVE0_BID        ( FIC_0_PERIPHERALS_0_AXI4mslave0_BID_0 ),
        .AXI4mslave0_SLAVE0_BRESP      ( FIC_0_PERIPHERALS_0_AXI4mslave0_BRESP ),
        .AXI4mslave0_SLAVE0_BUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4mslave0_SLAVE0_RDATA      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RDATA ),
        .AXI4mslave0_SLAVE0_RID        ( FIC_0_PERIPHERALS_0_AXI4mslave0_RID_0 ),
        .AXI4mslave0_SLAVE0_RRESP      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RRESP ),
        .AXI4mslave0_SLAVE0_RUSER      ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .AXI4mmaster0_MASTER0_ARREADY  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARREADY ),
        .AXI4mmaster0_MASTER0_AWREADY  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWREADY ),
        .AXI4mmaster0_MASTER0_BVALID   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BVALID ),
        .AXI4mmaster0_MASTER0_RLAST    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RLAST ),
        .AXI4mmaster0_MASTER0_RVALID   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RVALID ),
        .AXI4mmaster0_MASTER0_WREADY   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WREADY ),
        .AXI4mslave0_SLAVE0_ARVALID    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARVALID ),
        .AXI4mslave0_SLAVE0_AWVALID    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWVALID ),
        .AXI4mslave0_SLAVE0_BREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_BREADY ),
        .AXI4mslave0_SLAVE0_RREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_RREADY ),
        .AXI4mslave0_SLAVE0_WLAST      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WLAST ),
        .AXI4mslave0_SLAVE0_WVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_WVALID ),
        .AXI4mmaster0_MASTER0_BID      ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BID ),
        .AXI4mmaster0_MASTER0_BRESP    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BRESP ),
        .AXI4mmaster0_MASTER0_BUSER    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BUSER ),
        .AXI4mmaster0_MASTER0_RDATA    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RDATA ),
        .AXI4mmaster0_MASTER0_RID      ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RID ),
        .AXI4mmaster0_MASTER0_RRESP    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RRESP ),
        .AXI4mmaster0_MASTER0_RUSER    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RUSER ),
        .AXI4mslave0_SLAVE0_ARADDR     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR ),
        .AXI4mslave0_SLAVE0_ARBURST    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARBURST ),
        .AXI4mslave0_SLAVE0_ARCACHE    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARCACHE ),
        .AXI4mslave0_SLAVE0_ARID       ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARID ),
        .AXI4mslave0_SLAVE0_ARLEN      ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARLEN ),
        .AXI4mslave0_SLAVE0_ARLOCK     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK ),
        .AXI4mslave0_SLAVE0_ARPROT     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARPROT ),
        .AXI4mslave0_SLAVE0_ARQOS      ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARQOS ),
        .AXI4mslave0_SLAVE0_ARREGION   ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARREGION ),
        .AXI4mslave0_SLAVE0_ARSIZE     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARSIZE ),
        .AXI4mslave0_SLAVE0_ARUSER     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARUSER ),
        .AXI4mslave0_SLAVE0_AWADDR     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR ),
        .AXI4mslave0_SLAVE0_AWBURST    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWBURST ),
        .AXI4mslave0_SLAVE0_AWCACHE    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWCACHE ),
        .AXI4mslave0_SLAVE0_AWID       ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWID ),
        .AXI4mslave0_SLAVE0_AWLEN      ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWLEN ),
        .AXI4mslave0_SLAVE0_AWLOCK     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK ),
        .AXI4mslave0_SLAVE0_AWPROT     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWPROT ),
        .AXI4mslave0_SLAVE0_AWQOS      ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWQOS ),
        .AXI4mslave0_SLAVE0_AWREGION   ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWREGION ),
        .AXI4mslave0_SLAVE0_AWSIZE     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWSIZE ),
        .AXI4mslave0_SLAVE0_AWUSER     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWUSER ),
        .AXI4mslave0_SLAVE0_WDATA      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WDATA ),
        .AXI4mslave0_SLAVE0_WSTRB      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WSTRB ),
        .AXI4mslave0_SLAVE0_WUSER      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WUSER ) 
        );

//--------FIC_3_PERIPHERALS
FIC_3_PERIPHERALS FIC_3_PERIPHERALS_0(
        // Inputs
        .APB_MMASTER_in_penable  ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PENABLE ),
        .APB_MMASTER_in_psel     ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSELx ),
        .APB_MMASTER_in_pwrite   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWRITE ),
        .CoreUARTapb_RX          ( MBUS_UART_TXD ),
        .PCLK                    ( CLOCKS_AND_RESETS_0_FIC_3_CLK ),
        .PLL0_SW_DRI_INTERRUPT   ( VCC_net ), // tied to 1'b1 from definition
        .PRESETN                 ( CLOCKS_AND_RESETS_0_RESETN_FIC_3_CLK ),
        .APB_MMASTER_in_paddr    ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PADDR ),
        .APB_MMASTER_in_pwdata   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWDATA ),
        .PLL0_SW_DRI_RDATA       ( PLL0_SW_DRI_RDATA_const_net_0 ), // tied to 33'h000000000 from definition
        .PSTRB                   ( MSS_WRAPPER_0_FIC_3_APB_M_PSTRB ),
        // Outputs
        .APB_MMASTER_in_pready   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PREADY ),
        .APB_MMASTER_in_pslverr  ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSLVERR ),
        .CORE_I2C_C0_INT         ( FIC_3_PERIPHERALS_0_CORE_I2C_C0_INT ),
        .CoreUARTapb_TX          ( MBUS_UART_RXD_net_0 ),
        .FRAMING_ERR             ( FIC_3_PERIPHERALS_0_FRAMING_ERR ),
        .OVERFLOW                ( FIC_3_PERIPHERALS_0_OVERFLOW ),
        .PARITY_ERR              ( FIC_3_PERIPHERALS_0_PARITY_ERR ),
        .RXRDY                   ( FIC_3_PERIPHERALS_0_RXRDY ),
        .TXRDY                   ( FIC_3_PERIPHERALS_0_TXRDY ),
        .IHC_MP_APP_E51_IRQ      ( FIC_3_PERIPHERALS_0_IHC_MP_APP_E51_IRQ ),
        .IHC_MP_APP_U54_1_IRQ    ( FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_1_IRQ ),
        .IHC_MP_APP_U54_2_IRQ    ( FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_2_IRQ ),
        .IHC_MP_APP_U54_3_IRQ    ( FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_3_IRQ ),
        .IHC_MP_APP_U54_4_IRQ    ( FIC_3_PERIPHERALS_0_IHC_MP_APP_U54_4_IRQ ),
        .PWM_0                   ( MBUS_PWM_net_0 ),
        .Q0_LANE0_DRI_DRI_ARST_N (  ),
        .Q0_LANE0_DRI_DRI_CLK    (  ),
        .SPISCLKO                ( SPISCLKO_net_0 ),
        .SPISDO                  ( SPISDO_net_0 ),
        .SPISS                   ( SPISS_net_0 ),
        .APB_MMASTER_in_prdata   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PRDATA ),
        .GPIO_OUT                ( GPIO_OUT_net_0 ),
        .PLL0_SW_DRI_CTRL        (  ),
        .Q0_LANE0_DRI_DRI_WDATA  (  ),
        // Inouts
        .COREI2C_C0_SCL          ( RPI_I2C_SCL ),
        .COREI2C_C0_SDA          ( RPI_I2C_SDA ) 
        );

//--------MSS_WRAPPER
MSS_WRAPPER MSS_WRAPPER_0(
        // Inputs
        .FIC_0_ACLK                                ( CLOCKS_AND_RESETS_0_FIC_0_CLK ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARREADY ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARREADY ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWREADY ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWREADY ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BVALID  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BVALID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RLAST   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RLAST ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RVALID  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RVALID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WREADY  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLOCK     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARLOCK_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARVALID    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLOCK     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWLOCK_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWVALID    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_BREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_RREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WLAST      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WLAST ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_WVALID ),
        .FIC_1_ACLK                                ( CLOCKS_AND_RESETS_0_FIC_1_CLK ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BVALID  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RLAST   ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RVALID  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WREADY  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WLAST      ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WVALID     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_ACLK                                ( CLOCKS_AND_RESETS_0_FIC_2_CLK ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WLAST      ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WVALID     ( GND_net ), // tied to 1'b0 from definition
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PREADY    ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PREADY ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PSLVERR   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSLVERR ),
        .FIC_3_PCLK                                ( CLOCKS_AND_RESETS_0_FIC_3_CLK ),
        .GPIO_2_F2M_24                             ( GND_net ),
        .GPIO_2_F2M_25                             ( DIP5_IN_POST_INV4_0 ),
        .GPIO_2_F2M_26                             ( DIP6_IN_POST_INV5_0 ),
        .GPIO_2_F2M_27                             ( DIP7_IN_POST_INV6_0 ),
        .GPIO_2_F2M_28                             ( DIP8_IN_POST_INV7_0 ),
        .GPIO_2_F2M_30                             ( MSS_WRAPPER_0_GPIO_2_26_OUT ),
        .GPIO_2_F2M_31                             ( MSS_WRAPPER_0_GPIO_2_27_OUT ),
        .MMUART_0_RXD_F2M                          ( FTDI_UART_D_TXD ),
        .MMUART_1_RXD                              ( MMUART_1_RXD ),
        .MMUART_4_RXD                              ( MMUART_4_RXD ),
        .MSS_RESET_N_F2M                           ( CLOCKS_AND_RESETS_0_MSS_RESETN ),
        .REFCLK_N                                  ( REFCLK_N ),
        .REFCLK                                    ( REFCLK ),
        .SD_CD                                     ( SD_CD ),
        .SGMII_RX0_N                               ( SGMII_RX0_N ),
        .SGMII_RX0_P                               ( SGMII_RX0_P ),
        .SPI_0_DI_F2M                              ( MBUS_SPI_MISO ),
        .SPI_1_DI                                  ( SPI_1_DI ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BID     ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BRESP   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BRESP ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RDATA   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RDATA ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RID     ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RRESP   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RRESP ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARADDR     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARADDR_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARBURST    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARBURST ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARCACHE    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARCACHE ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARID       ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARID_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLEN      ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARLEN ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARPROT     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARPROT ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARQOS      ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARQOS ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARSIZE     ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARSIZE ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWADDR     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWADDR_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWBURST    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWBURST ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWCACHE    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWCACHE ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWID       ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWID_0 ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLEN      ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWLEN ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWPROT     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWPROT ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWQOS      ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWQOS ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWSIZE     ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWSIZE ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WDATA      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WDATA ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WSTRB      ( FIC_0_PERIPHERALS_0_AXI4mslave0_WSTRB ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID     ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID     ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID       ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID       ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0 ), // tied to 8'hFF from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID       ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID       ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0 ), // tied to 8'hFF from definition
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PRDATA    ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PRDATA ),
        .MSS_INT_F2M                               ( MSS_INT_F2M_net_0 ),
        // Outputs
        .ACT_N                                     ( ACT_N_net_0 ),
        .BG0                                       ( BG0_net_0 ),
        .CAS_N                                     ( CAS_N_net_0 ),
        .CK0_N                                     ( CK0_N_net_0 ),
        .CK0                                       ( CK0_net_0 ),
        .CKE0                                      ( CKE0_net_0 ),
        .CS0_N                                     ( CS0_N_net_0 ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARLOCK  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLOCK ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARVALID ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARVALID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWLOCK  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLOCK ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWVALID ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWVALID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BREADY  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_BREADY ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RREADY  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_RREADY ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WLAST   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WLAST ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WVALID  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARREADY    ( FIC_0_PERIPHERALS_0_AXI4mslave0_ARREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWREADY    ( FIC_0_PERIPHERALS_0_AXI4mslave0_AWREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_BVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RLAST      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RLAST ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RVALID     ( FIC_0_PERIPHERALS_0_AXI4mslave0_RVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WREADY     ( FIC_0_PERIPHERALS_0_AXI4mslave0_WREADY ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARLOCK  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARVALID (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWLOCK  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWVALID (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BREADY  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RREADY  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WLAST   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WVALID  (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARREADY    (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWREADY    (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BVALID     (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RLAST      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RVALID     (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WREADY     (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARREADY    (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWREADY    (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BVALID     (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RLAST      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RVALID     (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WREADY     (  ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PENABLE   ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PENABLE ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PSEL      ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PSELx ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PWRITE    ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWRITE ),
        .GPIO_1_20_OUT                             ( GPIO_1_20_OUT_net_0 ),
        .GPIO_1_9_OUT                              ( GPIO_1_9_OUT_net_0 ),
        .GPIO_2_26_OUT                             ( MSS_WRAPPER_0_GPIO_2_26_OUT ),
        .GPIO_2_27_OUT                             ( MSS_WRAPPER_0_GPIO_2_27_OUT ),
        .GPIO_2_28_OUT                             ( MSS_WRAPPER_0_GPIO_2_28_OUT ),
        .GPIO_2_M2F_17                             ( MSS_WRAPPER_0_GPIO_2_M2F_17 ),
        .GPIO_2_M2F_18                             ( MSS_WRAPPER_0_GPIO_2_M2F_18 ),
        .GPIO_2_M2F_19                             ( MSS_WRAPPER_0_GPIO_2_M2F_19 ),
        .GPIO_2_M2F_20                             ( MSS_WRAPPER_0_GPIO_2_M2F_20 ),
        .GPIO_2_M2F_21                             ( MSS_WRAPPER_0_GPIO_2_M2F_21 ),
        .GPIO_2_M2F_22                             ( MSS_WRAPPER_0_GPIO_2_M2F_22 ),
        .GPIO_2_M2F_23                             ( MSS_WRAPPER_0_GPIO_2_M2F_23 ),
        .MAC_0_MDC                                 ( MAC_0_MDC_net_0 ),
        .MMUART_0_TXD_M2F                          ( FTDI_UART_D_RXD_net_0 ),
        .MMUART_1_TXD                              ( MMUART_1_TXD_net_0 ),
        .MMUART_4_TXD                              ( MMUART_4_TXD_net_0 ),
        .MSS_DLL_LOCKS                             ( MSS_WRAPPER_0_MSS_DLL_LOCKS ),
        .MSS_RESET_N_M2F                           ( MSS_WRAPPER_0_MSS_RESET_N_M2F ),
        .ODT0                                      ( ODT0_net_0 ),
        .RAS_N                                     ( RAS_N_net_0 ),
        .RESET_N                                   ( RESET_N_net_0 ),
        .SD_CLK                                    ( SD_CLK_net_0 ),
        .SD_VOLT_CMD_DIR                           ( SD_VOLT_CMD_DIR_net_0 ),
        .SD_VOLT_DIR_0                             ( SD_VOLT_DIR_0_net_0 ),
        .SD_VOLT_DIR_1_3                           ( SD_VOLT_DIR_1_3_net_0 ),
        .SD_VOLT_EN                                ( SD_VOLT_EN_net_0 ),
        .SD_VOLT_SEL                               ( SD_VOLT_SEL_net_0 ),
        .SGMII_TX0_N                               ( SGMII_TX0_N_net_0 ),
        .SGMII_TX0_P                               ( SGMII_TX0_P_net_0 ),
        .SPI_0_DO                                  ( MBUS_SPI_MOSI_net_0 ),
        .SPI_1_DO                                  ( SPI_1_DO_net_0 ),
        .WE_N                                      ( WE_N_net_0 ),
        .A                                         ( A_net_0 ),
        .BA                                        ( BA_net_0 ),
        .DM                                        ( DM_net_0 ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARADDR  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARADDR ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARBURST ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARBURST ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARCACHE ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARCACHE ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARID    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARLEN   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARLEN ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARPROT  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARPROT ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARQOS   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARQOS ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARSIZE  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_ARSIZE ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWADDR  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWADDR ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWBURST ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWBURST ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWCACHE ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWCACHE ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWID    ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWID ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWLEN   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWLEN ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWPROT  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWPROT ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWQOS   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWQOS ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWSIZE  ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_AWSIZE ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WDATA   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WDATA ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WSTRB   ( MSS_WRAPPER_0_FIC_0_AXI4_INITIATOR_WSTRB ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BID        ( FIC_0_PERIPHERALS_0_AXI4mslave0_BID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BRESP      ( FIC_0_PERIPHERALS_0_AXI4mslave0_BRESP ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RDATA      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RDATA ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RID        ( FIC_0_PERIPHERALS_0_AXI4mslave0_RID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RRESP      ( FIC_0_PERIPHERALS_0_AXI4mslave0_RRESP ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARADDR  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARBURST (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARCACHE (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARID    (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARLEN   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARPROT  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARQOS   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARSIZE  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWADDR  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWBURST (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWCACHE (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWID    (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWLEN   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWPROT  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWQOS   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWSIZE  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WDATA   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WSTRB   (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BID        (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BRESP      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RDATA      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RID        (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RRESP      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BID        (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BRESP      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RDATA      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RID        (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RRESP      (  ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PADDR     ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PADDR ),
        .FIC_3_APB_INITIATOR_FIC_3_APB_M_PWDATA    ( MSS_WRAPPER_0_FIC_3_APB_INITIATOR_PWDATA ),
        .FIC_3_APB_M_PSTRB                         ( MSS_WRAPPER_0_FIC_3_APB_M_PSTRB ),
        .MSS_INT_M2F                               (  ),
        // Inouts
        .GPIO_2_0_IO                               ( RPI_GPIO4 ),
        .GPIO_2_10_IO                              ( RPI_GPIO12 ),
        .GPIO_2_11_IO                              ( RPI_GPIO13 ),
        .GPIO_2_12_IO                              ( RPI_GPIO19 ),
        .GPIO_2_13_IO                              ( RPI_GPIO16 ),
        .GPIO_2_14_IO                              ( RPI_GPIO26 ),
        .GPIO_2_15_IO                              ( RPI_GPIO20 ),
        .GPIO_2_16_IO                              ( RPI_GPIO21 ),
        .GPIO_2_1_IO                               ( RPI_GPIO17 ),
        .GPIO_2_2_IO                               ( RPI_GPIO18 ),
        .GPIO_2_3_IO                               ( RPI_GPIO27 ),
        .GPIO_2_4_IO                               ( RPI_GPIO22 ),
        .GPIO_2_5_IO                               ( RPI_GPIO23 ),
        .GPIO_2_6_IO                               ( RPI_GPIO24 ),
        .GPIO_2_7_IO                               ( RPI_GPIO25 ),
        .GPIO_2_8_IO                               ( RPI_GPIO5 ),
        .GPIO_2_9_IO                               ( RPI_GPIO6 ),
        .I2C_0_SCL                                 ( MBUS_I2C_SCL ),
        .I2C_0_SDA                                 ( MBUS_I2C_SDA ),
        .MDIO_PAD                                  ( MDIO_PAD ),
        .SD_CMD                                    ( SD_CMD ),
        .SD_DATA0                                  ( SD_DATA0 ),
        .SD_DATA1                                  ( SD_DATA1 ),
        .SD_DATA2                                  ( SD_DATA2 ),
        .SD_DATA3                                  ( SD_DATA3 ),
        .SPI_0_CLK                                 ( MBUS_SPI_CLK ),
        .SPI_0_SS                                  ( MBUS_SPI_CS ),
        .SPI_1_CLK                                 ( SPI_1_CLK ),
        .SPI_1_SS0                                 ( SPI_1_SS0 ),
        .DQS_N                                     ( DQS_N ),
        .DQS                                       ( DQS ),
        .DQ                                        ( DQ ) 
        );

//--------OR2
OR2 OR2_LED1(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT0to0 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_17 ),
        // Outputs
        .Y ( LED1_net_0 ) 
        );

//--------OR2
OR2 OR2_LED2(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT1to1 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_18 ),
        // Outputs
        .Y ( LED2_net_0 ) 
        );

//--------OR2
OR2 OR2_LED3(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT2to2 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_19 ),
        // Outputs
        .Y ( LED3_net_0 ) 
        );

//--------OR2
OR2 OR2_LED4(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT3to3 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_20 ),
        // Outputs
        .Y ( LED4_net_0 ) 
        );

//--------OR2
OR2 OR2_LED5(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT4to4 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_21 ),
        // Outputs
        .Y ( LED5_net_0 ) 
        );

//--------OR2
OR2 OR2_LED6(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT5to5 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_22 ),
        // Outputs
        .Y ( LED6_net_0 ) 
        );

//--------OR2
OR2 OR2_LED7(
        // Inputs
        .A ( FIC_3_PERIPHERALS_0_GPIO_OUT6to6 ),
        .B ( MSS_WRAPPER_0_GPIO_2_M2F_23 ),
        // Outputs
        .Y ( LED7_net_0 ) 
        );


endmodule
