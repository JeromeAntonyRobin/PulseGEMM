//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Sep 26 23:27:44 2026
// Version: 2026.1 2026.1.0.17
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FIC_0_PERIPHERALS
module FIC_0_PERIPHERALS(
    // Inputs
    ACLK,
    ARESETN,
    AXI4mmaster0_MASTER0_ARADDR,
    AXI4mmaster0_MASTER0_ARBURST,
    AXI4mmaster0_MASTER0_ARCACHE,
    AXI4mmaster0_MASTER0_ARID,
    AXI4mmaster0_MASTER0_ARLEN,
    AXI4mmaster0_MASTER0_ARLOCK,
    AXI4mmaster0_MASTER0_ARPROT,
    AXI4mmaster0_MASTER0_ARQOS,
    AXI4mmaster0_MASTER0_ARREGION,
    AXI4mmaster0_MASTER0_ARSIZE,
    AXI4mmaster0_MASTER0_ARUSER,
    AXI4mmaster0_MASTER0_ARVALID,
    AXI4mmaster0_MASTER0_AWADDR,
    AXI4mmaster0_MASTER0_AWBURST,
    AXI4mmaster0_MASTER0_AWCACHE,
    AXI4mmaster0_MASTER0_AWID,
    AXI4mmaster0_MASTER0_AWLEN,
    AXI4mmaster0_MASTER0_AWLOCK,
    AXI4mmaster0_MASTER0_AWPROT,
    AXI4mmaster0_MASTER0_AWQOS,
    AXI4mmaster0_MASTER0_AWREGION,
    AXI4mmaster0_MASTER0_AWSIZE,
    AXI4mmaster0_MASTER0_AWUSER,
    AXI4mmaster0_MASTER0_AWVALID,
    AXI4mmaster0_MASTER0_BREADY,
    AXI4mmaster0_MASTER0_RREADY,
    AXI4mmaster0_MASTER0_WDATA,
    AXI4mmaster0_MASTER0_WLAST,
    AXI4mmaster0_MASTER0_WSTRB,
    AXI4mmaster0_MASTER0_WUSER,
    AXI4mmaster0_MASTER0_WVALID,
    AXI4mslave0_SLAVE0_ARREADY,
    AXI4mslave0_SLAVE0_AWREADY,
    AXI4mslave0_SLAVE0_BID,
    AXI4mslave0_SLAVE0_BRESP,
    AXI4mslave0_SLAVE0_BUSER,
    AXI4mslave0_SLAVE0_BVALID,
    AXI4mslave0_SLAVE0_RDATA,
    AXI4mslave0_SLAVE0_RID,
    AXI4mslave0_SLAVE0_RLAST,
    AXI4mslave0_SLAVE0_RRESP,
    AXI4mslave0_SLAVE0_RUSER,
    AXI4mslave0_SLAVE0_RVALID,
    AXI4mslave0_SLAVE0_WREADY,
    // Outputs
    AXI4mmaster0_MASTER0_ARREADY,
    AXI4mmaster0_MASTER0_AWREADY,
    AXI4mmaster0_MASTER0_BID,
    AXI4mmaster0_MASTER0_BRESP,
    AXI4mmaster0_MASTER0_BUSER,
    AXI4mmaster0_MASTER0_BVALID,
    AXI4mmaster0_MASTER0_RDATA,
    AXI4mmaster0_MASTER0_RID,
    AXI4mmaster0_MASTER0_RLAST,
    AXI4mmaster0_MASTER0_RRESP,
    AXI4mmaster0_MASTER0_RUSER,
    AXI4mmaster0_MASTER0_RVALID,
    AXI4mmaster0_MASTER0_WREADY,
    AXI4mslave0_SLAVE0_ARADDR,
    AXI4mslave0_SLAVE0_ARBURST,
    AXI4mslave0_SLAVE0_ARCACHE,
    AXI4mslave0_SLAVE0_ARID,
    AXI4mslave0_SLAVE0_ARLEN,
    AXI4mslave0_SLAVE0_ARLOCK,
    AXI4mslave0_SLAVE0_ARPROT,
    AXI4mslave0_SLAVE0_ARQOS,
    AXI4mslave0_SLAVE0_ARREGION,
    AXI4mslave0_SLAVE0_ARSIZE,
    AXI4mslave0_SLAVE0_ARUSER,
    AXI4mslave0_SLAVE0_ARVALID,
    AXI4mslave0_SLAVE0_AWADDR,
    AXI4mslave0_SLAVE0_AWBURST,
    AXI4mslave0_SLAVE0_AWCACHE,
    AXI4mslave0_SLAVE0_AWID,
    AXI4mslave0_SLAVE0_AWLEN,
    AXI4mslave0_SLAVE0_AWLOCK,
    AXI4mslave0_SLAVE0_AWPROT,
    AXI4mslave0_SLAVE0_AWQOS,
    AXI4mslave0_SLAVE0_AWREGION,
    AXI4mslave0_SLAVE0_AWSIZE,
    AXI4mslave0_SLAVE0_AWUSER,
    AXI4mslave0_SLAVE0_AWVALID,
    AXI4mslave0_SLAVE0_BREADY,
    AXI4mslave0_SLAVE0_RREADY,
    AXI4mslave0_SLAVE0_WDATA,
    AXI4mslave0_SLAVE0_WLAST,
    AXI4mslave0_SLAVE0_WSTRB,
    AXI4mslave0_SLAVE0_WUSER,
    AXI4mslave0_SLAVE0_WVALID
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK;
input         ARESETN;
input  [37:0] AXI4mmaster0_MASTER0_ARADDR;
input  [1:0]  AXI4mmaster0_MASTER0_ARBURST;
input  [3:0]  AXI4mmaster0_MASTER0_ARCACHE;
input  [7:0]  AXI4mmaster0_MASTER0_ARID;
input  [7:0]  AXI4mmaster0_MASTER0_ARLEN;
input  [1:0]  AXI4mmaster0_MASTER0_ARLOCK;
input  [2:0]  AXI4mmaster0_MASTER0_ARPROT;
input  [3:0]  AXI4mmaster0_MASTER0_ARQOS;
input  [3:0]  AXI4mmaster0_MASTER0_ARREGION;
input  [2:0]  AXI4mmaster0_MASTER0_ARSIZE;
input  [0:0]  AXI4mmaster0_MASTER0_ARUSER;
input         AXI4mmaster0_MASTER0_ARVALID;
input  [37:0] AXI4mmaster0_MASTER0_AWADDR;
input  [1:0]  AXI4mmaster0_MASTER0_AWBURST;
input  [3:0]  AXI4mmaster0_MASTER0_AWCACHE;
input  [7:0]  AXI4mmaster0_MASTER0_AWID;
input  [7:0]  AXI4mmaster0_MASTER0_AWLEN;
input  [1:0]  AXI4mmaster0_MASTER0_AWLOCK;
input  [2:0]  AXI4mmaster0_MASTER0_AWPROT;
input  [3:0]  AXI4mmaster0_MASTER0_AWQOS;
input  [3:0]  AXI4mmaster0_MASTER0_AWREGION;
input  [2:0]  AXI4mmaster0_MASTER0_AWSIZE;
input  [0:0]  AXI4mmaster0_MASTER0_AWUSER;
input         AXI4mmaster0_MASTER0_AWVALID;
input         AXI4mmaster0_MASTER0_BREADY;
input         AXI4mmaster0_MASTER0_RREADY;
input  [63:0] AXI4mmaster0_MASTER0_WDATA;
input         AXI4mmaster0_MASTER0_WLAST;
input  [7:0]  AXI4mmaster0_MASTER0_WSTRB;
input  [0:0]  AXI4mmaster0_MASTER0_WUSER;
input         AXI4mmaster0_MASTER0_WVALID;
input         AXI4mslave0_SLAVE0_ARREADY;
input         AXI4mslave0_SLAVE0_AWREADY;
input  [8:0]  AXI4mslave0_SLAVE0_BID;
input  [1:0]  AXI4mslave0_SLAVE0_BRESP;
input  [0:0]  AXI4mslave0_SLAVE0_BUSER;
input         AXI4mslave0_SLAVE0_BVALID;
input  [63:0] AXI4mslave0_SLAVE0_RDATA;
input  [8:0]  AXI4mslave0_SLAVE0_RID;
input         AXI4mslave0_SLAVE0_RLAST;
input  [1:0]  AXI4mslave0_SLAVE0_RRESP;
input  [0:0]  AXI4mslave0_SLAVE0_RUSER;
input         AXI4mslave0_SLAVE0_RVALID;
input         AXI4mslave0_SLAVE0_WREADY;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        AXI4mmaster0_MASTER0_ARREADY;
output        AXI4mmaster0_MASTER0_AWREADY;
output [7:0]  AXI4mmaster0_MASTER0_BID;
output [1:0]  AXI4mmaster0_MASTER0_BRESP;
output [0:0]  AXI4mmaster0_MASTER0_BUSER;
output        AXI4mmaster0_MASTER0_BVALID;
output [63:0] AXI4mmaster0_MASTER0_RDATA;
output [7:0]  AXI4mmaster0_MASTER0_RID;
output        AXI4mmaster0_MASTER0_RLAST;
output [1:0]  AXI4mmaster0_MASTER0_RRESP;
output [0:0]  AXI4mmaster0_MASTER0_RUSER;
output        AXI4mmaster0_MASTER0_RVALID;
output        AXI4mmaster0_MASTER0_WREADY;
output [31:0] AXI4mslave0_SLAVE0_ARADDR;
output [1:0]  AXI4mslave0_SLAVE0_ARBURST;
output [3:0]  AXI4mslave0_SLAVE0_ARCACHE;
output [8:0]  AXI4mslave0_SLAVE0_ARID;
output [7:0]  AXI4mslave0_SLAVE0_ARLEN;
output [1:0]  AXI4mslave0_SLAVE0_ARLOCK;
output [2:0]  AXI4mslave0_SLAVE0_ARPROT;
output [3:0]  AXI4mslave0_SLAVE0_ARQOS;
output [3:0]  AXI4mslave0_SLAVE0_ARREGION;
output [2:0]  AXI4mslave0_SLAVE0_ARSIZE;
output [0:0]  AXI4mslave0_SLAVE0_ARUSER;
output        AXI4mslave0_SLAVE0_ARVALID;
output [31:0] AXI4mslave0_SLAVE0_AWADDR;
output [1:0]  AXI4mslave0_SLAVE0_AWBURST;
output [3:0]  AXI4mslave0_SLAVE0_AWCACHE;
output [8:0]  AXI4mslave0_SLAVE0_AWID;
output [7:0]  AXI4mslave0_SLAVE0_AWLEN;
output [1:0]  AXI4mslave0_SLAVE0_AWLOCK;
output [2:0]  AXI4mslave0_SLAVE0_AWPROT;
output [3:0]  AXI4mslave0_SLAVE0_AWQOS;
output [3:0]  AXI4mslave0_SLAVE0_AWREGION;
output [2:0]  AXI4mslave0_SLAVE0_AWSIZE;
output [0:0]  AXI4mslave0_SLAVE0_AWUSER;
output        AXI4mslave0_SLAVE0_AWVALID;
output        AXI4mslave0_SLAVE0_BREADY;
output        AXI4mslave0_SLAVE0_RREADY;
output [63:0] AXI4mslave0_SLAVE0_WDATA;
output        AXI4mslave0_SLAVE0_WLAST;
output [7:0]  AXI4mslave0_SLAVE0_WSTRB;
output [0:0]  AXI4mslave0_SLAVE0_WUSER;
output        AXI4mslave0_SLAVE0_WVALID;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACLK;
wire          ARESETN;
wire   [37:0] AXI4mmaster0_MASTER0_ARADDR;
wire   [1:0]  AXI4mmaster0_MASTER0_ARBURST;
wire   [3:0]  AXI4mmaster0_MASTER0_ARCACHE;
wire   [7:0]  AXI4mmaster0_MASTER0_ARID;
wire   [7:0]  AXI4mmaster0_MASTER0_ARLEN;
wire   [1:0]  AXI4mmaster0_MASTER0_ARLOCK;
wire   [2:0]  AXI4mmaster0_MASTER0_ARPROT;
wire   [3:0]  AXI4mmaster0_MASTER0_ARQOS;
wire          AXI4mmaster0_ARREADY;
wire   [3:0]  AXI4mmaster0_MASTER0_ARREGION;
wire   [2:0]  AXI4mmaster0_MASTER0_ARSIZE;
wire   [0:0]  AXI4mmaster0_MASTER0_ARUSER;
wire          AXI4mmaster0_MASTER0_ARVALID;
wire   [37:0] AXI4mmaster0_MASTER0_AWADDR;
wire   [1:0]  AXI4mmaster0_MASTER0_AWBURST;
wire   [3:0]  AXI4mmaster0_MASTER0_AWCACHE;
wire   [7:0]  AXI4mmaster0_MASTER0_AWID;
wire   [7:0]  AXI4mmaster0_MASTER0_AWLEN;
wire   [1:0]  AXI4mmaster0_MASTER0_AWLOCK;
wire   [2:0]  AXI4mmaster0_MASTER0_AWPROT;
wire   [3:0]  AXI4mmaster0_MASTER0_AWQOS;
wire          AXI4mmaster0_AWREADY;
wire   [3:0]  AXI4mmaster0_MASTER0_AWREGION;
wire   [2:0]  AXI4mmaster0_MASTER0_AWSIZE;
wire   [0:0]  AXI4mmaster0_MASTER0_AWUSER;
wire          AXI4mmaster0_MASTER0_AWVALID;
wire   [7:0]  AXI4mmaster0_BID;
wire          AXI4mmaster0_MASTER0_BREADY;
wire   [1:0]  AXI4mmaster0_BRESP;
wire   [0:0]  AXI4mmaster0_BUSER;
wire          AXI4mmaster0_BVALID;
wire   [63:0] AXI4mmaster0_RDATA;
wire   [7:0]  AXI4mmaster0_RID;
wire          AXI4mmaster0_RLAST;
wire          AXI4mmaster0_MASTER0_RREADY;
wire   [1:0]  AXI4mmaster0_RRESP;
wire   [0:0]  AXI4mmaster0_RUSER;
wire          AXI4mmaster0_RVALID;
wire   [63:0] AXI4mmaster0_MASTER0_WDATA;
wire          AXI4mmaster0_MASTER0_WLAST;
wire          AXI4mmaster0_WREADY;
wire   [7:0]  AXI4mmaster0_MASTER0_WSTRB;
wire   [0:0]  AXI4mmaster0_MASTER0_WUSER;
wire          AXI4mmaster0_MASTER0_WVALID;
wire   [31:0] AXI4mslave0_ARADDR;
wire   [1:0]  AXI4mslave0_ARBURST;
wire   [3:0]  AXI4mslave0_ARCACHE;
wire   [8:0]  AXI4mslave0_ARID;
wire   [7:0]  AXI4mslave0_ARLEN;
wire   [1:0]  AXI4mslave0_ARLOCK;
wire   [2:0]  AXI4mslave0_ARPROT;
wire   [3:0]  AXI4mslave0_ARQOS;
wire          AXI4mslave0_SLAVE0_ARREADY;
wire   [3:0]  AXI4mslave0_ARREGION;
wire   [2:0]  AXI4mslave0_ARSIZE;
wire   [0:0]  AXI4mslave0_ARUSER;
wire          AXI4mslave0_ARVALID;
wire   [31:0] AXI4mslave0_AWADDR;
wire   [1:0]  AXI4mslave0_AWBURST;
wire   [3:0]  AXI4mslave0_AWCACHE;
wire   [8:0]  AXI4mslave0_AWID;
wire   [7:0]  AXI4mslave0_AWLEN;
wire   [1:0]  AXI4mslave0_AWLOCK;
wire   [2:0]  AXI4mslave0_AWPROT;
wire   [3:0]  AXI4mslave0_AWQOS;
wire          AXI4mslave0_SLAVE0_AWREADY;
wire   [3:0]  AXI4mslave0_AWREGION;
wire   [2:0]  AXI4mslave0_AWSIZE;
wire   [0:0]  AXI4mslave0_AWUSER;
wire          AXI4mslave0_AWVALID;
wire   [8:0]  AXI4mslave0_SLAVE0_BID;
wire          AXI4mslave0_BREADY;
wire   [1:0]  AXI4mslave0_SLAVE0_BRESP;
wire   [0:0]  AXI4mslave0_SLAVE0_BUSER;
wire          AXI4mslave0_SLAVE0_BVALID;
wire   [63:0] AXI4mslave0_SLAVE0_RDATA;
wire   [8:0]  AXI4mslave0_SLAVE0_RID;
wire          AXI4mslave0_SLAVE0_RLAST;
wire          AXI4mslave0_RREADY;
wire   [1:0]  AXI4mslave0_SLAVE0_RRESP;
wire   [0:0]  AXI4mslave0_SLAVE0_RUSER;
wire          AXI4mslave0_SLAVE0_RVALID;
wire   [63:0] AXI4mslave0_WDATA;
wire          AXI4mslave0_WLAST;
wire          AXI4mslave0_SLAVE0_WREADY;
wire   [7:0]  AXI4mslave0_WSTRB;
wire   [0:0]  AXI4mslave0_WUSER;
wire          AXI4mslave0_WVALID;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_ARBURST;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_ARCACHE;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_ARLEN;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_ARLOCK;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave1_ARPROT;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_ARQOS;
wire          FIC0_INITIATOR_AXI4mslave1_ARREADY;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_ARREGION;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave1_ARSIZE;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave1_ARUSER;
wire          FIC0_INITIATOR_AXI4mslave1_ARVALID;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_AWBURST;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_AWCACHE;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_AWLEN;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_AWLOCK;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave1_AWPROT;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_AWQOS;
wire          FIC0_INITIATOR_AXI4mslave1_AWREADY;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave1_AWREGION;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave1_AWSIZE;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave1_AWUSER;
wire          FIC0_INITIATOR_AXI4mslave1_AWVALID;
wire          FIC0_INITIATOR_AXI4mslave1_BREADY;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_BRESP;
wire          FIC0_INITIATOR_AXI4mslave1_BVALID;
wire   [63:0] FIC0_INITIATOR_AXI4mslave1_RDATA;
wire          FIC0_INITIATOR_AXI4mslave1_RLAST;
wire          FIC0_INITIATOR_AXI4mslave1_RREADY;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave1_RRESP;
wire          FIC0_INITIATOR_AXI4mslave1_RVALID;
wire   [63:0] FIC0_INITIATOR_AXI4mslave1_WDATA;
wire          FIC0_INITIATOR_AXI4mslave1_WLAST;
wire          FIC0_INITIATOR_AXI4mslave1_WREADY;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_WSTRB;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave1_WUSER;
wire          FIC0_INITIATOR_AXI4mslave1_WVALID;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_ARBURST;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_ARCACHE;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave2_ARID;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave2_ARLEN;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_ARLOCK;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave2_ARPROT;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_ARQOS;
wire          FIC0_INITIATOR_AXI4mslave2_ARREADY;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_ARREGION;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave2_ARSIZE;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave2_ARUSER;
wire          FIC0_INITIATOR_AXI4mslave2_ARVALID;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_AWBURST;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_AWCACHE;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave2_AWID;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave2_AWLEN;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_AWLOCK;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave2_AWPROT;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_AWQOS;
wire          FIC0_INITIATOR_AXI4mslave2_AWREADY;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_AWREGION;
wire   [2:0]  FIC0_INITIATOR_AXI4mslave2_AWSIZE;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave2_AWUSER;
wire          FIC0_INITIATOR_AXI4mslave2_AWVALID;
wire          FIC0_INITIATOR_AXI4mslave2_BREADY;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_BRESP;
wire          FIC0_INITIATOR_AXI4mslave2_BVALID;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_RDATA;
wire          FIC0_INITIATOR_AXI4mslave2_RREADY;
wire   [1:0]  FIC0_INITIATOR_AXI4mslave2_RRESP;
wire          FIC0_INITIATOR_AXI4mslave2_RVALID;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_WDATA;
wire          FIC0_INITIATOR_AXI4mslave2_WLAST;
wire          FIC0_INITIATOR_AXI4mslave2_WREADY;
wire   [3:0]  FIC0_INITIATOR_AXI4mslave2_WSTRB;
wire   [0:0]  FIC0_INITIATOR_AXI4mslave2_WUSER;
wire          FIC0_INITIATOR_AXI4mslave2_WVALID;
wire   [31:0] GEMM_DMA_TOP_m_axi_ARADDR;
wire   [1:0]  GEMM_DMA_TOP_m_axi_ARBURST;
wire   [3:0]  GEMM_DMA_TOP_m_axi_ARCACHE;
wire   [7:0]  GEMM_DMA_TOP_m_axi_ARLEN;
wire   [2:0]  GEMM_DMA_TOP_m_axi_ARPROT;
wire   [3:0]  GEMM_DMA_TOP_m_axi_ARQOS;
wire          GEMM_DMA_TOP_m_axi_ARREADY;
wire   [2:0]  GEMM_DMA_TOP_m_axi_ARSIZE;
wire          GEMM_DMA_TOP_m_axi_ARVALID;
wire   [31:0] GEMM_DMA_TOP_m_axi_AWADDR;
wire   [1:0]  GEMM_DMA_TOP_m_axi_AWBURST;
wire   [3:0]  GEMM_DMA_TOP_m_axi_AWCACHE;
wire   [7:0]  GEMM_DMA_TOP_m_axi_AWLEN;
wire   [2:0]  GEMM_DMA_TOP_m_axi_AWPROT;
wire   [3:0]  GEMM_DMA_TOP_m_axi_AWQOS;
wire          GEMM_DMA_TOP_m_axi_AWREADY;
wire   [2:0]  GEMM_DMA_TOP_m_axi_AWSIZE;
wire          GEMM_DMA_TOP_m_axi_AWVALID;
wire   [7:0]  GEMM_DMA_TOP_m_axi_BID;
wire          GEMM_DMA_TOP_m_axi_BREADY;
wire   [1:0]  GEMM_DMA_TOP_m_axi_BRESP;
wire   [0:0]  GEMM_DMA_TOP_m_axi_BUSER;
wire          GEMM_DMA_TOP_m_axi_BVALID;
wire   [7:0]  GEMM_DMA_TOP_m_axi_RID;
wire          GEMM_DMA_TOP_m_axi_RLAST;
wire          GEMM_DMA_TOP_m_axi_RREADY;
wire   [1:0]  GEMM_DMA_TOP_m_axi_RRESP;
wire   [0:0]  GEMM_DMA_TOP_m_axi_RUSER;
wire          GEMM_DMA_TOP_m_axi_RVALID;
wire          GEMM_DMA_TOP_m_axi_WLAST;
wire          GEMM_DMA_TOP_m_axi_WREADY;
wire          GEMM_DMA_TOP_m_axi_WVALID;
wire          AXI4mmaster0_ARREADY_net_0;
wire          AXI4mmaster0_AWREADY_net_0;
wire          AXI4mmaster0_BVALID_net_0;
wire          AXI4mmaster0_RLAST_net_0;
wire          AXI4mmaster0_RVALID_net_0;
wire          AXI4mmaster0_WREADY_net_0;
wire          AXI4mslave0_ARVALID_net_0;
wire          AXI4mslave0_AWVALID_net_0;
wire          AXI4mslave0_BREADY_net_0;
wire          AXI4mslave0_RREADY_net_0;
wire          AXI4mslave0_WLAST_net_0;
wire          AXI4mslave0_WVALID_net_0;
wire   [7:0]  AXI4mmaster0_BID_net_0;
wire   [1:0]  AXI4mmaster0_BRESP_net_0;
wire   [0:0]  AXI4mmaster0_BUSER_net_0;
wire   [63:0] AXI4mmaster0_RDATA_net_0;
wire   [7:0]  AXI4mmaster0_RID_net_0;
wire   [1:0]  AXI4mmaster0_RRESP_net_0;
wire   [0:0]  AXI4mmaster0_RUSER_net_0;
wire   [31:0] AXI4mslave0_ARADDR_net_0;
wire   [1:0]  AXI4mslave0_ARBURST_net_0;
wire   [3:0]  AXI4mslave0_ARCACHE_net_0;
wire   [8:0]  AXI4mslave0_ARID_net_0;
wire   [7:0]  AXI4mslave0_ARLEN_net_0;
wire   [1:0]  AXI4mslave0_ARLOCK_net_0;
wire   [2:0]  AXI4mslave0_ARPROT_net_0;
wire   [3:0]  AXI4mslave0_ARQOS_net_0;
wire   [3:0]  AXI4mslave0_ARREGION_net_0;
wire   [2:0]  AXI4mslave0_ARSIZE_net_0;
wire   [0:0]  AXI4mslave0_ARUSER_net_0;
wire   [31:0] AXI4mslave0_AWADDR_net_0;
wire   [1:0]  AXI4mslave0_AWBURST_net_0;
wire   [3:0]  AXI4mslave0_AWCACHE_net_0;
wire   [8:0]  AXI4mslave0_AWID_net_0;
wire   [7:0]  AXI4mslave0_AWLEN_net_0;
wire   [1:0]  AXI4mslave0_AWLOCK_net_0;
wire   [2:0]  AXI4mslave0_AWPROT_net_0;
wire   [3:0]  AXI4mslave0_AWQOS_net_0;
wire   [3:0]  AXI4mslave0_AWREGION_net_0;
wire   [2:0]  AXI4mslave0_AWSIZE_net_0;
wire   [0:0]  AXI4mslave0_AWUSER_net_0;
wire   [63:0] AXI4mslave0_WDATA_net_0;
wire   [7:0]  AXI4mslave0_WSTRB_net_0;
wire   [0:0]  AXI4mslave0_WUSER_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]  MASTER0_AWID_const_net_0;
wire   [31:0] MASTER0_AWADDR_const_net_0;
wire   [7:0]  MASTER0_AWLEN_const_net_0;
wire   [2:0]  MASTER0_AWSIZE_const_net_0;
wire   [1:0]  MASTER0_AWBURST_const_net_0;
wire   [1:0]  MASTER0_AWLOCK_const_net_0;
wire   [3:0]  MASTER0_AWCACHE_const_net_0;
wire   [2:0]  MASTER0_AWPROT_const_net_0;
wire   [3:0]  MASTER0_AWQOS_const_net_0;
wire   [3:0]  MASTER0_AWREGION_const_net_0;
wire          GND_net;
wire   [31:0] MASTER0_WDATA_const_net_0;
wire   [3:0]  MASTER0_WSTRB_const_net_0;
wire   [7:0]  MASTER0_ARID_const_net_0;
wire   [31:0] MASTER0_ARADDR_const_net_0;
wire   [7:0]  MASTER0_ARLEN_const_net_0;
wire   [2:0]  MASTER0_ARSIZE_const_net_0;
wire   [1:0]  MASTER0_ARBURST_const_net_0;
wire   [1:0]  MASTER0_ARLOCK_const_net_0;
wire   [3:0]  MASTER0_ARCACHE_const_net_0;
wire   [2:0]  MASTER0_ARPROT_const_net_0;
wire   [3:0]  MASTER0_ARQOS_const_net_0;
wire   [3:0]  MASTER0_ARREGION_const_net_0;
wire   [7:0]  MASTER1_AWID_const_net_0;
wire   [3:0]  MASTER1_AWREGION_const_net_0;
wire   [7:0]  MASTER1_ARID_const_net_0;
wire   [3:0]  MASTER1_ARREGION_const_net_0;
wire   [8:0]  SLAVE0_BID_const_net_0;
wire   [1:0]  SLAVE0_BRESP_const_net_0;
wire   [8:0]  SLAVE0_RID_const_net_0;
wire   [31:0] SLAVE0_RDATA_const_net_0;
wire   [1:0]  SLAVE0_RRESP_const_net_0;
wire   [8:0]  SLAVE2_BID_const_net_0;
wire   [8:0]  SLAVE2_RID_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [37:0] FIC0_INITIATOR_AXI4mslave1_ARADDR;
wire   [31:0] FIC0_INITIATOR_AXI4mslave1_ARADDR_0;
wire   [31:0] FIC0_INITIATOR_AXI4mslave1_ARADDR_0_31to0;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave1_ARID;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_ARID_0;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_ARID_0_7to0;
wire   [37:0] FIC0_INITIATOR_AXI4mslave1_AWADDR;
wire   [31:0] FIC0_INITIATOR_AXI4mslave1_AWADDR_0;
wire   [31:0] FIC0_INITIATOR_AXI4mslave1_AWADDR_0_31to0;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave1_AWID;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_AWID_0;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_AWID_0_7to0;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_BID;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave1_BID_0;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_BID_0_7to0;
wire   [8:8]  FIC0_INITIATOR_AXI4mslave1_BID_0_8to8;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_RID;
wire   [8:0]  FIC0_INITIATOR_AXI4mslave1_RID_0;
wire   [7:0]  FIC0_INITIATOR_AXI4mslave1_RID_0_7to0;
wire   [8:8]  FIC0_INITIATOR_AXI4mslave1_RID_0_8to8;
wire   [37:0] FIC0_INITIATOR_AXI4mslave2_ARADDR;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_ARADDR_0;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_ARADDR_0_31to0;
wire   [37:0] FIC0_INITIATOR_AXI4mslave2_AWADDR;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_AWADDR_0;
wire   [31:0] FIC0_INITIATOR_AXI4mslave2_AWADDR_0_31to0;
wire          GEMM_DMA_TOP_m_axi_ARLOCK;
wire   [1:0]  GEMM_DMA_TOP_m_axi_ARLOCK_0;
wire   [0:0]  GEMM_DMA_TOP_m_axi_ARLOCK_0_0to0;
wire   [1:1]  GEMM_DMA_TOP_m_axi_ARLOCK_0_1to1;
wire          GEMM_DMA_TOP_m_axi_AWLOCK;
wire   [1:0]  GEMM_DMA_TOP_m_axi_AWLOCK_0;
wire   [0:0]  GEMM_DMA_TOP_m_axi_AWLOCK_0_0to0;
wire   [1:1]  GEMM_DMA_TOP_m_axi_AWLOCK_0_1to1;
wire   [63:0] GEMM_DMA_TOP_m_axi_RDATA;
wire   [63:0] GEMM_DMA_TOP_m_axi_RDATA_0;
wire   [31:0] GEMM_DMA_TOP_m_axi_RDATA_0_31to0;
wire   [63:0] GEMM_DMA_TOP_m_axi_WDATA;
wire   [63:0] GEMM_DMA_TOP_m_axi_WDATA_0;
wire   [31:0] GEMM_DMA_TOP_m_axi_WDATA_0_31to0;
wire   [63:32]GEMM_DMA_TOP_m_axi_WDATA_0_63to32;
wire [7:0] GEMM_DMA_TOP_m_axi_WSTRB;
wire   [7:0]  GEMM_DMA_TOP_m_axi_WSTRB_0;
wire   [3:0]  GEMM_DMA_TOP_m_axi_WSTRB_0_3to0;
wire   [7:4]  GEMM_DMA_TOP_m_axi_WSTRB_0_7to4;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign MASTER0_AWID_const_net_0     = 8'h00;
assign MASTER0_AWADDR_const_net_0   = 32'h00000000;
assign MASTER0_AWLEN_const_net_0    = 8'h00;
assign MASTER0_AWSIZE_const_net_0   = 3'h0;
assign MASTER0_AWBURST_const_net_0  = 2'h3;
assign MASTER0_AWLOCK_const_net_0   = 2'h0;
assign MASTER0_AWCACHE_const_net_0  = 4'h0;
assign MASTER0_AWPROT_const_net_0   = 3'h0;
assign MASTER0_AWQOS_const_net_0    = 4'h0;
assign MASTER0_AWREGION_const_net_0 = 4'h0;
assign GND_net                      = 1'b0;
assign MASTER0_WDATA_const_net_0    = 32'h00000000;
assign MASTER0_WSTRB_const_net_0    = 4'hF;
assign MASTER0_ARID_const_net_0     = 8'h00;
assign MASTER0_ARADDR_const_net_0   = 32'h00000000;
assign MASTER0_ARLEN_const_net_0    = 8'h00;
assign MASTER0_ARSIZE_const_net_0   = 3'h0;
assign MASTER0_ARBURST_const_net_0  = 2'h3;
assign MASTER0_ARLOCK_const_net_0   = 2'h0;
assign MASTER0_ARCACHE_const_net_0  = 4'h0;
assign MASTER0_ARPROT_const_net_0   = 3'h0;
assign MASTER0_ARQOS_const_net_0    = 4'h0;
assign MASTER0_ARREGION_const_net_0 = 4'h0;
assign MASTER1_AWID_const_net_0     = 8'h00;
assign MASTER1_AWREGION_const_net_0 = 4'h0;
assign MASTER1_ARID_const_net_0     = 8'h00;
assign MASTER1_ARREGION_const_net_0 = 4'h0;
assign SLAVE0_BID_const_net_0       = 9'h000;
assign SLAVE0_BRESP_const_net_0     = 2'h0;
assign SLAVE0_RID_const_net_0       = 9'h000;
assign SLAVE0_RDATA_const_net_0     = 32'h00000000;
assign SLAVE0_RRESP_const_net_0     = 2'h0;
assign SLAVE2_BID_const_net_0       = 9'h000;
assign SLAVE2_RID_const_net_0       = 9'h000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign AXI4mmaster0_ARREADY_net_0       = AXI4mmaster0_ARREADY;
assign AXI4mmaster0_MASTER0_ARREADY     = AXI4mmaster0_ARREADY_net_0;
assign AXI4mmaster0_AWREADY_net_0       = AXI4mmaster0_AWREADY;
assign AXI4mmaster0_MASTER0_AWREADY     = AXI4mmaster0_AWREADY_net_0;
assign AXI4mmaster0_BVALID_net_0        = AXI4mmaster0_BVALID;
assign AXI4mmaster0_MASTER0_BVALID      = AXI4mmaster0_BVALID_net_0;
assign AXI4mmaster0_RLAST_net_0         = AXI4mmaster0_RLAST;
assign AXI4mmaster0_MASTER0_RLAST       = AXI4mmaster0_RLAST_net_0;
assign AXI4mmaster0_RVALID_net_0        = AXI4mmaster0_RVALID;
assign AXI4mmaster0_MASTER0_RVALID      = AXI4mmaster0_RVALID_net_0;
assign AXI4mmaster0_WREADY_net_0        = AXI4mmaster0_WREADY;
assign AXI4mmaster0_MASTER0_WREADY      = AXI4mmaster0_WREADY_net_0;
assign AXI4mslave0_ARVALID_net_0        = AXI4mslave0_ARVALID;
assign AXI4mslave0_SLAVE0_ARVALID       = AXI4mslave0_ARVALID_net_0;
assign AXI4mslave0_AWVALID_net_0        = AXI4mslave0_AWVALID;
assign AXI4mslave0_SLAVE0_AWVALID       = AXI4mslave0_AWVALID_net_0;
assign AXI4mslave0_BREADY_net_0         = AXI4mslave0_BREADY;
assign AXI4mslave0_SLAVE0_BREADY        = AXI4mslave0_BREADY_net_0;
assign AXI4mslave0_RREADY_net_0         = AXI4mslave0_RREADY;
assign AXI4mslave0_SLAVE0_RREADY        = AXI4mslave0_RREADY_net_0;
assign AXI4mslave0_WLAST_net_0          = AXI4mslave0_WLAST;
assign AXI4mslave0_SLAVE0_WLAST         = AXI4mslave0_WLAST_net_0;
assign AXI4mslave0_WVALID_net_0         = AXI4mslave0_WVALID;
assign AXI4mslave0_SLAVE0_WVALID        = AXI4mslave0_WVALID_net_0;
assign AXI4mmaster0_BID_net_0           = AXI4mmaster0_BID;
assign AXI4mmaster0_MASTER0_BID[7:0]    = AXI4mmaster0_BID_net_0;
assign AXI4mmaster0_BRESP_net_0         = AXI4mmaster0_BRESP;
assign AXI4mmaster0_MASTER0_BRESP[1:0]  = AXI4mmaster0_BRESP_net_0;
assign AXI4mmaster0_BUSER_net_0[0]      = AXI4mmaster0_BUSER[0];
assign AXI4mmaster0_MASTER0_BUSER[0:0]  = AXI4mmaster0_BUSER_net_0[0];
assign AXI4mmaster0_RDATA_net_0         = AXI4mmaster0_RDATA;
assign AXI4mmaster0_MASTER0_RDATA[63:0] = AXI4mmaster0_RDATA_net_0;
assign AXI4mmaster0_RID_net_0           = AXI4mmaster0_RID;
assign AXI4mmaster0_MASTER0_RID[7:0]    = AXI4mmaster0_RID_net_0;
assign AXI4mmaster0_RRESP_net_0         = AXI4mmaster0_RRESP;
assign AXI4mmaster0_MASTER0_RRESP[1:0]  = AXI4mmaster0_RRESP_net_0;
assign AXI4mmaster0_RUSER_net_0[0]      = AXI4mmaster0_RUSER[0];
assign AXI4mmaster0_MASTER0_RUSER[0:0]  = AXI4mmaster0_RUSER_net_0[0];
assign AXI4mslave0_ARADDR_net_0         = AXI4mslave0_ARADDR;
assign AXI4mslave0_SLAVE0_ARADDR[31:0]  = AXI4mslave0_ARADDR_net_0;
assign AXI4mslave0_ARBURST_net_0        = AXI4mslave0_ARBURST;
assign AXI4mslave0_SLAVE0_ARBURST[1:0]  = AXI4mslave0_ARBURST_net_0;
assign AXI4mslave0_ARCACHE_net_0        = AXI4mslave0_ARCACHE;
assign AXI4mslave0_SLAVE0_ARCACHE[3:0]  = AXI4mslave0_ARCACHE_net_0;
assign AXI4mslave0_ARID_net_0           = AXI4mslave0_ARID;
assign AXI4mslave0_SLAVE0_ARID[8:0]     = AXI4mslave0_ARID_net_0;
assign AXI4mslave0_ARLEN_net_0          = AXI4mslave0_ARLEN;
assign AXI4mslave0_SLAVE0_ARLEN[7:0]    = AXI4mslave0_ARLEN_net_0;
assign AXI4mslave0_ARLOCK_net_0         = AXI4mslave0_ARLOCK;
assign AXI4mslave0_SLAVE0_ARLOCK[1:0]   = AXI4mslave0_ARLOCK_net_0;
assign AXI4mslave0_ARPROT_net_0         = AXI4mslave0_ARPROT;
assign AXI4mslave0_SLAVE0_ARPROT[2:0]   = AXI4mslave0_ARPROT_net_0;
assign AXI4mslave0_ARQOS_net_0          = AXI4mslave0_ARQOS;
assign AXI4mslave0_SLAVE0_ARQOS[3:0]    = AXI4mslave0_ARQOS_net_0;
assign AXI4mslave0_ARREGION_net_0       = AXI4mslave0_ARREGION;
assign AXI4mslave0_SLAVE0_ARREGION[3:0] = AXI4mslave0_ARREGION_net_0;
assign AXI4mslave0_ARSIZE_net_0         = AXI4mslave0_ARSIZE;
assign AXI4mslave0_SLAVE0_ARSIZE[2:0]   = AXI4mslave0_ARSIZE_net_0;
assign AXI4mslave0_ARUSER_net_0[0]      = AXI4mslave0_ARUSER[0];
assign AXI4mslave0_SLAVE0_ARUSER[0:0]   = AXI4mslave0_ARUSER_net_0[0];
assign AXI4mslave0_AWADDR_net_0         = AXI4mslave0_AWADDR;
assign AXI4mslave0_SLAVE0_AWADDR[31:0]  = AXI4mslave0_AWADDR_net_0;
assign AXI4mslave0_AWBURST_net_0        = AXI4mslave0_AWBURST;
assign AXI4mslave0_SLAVE0_AWBURST[1:0]  = AXI4mslave0_AWBURST_net_0;
assign AXI4mslave0_AWCACHE_net_0        = AXI4mslave0_AWCACHE;
assign AXI4mslave0_SLAVE0_AWCACHE[3:0]  = AXI4mslave0_AWCACHE_net_0;
assign AXI4mslave0_AWID_net_0           = AXI4mslave0_AWID;
assign AXI4mslave0_SLAVE0_AWID[8:0]     = AXI4mslave0_AWID_net_0;
assign AXI4mslave0_AWLEN_net_0          = AXI4mslave0_AWLEN;
assign AXI4mslave0_SLAVE0_AWLEN[7:0]    = AXI4mslave0_AWLEN_net_0;
assign AXI4mslave0_AWLOCK_net_0         = AXI4mslave0_AWLOCK;
assign AXI4mslave0_SLAVE0_AWLOCK[1:0]   = AXI4mslave0_AWLOCK_net_0;
assign AXI4mslave0_AWPROT_net_0         = AXI4mslave0_AWPROT;
assign AXI4mslave0_SLAVE0_AWPROT[2:0]   = AXI4mslave0_AWPROT_net_0;
assign AXI4mslave0_AWQOS_net_0          = AXI4mslave0_AWQOS;
assign AXI4mslave0_SLAVE0_AWQOS[3:0]    = AXI4mslave0_AWQOS_net_0;
assign AXI4mslave0_AWREGION_net_0       = AXI4mslave0_AWREGION;
assign AXI4mslave0_SLAVE0_AWREGION[3:0] = AXI4mslave0_AWREGION_net_0;
assign AXI4mslave0_AWSIZE_net_0         = AXI4mslave0_AWSIZE;
assign AXI4mslave0_SLAVE0_AWSIZE[2:0]   = AXI4mslave0_AWSIZE_net_0;
assign AXI4mslave0_AWUSER_net_0[0]      = AXI4mslave0_AWUSER[0];
assign AXI4mslave0_SLAVE0_AWUSER[0:0]   = AXI4mslave0_AWUSER_net_0[0];
assign AXI4mslave0_WDATA_net_0          = AXI4mslave0_WDATA;
assign AXI4mslave0_SLAVE0_WDATA[63:0]   = AXI4mslave0_WDATA_net_0;
assign AXI4mslave0_WSTRB_net_0          = AXI4mslave0_WSTRB;
assign AXI4mslave0_SLAVE0_WSTRB[7:0]    = AXI4mslave0_WSTRB_net_0;
assign AXI4mslave0_WUSER_net_0[0]       = AXI4mslave0_WUSER[0];
assign AXI4mslave0_SLAVE0_WUSER[0:0]    = AXI4mslave0_WUSER_net_0[0];
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign FIC0_INITIATOR_AXI4mslave1_ARADDR_0 = { FIC0_INITIATOR_AXI4mslave1_ARADDR_0_31to0 };
assign FIC0_INITIATOR_AXI4mslave1_ARADDR_0_31to0 = FIC0_INITIATOR_AXI4mslave1_ARADDR[31:0];

assign FIC0_INITIATOR_AXI4mslave1_ARID_0 = { FIC0_INITIATOR_AXI4mslave1_ARID_0_7to0 };
assign FIC0_INITIATOR_AXI4mslave1_ARID_0_7to0 = FIC0_INITIATOR_AXI4mslave1_ARID[7:0];

assign FIC0_INITIATOR_AXI4mslave1_AWADDR_0 = { FIC0_INITIATOR_AXI4mslave1_AWADDR_0_31to0 };
assign FIC0_INITIATOR_AXI4mslave1_AWADDR_0_31to0 = FIC0_INITIATOR_AXI4mslave1_AWADDR[31:0];

assign FIC0_INITIATOR_AXI4mslave1_AWID_0 = { FIC0_INITIATOR_AXI4mslave1_AWID_0_7to0 };
assign FIC0_INITIATOR_AXI4mslave1_AWID_0_7to0 = FIC0_INITIATOR_AXI4mslave1_AWID[7:0];

assign FIC0_INITIATOR_AXI4mslave1_BID_0 = { FIC0_INITIATOR_AXI4mslave1_BID_0_8to8, FIC0_INITIATOR_AXI4mslave1_BID_0_7to0 };
assign FIC0_INITIATOR_AXI4mslave1_BID_0_7to0 = FIC0_INITIATOR_AXI4mslave1_BID[7:0];
assign FIC0_INITIATOR_AXI4mslave1_BID_0_8to8 = 1'b0;

assign FIC0_INITIATOR_AXI4mslave1_RID_0 = { FIC0_INITIATOR_AXI4mslave1_RID_0_8to8, FIC0_INITIATOR_AXI4mslave1_RID_0_7to0 };
assign FIC0_INITIATOR_AXI4mslave1_RID_0_7to0 = FIC0_INITIATOR_AXI4mslave1_RID[7:0];
assign FIC0_INITIATOR_AXI4mslave1_RID_0_8to8 = 1'b0;

assign FIC0_INITIATOR_AXI4mslave2_ARADDR_0 = { FIC0_INITIATOR_AXI4mslave2_ARADDR_0_31to0 };
assign FIC0_INITIATOR_AXI4mslave2_ARADDR_0_31to0 = FIC0_INITIATOR_AXI4mslave2_ARADDR[31:0];

assign FIC0_INITIATOR_AXI4mslave2_AWADDR_0 = { FIC0_INITIATOR_AXI4mslave2_AWADDR_0_31to0 };
assign FIC0_INITIATOR_AXI4mslave2_AWADDR_0_31to0 = FIC0_INITIATOR_AXI4mslave2_AWADDR[31:0];

assign GEMM_DMA_TOP_m_axi_ARLOCK_0 = { GEMM_DMA_TOP_m_axi_ARLOCK_0_1to1, GEMM_DMA_TOP_m_axi_ARLOCK_0_0to0 };
assign GEMM_DMA_TOP_m_axi_ARLOCK_0_0to0 = GEMM_DMA_TOP_m_axi_ARLOCK;
assign GEMM_DMA_TOP_m_axi_ARLOCK_0_1to1 = 1'b0;

assign GEMM_DMA_TOP_m_axi_AWLOCK_0 = { GEMM_DMA_TOP_m_axi_AWLOCK_0_1to1, GEMM_DMA_TOP_m_axi_AWLOCK_0_0to0 };
assign GEMM_DMA_TOP_m_axi_AWLOCK_0_0to0 = GEMM_DMA_TOP_m_axi_AWLOCK;
assign GEMM_DMA_TOP_m_axi_AWLOCK_0_1to1 = 1'b0;

assign GEMM_DMA_TOP_m_axi_RDATA_0 = GEMM_DMA_TOP_m_axi_RDATA;

assign GEMM_DMA_TOP_m_axi_WDATA_0 = GEMM_DMA_TOP_m_axi_WDATA;

assign GEMM_DMA_TOP_m_axi_WSTRB_0 = GEMM_DMA_TOP_m_axi_WSTRB;

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DMA_INITIATOR
DMA_INITIATOR DMA_INITIATOR_inst_0(
        // Inputs
        .ACLK             ( ACLK ),
        .ARESETN          ( ARESETN ),
        .SLAVE0_AWREADY   ( AXI4mslave0_SLAVE0_AWREADY ),
        .SLAVE0_WREADY    ( AXI4mslave0_SLAVE0_WREADY ),
        .SLAVE0_BID       ( AXI4mslave0_SLAVE0_BID ),
        .SLAVE0_BRESP     ( AXI4mslave0_SLAVE0_BRESP ),
        .SLAVE0_BVALID    ( AXI4mslave0_SLAVE0_BVALID ),
        .SLAVE0_ARREADY   ( AXI4mslave0_SLAVE0_ARREADY ),
        .SLAVE0_RID       ( AXI4mslave0_SLAVE0_RID ),
        .SLAVE0_RDATA     ( AXI4mslave0_SLAVE0_RDATA ),
        .SLAVE0_RRESP     ( AXI4mslave0_SLAVE0_RRESP ),
        .SLAVE0_RLAST     ( AXI4mslave0_SLAVE0_RLAST ),
        .SLAVE0_RVALID    ( AXI4mslave0_SLAVE0_RVALID ),
        .SLAVE0_BUSER     ( AXI4mslave0_SLAVE0_BUSER ),
        .SLAVE0_RUSER     ( AXI4mslave0_SLAVE0_RUSER ),
        .MASTER0_AWID     ( MASTER0_AWID_const_net_0 ), // tied to 8'h00 from definition
        .MASTER0_AWADDR   ( MASTER0_AWADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .MASTER0_AWLEN    ( MASTER0_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .MASTER0_AWSIZE   ( MASTER0_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .MASTER0_AWBURST  ( MASTER0_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .MASTER0_AWLOCK   ( MASTER0_AWLOCK_const_net_0 ), // tied to 2'h0 from definition
        .MASTER0_AWCACHE  ( MASTER0_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_AWPROT   ( MASTER0_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .MASTER0_AWQOS    ( MASTER0_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_AWREGION ( MASTER0_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_AWVALID  ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_WDATA    ( MASTER0_WDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .MASTER0_WSTRB    ( MASTER0_WSTRB_const_net_0 ), // tied to 4'hF from definition
        .MASTER0_WLAST    ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_WVALID   ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_BREADY   ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_ARID     ( MASTER0_ARID_const_net_0 ), // tied to 8'h00 from definition
        .MASTER0_ARADDR   ( MASTER0_ARADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .MASTER0_ARLEN    ( MASTER0_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .MASTER0_ARSIZE   ( MASTER0_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .MASTER0_ARBURST  ( MASTER0_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .MASTER0_ARLOCK   ( MASTER0_ARLOCK_const_net_0 ), // tied to 2'h0 from definition
        .MASTER0_ARCACHE  ( MASTER0_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_ARPROT   ( MASTER0_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .MASTER0_ARQOS    ( MASTER0_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_ARREGION ( MASTER0_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .MASTER0_ARVALID  ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_RREADY   ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_AWUSER   ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_WUSER    ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_ARUSER   ( GND_net ), // tied to 1'b0 from definition
        .MASTER1_AWID     ( MASTER1_AWID_const_net_0 ), // tied to 8'h00 from definition
        .MASTER1_AWADDR   ( GEMM_DMA_TOP_m_axi_AWADDR ),
        .MASTER1_AWLEN    ( GEMM_DMA_TOP_m_axi_AWLEN ),
        .MASTER1_AWSIZE   ( GEMM_DMA_TOP_m_axi_AWSIZE ),
        .MASTER1_AWBURST  ( GEMM_DMA_TOP_m_axi_AWBURST ),
        .MASTER1_AWLOCK   ( GEMM_DMA_TOP_m_axi_AWLOCK_0 ),
        .MASTER1_AWCACHE  ( GEMM_DMA_TOP_m_axi_AWCACHE ),
        .MASTER1_AWPROT   ( GEMM_DMA_TOP_m_axi_AWPROT ),
        .MASTER1_AWQOS    ( GEMM_DMA_TOP_m_axi_AWQOS ),
        .MASTER1_AWREGION ( MASTER1_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .MASTER1_AWVALID  ( GEMM_DMA_TOP_m_axi_AWVALID ),
        .MASTER1_WDATA    ( GEMM_DMA_TOP_m_axi_WDATA_0 ),
        .MASTER1_WSTRB    ( GEMM_DMA_TOP_m_axi_WSTRB_0 ),
        .MASTER1_WLAST    ( GEMM_DMA_TOP_m_axi_WLAST ),
        .MASTER1_WVALID   ( GEMM_DMA_TOP_m_axi_WVALID ),
        .MASTER1_BREADY   ( GEMM_DMA_TOP_m_axi_BREADY ),
        .MASTER1_ARID     ( MASTER1_ARID_const_net_0 ), // tied to 8'h00 from definition
        .MASTER1_ARADDR   ( GEMM_DMA_TOP_m_axi_ARADDR ),
        .MASTER1_ARLEN    ( GEMM_DMA_TOP_m_axi_ARLEN ),
        .MASTER1_ARSIZE   ( GEMM_DMA_TOP_m_axi_ARSIZE ),
        .MASTER1_ARBURST  ( GEMM_DMA_TOP_m_axi_ARBURST ),
        .MASTER1_ARLOCK   ( GEMM_DMA_TOP_m_axi_ARLOCK_0 ),
        .MASTER1_ARCACHE  ( GEMM_DMA_TOP_m_axi_ARCACHE ),
        .MASTER1_ARPROT   ( GEMM_DMA_TOP_m_axi_ARPROT ),
        .MASTER1_ARQOS    ( GEMM_DMA_TOP_m_axi_ARQOS ),
        .MASTER1_ARREGION ( MASTER1_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .MASTER1_ARVALID  ( GEMM_DMA_TOP_m_axi_ARVALID ),
        .MASTER1_RREADY   ( GEMM_DMA_TOP_m_axi_RREADY ),
        .MASTER1_AWUSER   ( GND_net ), // tied to 1'b0 from definition
        .MASTER1_WUSER    ( GND_net ), // tied to 1'b0 from definition
        .MASTER1_ARUSER   ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .SLAVE0_AWID      ( AXI4mslave0_AWID ),
        .SLAVE0_AWADDR    ( AXI4mslave0_AWADDR ),
        .SLAVE0_AWLEN     ( AXI4mslave0_AWLEN ),
        .SLAVE0_AWSIZE    ( AXI4mslave0_AWSIZE ),
        .SLAVE0_AWBURST   ( AXI4mslave0_AWBURST ),
        .SLAVE0_AWLOCK    ( AXI4mslave0_AWLOCK ),
        .SLAVE0_AWCACHE   ( AXI4mslave0_AWCACHE ),
        .SLAVE0_AWPROT    ( AXI4mslave0_AWPROT ),
        .SLAVE0_AWQOS     ( AXI4mslave0_AWQOS ),
        .SLAVE0_AWREGION  ( AXI4mslave0_AWREGION ),
        .SLAVE0_AWVALID   ( AXI4mslave0_AWVALID ),
        .SLAVE0_WDATA     ( AXI4mslave0_WDATA ),
        .SLAVE0_WSTRB     ( AXI4mslave0_WSTRB ),
        .SLAVE0_WLAST     ( AXI4mslave0_WLAST ),
        .SLAVE0_WVALID    ( AXI4mslave0_WVALID ),
        .SLAVE0_BREADY    ( AXI4mslave0_BREADY ),
        .SLAVE0_ARID      ( AXI4mslave0_ARID ),
        .SLAVE0_ARADDR    ( AXI4mslave0_ARADDR ),
        .SLAVE0_ARLEN     ( AXI4mslave0_ARLEN ),
        .SLAVE0_ARSIZE    ( AXI4mslave0_ARSIZE ),
        .SLAVE0_ARBURST   ( AXI4mslave0_ARBURST ),
        .SLAVE0_ARLOCK    ( AXI4mslave0_ARLOCK ),
        .SLAVE0_ARCACHE   ( AXI4mslave0_ARCACHE ),
        .SLAVE0_ARPROT    ( AXI4mslave0_ARPROT ),
        .SLAVE0_ARQOS     ( AXI4mslave0_ARQOS ),
        .SLAVE0_ARREGION  ( AXI4mslave0_ARREGION ),
        .SLAVE0_ARVALID   ( AXI4mslave0_ARVALID ),
        .SLAVE0_RREADY    ( AXI4mslave0_RREADY ),
        .SLAVE0_AWUSER    ( AXI4mslave0_AWUSER ),
        .SLAVE0_WUSER     ( AXI4mslave0_WUSER ),
        .SLAVE0_ARUSER    ( AXI4mslave0_ARUSER ),
        .MASTER0_AWREADY  (  ),
        .MASTER0_WREADY   (  ),
        .MASTER0_BID      (  ),
        .MASTER0_BRESP    (  ),
        .MASTER0_BVALID   (  ),
        .MASTER0_ARREADY  (  ),
        .MASTER0_RID      (  ),
        .MASTER0_RDATA    (  ),
        .MASTER0_RRESP    (  ),
        .MASTER0_RLAST    (  ),
        .MASTER0_RVALID   (  ),
        .MASTER0_BUSER    (  ),
        .MASTER0_RUSER    (  ),
        .MASTER1_AWREADY  ( GEMM_DMA_TOP_m_axi_AWREADY ),
        .MASTER1_WREADY   ( GEMM_DMA_TOP_m_axi_WREADY ),
        .MASTER1_BID      ( GEMM_DMA_TOP_m_axi_BID ),
        .MASTER1_BRESP    ( GEMM_DMA_TOP_m_axi_BRESP ),
        .MASTER1_BVALID   ( GEMM_DMA_TOP_m_axi_BVALID ),
        .MASTER1_ARREADY  ( GEMM_DMA_TOP_m_axi_ARREADY ),
        .MASTER1_RID      ( GEMM_DMA_TOP_m_axi_RID ),
        .MASTER1_RDATA    ( GEMM_DMA_TOP_m_axi_RDATA ),
        .MASTER1_RRESP    ( GEMM_DMA_TOP_m_axi_RRESP ),
        .MASTER1_RLAST    ( GEMM_DMA_TOP_m_axi_RLAST ),
        .MASTER1_RVALID   ( GEMM_DMA_TOP_m_axi_RVALID ),
        .MASTER1_BUSER    ( GEMM_DMA_TOP_m_axi_BUSER ),
        .MASTER1_RUSER    ( GEMM_DMA_TOP_m_axi_RUSER ) 
        );

//--------FIC0_INITIATOR
FIC0_INITIATOR FIC0_INITIATOR_inst_0(
        // Inputs
        .ACLK             ( ACLK ),
        .ARESETN          ( ARESETN ),
        .SLAVE0_AWREADY   ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_WREADY    ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_BID       ( SLAVE0_BID_const_net_0 ), // tied to 9'h000 from definition
        .SLAVE0_BRESP     ( SLAVE0_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .SLAVE0_BVALID    ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_ARREADY   ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_RID       ( SLAVE0_RID_const_net_0 ), // tied to 9'h000 from definition
        .SLAVE0_RDATA     ( SLAVE0_RDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .SLAVE0_RRESP     ( SLAVE0_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .SLAVE0_RLAST     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_RVALID    ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_BUSER     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE0_RUSER     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE1_AWREADY   ( FIC0_INITIATOR_AXI4mslave1_AWREADY ),
        .SLAVE1_WREADY    ( FIC0_INITIATOR_AXI4mslave1_WREADY ),
        .SLAVE1_BID       ( FIC0_INITIATOR_AXI4mslave1_BID_0 ),
        .SLAVE1_BRESP     ( FIC0_INITIATOR_AXI4mslave1_BRESP ),
        .SLAVE1_BVALID    ( FIC0_INITIATOR_AXI4mslave1_BVALID ),
        .SLAVE1_ARREADY   ( FIC0_INITIATOR_AXI4mslave1_ARREADY ),
        .SLAVE1_RID       ( FIC0_INITIATOR_AXI4mslave1_RID_0 ),
        .SLAVE1_RDATA     ( FIC0_INITIATOR_AXI4mslave1_RDATA ),
        .SLAVE1_RRESP     ( FIC0_INITIATOR_AXI4mslave1_RRESP ),
        .SLAVE1_RLAST     ( FIC0_INITIATOR_AXI4mslave1_RLAST ),
        .SLAVE1_RVALID    ( FIC0_INITIATOR_AXI4mslave1_RVALID ),
        .SLAVE1_BUSER     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE1_RUSER     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE2_AWREADY   ( FIC0_INITIATOR_AXI4mslave2_AWREADY ),
        .SLAVE2_WREADY    ( FIC0_INITIATOR_AXI4mslave2_WREADY ),
        .SLAVE2_BID       ( SLAVE2_BID_const_net_0 ), // tied to 9'h000 from definition
        .SLAVE2_BRESP     ( FIC0_INITIATOR_AXI4mslave2_BRESP ),
        .SLAVE2_BVALID    ( FIC0_INITIATOR_AXI4mslave2_BVALID ),
        .SLAVE2_ARREADY   ( FIC0_INITIATOR_AXI4mslave2_ARREADY ),
        .SLAVE2_RID       ( SLAVE2_RID_const_net_0 ), // tied to 9'h000 from definition
        .SLAVE2_RDATA     ( FIC0_INITIATOR_AXI4mslave2_RDATA ),
        .SLAVE2_RRESP     ( FIC0_INITIATOR_AXI4mslave2_RRESP ),
        .SLAVE2_RLAST     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE2_RVALID    ( FIC0_INITIATOR_AXI4mslave2_RVALID ),
        .SLAVE2_BUSER     ( GND_net ), // tied to 1'b0 from definition
        .SLAVE2_RUSER     ( GND_net ), // tied to 1'b0 from definition
        .MASTER0_AWID     ( AXI4mmaster0_MASTER0_AWID ),
        .MASTER0_AWADDR   ( AXI4mmaster0_MASTER0_AWADDR ),
        .MASTER0_AWLEN    ( AXI4mmaster0_MASTER0_AWLEN ),
        .MASTER0_AWSIZE   ( AXI4mmaster0_MASTER0_AWSIZE ),
        .MASTER0_AWBURST  ( AXI4mmaster0_MASTER0_AWBURST ),
        .MASTER0_AWLOCK   ( AXI4mmaster0_MASTER0_AWLOCK ),
        .MASTER0_AWCACHE  ( AXI4mmaster0_MASTER0_AWCACHE ),
        .MASTER0_AWPROT   ( AXI4mmaster0_MASTER0_AWPROT ),
        .MASTER0_AWQOS    ( AXI4mmaster0_MASTER0_AWQOS ),
        .MASTER0_AWREGION ( AXI4mmaster0_MASTER0_AWREGION ),
        .MASTER0_AWVALID  ( AXI4mmaster0_MASTER0_AWVALID ),
        .MASTER0_WDATA    ( AXI4mmaster0_MASTER0_WDATA ),
        .MASTER0_WSTRB    ( AXI4mmaster0_MASTER0_WSTRB ),
        .MASTER0_WLAST    ( AXI4mmaster0_MASTER0_WLAST ),
        .MASTER0_WVALID   ( AXI4mmaster0_MASTER0_WVALID ),
        .MASTER0_BREADY   ( AXI4mmaster0_MASTER0_BREADY ),
        .MASTER0_ARID     ( AXI4mmaster0_MASTER0_ARID ),
        .MASTER0_ARADDR   ( AXI4mmaster0_MASTER0_ARADDR ),
        .MASTER0_ARLEN    ( AXI4mmaster0_MASTER0_ARLEN ),
        .MASTER0_ARSIZE   ( AXI4mmaster0_MASTER0_ARSIZE ),
        .MASTER0_ARBURST  ( AXI4mmaster0_MASTER0_ARBURST ),
        .MASTER0_ARLOCK   ( AXI4mmaster0_MASTER0_ARLOCK ),
        .MASTER0_ARCACHE  ( AXI4mmaster0_MASTER0_ARCACHE ),
        .MASTER0_ARPROT   ( AXI4mmaster0_MASTER0_ARPROT ),
        .MASTER0_ARQOS    ( AXI4mmaster0_MASTER0_ARQOS ),
        .MASTER0_ARREGION ( AXI4mmaster0_MASTER0_ARREGION ),
        .MASTER0_ARVALID  ( AXI4mmaster0_MASTER0_ARVALID ),
        .MASTER0_RREADY   ( AXI4mmaster0_MASTER0_RREADY ),
        .MASTER0_AWUSER   ( AXI4mmaster0_MASTER0_AWUSER ),
        .MASTER0_WUSER    ( AXI4mmaster0_MASTER0_WUSER ),
        .MASTER0_ARUSER   ( AXI4mmaster0_MASTER0_ARUSER ),
        // Outputs
        .SLAVE0_AWID      (  ),
        .SLAVE0_AWADDR    (  ),
        .SLAVE0_AWLEN     (  ),
        .SLAVE0_AWSIZE    (  ),
        .SLAVE0_AWBURST   (  ),
        .SLAVE0_AWLOCK    (  ),
        .SLAVE0_AWCACHE   (  ),
        .SLAVE0_AWPROT    (  ),
        .SLAVE0_AWQOS     (  ),
        .SLAVE0_AWREGION  (  ),
        .SLAVE0_AWVALID   (  ),
        .SLAVE0_WDATA     (  ),
        .SLAVE0_WSTRB     (  ),
        .SLAVE0_WLAST     (  ),
        .SLAVE0_WVALID    (  ),
        .SLAVE0_BREADY    (  ),
        .SLAVE0_ARID      (  ),
        .SLAVE0_ARADDR    (  ),
        .SLAVE0_ARLEN     (  ),
        .SLAVE0_ARSIZE    (  ),
        .SLAVE0_ARBURST   (  ),
        .SLAVE0_ARLOCK    (  ),
        .SLAVE0_ARCACHE   (  ),
        .SLAVE0_ARPROT    (  ),
        .SLAVE0_ARQOS     (  ),
        .SLAVE0_ARREGION  (  ),
        .SLAVE0_ARVALID   (  ),
        .SLAVE0_RREADY    (  ),
        .SLAVE0_AWUSER    (  ),
        .SLAVE0_WUSER     (  ),
        .SLAVE0_ARUSER    (  ),
        .SLAVE1_AWID      ( FIC0_INITIATOR_AXI4mslave1_AWID ),
        .SLAVE1_AWADDR    ( FIC0_INITIATOR_AXI4mslave1_AWADDR ),
        .SLAVE1_AWLEN     ( FIC0_INITIATOR_AXI4mslave1_AWLEN ),
        .SLAVE1_AWSIZE    ( FIC0_INITIATOR_AXI4mslave1_AWSIZE ),
        .SLAVE1_AWBURST   ( FIC0_INITIATOR_AXI4mslave1_AWBURST ),
        .SLAVE1_AWLOCK    ( FIC0_INITIATOR_AXI4mslave1_AWLOCK ),
        .SLAVE1_AWCACHE   ( FIC0_INITIATOR_AXI4mslave1_AWCACHE ),
        .SLAVE1_AWPROT    ( FIC0_INITIATOR_AXI4mslave1_AWPROT ),
        .SLAVE1_AWQOS     ( FIC0_INITIATOR_AXI4mslave1_AWQOS ),
        .SLAVE1_AWREGION  ( FIC0_INITIATOR_AXI4mslave1_AWREGION ),
        .SLAVE1_AWVALID   ( FIC0_INITIATOR_AXI4mslave1_AWVALID ),
        .SLAVE1_WDATA     ( FIC0_INITIATOR_AXI4mslave1_WDATA ),
        .SLAVE1_WSTRB     ( FIC0_INITIATOR_AXI4mslave1_WSTRB ),
        .SLAVE1_WLAST     ( FIC0_INITIATOR_AXI4mslave1_WLAST ),
        .SLAVE1_WVALID    ( FIC0_INITIATOR_AXI4mslave1_WVALID ),
        .SLAVE1_BREADY    ( FIC0_INITIATOR_AXI4mslave1_BREADY ),
        .SLAVE1_ARID      ( FIC0_INITIATOR_AXI4mslave1_ARID ),
        .SLAVE1_ARADDR    ( FIC0_INITIATOR_AXI4mslave1_ARADDR ),
        .SLAVE1_ARLEN     ( FIC0_INITIATOR_AXI4mslave1_ARLEN ),
        .SLAVE1_ARSIZE    ( FIC0_INITIATOR_AXI4mslave1_ARSIZE ),
        .SLAVE1_ARBURST   ( FIC0_INITIATOR_AXI4mslave1_ARBURST ),
        .SLAVE1_ARLOCK    ( FIC0_INITIATOR_AXI4mslave1_ARLOCK ),
        .SLAVE1_ARCACHE   ( FIC0_INITIATOR_AXI4mslave1_ARCACHE ),
        .SLAVE1_ARPROT    ( FIC0_INITIATOR_AXI4mslave1_ARPROT ),
        .SLAVE1_ARQOS     ( FIC0_INITIATOR_AXI4mslave1_ARQOS ),
        .SLAVE1_ARREGION  ( FIC0_INITIATOR_AXI4mslave1_ARREGION ),
        .SLAVE1_ARVALID   ( FIC0_INITIATOR_AXI4mslave1_ARVALID ),
        .SLAVE1_RREADY    ( FIC0_INITIATOR_AXI4mslave1_RREADY ),
        .SLAVE1_AWUSER    ( FIC0_INITIATOR_AXI4mslave1_AWUSER ),
        .SLAVE1_WUSER     ( FIC0_INITIATOR_AXI4mslave1_WUSER ),
        .SLAVE1_ARUSER    ( FIC0_INITIATOR_AXI4mslave1_ARUSER ),
        .SLAVE2_AWID      ( FIC0_INITIATOR_AXI4mslave2_AWID ),
        .SLAVE2_AWADDR    ( FIC0_INITIATOR_AXI4mslave2_AWADDR ),
        .SLAVE2_AWLEN     ( FIC0_INITIATOR_AXI4mslave2_AWLEN ),
        .SLAVE2_AWSIZE    ( FIC0_INITIATOR_AXI4mslave2_AWSIZE ),
        .SLAVE2_AWBURST   ( FIC0_INITIATOR_AXI4mslave2_AWBURST ),
        .SLAVE2_AWLOCK    ( FIC0_INITIATOR_AXI4mslave2_AWLOCK ),
        .SLAVE2_AWCACHE   ( FIC0_INITIATOR_AXI4mslave2_AWCACHE ),
        .SLAVE2_AWPROT    ( FIC0_INITIATOR_AXI4mslave2_AWPROT ),
        .SLAVE2_AWQOS     ( FIC0_INITIATOR_AXI4mslave2_AWQOS ),
        .SLAVE2_AWREGION  ( FIC0_INITIATOR_AXI4mslave2_AWREGION ),
        .SLAVE2_AWVALID   ( FIC0_INITIATOR_AXI4mslave2_AWVALID ),
        .SLAVE2_WDATA     ( FIC0_INITIATOR_AXI4mslave2_WDATA ),
        .SLAVE2_WSTRB     ( FIC0_INITIATOR_AXI4mslave2_WSTRB ),
        .SLAVE2_WLAST     ( FIC0_INITIATOR_AXI4mslave2_WLAST ),
        .SLAVE2_WVALID    ( FIC0_INITIATOR_AXI4mslave2_WVALID ),
        .SLAVE2_BREADY    ( FIC0_INITIATOR_AXI4mslave2_BREADY ),
        .SLAVE2_ARID      ( FIC0_INITIATOR_AXI4mslave2_ARID ),
        .SLAVE2_ARADDR    ( FIC0_INITIATOR_AXI4mslave2_ARADDR ),
        .SLAVE2_ARLEN     ( FIC0_INITIATOR_AXI4mslave2_ARLEN ),
        .SLAVE2_ARSIZE    ( FIC0_INITIATOR_AXI4mslave2_ARSIZE ),
        .SLAVE2_ARBURST   ( FIC0_INITIATOR_AXI4mslave2_ARBURST ),
        .SLAVE2_ARLOCK    ( FIC0_INITIATOR_AXI4mslave2_ARLOCK ),
        .SLAVE2_ARCACHE   ( FIC0_INITIATOR_AXI4mslave2_ARCACHE ),
        .SLAVE2_ARPROT    ( FIC0_INITIATOR_AXI4mslave2_ARPROT ),
        .SLAVE2_ARQOS     ( FIC0_INITIATOR_AXI4mslave2_ARQOS ),
        .SLAVE2_ARREGION  ( FIC0_INITIATOR_AXI4mslave2_ARREGION ),
        .SLAVE2_ARVALID   ( FIC0_INITIATOR_AXI4mslave2_ARVALID ),
        .SLAVE2_RREADY    ( FIC0_INITIATOR_AXI4mslave2_RREADY ),
        .SLAVE2_AWUSER    ( FIC0_INITIATOR_AXI4mslave2_AWUSER ),
        .SLAVE2_WUSER     ( FIC0_INITIATOR_AXI4mslave2_WUSER ),
        .SLAVE2_ARUSER    ( FIC0_INITIATOR_AXI4mslave2_ARUSER ),
        .MASTER0_AWREADY  ( AXI4mmaster0_AWREADY ),
        .MASTER0_WREADY   ( AXI4mmaster0_WREADY ),
        .MASTER0_BID      ( AXI4mmaster0_BID ),
        .MASTER0_BRESP    ( AXI4mmaster0_BRESP ),
        .MASTER0_BVALID   ( AXI4mmaster0_BVALID ),
        .MASTER0_ARREADY  ( AXI4mmaster0_ARREADY ),
        .MASTER0_RID      ( AXI4mmaster0_RID ),
        .MASTER0_RDATA    ( AXI4mmaster0_RDATA ),
        .MASTER0_RRESP    ( AXI4mmaster0_RRESP ),
        .MASTER0_RLAST    ( AXI4mmaster0_RLAST ),
        .MASTER0_RVALID   ( AXI4mmaster0_RVALID ),
        .MASTER0_BUSER    ( AXI4mmaster0_BUSER ),
        .MASTER0_RUSER    ( AXI4mmaster0_RUSER ) 
        );

//--------gemm_dma_top
gemm_dma_top #( 
        .AXI_ADDR_WIDTH ( 32 ),
        .AXI_DATA_WIDTH ( 32 ) )
GEMM_DMA_TOP(
        // Inputs
        .clk           ( ACLK ),
        .rst_n         ( ARESETN ),
        .s_axi_awaddr  ( FIC0_INITIATOR_AXI4mslave2_AWADDR_0 ),
        .s_axi_awvalid ( FIC0_INITIATOR_AXI4mslave2_AWVALID ),
        .s_axi_wdata   ( FIC0_INITIATOR_AXI4mslave2_WDATA ),
        .s_axi_wstrb   ( FIC0_INITIATOR_AXI4mslave2_WSTRB ),
        .s_axi_wvalid  ( FIC0_INITIATOR_AXI4mslave2_WVALID ),
        .s_axi_bready  ( FIC0_INITIATOR_AXI4mslave2_BREADY ),
        .s_axi_araddr  ( FIC0_INITIATOR_AXI4mslave2_ARADDR_0 ),
        .s_axi_arvalid ( FIC0_INITIATOR_AXI4mslave2_ARVALID ),
        .s_axi_rready  ( FIC0_INITIATOR_AXI4mslave2_RREADY ),
        .m_axi_awready ( GEMM_DMA_TOP_m_axi_AWREADY ),
        .m_axi_wready  ( GEMM_DMA_TOP_m_axi_WREADY ),
        .m_axi_bresp   ( GEMM_DMA_TOP_m_axi_BRESP ),
        .m_axi_bvalid  ( GEMM_DMA_TOP_m_axi_BVALID ),
        .m_axi_arready ( GEMM_DMA_TOP_m_axi_ARREADY ),
        .m_axi_rdata   ( GEMM_DMA_TOP_m_axi_RDATA_0 ),
        .m_axi_rresp   ( GEMM_DMA_TOP_m_axi_RRESP ),
        .m_axi_rlast   ( GEMM_DMA_TOP_m_axi_RLAST ),
        .m_axi_rvalid  ( GEMM_DMA_TOP_m_axi_RVALID ),
        // Outputs
        .s_axi_awready ( FIC0_INITIATOR_AXI4mslave2_AWREADY ),
        .s_axi_wready  ( FIC0_INITIATOR_AXI4mslave2_WREADY ),
        .s_axi_bresp   ( FIC0_INITIATOR_AXI4mslave2_BRESP ),
        .s_axi_bvalid  ( FIC0_INITIATOR_AXI4mslave2_BVALID ),
        .s_axi_arready ( FIC0_INITIATOR_AXI4mslave2_ARREADY ),
        .s_axi_rdata   ( FIC0_INITIATOR_AXI4mslave2_RDATA ),
        .s_axi_rresp   ( FIC0_INITIATOR_AXI4mslave2_RRESP ),
        .s_axi_rvalid  ( FIC0_INITIATOR_AXI4mslave2_RVALID ),
        .m_axi_awaddr  ( GEMM_DMA_TOP_m_axi_AWADDR ),
        .m_axi_awlen   ( GEMM_DMA_TOP_m_axi_AWLEN ),
        .m_axi_awsize  ( GEMM_DMA_TOP_m_axi_AWSIZE ),
        .m_axi_awburst ( GEMM_DMA_TOP_m_axi_AWBURST ),
        .m_axi_awlock  ( GEMM_DMA_TOP_m_axi_AWLOCK ),
        .m_axi_awcache ( GEMM_DMA_TOP_m_axi_AWCACHE ),
        .m_axi_awprot  ( GEMM_DMA_TOP_m_axi_AWPROT ),
        .m_axi_awqos   ( GEMM_DMA_TOP_m_axi_AWQOS ),
        .m_axi_awvalid ( GEMM_DMA_TOP_m_axi_AWVALID ),
        .m_axi_wdata   ( GEMM_DMA_TOP_m_axi_WDATA ),
        .m_axi_wstrb   ( GEMM_DMA_TOP_m_axi_WSTRB ),
        .m_axi_wlast   ( GEMM_DMA_TOP_m_axi_WLAST ),
        .m_axi_wvalid  ( GEMM_DMA_TOP_m_axi_WVALID ),
        .m_axi_bready  ( GEMM_DMA_TOP_m_axi_BREADY ),
        .m_axi_araddr  ( GEMM_DMA_TOP_m_axi_ARADDR ),
        .m_axi_arlen   ( GEMM_DMA_TOP_m_axi_ARLEN ),
        .m_axi_arsize  ( GEMM_DMA_TOP_m_axi_ARSIZE ),
        .m_axi_arburst ( GEMM_DMA_TOP_m_axi_ARBURST ),
        .m_axi_arlock  ( GEMM_DMA_TOP_m_axi_ARLOCK ),
        .m_axi_arcache ( GEMM_DMA_TOP_m_axi_ARCACHE ),
        .m_axi_arprot  ( GEMM_DMA_TOP_m_axi_ARPROT ),
        .m_axi_arqos   ( GEMM_DMA_TOP_m_axi_ARQOS ),
        .m_axi_arvalid ( GEMM_DMA_TOP_m_axi_ARVALID ),
        .m_axi_rready  ( GEMM_DMA_TOP_m_axi_RREADY ),
        .irq           (  ),
        .led_busy      (  ),
        .led_done      (  ) 
        );

//--------MSS_LSRAM
MSS_LSRAM MSS_LSRAM_inst_0(
        // Inputs
        .ACLK    ( ACLK ),
        .ARESETN ( ARESETN ),
        .AWADDR  ( FIC0_INITIATOR_AXI4mslave1_AWADDR_0 ),
        .AWLEN   ( FIC0_INITIATOR_AXI4mslave1_AWLEN ),
        .AWSIZE  ( FIC0_INITIATOR_AXI4mslave1_AWSIZE ),
        .AWBURST ( FIC0_INITIATOR_AXI4mslave1_AWBURST ),
        .AWLOCK  ( FIC0_INITIATOR_AXI4mslave1_AWLOCK ),
        .AWCACHE ( FIC0_INITIATOR_AXI4mslave1_AWCACHE ),
        .AWPROT  ( FIC0_INITIATOR_AXI4mslave1_AWPROT ),
        .AWVALID ( FIC0_INITIATOR_AXI4mslave1_AWVALID ),
        .WDATA   ( FIC0_INITIATOR_AXI4mslave1_WDATA ),
        .WSTRB   ( FIC0_INITIATOR_AXI4mslave1_WSTRB ),
        .WLAST   ( FIC0_INITIATOR_AXI4mslave1_WLAST ),
        .WVALID  ( FIC0_INITIATOR_AXI4mslave1_WVALID ),
        .BREADY  ( FIC0_INITIATOR_AXI4mslave1_BREADY ),
        .ARADDR  ( FIC0_INITIATOR_AXI4mslave1_ARADDR_0 ),
        .ARLEN   ( FIC0_INITIATOR_AXI4mslave1_ARLEN ),
        .ARSIZE  ( FIC0_INITIATOR_AXI4mslave1_ARSIZE ),
        .ARBURST ( FIC0_INITIATOR_AXI4mslave1_ARBURST ),
        .ARLOCK  ( FIC0_INITIATOR_AXI4mslave1_ARLOCK ),
        .ARCACHE ( FIC0_INITIATOR_AXI4mslave1_ARCACHE ),
        .ARPROT  ( FIC0_INITIATOR_AXI4mslave1_ARPROT ),
        .ARVALID ( FIC0_INITIATOR_AXI4mslave1_ARVALID ),
        .RREADY  ( FIC0_INITIATOR_AXI4mslave1_RREADY ),
        .AWID    ( FIC0_INITIATOR_AXI4mslave1_AWID_0 ),
        .ARID    ( FIC0_INITIATOR_AXI4mslave1_ARID_0 ),
        // Outputs
        .AWREADY ( FIC0_INITIATOR_AXI4mslave1_AWREADY ),
        .WREADY  ( FIC0_INITIATOR_AXI4mslave1_WREADY ),
        .BVALID  ( FIC0_INITIATOR_AXI4mslave1_BVALID ),
        .ARREADY ( FIC0_INITIATOR_AXI4mslave1_ARREADY ),
        .RDATA   ( FIC0_INITIATOR_AXI4mslave1_RDATA ),
        .RRESP   ( FIC0_INITIATOR_AXI4mslave1_RRESP ),
        .RLAST   ( FIC0_INITIATOR_AXI4mslave1_RLAST ),
        .RVALID  ( FIC0_INITIATOR_AXI4mslave1_RVALID ),
        .BRESP   ( FIC0_INITIATOR_AXI4mslave1_BRESP ),
        .BID     ( FIC0_INITIATOR_AXI4mslave1_BID ),
        .RID     ( FIC0_INITIATOR_AXI4mslave1_RID ) 
        );


endmodule
