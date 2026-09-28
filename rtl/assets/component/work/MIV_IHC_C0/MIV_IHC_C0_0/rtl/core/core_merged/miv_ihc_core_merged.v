// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module MIV_IHC_C0_MIV_IHC_C0_0_MIV_IHC (
    // Inputs
    APB_0_PADDR,
    APB_0_PCLK,
    APB_0_PENABLE,
    APB_0_PRESETn,
    APB_0_PSEL,
    APB_0_PWDATA,
    APB_0_PWRITE,
    AXI_0_ACLK,
    AXI_0_ARADDR,
    AXI_0_ARESETn,
	AXI_0_ARPROT,
    AXI_0_ARVALID,
    AXI_0_AWADDR,
    AXI_0_AWPROT,
    AXI_0_AWVALID,
    AXI_0_BREADY,
    AXI_0_RREADY,
    AXI_0_WDATA,
    AXI_0_WSTRB,
    AXI_0_WVALID,
	APB_1_PADDR,
    APB_1_PCLK,
    APB_1_PENABLE,
    APB_1_PRESETn,
    APB_1_PSEL,
    APB_1_PWDATA,
    APB_1_PWRITE,
    AXI_1_ACLK,
    AXI_1_ARADDR,
    AXI_1_ARESETn,
    AXI_1_ARPROT,
    AXI_1_ARVALID,
    AXI_1_AWADDR,
    AXI_1_AWPROT,
    AXI_1_AWVALID,
    AXI_1_BREADY,
    AXI_1_RREADY,
    AXI_1_WDATA,
    AXI_1_WSTRB,
    AXI_1_WVALID,
	APB_2_PADDR,
    APB_2_PCLK,
    APB_2_PENABLE,
    APB_2_PRESETn,
    APB_2_PSEL,
    APB_2_PWDATA,
    APB_2_PWRITE,
    AXI_2_ACLK,
    AXI_2_ARADDR,
    AXI_2_ARESETn,
	AXI_2_ARPROT,
    AXI_2_ARVALID,
    AXI_2_AWADDR,
    AXI_2_AWPROT,
    AXI_2_AWVALID,
    AXI_2_BREADY,
    AXI_2_RREADY,
    AXI_2_WDATA,
    AXI_2_WSTRB,
    AXI_2_WVALID,
    CORE_CLK,
    CORE_RESETN,
    // Outputs
    APB_0_PRDATA,
    APB_0_PREADY,
    APB_0_PSLVERR,
    AXI_0_ARREADY,
    AXI_0_AWREADY,
    AXI_0_BRESP,
    AXI_0_BVALID,
    AXI_0_RDATA,
    AXI_0_RRESP,
    AXI_0_RVALID,
    AXI_0_WREADY,
	APB_1_PRDATA,
    APB_1_PREADY,
    APB_1_PSLVERR,
    AXI_1_ARREADY,
    AXI_1_AWREADY,
    AXI_1_BRESP,
    AXI_1_BVALID,
    AXI_1_RDATA,
    AXI_1_RRESP,
    AXI_1_RVALID,
    AXI_1_WREADY,
	APB_2_PRDATA,
    APB_2_PREADY,
    APB_2_PSLVERR,
    AXI_2_ARREADY,
    AXI_2_AWREADY,
    AXI_2_BRESP,
    AXI_2_BVALID,
    AXI_2_RDATA,
    AXI_2_RRESP,
    AXI_2_RVALID,
    AXI_2_WREADY,
    MON_IRQ_H1,
    MON_IRQ_H2,
    MON_IRQ_H3,
    MON_IRQ_H4,
    MON_IRQ_H5,
    APP_IRQ_H0,
    APP_IRQ_H1,
    APP_IRQ_H2,
    APP_IRQ_H3,
    APP_IRQ_H4,
    APP_IRQ_H5
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
// FAMILY parameter
parameter FAMILY            = 26;

// H0 Monitor Parameter
parameter H0_MONITOR_EN		= 1;

// Channel Enable Parameters
parameter H0_TO_H1_CH_EN 	= 1;  // 0 = no channel between H0 and H1, 1 = channel present between H0 and H1
parameter H0_TO_H2_CH_EN 	= 1;
parameter H0_TO_H3_CH_EN 	= 1;
parameter H0_TO_H4_CH_EN 	= 1;
parameter H0_TO_H5_CH_EN 	= 0;
parameter H1_TO_H2_CH_EN 	= 1;
parameter H1_TO_H3_CH_EN 	= 1;
parameter H1_TO_H4_CH_EN 	= 1;
parameter H1_TO_H5_CH_EN 	= 0;
parameter H2_TO_H3_CH_EN 	= 1;
parameter H2_TO_H4_CH_EN 	= 1;
parameter H2_TO_H5_CH_EN 	= 0;
parameter H3_TO_H4_CH_EN 	= 1;
parameter H3_TO_H5_CH_EN 	= 0;
parameter H4_TO_H5_CH_EN 	= 0;  // 0 = no channel between H4 and H5, 1 = channel present between H4 and H5

// Interrupt Module Parameters
parameter H0_IHCIM_EN		= 1;
parameter H1_IHCIM_EN		= 1;
parameter H2_IHCIM_EN		= 1;
parameter H3_IHCIM_EN		= 1;
parameter H4_IHCIM_EN		= 1;
parameter H5_IHCIM_EN		= 0;

// Target Interface Parameters
parameter INF_0_TYPE		= 1;  // 0 = no interface 0 present, 1 = APB interface 0 present, 2 = AXI3-Lite interface 0 present, 3 = AXI4-Lite interface 0 present
parameter INF_0_TYPE_MIRROR = 1;  // 0 = Interface 0 is a non-mirrored Target port, 1 = Interface 0 is a mirrored Initiator
parameter INF_1_TYPE		= 0;
parameter INF_1_TYPE_MIRROR = 0;
parameter INF_2_TYPE		= 0;
parameter INF_2_TYPE_MIRROR = 0;

// CDC parameters
parameter INF_0_CDC_EN		= 0;  // 0 = no CDC on interface 0, 1 = CDC enabled on interface 0
parameter INF_1_CDC_EN		= 0;
parameter INF_2_CDC_EN		= 0;  // 0 = no CDC on interface 2, 1 = CDC enabled on interface 2

// Memory Protection Unit Parameters
parameter MPU_EN		 	= 0;  // 0 = no MPUs, 1 = MPU enabled on all interfaces

parameter INF_0_H0_ACCESS	= 0;  // allow interface 0 to access H0 channels and corresponding interrupt module 
parameter INF_0_H1_ACCESS	= 0;
parameter INF_0_H2_ACCESS	= 0;
parameter INF_0_H3_ACCESS	= 0;
parameter INF_0_H4_ACCESS	= 0;
parameter INF_0_H5_ACCESS	= 0;  // allow interface 0 to access H5 channels and corresponding interrupt module 

parameter INF_1_H0_ACCESS	= 0;  // allow interface 1 to access H0 channels and corresponding interrupt module 
parameter INF_1_H1_ACCESS	= 0;
parameter INF_1_H2_ACCESS	= 0;
parameter INF_1_H3_ACCESS	= 0;
parameter INF_1_H4_ACCESS	= 0;
parameter INF_1_H5_ACCESS	= 0;  // allow interface 1 to access H5 channels and corresponding interrupt module 

parameter INF_2_H0_ACCESS	= 0;  // allow interface 2 to access H0 channels and corresponding interrupt module 
parameter INF_2_H1_ACCESS	= 0;
parameter INF_2_H2_ACCESS	= 0;
parameter INF_2_H3_ACCESS	= 0;
parameter INF_2_H4_ACCESS	= 0;
parameter INF_2_H5_ACCESS	= 0;  // allow interface 2 to access H5 channels and corresponding interrupt module 


//--------------------------------------------------------------------
// Local Parameters
//--------------------------------------------------------------------
// User-configurable Parameters
localparam SYNC_RESET = 0;  // synchronous/asynchronous mode select

//Depth of each IHCC mailbox
localparam H0_TO_H1_A_MEMORY_DEPTH_N = 4;  // write depth of Hart 0 to Hart 1 A_side (equivalent to read depth of Hart 1 from Hart 0 B_side)
localparam H0_TO_H1_B_MEMORY_DEPTH_M = 4;  // write depth of Hart 1 to Hart 0 B_side (equivalent to read depth of Hart 0 from Hart 1 A_side)
localparam H0_TO_H2_A_MEMORY_DEPTH_N = 4;
localparam H0_TO_H2_B_MEMORY_DEPTH_M = 4;
localparam H0_TO_H3_A_MEMORY_DEPTH_N = 4;
localparam H0_TO_H3_B_MEMORY_DEPTH_M = 4;
localparam H0_TO_H4_A_MEMORY_DEPTH_N = 4;
localparam H0_TO_H4_B_MEMORY_DEPTH_M = 4;
localparam H0_TO_H5_A_MEMORY_DEPTH_N = 4;
localparam H0_TO_H5_B_MEMORY_DEPTH_M = 4;
localparam H1_TO_H2_A_MEMORY_DEPTH_N = 4;
localparam H1_TO_H2_B_MEMORY_DEPTH_M = 4;
localparam H1_TO_H3_A_MEMORY_DEPTH_N = 4;
localparam H1_TO_H3_B_MEMORY_DEPTH_M = 4;
localparam H1_TO_H4_A_MEMORY_DEPTH_N = 4;
localparam H1_TO_H4_B_MEMORY_DEPTH_M = 4;
localparam H1_TO_H5_A_MEMORY_DEPTH_N = 4;
localparam H1_TO_H5_B_MEMORY_DEPTH_M = 4;
localparam H2_TO_H3_A_MEMORY_DEPTH_N = 4;
localparam H2_TO_H3_B_MEMORY_DEPTH_M = 4;
localparam H2_TO_H4_A_MEMORY_DEPTH_N = 4;
localparam H2_TO_H4_B_MEMORY_DEPTH_M = 4;
localparam H2_TO_H5_A_MEMORY_DEPTH_N = 4;
localparam H2_TO_H5_B_MEMORY_DEPTH_M = 4;
localparam H3_TO_H4_A_MEMORY_DEPTH_N = 4;
localparam H3_TO_H4_B_MEMORY_DEPTH_M = 4;
localparam H3_TO_H5_A_MEMORY_DEPTH_N = 4;
localparam H3_TO_H5_B_MEMORY_DEPTH_M = 4;
localparam H4_TO_H5_A_MEMORY_DEPTH_N = 4;
localparam H4_TO_H5_B_MEMORY_DEPTH_M = 4;

// The memory map will be switched from the default to increasing powers of 2
// for H0-H5 starting at address 0x0_4000 if this localparam is set to 1
localparam ONE_HOT_MM = 0;

// Do not change the below localparameters!
localparam APB_INTERFACE_0 = (INF_0_TYPE == 1);
localparam APB_INTERFACE_1 = (INF_1_TYPE == 1);
localparam APB_INTERFACE_2 = (INF_2_TYPE == 1);
localparam AXI_INTERFACE_0 = (INF_0_TYPE == 2 || INF_0_TYPE == 3);
localparam AXI_INTERFACE_1 = (INF_1_TYPE == 2 || INF_1_TYPE == 3);
localparam AXI_INTERFACE_2 = (INF_2_TYPE == 2 || INF_2_TYPE == 3);

localparam IF_0_EN = APB_INTERFACE_0 || AXI_INTERFACE_0;
localparam IF_1_EN = APB_INTERFACE_1 || AXI_INTERFACE_1;
localparam IF_2_EN = APB_INTERFACE_2 || AXI_INTERFACE_2;

localparam MIV_IHC_IP_VERSION = 32'h02000064;

localparam l_h0_ihcim_en = H0_IHCIM_EN && (H0_TO_H1_CH_EN || H0_TO_H2_CH_EN || H0_TO_H3_CH_EN || H0_TO_H4_CH_EN || H0_TO_H5_CH_EN);
localparam l_h1_ihcim_en = H1_IHCIM_EN && (H0_TO_H1_CH_EN || H1_TO_H2_CH_EN || H1_TO_H3_CH_EN || H1_TO_H4_CH_EN || H1_TO_H5_CH_EN);
localparam l_h2_ihcim_en = H2_IHCIM_EN && (H0_TO_H2_CH_EN || H1_TO_H2_CH_EN || H2_TO_H3_CH_EN || H2_TO_H4_CH_EN || H2_TO_H5_CH_EN);
localparam l_h3_ihcim_en = H3_IHCIM_EN && (H0_TO_H3_CH_EN || H1_TO_H3_CH_EN || H2_TO_H3_CH_EN || H3_TO_H4_CH_EN || H3_TO_H5_CH_EN);
localparam l_h4_ihcim_en = H4_IHCIM_EN && (H0_TO_H4_CH_EN || H1_TO_H4_CH_EN || H2_TO_H4_CH_EN || H3_TO_H4_CH_EN || H4_TO_H5_CH_EN);
localparam l_h5_ihcim_en = H5_IHCIM_EN && (H0_TO_H5_CH_EN || H1_TO_H5_CH_EN || H2_TO_H5_CH_EN || H3_TO_H5_CH_EN || H4_TO_H5_CH_EN);

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
input         AXI_0_ACLK;
input  [31:0] AXI_0_ARADDR;
input         AXI_0_ARESETn;
input  [2:0]  AXI_0_ARPROT;
input         AXI_0_ARVALID;
input  [31:0] AXI_0_AWADDR;
input  [2:0]  AXI_0_AWPROT;
input         AXI_0_AWVALID;
input         AXI_0_BREADY;
input         AXI_0_RREADY;
input  [31:0] AXI_0_WDATA;
input  [3:0]  AXI_0_WSTRB;
input         AXI_0_WVALID;
input  [31:0] APB_1_PADDR;
input         APB_1_PCLK;
input         APB_1_PENABLE;
input         APB_1_PRESETn;
input         APB_1_PSEL;
input  [31:0] APB_1_PWDATA;
input         APB_1_PWRITE;
input         AXI_1_ACLK;
input  [31:0] AXI_1_ARADDR;
input         AXI_1_ARESETn;
input  [2:0]  AXI_1_ARPROT;
input         AXI_1_ARVALID;
input  [31:0] AXI_1_AWADDR;
input  [2:0]  AXI_1_AWPROT;
input         AXI_1_AWVALID;
input         AXI_1_BREADY;
input         AXI_1_RREADY;
input  [31:0] AXI_1_WDATA;
input  [3:0]  AXI_1_WSTRB;
input         AXI_1_WVALID;
input  [31:0] APB_2_PADDR;
input         APB_2_PCLK;
input         APB_2_PENABLE;
input         APB_2_PRESETn;
input         APB_2_PSEL;
input  [31:0] APB_2_PWDATA;
input         APB_2_PWRITE;
input         AXI_2_ACLK;
input  [31:0] AXI_2_ARADDR;
input         AXI_2_ARESETn;
input  [2:0]  AXI_2_ARPROT;
input         AXI_2_ARVALID;
input  [31:0] AXI_2_AWADDR;
input  [2:0]  AXI_2_AWPROT;
input         AXI_2_AWVALID;
input         AXI_2_BREADY;
input         AXI_2_RREADY;
input  [31:0] AXI_2_WDATA;
input  [3:0]  AXI_2_WSTRB;
input         AXI_2_WVALID;
input         CORE_CLK;
input         CORE_RESETN;

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_0_PRDATA;
output        APB_0_PREADY;
output        APB_0_PSLVERR;
output        AXI_0_ARREADY;
output        AXI_0_AWREADY;
output [1:0]  AXI_0_BRESP;
output        AXI_0_BVALID;
output [31:0] AXI_0_RDATA;
output [1:0]  AXI_0_RRESP;
output        AXI_0_RVALID;
output        AXI_0_WREADY;
output [31:0] APB_1_PRDATA;
output        APB_1_PREADY;
output        APB_1_PSLVERR;
output        AXI_1_ARREADY;
output        AXI_1_AWREADY;
output [1:0]  AXI_1_BRESP;
output        AXI_1_BVALID;
output [31:0] AXI_1_RDATA;
output [1:0]  AXI_1_RRESP;
output        AXI_1_RVALID;
output        AXI_1_WREADY;
output [31:0] APB_2_PRDATA;
output        APB_2_PREADY;
output        APB_2_PSLVERR;
output        AXI_2_ARREADY;
output        AXI_2_AWREADY;
output [1:0]  AXI_2_BRESP;
output        AXI_2_BVALID;
output [31:0] AXI_2_RDATA;
output [1:0]  AXI_2_RRESP;
output        AXI_2_RVALID;
output        AXI_2_WREADY;
output        MON_IRQ_H1;
output        MON_IRQ_H2;
output        MON_IRQ_H3;
output        MON_IRQ_H4;
output        MON_IRQ_H5;
output        APP_IRQ_H0;
output        APP_IRQ_H1;
output        APP_IRQ_H2;
output        APP_IRQ_H3;
output        APP_IRQ_H4;
output        APP_IRQ_H5;

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB_ARBITER_0_APB_INITIATOR_0_PRDATA;
wire          APB_ARBITER_0_APB_INITIATOR_0_PREADY;
wire          APB_ARBITER_0_APB_INITIATOR_0_PSLVERR;
wire   [31:0] APB_ARBITER_0_APB_INITIATOR_1_PRDATA;
wire          APB_ARBITER_0_APB_INITIATOR_1_PREADY;
wire          APB_ARBITER_0_APB_INITIATOR_1_PSLVERR;
wire   [31:0] APB_ARBITER_0_APB_INITIATOR_2_PRDATA;
wire          APB_ARBITER_0_APB_INITIATOR_2_PREADY;
wire          APB_ARBITER_0_APB_INITIATOR_2_PSLVERR;

wire   [31:0] APB_ARBITER_0_APB_TARGET_0_PADDR;
wire          APB_ARBITER_0_APB_TARGET_0_PENABLE;
wire          APB_ARBITER_0_APB_TARGET_0_PSEL;
wire   [31:0] APB_ARBITER_0_APB_TARGET_0_PWDATA;
wire          APB_ARBITER_0_APB_TARGET_0_PWRITE;

wire   [31:0] APB_TARGET_0_dest_PADDR_o;
wire          APB_TARGET_0_dest_PENABLE_o;
wire          APB_TARGET_0_dest_PSEL_o;
wire   [31:0] APB_TARGET_0_dest_PWDATA_o;
wire          APB_TARGET_0_dest_PWRITE_o;

wire   [31:0] AXI_TARGET_0_dest_PADDR_o;
wire          AXI_TARGET_0_dest_PENABLE_o;
wire          AXI_TARGET_0_dest_PSEL_o;
wire   [31:0] AXI_TARGET_0_dest_PWDATA_o;
wire          AXI_TARGET_0_dest_PWRITE_o;

wire   [31:0] APB_TARGET_1_dest_PADDR_o;
wire          APB_TARGET_1_dest_PENABLE_o;
wire          APB_TARGET_1_dest_PSEL_o;
wire   [31:0] APB_TARGET_1_dest_PWDATA_o;
wire          APB_TARGET_1_dest_PWRITE_o;

wire   [31:0] AXI_TARGET_1_dest_PADDR_o;
wire          AXI_TARGET_1_dest_PENABLE_o;
wire          AXI_TARGET_1_dest_PSEL_o;
wire   [31:0] AXI_TARGET_1_dest_PWDATA_o;
wire          AXI_TARGET_1_dest_PWRITE_o;

wire   [31:0] APB_TARGET_2_dest_PADDR_o;
wire          APB_TARGET_2_dest_PENABLE_o;
wire          APB_TARGET_2_dest_PSEL_o;
wire   [31:0] APB_TARGET_2_dest_PWDATA_o;
wire          APB_TARGET_2_dest_PWRITE_o;

wire   [31:0] AXI_TARGET_2_dest_PADDR_o;
wire          AXI_TARGET_2_dest_PENABLE_o;
wire          AXI_TARGET_2_dest_PSEL_o;
wire   [31:0] AXI_TARGET_2_dest_PWDATA_o;
wire          AXI_TARGET_2_dest_PWRITE_o;

wire          CORE_CLK;
wire          CORE_RESETN;

wire   [31:0] MIV_IHC_APB_0_APB3_0_PRDATA;
wire          MIV_IHC_APB_0_APB3_0_PREADY;
wire          MIV_IHC_APB_0_APB3_0_PSLVERR;

wire   [5:0]  APP_IRQ;
wire   [5:0]  MON_IRQ;

wire		  APB_INITIATOR_0_PSEL_net;
wire		  APB_INITIATOR_0_PENABLE_net;
wire		  APB_INITIATOR_0_PWRITE_net;
wire   [31:0] APB_INITIATOR_0_PADDR_net;
wire   [31:0] APB_INITIATOR_0_PWDATA_net;

wire 		  APB_INITIATOR_1_PSEL_net;
wire		  APB_INITIATOR_1_PENABLE_net;
wire 		  APB_INITIATOR_1_PWRITE_net;
wire   [31:0] APB_INITIATOR_1_PADDR_net;
wire   [31:0] APB_INITIATOR_1_PWDATA_net;

wire		  APB_INITIATOR_2_PSEL_net;
wire		  APB_INITIATOR_2_PENABLE_net;
wire		  APB_INITIATOR_2_PWRITE_net;
wire   [31:0] APB_INITIATOR_2_PADDR_net;
wire   [31:0] APB_INITIATOR_2_PWDATA_net;

wire [1:0]  AXI_0_ARBURST;
wire [3:0]  AXI_0_ARCACHE;
wire [15:0] AXI_0_ARID;
wire [7:0]  AXI_0_ARLEN;
wire 		AXI_0_ARLOCK;
wire [3:0]  AXI_0_ARQOS;
wire [3:0]  AXI_0_ARREGION;
wire [2:0]  AXI_0_ARSIZE;
wire [9:0]  AXI_0_ARUSER;
wire [1:0]  AXI_0_AWBURST;
wire [3:0]  AXI_0_AWCACHE;
wire [15:0] AXI_0_AWID;
wire [7:0]  AXI_0_AWLEN;
wire 		AXI_0_AWLOCK;
wire [3:0]  AXI_0_AWQOS;
wire [3:0]  AXI_0_AWREGION;
wire [2:0]  AXI_0_AWSIZE;
wire [9:0]  AXI_0_AWUSER;
wire 		AXI_0_WLAST;
wire [9:0]  AXI_0_WUSER;

wire [1:0]  AXI_1_ARBURST;
wire [3:0]  AXI_1_ARCACHE;
wire [15:0] AXI_1_ARID;
wire [7:0]  AXI_1_ARLEN;
wire 		AXI_1_ARLOCK;
wire [3:0]  AXI_1_ARQOS;
wire [3:0]  AXI_1_ARREGION;
wire [2:0]  AXI_1_ARSIZE;
wire [9:0]  AXI_1_ARUSER;
wire [1:0]  AXI_1_AWBURST;
wire [3:0]  AXI_1_AWCACHE;
wire [15:0] AXI_1_AWID;
wire [7:0]  AXI_1_AWLEN;
wire 		AXI_1_AWLOCK;
wire [3:0]  AXI_1_AWQOS;
wire [3:0]  AXI_1_AWREGION;
wire [2:0]  AXI_1_AWSIZE;
wire [9:0]  AXI_1_AWUSER;
wire 		AXI_1_WLAST;
wire [9:0]  AXI_1_WUSER;

wire [1:0]  AXI_2_ARBURST;
wire [3:0]  AXI_2_ARCACHE;
wire [15:0] AXI_2_ARID;
wire [7:0]  AXI_2_ARLEN;
wire 		AXI_2_ARLOCK;
wire [3:0]  AXI_2_ARQOS;
wire [3:0]  AXI_2_ARREGION;
wire [2:0]  AXI_2_ARSIZE;
wire [9:0]  AXI_2_ARUSER;
wire [1:0]  AXI_2_AWBURST;
wire [3:0]  AXI_2_AWCACHE;
wire [15:0] AXI_2_AWID;
wire [7:0]  AXI_2_AWLEN;
wire 		AXI_2_AWLOCK;
wire [3:0]  AXI_2_AWQOS;
wire [3:0]  AXI_2_AWREGION;
wire [2:0]  AXI_2_AWSIZE;
wire [9:0]  AXI_2_AWUSER;
wire 		AXI_2_WLAST;
wire [9:0]  AXI_2_WUSER;

//--------------------------------------------------------------------
// Main Code
//--------------------------------------------------------------------
// Assign the APB Initiator signals for each of the three target interfaces
// These APB Initiator signals connect to a round-robin arbiter to control access to the MIV_IHC Core logic 
// If an interface is not enabled the corresponding Initiator signals will all be tied low
assign APB_INITIATOR_0_PENABLE_net = (APB_INTERFACE_0) ? APB_TARGET_0_dest_PENABLE_o : AXI_TARGET_0_dest_PENABLE_o;
assign APB_INITIATOR_0_PSEL_net	   = (APB_INTERFACE_0) ? APB_TARGET_0_dest_PSEL_o 	 : AXI_TARGET_0_dest_PSEL_o;
assign APB_INITIATOR_0_PWRITE_net  = (APB_INTERFACE_0) ? APB_TARGET_0_dest_PWRITE_o  : AXI_TARGET_0_dest_PWRITE_o;
assign APB_INITIATOR_0_PADDR_net   = (APB_INTERFACE_0) ? APB_TARGET_0_dest_PADDR_o   : AXI_TARGET_0_dest_PADDR_o;
assign APB_INITIATOR_0_PWDATA_net  = (APB_INTERFACE_0) ? APB_TARGET_0_dest_PWDATA_o  : AXI_TARGET_0_dest_PWDATA_o;

assign APB_INITIATOR_1_PENABLE_net = (APB_INTERFACE_1) ? APB_TARGET_1_dest_PENABLE_o : AXI_TARGET_1_dest_PENABLE_o;
assign APB_INITIATOR_1_PSEL_net    = (APB_INTERFACE_1) ? APB_TARGET_1_dest_PSEL_o 	 : AXI_TARGET_1_dest_PSEL_o;
assign APB_INITIATOR_1_PWRITE_net  = (APB_INTERFACE_1) ? APB_TARGET_1_dest_PWRITE_o	 : AXI_TARGET_1_dest_PWRITE_o;
assign APB_INITIATOR_1_PADDR_net   = (APB_INTERFACE_1) ? APB_TARGET_1_dest_PADDR_o	 : AXI_TARGET_1_dest_PADDR_o;
assign APB_INITIATOR_1_PWDATA_net  = (APB_INTERFACE_1) ? APB_TARGET_1_dest_PWDATA_o	 : AXI_TARGET_1_dest_PWDATA_o;

assign APB_INITIATOR_2_PENABLE_net = (APB_INTERFACE_2) ? APB_TARGET_2_dest_PENABLE_o : AXI_TARGET_2_dest_PENABLE_o;
assign APB_INITIATOR_2_PSEL_net    = (APB_INTERFACE_2) ? APB_TARGET_2_dest_PSEL_o 	 : AXI_TARGET_2_dest_PSEL_o;
assign APB_INITIATOR_2_PWRITE_net  = (APB_INTERFACE_2) ? APB_TARGET_2_dest_PWRITE_o	 : AXI_TARGET_2_dest_PWRITE_o;
assign APB_INITIATOR_2_PADDR_net   = (APB_INTERFACE_2) ? APB_TARGET_2_dest_PADDR_o	 : AXI_TARGET_2_dest_PADDR_o;
assign APB_INITIATOR_2_PWDATA_net  = (APB_INTERFACE_2) ? APB_TARGET_2_dest_PWDATA_o	 : AXI_TARGET_2_dest_PWDATA_o;

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
// The Arbiter receives the synchronized APB interface signals and arbitrates access to the Core logic (miv_ihc_core) for the enabled interface(s)
miv_ihc_apb_arbiter_top #(
	.SYNC_RESET(SYNC_RESET),
	.IF_0_EN(IF_0_EN),
	.IF_1_EN(IF_1_EN),
	.IF_2_EN(IF_2_EN)
	)
	apb_arbiter_top_0 (
	// Inputs
	.APB_PCLK                ( CORE_CLK ),
	.APB_PRESETN             ( CORE_RESETN ),
	.APB_INITIATOR_0_PSEL    ( APB_INITIATOR_0_PSEL_net ),
	.APB_INITIATOR_0_PENABLE ( APB_INITIATOR_0_PENABLE_net ),
	.APB_INITIATOR_0_PWRITE  ( APB_INITIATOR_0_PWRITE_net ),
	.APB_INITIATOR_1_PSEL    ( APB_INITIATOR_1_PSEL_net ),
	.APB_INITIATOR_1_PENABLE ( APB_INITIATOR_1_PENABLE_net ),
	.APB_INITIATOR_1_PWRITE  ( APB_INITIATOR_1_PWRITE_net ),
	.APB_INITIATOR_2_PSEL    ( APB_INITIATOR_2_PSEL_net ),
	.APB_INITIATOR_2_PENABLE ( APB_INITIATOR_2_PENABLE_net ),
	.APB_INITIATOR_2_PWRITE  ( APB_INITIATOR_2_PWRITE_net ),
	.APB_TARGET_0_PREADY     ( MIV_IHC_APB_0_APB3_0_PREADY ),
	.APB_TARGET_0_PSLVERR    ( MIV_IHC_APB_0_APB3_0_PSLVERR ),
	.APB_TARGET_0_PRDATA     ( MIV_IHC_APB_0_APB3_0_PRDATA ),
	.APB_INITIATOR_0_PADDR   ( APB_INITIATOR_0_PADDR_net ),
	.APB_INITIATOR_0_PWDATA  ( APB_INITIATOR_0_PWDATA_net ),
	.APB_INITIATOR_1_PADDR   ( APB_INITIATOR_1_PADDR_net ),
	.APB_INITIATOR_1_PWDATA  ( APB_INITIATOR_1_PWDATA_net ),
	.APB_INITIATOR_2_PADDR   ( APB_INITIATOR_2_PADDR_net ),
	.APB_INITIATOR_2_PWDATA  ( APB_INITIATOR_2_PWDATA_net ),
	// Outputs
	.APB_INITIATOR_0_PREADY  ( APB_ARBITER_0_APB_INITIATOR_0_PREADY ),
	.APB_INITIATOR_0_PSLVERR ( APB_ARBITER_0_APB_INITIATOR_0_PSLVERR ),
	.APB_INITIATOR_0_PRDATA  ( APB_ARBITER_0_APB_INITIATOR_0_PRDATA ),
	.APB_INITIATOR_1_PREADY  ( APB_ARBITER_0_APB_INITIATOR_1_PREADY ),
	.APB_INITIATOR_1_PSLVERR ( APB_ARBITER_0_APB_INITIATOR_1_PSLVERR ),
	.APB_INITIATOR_1_PRDATA  ( APB_ARBITER_0_APB_INITIATOR_1_PRDATA ),
	.APB_INITIATOR_2_PREADY  ( APB_ARBITER_0_APB_INITIATOR_2_PREADY ),
	.APB_INITIATOR_2_PSLVERR ( APB_ARBITER_0_APB_INITIATOR_2_PSLVERR ),
	.APB_INITIATOR_2_PRDATA  ( APB_ARBITER_0_APB_INITIATOR_2_PRDATA ),
	.APB_TARGET_0_PSEL       ( APB_ARBITER_0_APB_TARGET_0_PSEL ),
	.APB_TARGET_0_PENABLE    ( APB_ARBITER_0_APB_TARGET_0_PENABLE ),
	.APB_TARGET_0_PWRITE     ( APB_ARBITER_0_APB_TARGET_0_PWRITE ),
	.APB_TARGET_0_PADDR      ( APB_ARBITER_0_APB_TARGET_0_PADDR ),
	.APB_TARGET_0_PWDATA     ( APB_ARBITER_0_APB_TARGET_0_PWDATA ) 
);

//--------apb_target 0
generate
   if (APB_INTERFACE_0)
       begin: apb_tgt0
			miv_ihc_apb_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_0_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_0_H0_ACCESS),
			.H1_ACCESS(INF_0_H1_ACCESS),
			.H2_ACCESS(INF_0_H2_ACCESS),
			.H3_ACCESS(INF_0_H3_ACCESS),
			.H4_ACCESS(INF_0_H4_ACCESS),
			.H5_ACCESS(INF_0_H5_ACCESS)
			) 
			apb_target_0 (
			// Inputs
			.dest_rst_n     ( CORE_RESETN ),
			.src_PENABLE_i  ( APB_0_PENABLE ),
			.src_PWRITE_i   ( APB_0_PWRITE ),
			.src_PSEL_i     ( APB_0_PSEL ),
			.src_clk        ( APB_0_PCLK ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_0_PREADY ),
			.src_rst_n      ( APB_0_PRESETn ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_0_PSLVERR ),
			.dest_clk       ( CORE_CLK ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_0_PRDATA ),
			.src_PADDR_i    ( APB_0_PADDR ),
			.src_PWDATA_i   ( APB_0_PWDATA ),
			// Outputs
			.src_PREADY_o   ( APB_0_PREADY ),
			.src_PSLVERR_o  ( APB_0_PSLVERR ),
			.dest_PWRITE_o  ( APB_TARGET_0_dest_PWRITE_o ),
			.dest_PENABLE_o ( APB_TARGET_0_dest_PENABLE_o ),
			.dest_PSEL_o    ( APB_TARGET_0_dest_PSEL_o ),
			.src_PRDATA_o   ( APB_0_PRDATA ),
			.dest_PADDR_o   ( APB_TARGET_0_dest_PADDR_o ),
			.dest_PWDATA_o  ( APB_TARGET_0_dest_PWDATA_o ) 
			);
       end
   else
       begin: ngen_apb_tgt0
           assign APB_0_PREADY = 1'b0;
           assign APB_0_PRDATA = 1'b0;
           assign APB_0_PSLVERR = 1'b0;
		   
		   assign APB_TARGET_0_dest_PADDR_o = 32'b0;
		   assign APB_TARGET_0_dest_PENABLE_o = 1'b0;
		   assign APB_TARGET_0_dest_PSEL_o = 1'b0;
		   assign APB_TARGET_0_dest_PWDATA_o = 32'b0;
		   assign APB_TARGET_0_dest_PWRITE_o = 1'b0;
       end
endgenerate

//--------axi_target 0
generate
   if (AXI_INTERFACE_0)
       begin: axi_tgt0
			miv_ihc_axi_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_0_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_0_H0_ACCESS),
			.H1_ACCESS(INF_0_H1_ACCESS),
			.H2_ACCESS(INF_0_H2_ACCESS),
			.H3_ACCESS(INF_0_H3_ACCESS),
			.H4_ACCESS(INF_0_H4_ACCESS),
			.H5_ACCESS(INF_0_H5_ACCESS)
			) 
			axi_target_0 (
			// Inputs
			.ARESETn        ( AXI_0_ARESETn ),
			.ACLK           ( AXI_0_ACLK ),
			.ARVALID_i      ( AXI_0_ARVALID ),
			.WVALID_i       ( AXI_0_WVALID ),
			.AWVALID_i      ( AXI_0_AWVALID ),
			.BREADY_i       ( AXI_0_BREADY ),
			.AWLOCK_i       ( AXI_0_AWLOCK ),
			.WLAST_i        ( AXI_0_WLAST ),
			.ARLOCK_i       ( AXI_0_ARLOCK ),
			.dest_clk       ( CORE_CLK ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_0_PSLVERR ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_0_PREADY ),
			.dest_rst_n     ( CORE_RESETN ),
			.RREADY_i       ( AXI_0_RREADY ),
			.AWID_i         ( AXI_0_AWID ),
			.AWUSER_i       ( AXI_0_AWUSER ),
			.AWQOS_i        ( AXI_0_AWQOS ),
			.ARID_i         ( AXI_0_ARID ),
			.AWCACHE_i      ( AXI_0_AWCACHE ),
			.AWADDR_i       ( AXI_0_AWADDR ),
			.WDATA_i        ( AXI_0_WDATA ),
			.AWPROT_i       ( AXI_0_AWPROT ),
			.AWLEN_i        ( AXI_0_AWLEN ),
			.WSTRB_i        ( AXI_0_WSTRB ),
			.AWREGION_i     ( AXI_0_AWREGION ),
			.AWSIZE_i       ( AXI_0_AWSIZE ),
			.AWBURST_i      ( AXI_0_AWBURST ),
			.WUSER_i        ( AXI_0_WUSER ),
			.ARADDR_i       ( AXI_0_ARADDR ),
			.ARLEN_i        ( AXI_0_ARLEN ),
			.ARSIZE_i       ( AXI_0_ARSIZE ),
			.ARBURST_i      ( AXI_0_ARBURST ),
			.ARCACHE_i      ( AXI_0_ARCACHE ),
			.ARPROT_i       ( AXI_0_ARPROT ),
			.ARREGION_i     ( AXI_0_ARREGION ),
			.ARUSER_i       ( AXI_0_ARUSER ),
			.ARQOS_i        ( AXI_0_ARQOS ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_0_PRDATA ),
			// Outputs
			.RVALID_o       ( AXI_0_RVALID ),
			.AWREADY_o      ( AXI_0_AWREADY ),
			.WREADY_o       ( AXI_0_WREADY ),
			.BVALID_o       ( AXI_0_BVALID ),
			.ARREADY_o      ( AXI_0_ARREADY ),
			.RLAST_o        (  ),
			.dest_PSEL_o    ( AXI_TARGET_0_dest_PSEL_o ),
			.dest_PWRITE_o  ( AXI_TARGET_0_dest_PWRITE_o ),
			.dest_PENABLE_o ( AXI_TARGET_0_dest_PENABLE_o ),
			.BID_o          (  ),
			.BRESP_o        ( AXI_0_BRESP ),
			.BUSER_o        (  ),
			.RID_o          (  ),
			.RDATA_o        ( AXI_0_RDATA ),
			.RRESP_o        ( AXI_0_RRESP ),
			.RUSER_o        (  ),
			.dest_PWDATA_o  ( AXI_TARGET_0_dest_PWDATA_o ),
			.dest_PADDR_o   ( AXI_TARGET_0_dest_PADDR_o ) 
			);
       end
   else 
       begin: ngen_axi_tgt0
			assign AXI_0_AWREADY = 1'b0;
			assign AXI_0_WREADY = 1'b0;
			assign AXI_0_BVALID = 1'b0;
			assign AXI_0_BRESP = 2'b0;
			assign AXI_0_ARREADY = 1'b0;
			assign AXI_0_RVALID = 1'b0;
			assign AXI_0_RDATA = 32'b0;
			assign AXI_0_RRESP = 2'b0;
			
			// AXI Target 0 nets not used if APB Target on
		    assign AXI_TARGET_0_dest_PADDR_o = 32'b0;
            assign AXI_TARGET_0_dest_PENABLE_o = 1'b0;
            assign AXI_TARGET_0_dest_PSEL_o = 1'b0;
		    assign AXI_TARGET_0_dest_PWDATA_o = 32'b0;
		    assign AXI_TARGET_0_dest_PWRITE_o = 1'b0;			
       end
endgenerate

//--------apb_target 1
generate
   if (APB_INTERFACE_1)
       begin: apb_tgt1
			miv_ihc_apb_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_1_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_1_H0_ACCESS),
			.H1_ACCESS(INF_1_H1_ACCESS),
			.H2_ACCESS(INF_1_H2_ACCESS),
			.H3_ACCESS(INF_1_H3_ACCESS),
			.H4_ACCESS(INF_1_H4_ACCESS),
			.H5_ACCESS(INF_1_H5_ACCESS)
			) 
			apb_target_1 (
			// Inputs
			.dest_rst_n     ( CORE_RESETN ),
			.src_PENABLE_i  ( APB_1_PENABLE ),
			.src_PWRITE_i   ( APB_1_PWRITE ),
			.src_PSEL_i     ( APB_1_PSEL ),
			.src_clk        ( APB_1_PCLK ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_1_PREADY ),
			.src_rst_n      ( APB_1_PRESETn ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_1_PSLVERR ),
			.dest_clk       ( CORE_CLK ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_1_PRDATA ),
			.src_PADDR_i    ( APB_1_PADDR ),
			.src_PWDATA_i   ( APB_1_PWDATA ),
			// Outputs
			.src_PREADY_o   ( APB_1_PREADY ),
			.src_PSLVERR_o  ( APB_1_PSLVERR ),
			.dest_PWRITE_o  ( APB_TARGET_1_dest_PWRITE_o ),
			.dest_PENABLE_o ( APB_TARGET_1_dest_PENABLE_o ),
			.dest_PSEL_o    ( APB_TARGET_1_dest_PSEL_o ),
			.src_PRDATA_o   ( APB_1_PRDATA ),
			.dest_PADDR_o   ( APB_TARGET_1_dest_PADDR_o ),
			.dest_PWDATA_o  ( APB_TARGET_1_dest_PWDATA_o ) 
			);
       end
   else
       begin: ngen_apb_tgt1
           assign APB_1_PREADY = 1'b0;
           assign APB_1_PRDATA = 1'b0;
           assign APB_1_PSLVERR = 1'b0;
		   
		   assign APB_TARGET_1_dest_PADDR_o = 32'b0;
		   assign APB_TARGET_1_dest_PENABLE_o = 1'b0;
		   assign APB_TARGET_1_dest_PSEL_o = 1'b0;
		   assign APB_TARGET_1_dest_PWDATA_o = 32'b0;
		   assign APB_TARGET_1_dest_PWRITE_o = 1'b0;
       end
endgenerate

//--------axi_target 1
generate
   if (AXI_INTERFACE_1)
       begin: axi_tgt1
			miv_ihc_axi_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_1_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_1_H0_ACCESS),
			.H1_ACCESS(INF_1_H1_ACCESS),
			.H2_ACCESS(INF_1_H2_ACCESS),
			.H3_ACCESS(INF_1_H3_ACCESS),
			.H4_ACCESS(INF_1_H4_ACCESS),
			.H5_ACCESS(INF_1_H5_ACCESS)
			)
			axi_target_1 (
			// Inputs
			.ARESETn        ( AXI_1_ARESETn ),
			.ACLK           ( AXI_1_ACLK ),
			.ARVALID_i      ( AXI_1_ARVALID ),
			.WVALID_i       ( AXI_1_WVALID ),
			.AWVALID_i      ( AXI_1_AWVALID ),
			.BREADY_i       ( AXI_1_BREADY ),
			.AWLOCK_i       ( AXI_1_AWLOCK ),
			.WLAST_i        ( AXI_1_WLAST ),
			.ARLOCK_i       ( AXI_1_ARLOCK ),
			.dest_clk       ( CORE_CLK ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_1_PSLVERR ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_1_PREADY ),
			.dest_rst_n     ( CORE_RESETN ),
			.RREADY_i       ( AXI_1_RREADY ),
			.AWID_i         ( AXI_1_AWID ),
			.AWUSER_i       ( AXI_1_AWUSER ),
			.AWQOS_i        ( AXI_1_AWQOS ),
			.ARID_i         ( AXI_1_ARID ),
			.AWCACHE_i      ( AXI_1_AWCACHE ),
			.AWADDR_i       ( AXI_1_AWADDR ),
			.WDATA_i        ( AXI_1_WDATA ),
			.AWPROT_i       ( AXI_1_AWPROT ),
			.AWLEN_i        ( AXI_1_AWLEN ),
			.WSTRB_i        ( AXI_1_WSTRB ),
			.AWREGION_i     ( AXI_1_AWREGION ),
			.AWSIZE_i       ( AXI_1_AWSIZE ),
			.AWBURST_i      ( AXI_1_AWBURST ),
			.WUSER_i        ( AXI_1_WUSER ),
			.ARADDR_i       ( AXI_1_ARADDR ),
			.ARLEN_i        ( AXI_1_ARLEN ),
			.ARSIZE_i       ( AXI_1_ARSIZE ),
			.ARBURST_i      ( AXI_1_ARBURST ),
			.ARCACHE_i      ( AXI_1_ARCACHE ),
			.ARPROT_i       ( AXI_1_ARPROT ),
			.ARREGION_i     ( AXI_1_ARREGION ),
			.ARUSER_i       ( AXI_1_ARUSER ),
			.ARQOS_i        ( AXI_1_ARQOS ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_1_PRDATA ),
			// Outputs
			.RVALID_o       ( AXI_1_RVALID ),
			.AWREADY_o      ( AXI_1_AWREADY ),
			.WREADY_o       ( AXI_1_WREADY ),
			.BVALID_o       ( AXI_1_BVALID ),
			.ARREADY_o      ( AXI_1_ARREADY ),
			.RLAST_o        (  ),
			.dest_PSEL_o    ( AXI_TARGET_1_dest_PSEL_o ),
			.dest_PWRITE_o  ( AXI_TARGET_1_dest_PWRITE_o ),
			.dest_PENABLE_o ( AXI_TARGET_1_dest_PENABLE_o ),
			.BID_o          (  ),
			.BRESP_o        ( AXI_1_BRESP ),
			.BUSER_o        (  ),
			.RID_o          (  ),
			.RDATA_o        ( AXI_1_RDATA ),
			.RRESP_o        ( AXI_1_RRESP ),
			.RUSER_o        (  ),
			.dest_PWDATA_o  ( AXI_TARGET_1_dest_PWDATA_o ),
			.dest_PADDR_o   ( AXI_TARGET_1_dest_PADDR_o ) 
			);
       end
   else 
       begin: ngen_axi_tgt1
			assign AXI_1_AWREADY = 1'b0;
			assign AXI_1_WREADY = 1'b0;
			assign AXI_1_BVALID = 1'b0;
			assign AXI_1_BRESP = 2'b0;
			assign AXI_1_ARREADY = 1'b0;
			assign AXI_1_RVALID = 1'b0;
			assign AXI_1_RDATA = 32'b0;
			assign AXI_1_RRESP = 2'b0;
			
			assign AXI_TARGET_1_dest_PADDR_o = 32'b0;
            assign AXI_TARGET_1_dest_PENABLE_o = 1'b0;
            assign AXI_TARGET_1_dest_PSEL_o = 1'b0;
		    assign AXI_TARGET_1_dest_PWDATA_o = 32'b0;
		    assign AXI_TARGET_1_dest_PWRITE_o = 1'b0;
       end
endgenerate

//--------apb_target 2
generate
   if (APB_INTERFACE_2)
       begin: apb_tgt2
			miv_ihc_apb_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_2_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_2_H0_ACCESS),
			.H1_ACCESS(INF_2_H1_ACCESS),
			.H2_ACCESS(INF_2_H2_ACCESS),
			.H3_ACCESS(INF_2_H3_ACCESS),
			.H4_ACCESS(INF_2_H4_ACCESS),
			.H5_ACCESS(INF_2_H5_ACCESS)
			) 
			apb_target_2 (
			// Inputs
			.dest_rst_n     ( CORE_RESETN ),
			.src_PENABLE_i  ( APB_2_PENABLE ),
			.src_PWRITE_i   ( APB_2_PWRITE ),
			.src_PSEL_i     ( APB_2_PSEL ),
			.src_clk        ( APB_2_PCLK ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_2_PREADY ),
			.src_rst_n      ( APB_2_PRESETn ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_2_PSLVERR ),
			.dest_clk       ( CORE_CLK ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_2_PRDATA ),
			.src_PADDR_i    ( APB_2_PADDR ),
			.src_PWDATA_i   ( APB_2_PWDATA ),
			// Outputs
			.src_PREADY_o   ( APB_2_PREADY ),
			.src_PSLVERR_o  ( APB_2_PSLVERR ),
			.dest_PWRITE_o  ( APB_TARGET_2_dest_PWRITE_o ),
			.dest_PENABLE_o ( APB_TARGET_2_dest_PENABLE_o ),
			.dest_PSEL_o    ( APB_TARGET_2_dest_PSEL_o ),
			.src_PRDATA_o   ( APB_2_PRDATA ),
			.dest_PADDR_o   ( APB_TARGET_2_dest_PADDR_o ),
			.dest_PWDATA_o  ( APB_TARGET_2_dest_PWDATA_o ) 
			);
       end
   else
       begin: ngen_apb_tgt2
           assign APB_2_PREADY = 1'b0;
           assign APB_2_PRDATA = 1'b0;
           assign APB_2_PSLVERR = 1'b0;
		   
		   assign APB_TARGET_2_dest_PADDR_o = 32'b0;
		   assign APB_TARGET_2_dest_PENABLE_o = 1'b0;
		   assign APB_TARGET_2_dest_PSEL_o = 1'b0;
		   assign APB_TARGET_2_dest_PWDATA_o = 32'b0;
		   assign APB_TARGET_2_dest_PWRITE_o = 1'b0;
       end
endgenerate

//--------axi_target 2
generate
   if (AXI_INTERFACE_2)
       begin: axi_tgt2
			miv_ihc_axi_target_top #(
			.SYNC_RESET(SYNC_RESET),
			.CDC_EN(INF_2_CDC_EN),
			.MPU_EN(MPU_EN),
			.H0_ACCESS(INF_2_H0_ACCESS),
			.H1_ACCESS(INF_2_H1_ACCESS),
			.H2_ACCESS(INF_2_H2_ACCESS),
			.H3_ACCESS(INF_2_H3_ACCESS),
			.H4_ACCESS(INF_2_H4_ACCESS),
			.H5_ACCESS(INF_2_H5_ACCESS)
			) 
			axi_target_2 (
			// Inputs
			.ARESETn        ( AXI_2_ARESETn ),
			.ACLK           ( AXI_2_ACLK ),
			.ARVALID_i      ( AXI_2_ARVALID ),
			.WVALID_i       ( AXI_2_WVALID ),
			.AWVALID_i      ( AXI_2_AWVALID ),
			.BREADY_i       ( AXI_2_BREADY ),
			.AWLOCK_i       ( AXI_2_AWLOCK ),
			.WLAST_i        ( AXI_2_WLAST ),
			.ARLOCK_i       ( AXI_2_ARLOCK ),
			.dest_clk       ( CORE_CLK ),
			.dest_PSLVERR_i ( APB_ARBITER_0_APB_INITIATOR_2_PSLVERR ),
			.dest_PREADY_i  ( APB_ARBITER_0_APB_INITIATOR_2_PREADY ),
			.dest_rst_n     ( CORE_RESETN ),
			.RREADY_i       ( AXI_2_RREADY ),
			.AWID_i         ( AXI_2_AWID ),
			.AWUSER_i       ( AXI_2_AWUSER ),
			.AWQOS_i        ( AXI_2_AWQOS ),
			.ARID_i         ( AXI_2_ARID ),
			.AWCACHE_i      ( AXI_2_AWCACHE ),
			.AWADDR_i       ( AXI_2_AWADDR ),
			.WDATA_i        ( AXI_2_WDATA ),
			.AWPROT_i       ( AXI_2_AWPROT ),
			.AWLEN_i        ( AXI_2_AWLEN ),
			.WSTRB_i        ( AXI_2_WSTRB ),
			.AWREGION_i     ( AXI_2_AWREGION ),
			.AWSIZE_i       ( AXI_2_AWSIZE ),
			.AWBURST_i      ( AXI_2_AWBURST ),
			.WUSER_i        ( AXI_2_WUSER ),
			.ARADDR_i       ( AXI_2_ARADDR ),
			.ARLEN_i        ( AXI_2_ARLEN ),
			.ARSIZE_i       ( AXI_2_ARSIZE ),
			.ARBURST_i      ( AXI_2_ARBURST ),
			.ARCACHE_i      ( AXI_2_ARCACHE ),
			.ARPROT_i       ( AXI_2_ARPROT ),
			.ARREGION_i     ( AXI_2_ARREGION ),
			.ARUSER_i       ( AXI_2_ARUSER ),
			.ARQOS_i        ( AXI_2_ARQOS ),
			.dest_PRDATA_i  ( APB_ARBITER_0_APB_INITIATOR_2_PRDATA ),
			// Outputs
			.RVALID_o       ( AXI_2_RVALID ),
			.AWREADY_o      ( AXI_2_AWREADY ),
			.WREADY_o       ( AXI_2_WREADY ),
			.BVALID_o       ( AXI_2_BVALID ),
			.ARREADY_o      ( AXI_2_ARREADY ),
			.RLAST_o        (  ),
			.dest_PSEL_o    ( AXI_TARGET_2_dest_PSEL_o ),
			.dest_PWRITE_o  ( AXI_TARGET_2_dest_PWRITE_o ),
			.dest_PENABLE_o ( AXI_TARGET_2_dest_PENABLE_o ),
			.BID_o          (  ),
			.BRESP_o        ( AXI_2_BRESP ),
			.BUSER_o        (  ),
			.RID_o          (  ),
			.RDATA_o        ( AXI_2_RDATA ),
			.RRESP_o        ( AXI_2_RRESP ),
			.RUSER_o        (  ),
			.dest_PWDATA_o  ( AXI_TARGET_2_dest_PWDATA_o ),
			.dest_PADDR_o   ( AXI_TARGET_2_dest_PADDR_o ) 
			);
       end
   else 
       begin: ngen_axi_tgt2
			assign AXI_2_AWREADY = 1'b0;
			assign AXI_2_WREADY = 1'b0;
			assign AXI_2_BVALID = 1'b0;
			assign AXI_2_BRESP = 2'b0;
			assign AXI_2_ARREADY = 1'b0;
			assign AXI_2_RVALID = 1'b0;
			assign AXI_2_RDATA = 32'b0;
			assign AXI_2_RRESP = 2'b0;
			
			// AXI Target 0 nets not used if APB Target on
		    assign AXI_TARGET_2_dest_PADDR_o = 32'b0;
            assign AXI_TARGET_2_dest_PENABLE_o = 1'b0;
            assign AXI_TARGET_2_dest_PSEL_o = 1'b0;
		    assign AXI_TARGET_2_dest_PWDATA_o = 32'b0;
		    assign AXI_TARGET_2_dest_PWRITE_o = 1'b0;			
       end
endgenerate

//--------miv_ihc_core
miv_ihc_core #(
	.SYNC_RESET(SYNC_RESET),
	.IP_VERSION(MIV_IHC_IP_VERSION),
	.ONE_HOT_MM(ONE_HOT_MM),
	.H0_TO_H1_CH_EN(H0_TO_H1_CH_EN),
	.H0_TO_H2_CH_EN(H0_TO_H2_CH_EN),
	.H0_TO_H3_CH_EN(H0_TO_H3_CH_EN),
	.H0_TO_H4_CH_EN(H0_TO_H4_CH_EN),
	.H0_TO_H5_CH_EN(H0_TO_H5_CH_EN),
	.H1_TO_H2_CH_EN(H1_TO_H2_CH_EN),
	.H1_TO_H3_CH_EN(H1_TO_H3_CH_EN),
	.H1_TO_H4_CH_EN(H1_TO_H4_CH_EN),
	.H1_TO_H5_CH_EN(H1_TO_H5_CH_EN),
	.H2_TO_H3_CH_EN(H2_TO_H3_CH_EN),
	.H2_TO_H4_CH_EN(H2_TO_H4_CH_EN),
	.H2_TO_H5_CH_EN(H2_TO_H5_CH_EN),
	.H3_TO_H4_CH_EN(H3_TO_H4_CH_EN),
	.H3_TO_H5_CH_EN(H3_TO_H5_CH_EN),
	.H4_TO_H5_CH_EN(H4_TO_H5_CH_EN),
    .H0_IHCIM_EN(l_h0_ihcim_en),
    .H1_IHCIM_EN(l_h1_ihcim_en),
    .H2_IHCIM_EN(l_h2_ihcim_en),
    .H3_IHCIM_EN(l_h3_ihcim_en),
    .H4_IHCIM_EN(l_h4_ihcim_en),
    .H5_IHCIM_EN(l_h5_ihcim_en),
	.H0_TO_H1_A_MEMORY_DEPTH_N(H0_TO_H1_A_MEMORY_DEPTH_N),
	.H0_TO_H1_B_MEMORY_DEPTH_M(H0_TO_H1_B_MEMORY_DEPTH_M),
	.H0_TO_H2_A_MEMORY_DEPTH_N(H0_TO_H2_A_MEMORY_DEPTH_N),
	.H0_TO_H2_B_MEMORY_DEPTH_M(H0_TO_H2_B_MEMORY_DEPTH_M),
	.H0_TO_H3_A_MEMORY_DEPTH_N(H0_TO_H3_A_MEMORY_DEPTH_N),
	.H0_TO_H3_B_MEMORY_DEPTH_M(H0_TO_H3_B_MEMORY_DEPTH_M),
	.H0_TO_H4_A_MEMORY_DEPTH_N(H0_TO_H4_A_MEMORY_DEPTH_N),
	.H0_TO_H4_B_MEMORY_DEPTH_M(H0_TO_H4_B_MEMORY_DEPTH_M),
	.H0_TO_H5_A_MEMORY_DEPTH_N(H0_TO_H5_A_MEMORY_DEPTH_N),
	.H0_TO_H5_B_MEMORY_DEPTH_M(H0_TO_H5_B_MEMORY_DEPTH_M),
	.H1_TO_H2_A_MEMORY_DEPTH_N(H1_TO_H2_A_MEMORY_DEPTH_N),
	.H1_TO_H2_B_MEMORY_DEPTH_M(H1_TO_H2_B_MEMORY_DEPTH_M),
	.H1_TO_H3_A_MEMORY_DEPTH_N(H1_TO_H3_A_MEMORY_DEPTH_N),
	.H1_TO_H3_B_MEMORY_DEPTH_M(H1_TO_H3_B_MEMORY_DEPTH_M),
	.H1_TO_H4_A_MEMORY_DEPTH_N(H1_TO_H4_A_MEMORY_DEPTH_N),
	.H1_TO_H4_B_MEMORY_DEPTH_M(H1_TO_H4_B_MEMORY_DEPTH_M),
	.H1_TO_H5_A_MEMORY_DEPTH_N(H1_TO_H5_A_MEMORY_DEPTH_N),
	.H1_TO_H5_B_MEMORY_DEPTH_M(H1_TO_H5_B_MEMORY_DEPTH_M),
	.H2_TO_H3_A_MEMORY_DEPTH_N(H2_TO_H3_A_MEMORY_DEPTH_N),
	.H2_TO_H3_B_MEMORY_DEPTH_M(H2_TO_H3_B_MEMORY_DEPTH_M),
	.H2_TO_H4_A_MEMORY_DEPTH_N(H2_TO_H4_A_MEMORY_DEPTH_N),
	.H2_TO_H4_B_MEMORY_DEPTH_M(H2_TO_H4_B_MEMORY_DEPTH_M),
	.H2_TO_H5_A_MEMORY_DEPTH_N(H2_TO_H5_A_MEMORY_DEPTH_N),
	.H2_TO_H5_B_MEMORY_DEPTH_M(H2_TO_H5_B_MEMORY_DEPTH_M),
	.H3_TO_H4_A_MEMORY_DEPTH_N(H3_TO_H4_A_MEMORY_DEPTH_N),
	.H3_TO_H4_B_MEMORY_DEPTH_M(H3_TO_H4_B_MEMORY_DEPTH_M),
	.H3_TO_H5_A_MEMORY_DEPTH_N(H3_TO_H5_A_MEMORY_DEPTH_N),
	.H3_TO_H5_B_MEMORY_DEPTH_M(H3_TO_H5_B_MEMORY_DEPTH_M),
	.H4_TO_H5_A_MEMORY_DEPTH_N(H4_TO_H5_A_MEMORY_DEPTH_N),
	.H4_TO_H5_B_MEMORY_DEPTH_M(H4_TO_H5_B_MEMORY_DEPTH_M)
	) 
	miv_ihc_core_0 (
	// Inputs
	.CLK            ( CORE_CLK ),
	.RESETN         ( CORE_RESETN ),
	.APB3_0_PENABLE ( APB_ARBITER_0_APB_TARGET_0_PENABLE ),
	.APB3_0_PSEL    ( APB_ARBITER_0_APB_TARGET_0_PSEL ),
	.APB3_0_PWRITE  ( APB_ARBITER_0_APB_TARGET_0_PWRITE ),
	.APB3_0_PADDR   ( APB_ARBITER_0_APB_TARGET_0_PADDR ),
	.APB3_0_PWDATA  ( APB_ARBITER_0_APB_TARGET_0_PWDATA ),
	// Outputs
	.APB3_0_PREADY  ( MIV_IHC_APB_0_APB3_0_PREADY ),
	.APB3_0_PSLVERR ( MIV_IHC_APB_0_APB3_0_PSLVERR ),
	.APB3_0_PRDATA  ( MIV_IHC_APB_0_APB3_0_PRDATA ),
	.APP_IRQ		( APP_IRQ ),
	.MON_IRQ		( MON_IRQ ) 
	);

//--------------------------------------------------------------------
// Assigns for Interrupt Output pins
//--------------------------------------------------------------------
assign MON_IRQ_H1 = (H0_MONITOR_EN) ? MON_IRQ[1] : 1'b0;
assign MON_IRQ_H2 = (H0_MONITOR_EN) ? MON_IRQ[2] : 1'b0;
assign MON_IRQ_H3 = (H0_MONITOR_EN) ? MON_IRQ[3] : 1'b0;
assign MON_IRQ_H4 = (H0_MONITOR_EN) ? MON_IRQ[4] : 1'b0;
assign MON_IRQ_H5 = (H0_MONITOR_EN) ? MON_IRQ[5] : 1'b0;

assign APP_IRQ_H0 = (H0_MONITOR_EN) ? APP_IRQ[0] : (APP_IRQ[0] || MON_IRQ[0]);
assign APP_IRQ_H1 = (H0_MONITOR_EN) ? APP_IRQ[1] : (APP_IRQ[1] || MON_IRQ[1]);
assign APP_IRQ_H2 = (H0_MONITOR_EN) ? APP_IRQ[2] : (APP_IRQ[2] || MON_IRQ[2]); 
assign APP_IRQ_H3 = (H0_MONITOR_EN) ? APP_IRQ[3] : (APP_IRQ[3] || MON_IRQ[3]); 
assign APP_IRQ_H4 = (H0_MONITOR_EN) ? APP_IRQ[4] : (APP_IRQ[4] || MON_IRQ[4]);
assign APP_IRQ_H5 = (H0_MONITOR_EN) ? APP_IRQ[5] : (APP_IRQ[5] || MON_IRQ[5]);

//--------------------------------------------------------------------
// Assigns for AXI pins not used
//--------------------------------------------------------------------
assign AXI_0_ARBURST 	= 'b0;
assign AXI_0_ARCACHE 	= 'b0;
assign AXI_0_ARID		= 'b0;
assign AXI_0_ARLEN		= 'b0;
assign AXI_0_ARLOCK  	= 'b0;
assign AXI_0_ARQOS  	= 'b0;
assign AXI_0_ARREGION  	= 'b0;
assign AXI_0_ARSIZE		= 'b0;
assign AXI_0_ARUSER 	= 'b0;
assign AXI_0_AWBURST 	= 'b0;
assign AXI_0_AWCACHE	= 'b0;
assign AXI_0_AWID 		= 'b0;
assign AXI_0_AWLEN 		= 'b0;
assign AXI_0_AWLOCK 	= 'b0;
assign AXI_0_AWQOS 		= 'b0;
assign AXI_0_AWREGION 	= 'b0;
assign AXI_0_AWSIZE 	= 'b0;
assign AXI_0_AWUSER 	= 'b0;
assign AXI_0_WLAST 		= 1'b1;
assign AXI_0_WUSER 		= 'b0;
assign AXI_1_ARBURST 	= 'b0;
assign AXI_1_ARCACHE 	= 'b0;
assign AXI_1_ARQOS 		= 'b0;
assign AXI_1_ARREGION 	= 'b0;
assign AXI_1_ARSIZE 	= 'b0;
assign AXI_1_ARUSER 	= 'b0;
assign AXI_1_WUSER 		= 'b0;
assign AXI_1_WLAST 		= 1'b1;
assign AXI_1_AWQOS 		= 'b0;
assign AXI_1_AWREGION 	= 'b0;
assign AXI_1_AWSIZE 	= 'b0;
assign AXI_1_AWUSER 	= 'b0;
assign AXI_1_AWBURST 	= 'b0;
assign AXI_1_AWCACHE 	= 'b0;
assign AXI_1_AWID 		= 'b0;
assign AXI_1_AWLEN 		= 'b0;
assign AXI_1_AWLOCK 	= 'b0;
assign AXI_1_ARID 		= 'b0;
assign AXI_1_ARLEN 		= 'b0;
assign AXI_1_ARLOCK 	= 'b0;
assign AXI_2_ARBURST 	= 'b0;
assign AXI_2_ARCACHE 	= 'b0;
assign AXI_2_ARQOS 		= 'b0;
assign AXI_2_ARREGION 	= 'b0;
assign AXI_2_ARSIZE 	= 'b0;
assign AXI_2_ARUSER 	= 'b0;
assign AXI_2_WUSER 		= 'b0;
assign AXI_2_WLAST 		= 1'b1;
assign AXI_2_AWQOS 		= 'b0;
assign AXI_2_AWREGION 	= 'b0;
assign AXI_2_AWSIZE 	= 'b0;
assign AXI_2_AWUSER 	= 'b0;
assign AXI_2_AWBURST 	= 'b0;
assign AXI_2_AWCACHE 	= 'b0;
assign AXI_2_AWID 		= 'b0;
assign AXI_2_AWLEN 		= 'b0;
assign AXI_2_AWLOCK 	= 'b0;
assign AXI_2_ARID 		= 'b0;
assign AXI_2_ARLEN 		= 'b0;
assign AXI_2_ARLOCK 	= 'b0;

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_ram_singleport_addreg 
//********************************************************************************
// Parameter description

  #(
    parameter RAM_DEPTH            = 4,
    parameter ADDR_WIDTH           = 2,
    parameter DATA_WIDTH           = 32
  )
  
//********************************************************************************
// Port description

    (
    input wire logic                  clk,
    input wire logic [DATA_WIDTH-1:0] din,
    input wire logic                  wr,
    input wire logic [ADDR_WIDTH-1:0] addr,
    output logic     [DATA_WIDTH-1:0] dout
    );

//********************************************************************************
// Internal nets
    reg [ADDR_WIDTH-1:0] addr_reg;
    reg [DATA_WIDTH-1:0] mem [RAM_DEPTH-1:0] ;
    
//********************************************************************************
// Main code
//********************************************************************************
    assign dout = mem[addr_reg];

    always@(posedge clk)
    begin
        if(wr) mem[addr]<= din;
        addr_reg <= addr;
    end

//********************************************************************************
// Simulation Only - Memory Initialization code
//********************************************************************************
/* synthesis synthesis_off */
initial begin
  for (integer i=0; i<RAM_DEPTH; i=i+1) begin
    mem[i] = 'b0;
  end
end
/* synthesis synthesis_on */

endmodule

`default_nettype none


// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_channel(clk, resetn, 
                        WR_EN_CH_A, RD_EN_CH_A, ADDR_CH_A, WDATA_CH_A, RDATA_CH_A,
                        WR_EN_CH_B, RD_EN_CH_B, ADDR_CH_B, WDATA_CH_B, RDATA_CH_B,
                        MB_ACCESS_EN, MB_WR_EN, MB_RDATA, MB_A_ACTIVE, MB_RB_RD_EN,
                        MP_IRQ, MP_ACK);

parameter SYNC_RESET = 0;
parameter DATA_WIDTH = 32;
parameter CH_ADDR_WIDTH = 8;
parameter MB_ADDR_WIDTH = 12;
parameter A_MEMORY_DEPTH_N = 4;
parameter B_MEMORY_DEPTH_M = 4;
parameter A_DEBUG_ID = 0;
parameter B_DEBUG_ID = 0;
input wire logic clk;
input wire logic resetn;

input wire logic WR_EN_CH_A;
input wire logic RD_EN_CH_A;
input wire logic [CH_ADDR_WIDTH-1:0] ADDR_CH_A;
input wire logic [31:0] WDATA_CH_A;
output logic     [31:0] RDATA_CH_A;

input wire logic WR_EN_CH_B;
input wire logic RD_EN_CH_B;
input wire logic [CH_ADDR_WIDTH-1:0] ADDR_CH_B;
input wire logic [31:0] WDATA_CH_B;
output logic     [31:0] RDATA_CH_B;

input wire logic [DATA_WIDTH-1:0] MB_RDATA;
output logic  MB_WR_EN;  // 0 = mailbox read enable, 1 = mailbox write enable
output logic  MB_ACCESS_EN;  //determines whether we have access to the common mailbox or not
output logic  MB_A_ACTIVE;
output logic  MB_RB_RD_EN;

output logic [1:0] MP_IRQ;
output logic [1:0] MP_ACK;

// Local Parameters
localparam [7:0] CONTROL_ADDR             = 8'h00;
localparam [7:0] DEBUG_ID_ADDR            = 8'h04;
localparam [7:0] MESSAGE_DEPTH_ADDR       = 8'h08;
localparam [7:0] MESSAGE_BASE_ADDR_OUT    = 8'h90;  // address for sending messages
localparam [7:0] MESSAGE_BASE_ADDR_IN     = 8'h20;  // address for receiving messages 

reg mb_rd_en_delay_1;
reg rd_en_ch_a_delay_1;
reg rd_en_ch_b_delay_1;

reg a_mp_ie;
reg a_mp;
reg a_mp_ack;
reg a_ack_ie;

reg b_mp_ie;
reg b_mp;
reg b_mp_ack;
reg b_ack_ie;

wire aresetn;
wire sresetn; 

wire [A_MEMORY_DEPTH_N-1:0] mb_a_wr_en;
wire [B_MEMORY_DEPTH_M-1:0] mb_a_rd_en;
wire [A_MEMORY_DEPTH_N-1:0] mb_a_rb_rd_en;
wire mb_a_wr_en_or;
wire mb_a_rd_en_or;
wire mb_a_rb_rd_en_or;

wire [B_MEMORY_DEPTH_M-1:0] mb_b_wr_en;
wire [A_MEMORY_DEPTH_N-1:0] mb_b_rd_en;
wire [B_MEMORY_DEPTH_M-1:0] mb_b_rb_rd_en;
wire mb_b_wr_en_or;
wire mb_b_rd_en_or;
wire mb_b_rb_rd_en_or;

wire ctrl_b_wr_en;
wire ctrl_a_wr_en;

wire MB_RD_EN;

// Interrupt Generate
assign MP_IRQ[0] = a_mp_ie && a_mp;
assign MP_IRQ[1] = b_mp_ie && b_mp;
assign MP_ACK[0] = a_ack_ie && a_mp_ack;
assign MP_ACK[1] = b_ack_ie && b_mp_ack;

// Sync/Async mode select
assign aresetn = (SYNC_RESET==1) ? 1'b1 : resetn;
assign sresetn = (SYNC_RESET==1) ? resetn : 1'b1;

// Channel A Write enables
genvar i;
generate 
    for (i = 0; i < A_MEMORY_DEPTH_N; i = i + 1) begin: gen_mb_a_wr_en
        assign mb_a_wr_en[i] = ((ADDR_CH_A == MESSAGE_BASE_ADDR_OUT + 4*i) & WR_EN_CH_A);
    end
endgenerate

assign mb_a_wr_en_or = |mb_a_wr_en;

assign ctrl_a_wr_en  = ((ADDR_CH_A == CONTROL_ADDR) & WR_EN_CH_A);

// Channel A Read enables
generate
    for (i = 0; i < B_MEMORY_DEPTH_M; i = i + 1) begin: gen_mb_a_rd_en
        assign mb_a_rd_en[i] = ((ADDR_CH_A == MESSAGE_BASE_ADDR_IN + 4*i) & RD_EN_CH_A);
    end
endgenerate

assign mb_a_rd_en_or = |mb_a_rd_en;

// Generate mailbox a readback enables (reading back a written message to ensure write was successful)
generate 
    for (i = 0; i < A_MEMORY_DEPTH_N; i = i + 1) begin: gen_mb_a_rb_rd_en
        assign mb_a_rb_rd_en[i] = ((ADDR_CH_A == MESSAGE_BASE_ADDR_OUT + 4*i) & RD_EN_CH_A);
    end
endgenerate

assign mb_a_rb_rd_en_or = |mb_a_rb_rd_en;

// Channel A Control Registers
// Message Pending Interrupt Enable (a_mp_ie)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                a_mp_ie <= 1'b0;
            end 
        else if (ctrl_a_wr_en)
            begin
                a_mp_ie <= WDATA_CH_A[2];
            end
    end

// Message Pending (a_mp)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                a_mp <= 1'b0;
            end 
        else if (ctrl_a_wr_en)
            begin
                a_mp <= WDATA_CH_A[1];
            end
        else if (ctrl_b_wr_en)
            begin
                a_mp <= WDATA_CH_B[0];
            end            
    end

// Message Acknowledge (a_mp_ie)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                a_mp_ack <= 1'b0;
            end 
        else if (ctrl_a_wr_en)
            begin
                a_mp_ack <= WDATA_CH_A[4];
            end
        else if (ctrl_b_wr_en)
            begin
                a_mp_ack <= WDATA_CH_B[3];
            end               
    end

// Message Acknowledge (a_mp_ie)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                a_ack_ie <= 1'b0;
            end 
        else if (ctrl_a_wr_en)
            begin
                a_ack_ie <= WDATA_CH_A[5];
            end
    end    

// Channel B Write enables
generate 
    for (i = 0; i < B_MEMORY_DEPTH_M; i = i + 1) begin: gen_mb_b_wr_en
        assign mb_b_wr_en[i] = ((ADDR_CH_B == MESSAGE_BASE_ADDR_OUT + 4*i) & WR_EN_CH_B);
    end
endgenerate

assign mb_b_wr_en_or = |mb_b_wr_en;

assign ctrl_b_wr_en  = ((ADDR_CH_B == CONTROL_ADDR) & WR_EN_CH_B);

// Channel B Read enables
generate 
    for (i = 0; i < A_MEMORY_DEPTH_N; i = i + 1) begin: gen_mb_b_rd_en
        assign mb_b_rd_en[i] = ((ADDR_CH_B == MESSAGE_BASE_ADDR_IN + 4*i) & RD_EN_CH_B);
    end
endgenerate

assign mb_b_rd_en_or = |mb_b_rd_en;

// Generate mailbox b readback enables
generate 
    for (i = 0; i < B_MEMORY_DEPTH_M; i = i + 1) begin: gen_mb_b_rb_rd_en
        assign mb_b_rb_rd_en[i] = ((ADDR_CH_B == MESSAGE_BASE_ADDR_OUT + 4*i) & RD_EN_CH_B);
    end
endgenerate

assign mb_b_rb_rd_en_or = |mb_b_rb_rd_en;

// Channel B Control Registers
// Message Pending Interrupt Enable (b_mp_ie)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                b_mp_ie <= 1'b0;
            end 
        else if (ctrl_b_wr_en)
            begin
                b_mp_ie <= WDATA_CH_B[2];
            end
    end

// Message Pending (b_mp)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                b_mp <= 1'b0;
            end 
        else if (ctrl_b_wr_en)
            begin
                b_mp <= WDATA_CH_B[1];
            end
        else if (ctrl_a_wr_en)
            begin
                b_mp <= WDATA_CH_A[0];
            end
    end

// Message Acknowledge (b_mp_ack)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                b_mp_ack <= 1'b0;
            end 
        else if (ctrl_b_wr_en)
            begin
                b_mp_ack <= WDATA_CH_B[4];
            end
        else if (ctrl_a_wr_en)
            begin
                b_mp_ack <= WDATA_CH_A[3];
            end            
    end

// Message Acknowledge (a_mp_ie)
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn)) 
            begin
                b_ack_ie <= 1'b0;
            end 
        else if (ctrl_b_wr_en)
            begin
                b_ack_ie <= WDATA_CH_B[5];
            end
    end 

// Mailbox Write/Read Enable, Address and Data In/Out
assign MB_WR_EN = mb_a_wr_en_or || mb_b_wr_en_or;
assign MB_RB_RD_EN = mb_a_rb_rd_en_or || mb_b_rb_rd_en_or;
assign MB_RD_EN = mb_a_rd_en_or || mb_b_rd_en_or || MB_RB_RD_EN;
assign MB_ACCESS_EN = MB_WR_EN || MB_RD_EN;  // enable access to the mailbox only when it is necessary to interact with the mailbox
assign MB_A_ACTIVE = mb_a_wr_en_or || mb_a_rd_en_or || mb_a_rb_rd_en_or;

// Channel A & B Register read enable delays
always@(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn))
            begin
                mb_rd_en_delay_1 <= 1'b0;
                rd_en_ch_a_delay_1 <= 1'b0;
                rd_en_ch_b_delay_1 <= 1'b0;
            end
        else
            begin
                mb_rd_en_delay_1   <= MB_RD_EN;  // reading from LSRAM takes one clock cycle so drive read bus one cycle later
                rd_en_ch_a_delay_1 <= RD_EN_CH_A;  // delay driving control, debug, message depth registers read data bus to be in synch with LSRAM read data
                rd_en_ch_b_delay_1 <= RD_EN_CH_B;
            end
    end

// Read A Channel
always @(*)
begin
        if (rd_en_ch_a_delay_1) begin  // if the read enable channel bit is high, put requested data onto the RDATA_CH_A
            if (mb_rd_en_delay_1) begin  // if mailbox a or b is to be read, put mailbox read back data onto RDATA_CH_A
                RDATA_CH_A = MB_RDATA;
            end
            else begin
                case(ADDR_CH_A)
                    CONTROL_ADDR         :    RDATA_CH_A  = {26'b0, a_ack_ie, a_mp_ack, b_mp_ack, a_mp_ie, a_mp, b_mp};
                    DEBUG_ID_ADDR        :    RDATA_CH_A  = {16'b0, 8'(B_DEBUG_ID), 8'(A_DEBUG_ID)};
                    MESSAGE_DEPTH_ADDR   :    RDATA_CH_A  = {16'b0, 8'(B_MEMORY_DEPTH_M), 8'(A_MEMORY_DEPTH_N)};
                    default:                  RDATA_CH_A  = 'b0;
                endcase
            end
        end
        else begin
            RDATA_CH_A = 'b0;
        end
end

// Read B Channel
always @(*)
begin   
        if (rd_en_ch_b_delay_1) begin  // if the read enable channel bit is high, put requested data onto the RDATA_CH_B
            if (mb_rd_en_delay_1) begin  // if mailbox a or b is to be read, put mailbox read back data onto RDATA_CH_B
                RDATA_CH_B = MB_RDATA;
            end
            else begin
                case(ADDR_CH_B)
                    CONTROL_ADDR         :    RDATA_CH_B  = {26'b0, b_ack_ie, b_mp_ack, a_mp_ack, b_mp_ie, b_mp, a_mp};
                    DEBUG_ID_ADDR        :    RDATA_CH_B  = {16'b0, 8'(A_DEBUG_ID), 8'(B_DEBUG_ID)};
                    MESSAGE_DEPTH_ADDR   :    RDATA_CH_B  = {16'b0, 8'(A_MEMORY_DEPTH_N), 8'(B_MEMORY_DEPTH_M)};
                    default:                  RDATA_CH_B  = 'b0;
                endcase
            end
        end
        else begin
            RDATA_CH_B = 'b0;
        end
end

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_interrupt_module(clk, resetn, WR_EN, RD_EN, ADDR, WDATA, RDATA, CH_MSG_PRESENT_IRQ, CH_ACK_IRQ, mon_irq, app_irq);
parameter SYNC_RESET = 0;
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 32;
input wire logic                      clk;
input wire logic                      resetn;
input wire logic                      WR_EN;
input wire logic                      RD_EN;
input wire logic [ADDR_WIDTH-1:0]     ADDR;
input wire logic [DATA_WIDTH-1:0]     WDATA;
output logic     [DATA_WIDTH-1:0]     RDATA;
input wire logic [5:0]                CH_MSG_PRESENT_IRQ;
input wire logic [5:0]                CH_ACK_IRQ;

output logic mon_irq;
output logic app_irq;

localparam [7:0] IRQ_MASK_ADDR    = 8'h00;
localparam [7:0] IRQ_STATUS_ADDR  = 8'h08;

reg   [11:0]    irq_mask;
reg   [11:0]    irq_status;
wire            wr_en_irq_mask;
wire  [11:0]    irq_status_net;
wire  [5:0]     ch_irq;
wire            aresetn;
wire            sresetn;

// Sync/Async mode select
assign aresetn = (SYNC_RESET==1) ? 1'b1 : resetn;
assign sresetn = (SYNC_RESET==1) ? resetn : 1'b1;

assign ch_irq[0] =  ((irq_mask[0]  && CH_MSG_PRESENT_IRQ[0])|(irq_mask[1]  && CH_ACK_IRQ[0]));
assign ch_irq[1] =  ((irq_mask[2]  && CH_MSG_PRESENT_IRQ[1])|(irq_mask[3]  && CH_ACK_IRQ[1]));
assign ch_irq[2] =  ((irq_mask[4]  && CH_MSG_PRESENT_IRQ[2])|(irq_mask[5]  && CH_ACK_IRQ[2]));
assign ch_irq[3] =  ((irq_mask[6]  && CH_MSG_PRESENT_IRQ[3])|(irq_mask[7]  && CH_ACK_IRQ[3]));
assign ch_irq[4] =  ((irq_mask[8]  && CH_MSG_PRESENT_IRQ[4])|(irq_mask[9]  && CH_ACK_IRQ[4]));
assign ch_irq[5] =  ((irq_mask[10] && CH_MSG_PRESENT_IRQ[5])|(irq_mask[11] && CH_ACK_IRQ[5]));

assign mon_irq = ch_irq[0] ? 1:0;
assign app_irq = (ch_irq[5]|ch_irq[4]|ch_irq[3]|ch_irq[2]|ch_irq[1]) ? 1:0;

assign wr_en_irq_mask = ((ADDR[7:0] == IRQ_MASK_ADDR) & WR_EN);
always@(posedge clk or negedge aresetn)
    begin
        if((!aresetn) || (!sresetn))
            begin
                irq_mask <= 'b0;
            end 
        else if(wr_en_irq_mask)
            begin
                irq_mask <= WDATA[11:0];
            end
    end

assign irq_status_net = {CH_ACK_IRQ[5], CH_MSG_PRESENT_IRQ[5], CH_ACK_IRQ[4], CH_MSG_PRESENT_IRQ[4], 
                      CH_ACK_IRQ[3], CH_MSG_PRESENT_IRQ[3], CH_ACK_IRQ[2], CH_MSG_PRESENT_IRQ[2], 
                      CH_ACK_IRQ[1], CH_MSG_PRESENT_IRQ[1], CH_ACK_IRQ[0], CH_MSG_PRESENT_IRQ[0]};

always@(posedge clk or negedge aresetn)
    begin
        if((!aresetn) || (!sresetn))
            begin
                irq_status <= 'b0;
            end 
        else 
            begin
                irq_status <= irq_status_net;
            end
    end    

always @(posedge clk or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn))    
            begin
                RDATA <= 'b0;
            end
        else if (RD_EN)
            begin
            	case(ADDR)
                    IRQ_MASK_ADDR:    RDATA <= {20'b0, irq_mask};
                    IRQ_STATUS_ADDR:  RDATA <= {20'b0, irq_status};
                    default:          RDATA <= 'b0;
            	endcase
            end
        else
            begin
                RDATA  <= 'b0;
            end
    end

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_address_controller #(
parameter ADDR_WIDTH = 32,
parameter DATA_WIDTH = 32,
parameter MIV_IHC_IP_VERSION = 1,
parameter ONE_HOT_MM = 0
)(
input wire                      WR_EN,
input wire                      RD_EN,
input wire [ADDR_WIDTH-1:0]     ADDR,
input wire [DATA_WIDTH-1:0]     WDATA,
output reg [DATA_WIDTH-1:0]     RDATA,

// HART 0 Inputs and Outputs
output reg                      H0_TO_H1_WR_EN,
output reg                      H0_TO_H1_RD_EN,
output reg [7:0]                H0_TO_H1_ADDR,
output reg [DATA_WIDTH-1:0]     H0_TO_H1_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_TO_H1_RDATA,

output reg                      H0_TO_H2_WR_EN,
output reg                      H0_TO_H2_RD_EN,
output reg [7:0]                H0_TO_H2_ADDR,
output reg [DATA_WIDTH-1:0]     H0_TO_H2_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_TO_H2_RDATA,

output reg                      H0_TO_H3_WR_EN,
output reg                      H0_TO_H3_RD_EN,
output reg [7:0]                H0_TO_H3_ADDR,
output reg [DATA_WIDTH-1:0]     H0_TO_H3_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_TO_H3_RDATA,

output reg                      H0_TO_H4_WR_EN,
output reg                      H0_TO_H4_RD_EN,
output reg [7:0]                H0_TO_H4_ADDR,
output reg [DATA_WIDTH-1:0]     H0_TO_H4_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_TO_H4_RDATA,

output reg                      H0_TO_H5_WR_EN,
output reg                      H0_TO_H5_RD_EN,
output reg [7:0]                H0_TO_H5_ADDR,
output reg [DATA_WIDTH-1:0]     H0_TO_H5_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_TO_H5_RDATA,

// HART 1 Inputs and Outputs
output reg                      H1_TO_H0_WR_EN,
output reg                      H1_TO_H0_RD_EN,
output reg [7:0]                H1_TO_H0_ADDR,
output reg [DATA_WIDTH-1:0]     H1_TO_H0_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_TO_H0_RDATA,

output reg                      H1_TO_H2_WR_EN,
output reg                      H1_TO_H2_RD_EN,
output reg [7:0]                H1_TO_H2_ADDR,
output reg [DATA_WIDTH-1:0]     H1_TO_H2_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_TO_H2_RDATA,

output reg                      H1_TO_H3_WR_EN,
output reg                      H1_TO_H3_RD_EN,
output reg [7:0]                H1_TO_H3_ADDR,
output reg [DATA_WIDTH-1:0]     H1_TO_H3_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_TO_H3_RDATA,

output reg                      H1_TO_H4_WR_EN,
output reg                      H1_TO_H4_RD_EN,
output reg [7:0]                H1_TO_H4_ADDR,
output reg [DATA_WIDTH-1:0]     H1_TO_H4_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_TO_H4_RDATA,

output reg                      H1_TO_H5_WR_EN,
output reg                      H1_TO_H5_RD_EN,
output reg [7:0]                H1_TO_H5_ADDR,
output reg [DATA_WIDTH-1:0]     H1_TO_H5_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_TO_H5_RDATA,

// HART 2 Inputs and Outputs
output reg                      H2_TO_H0_WR_EN,
output reg                      H2_TO_H0_RD_EN,
output reg [7:0]                H2_TO_H0_ADDR,
output reg [DATA_WIDTH-1:0]     H2_TO_H0_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_TO_H0_RDATA,

output reg                      H2_TO_H1_WR_EN,
output reg                      H2_TO_H1_RD_EN,
output reg [7:0]                H2_TO_H1_ADDR,
output reg [DATA_WIDTH-1:0]     H2_TO_H1_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_TO_H1_RDATA,

output reg                      H2_TO_H3_WR_EN,
output reg                      H2_TO_H3_RD_EN,
output reg [7:0]                H2_TO_H3_ADDR,
output reg [DATA_WIDTH-1:0]     H2_TO_H3_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_TO_H3_RDATA,

output reg                      H2_TO_H4_WR_EN,
output reg                      H2_TO_H4_RD_EN,
output reg [7:0]                H2_TO_H4_ADDR,
output reg [DATA_WIDTH-1:0]     H2_TO_H4_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_TO_H4_RDATA,

output reg                      H2_TO_H5_WR_EN,
output reg                      H2_TO_H5_RD_EN,
output reg [7:0]                H2_TO_H5_ADDR,
output reg [DATA_WIDTH-1:0]     H2_TO_H5_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_TO_H5_RDATA,

// HART 3 Inputs and Outputs
output reg                      H3_TO_H0_WR_EN,
output reg                      H3_TO_H0_RD_EN,
output reg [7:0]                H3_TO_H0_ADDR,
output reg [DATA_WIDTH-1:0]     H3_TO_H0_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_TO_H0_RDATA,

output reg                      H3_TO_H1_WR_EN,
output reg                      H3_TO_H1_RD_EN,
output reg [7:0]                H3_TO_H1_ADDR,
output reg [DATA_WIDTH-1:0]     H3_TO_H1_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_TO_H1_RDATA,

output reg                      H3_TO_H2_WR_EN,
output reg                      H3_TO_H2_RD_EN,
output reg [7:0]                H3_TO_H2_ADDR,
output reg [DATA_WIDTH-1:0]     H3_TO_H2_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_TO_H2_RDATA,

output reg                      H3_TO_H4_WR_EN,
output reg                      H3_TO_H4_RD_EN,
output reg [7:0]                H3_TO_H4_ADDR,
output reg [DATA_WIDTH-1:0]     H3_TO_H4_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_TO_H4_RDATA,

output reg                      H3_TO_H5_WR_EN,
output reg                      H3_TO_H5_RD_EN,
output reg [7:0]                H3_TO_H5_ADDR,
output reg [DATA_WIDTH-1:0]     H3_TO_H5_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_TO_H5_RDATA,

// HART 4 Inputs and Outputs
output reg                      H4_TO_H0_WR_EN,
output reg                      H4_TO_H0_RD_EN,
output reg [7:0]                H4_TO_H0_ADDR,
output reg [DATA_WIDTH-1:0]     H4_TO_H0_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_TO_H0_RDATA,

output reg                      H4_TO_H1_WR_EN,
output reg                      H4_TO_H1_RD_EN,
output reg [7:0]                H4_TO_H1_ADDR,
output reg [DATA_WIDTH-1:0]     H4_TO_H1_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_TO_H1_RDATA,

output reg                      H4_TO_H2_WR_EN,
output reg                      H4_TO_H2_RD_EN,
output reg [7:0]                H4_TO_H2_ADDR,
output reg [DATA_WIDTH-1:0]     H4_TO_H2_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_TO_H2_RDATA,

output reg                      H4_TO_H3_WR_EN,
output reg                      H4_TO_H3_RD_EN,
output reg [7:0]                H4_TO_H3_ADDR,
output reg [DATA_WIDTH-1:0]     H4_TO_H3_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_TO_H3_RDATA,

output reg                      H4_TO_H5_WR_EN,
output reg                      H4_TO_H5_RD_EN,
output reg [7:0]                H4_TO_H5_ADDR,
output reg [DATA_WIDTH-1:0]     H4_TO_H5_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_TO_H5_RDATA,

// HART 5 Inputs and Outputs
output reg                      H5_TO_H0_WR_EN,
output reg                      H5_TO_H0_RD_EN,
output reg [7:0]                H5_TO_H0_ADDR,
output reg [DATA_WIDTH-1:0]     H5_TO_H0_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_TO_H0_RDATA,

output reg                      H5_TO_H1_WR_EN,
output reg                      H5_TO_H1_RD_EN,
output reg [7:0]                H5_TO_H1_ADDR,
output reg [DATA_WIDTH-1:0]     H5_TO_H1_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_TO_H1_RDATA,

output reg                      H5_TO_H2_WR_EN,
output reg                      H5_TO_H2_RD_EN,
output reg [7:0]                H5_TO_H2_ADDR,
output reg [DATA_WIDTH-1:0]     H5_TO_H2_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_TO_H2_RDATA,

output reg                      H5_TO_H3_WR_EN,
output reg                      H5_TO_H3_RD_EN,
output reg [7:0]                H5_TO_H3_ADDR,
output reg [DATA_WIDTH-1:0]     H5_TO_H3_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_TO_H3_RDATA,

output reg                      H5_TO_H4_WR_EN,
output reg                      H5_TO_H4_RD_EN,
output reg [7:0]                H5_TO_H4_ADDR,
output reg [DATA_WIDTH-1:0]     H5_TO_H4_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_TO_H4_RDATA,

// Interrupt Controllers I/O's
output reg                      H0_IRQ_MODULE_WR_EN,
output reg                      H0_IRQ_MODULE_RD_EN,
output reg [7:0]                H0_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H0_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H0_IRQ_MODULE_RDATA,

output reg                      H1_IRQ_MODULE_WR_EN,
output reg                      H1_IRQ_MODULE_RD_EN,
output reg [7:0]                H1_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H1_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H1_IRQ_MODULE_RDATA,

output reg                      H2_IRQ_MODULE_WR_EN,
output reg                      H2_IRQ_MODULE_RD_EN,
output reg [7:0]                H2_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H2_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H2_IRQ_MODULE_RDATA,

output reg                      H3_IRQ_MODULE_WR_EN,
output reg                      H3_IRQ_MODULE_RD_EN,
output reg [7:0]                H3_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H3_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H3_IRQ_MODULE_RDATA,

output reg                      H4_IRQ_MODULE_WR_EN,
output reg                      H4_IRQ_MODULE_RD_EN,
output reg [7:0]                H4_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H4_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H4_IRQ_MODULE_RDATA,

output reg                      H5_IRQ_MODULE_WR_EN,
output reg                      H5_IRQ_MODULE_RD_EN,
output reg [7:0]                H5_IRQ_MODULE_ADDR,
output reg [DATA_WIDTH-1:0]     H5_IRQ_MODULE_WDATA,
input  wire [DATA_WIDTH-1:0]    H5_IRQ_MODULE_RDATA
);

// MIV_IHC IP Version address
localparam [19:0] MIV_IHC_IP_VERSION_ADDR = 20'h0_3BFC;

localparam [11:0] H0_BASE_ADDR_DEFAULT = 12'h0_40;
localparam [11:0] H1_BASE_ADDR_DEFAULT = 12'h0_80;
localparam [11:0] H2_BASE_ADDR_DEFAULT = 12'h0_C0;
localparam [11:0] H3_BASE_ADDR_DEFAULT = 12'h1_00;
localparam [11:0] H4_BASE_ADDR_DEFAULT = 12'h1_40;
localparam [11:0] H5_BASE_ADDR_DEFAULT = 12'h1_80;

localparam [11:0] H0_BASE_ADDR_ONE_HOT = 12'h0_40;
localparam [11:0] H1_BASE_ADDR_ONE_HOT = 12'h0_80;
localparam [11:0] H2_BASE_ADDR_ONE_HOT = 12'h1_00;
localparam [11:0] H3_BASE_ADDR_ONE_HOT = 12'h2_00;
localparam [11:0] H4_BASE_ADDR_ONE_HOT = 12'h4_00;
localparam [11:0] H5_BASE_ADDR_ONE_HOT = 12'h8_00; 

localparam [11:0] H0_BASE_ADDR = ONE_HOT_MM ? H0_BASE_ADDR_ONE_HOT : H0_BASE_ADDR_DEFAULT;
localparam [11:0] H1_BASE_ADDR = ONE_HOT_MM ? H1_BASE_ADDR_ONE_HOT : H1_BASE_ADDR_DEFAULT;
localparam [11:0] H2_BASE_ADDR = ONE_HOT_MM ? H2_BASE_ADDR_ONE_HOT : H2_BASE_ADDR_DEFAULT;
localparam [11:0] H3_BASE_ADDR = ONE_HOT_MM ? H3_BASE_ADDR_ONE_HOT : H3_BASE_ADDR_DEFAULT;
localparam [11:0] H4_BASE_ADDR = ONE_HOT_MM ? H4_BASE_ADDR_ONE_HOT : H4_BASE_ADDR_DEFAULT;
localparam [11:0] H5_BASE_ADDR = ONE_HOT_MM ? H5_BASE_ADDR_ONE_HOT : H5_BASE_ADDR_DEFAULT;

// HART0 - E51
localparam [11:0] H0_TO_H1_BASE_ADDR 	= H0_BASE_ADDR + 12'h0_01;
localparam [11:0] H0_TO_H2_BASE_ADDR 	= H0_BASE_ADDR + 12'h0_02;
localparam [11:0] H0_TO_H3_BASE_ADDR 	= H0_BASE_ADDR + 12'h0_03;
localparam [11:0] H0_TO_H4_BASE_ADDR 	= H0_BASE_ADDR + 12'h0_04;
localparam [11:0] H0_TO_H5_BASE_ADDR 	= H0_BASE_ADDR + 12'h0_05;

// HART1 - U54_1
localparam [11:0] H1_TO_H0_BASE_ADDR 	= H1_BASE_ADDR + 12'h0_01;
localparam [11:0] H1_TO_H2_BASE_ADDR 	= H1_BASE_ADDR + 12'h0_02;
localparam [11:0] H1_TO_H3_BASE_ADDR 	= H1_BASE_ADDR + 12'h0_03;
localparam [11:0] H1_TO_H4_BASE_ADDR 	= H1_BASE_ADDR + 12'h0_04;
localparam [11:0] H1_TO_H5_BASE_ADDR 	= H1_BASE_ADDR + 12'h0_05;

// HART2 - U54_2
localparam [11:0] H2_TO_H0_BASE_ADDR    = H2_BASE_ADDR + 12'h0_01;
localparam [11:0] H2_TO_H1_BASE_ADDR    = H2_BASE_ADDR + 12'h0_02;
localparam [11:0] H2_TO_H3_BASE_ADDR 	= H2_BASE_ADDR + 12'h0_03;
localparam [11:0] H2_TO_H4_BASE_ADDR 	= H2_BASE_ADDR + 12'h0_04;
localparam [11:0] H2_TO_H5_BASE_ADDR 	= H2_BASE_ADDR + 12'h0_05;

// HART3 - U54_3
localparam [11:0] H3_TO_H0_BASE_ADDR 	= H3_BASE_ADDR + 12'h0_01;
localparam [11:0] H3_TO_H1_BASE_ADDR 	= H3_BASE_ADDR + 12'h0_02;
localparam [11:0] H3_TO_H2_BASE_ADDR 	= H3_BASE_ADDR + 12'h0_03;
localparam [11:0] H3_TO_H4_BASE_ADDR 	= H3_BASE_ADDR + 12'h0_04;
localparam [11:0] H3_TO_H5_BASE_ADDR 	= H3_BASE_ADDR + 12'h0_05;

// HART4 - U54_4
localparam [11:0] H4_TO_H0_BASE_ADDR 	= H4_BASE_ADDR + 12'h0_01;
localparam [11:0] H4_TO_H1_BASE_ADDR 	= H4_BASE_ADDR + 12'h0_02;
localparam [11:0] H4_TO_H2_BASE_ADDR 	= H4_BASE_ADDR + 12'h0_03;
localparam [11:0] H4_TO_H3_BASE_ADDR 	= H4_BASE_ADDR + 12'h0_04;
localparam [11:0] H4_TO_H5_BASE_ADDR 	= H4_BASE_ADDR + 12'h0_05;

// HART5 - MIV_RV32
localparam [11:0] H5_TO_H0_BASE_ADDR 	= H5_BASE_ADDR + 12'h0_01;
localparam [11:0] H5_TO_H1_BASE_ADDR 	= H5_BASE_ADDR + 12'h0_02;
localparam [11:0] H5_TO_H2_BASE_ADDR 	= H5_BASE_ADDR + 12'h0_03;
localparam [11:0] H5_TO_H3_BASE_ADDR 	= H5_BASE_ADDR + 12'h0_04;
localparam [11:0] H5_TO_H4_BASE_ADDR 	= H5_BASE_ADDR + 12'h0_05;

// Interrupt Controllers
localparam [11:0] H0_IRQ_MODULE_BASE_ADDR = H0_BASE_ADDR;
localparam [11:0] H1_IRQ_MODULE_BASE_ADDR = H1_BASE_ADDR;
localparam [11:0] H2_IRQ_MODULE_BASE_ADDR = H2_BASE_ADDR; 
localparam [11:0] H3_IRQ_MODULE_BASE_ADDR = H3_BASE_ADDR;
localparam [11:0] H4_IRQ_MODULE_BASE_ADDR = H4_BASE_ADDR;
localparam [11:0] H5_IRQ_MODULE_BASE_ADDR = H5_BASE_ADDR;

// Write Addressing Mux for WR_EN and WDATA
always@(*)
begin
    H0_TO_H1_WR_EN = 'b0;            
    H0_TO_H1_WDATA = 'b0;
                
    H0_TO_H2_WR_EN = 'b0;            
    H0_TO_H2_WDATA = 'b0;

    H0_TO_H3_WR_EN = 'b0;            
    H0_TO_H3_WDATA = 'b0;

    H0_TO_H4_WR_EN = 'b0;            
    H0_TO_H4_WDATA = 'b0;

    H0_TO_H5_WR_EN = 'b0;            
    H0_TO_H5_WDATA = 'b0;


    H1_TO_H0_WR_EN = 'b0;
    H1_TO_H0_WDATA = 'b0;

    H1_TO_H2_WR_EN = 'b0;
    H1_TO_H2_WDATA = 'b0;

    H1_TO_H3_WR_EN = 'b0;
    H1_TO_H3_WDATA = 'b0;

    H1_TO_H4_WR_EN = 'b0;
    H1_TO_H4_WDATA = 'b0;

    H1_TO_H5_WR_EN = 'b0;            
    H1_TO_H5_WDATA = 'b0;


    H2_TO_H0_WR_EN = 'b0;
    H2_TO_H0_WDATA = 'b0;

    H2_TO_H1_WR_EN = 'b0;
    H2_TO_H1_WDATA = 'b0;

    H2_TO_H3_WR_EN = 'b0;
    H2_TO_H3_WDATA = 'b0;

    H2_TO_H4_WR_EN = 'b0;
    H2_TO_H4_WDATA = 'b0;

    H2_TO_H5_WR_EN = 'b0;
    H2_TO_H5_WDATA = 'b0;


    H3_TO_H0_WR_EN = 'b0;
    H3_TO_H0_WDATA = 'b0;

    H3_TO_H1_WR_EN = 'b0;
    H3_TO_H1_WDATA = 'b0;

    H3_TO_H2_WR_EN = 'b0;
    H3_TO_H2_WDATA = 'b0;

    H3_TO_H4_WR_EN = 'b0;
    H3_TO_H4_WDATA = 'b0;

    H3_TO_H5_WR_EN = 'b0;
    H3_TO_H5_WDATA = 'b0;


    H4_TO_H0_WR_EN = 'b0;
    H4_TO_H0_WDATA = 'b0;

    H4_TO_H1_WR_EN = 'b0;
    H4_TO_H1_WDATA = 'b0;

    H4_TO_H2_WR_EN = 'b0;
    H4_TO_H2_WDATA = 'b0;

    H4_TO_H3_WR_EN = 'b0;
    H4_TO_H3_WDATA = 'b0;

    H4_TO_H5_WR_EN = 'b0;
    H4_TO_H5_WDATA = 'b0;


    H5_TO_H0_WR_EN = 'b0;
    H5_TO_H0_WDATA = 'b0;

    H5_TO_H1_WR_EN = 'b0;
    H5_TO_H1_WDATA = 'b0;

    H5_TO_H2_WR_EN = 'b0;
    H5_TO_H2_WDATA = 'b0;

    H5_TO_H3_WR_EN = 'b0;
    H5_TO_H3_WDATA = 'b0;

    H5_TO_H4_WR_EN = 'b0;
    H5_TO_H4_WDATA = 'b0;

    H0_IRQ_MODULE_WR_EN = 'b0;
    H0_IRQ_MODULE_WDATA = 'b0;

    H1_IRQ_MODULE_WR_EN = 'b0;
    H1_IRQ_MODULE_WDATA = 'b0;
                
    H2_IRQ_MODULE_WR_EN = 'b0;
    H2_IRQ_MODULE_WDATA = 'b0;
                
    H3_IRQ_MODULE_WR_EN = 'b0;
    H3_IRQ_MODULE_WDATA = 'b0;
                
    H4_IRQ_MODULE_WR_EN = 'b0;
    H4_IRQ_MODULE_WDATA = 'b0;

    H5_IRQ_MODULE_WR_EN = 'b0;
    H5_IRQ_MODULE_WDATA = 'b0;
            
    case(ADDR[19:8])
    H0_TO_H1_BASE_ADDR:
        begin
            H0_TO_H1_WR_EN = WR_EN;
            H0_TO_H1_WDATA = WDATA;
        end
    H0_TO_H2_BASE_ADDR:
        begin
            H0_TO_H2_WR_EN = WR_EN;
            H0_TO_H2_WDATA = WDATA;
        end
    H0_TO_H3_BASE_ADDR:
        begin
            H0_TO_H3_WR_EN = WR_EN;
            H0_TO_H3_WDATA = WDATA;
        end
    H0_TO_H4_BASE_ADDR:
        begin
            H0_TO_H4_WR_EN = WR_EN;
            H0_TO_H4_WDATA = WDATA;
        end      
    H0_TO_H5_BASE_ADDR:
        begin
            H0_TO_H5_WR_EN = WR_EN;
            H0_TO_H5_WDATA = WDATA;
        end       
    H1_TO_H0_BASE_ADDR:
        begin
            H1_TO_H0_WR_EN = WR_EN;
            H1_TO_H0_WDATA = WDATA;
        end
    H1_TO_H2_BASE_ADDR:
        begin
            H1_TO_H2_WR_EN = WR_EN;
            H1_TO_H2_WDATA = WDATA;
        end
    H1_TO_H3_BASE_ADDR:
        begin
            H1_TO_H3_WR_EN = WR_EN;
            H1_TO_H3_WDATA = WDATA;
        end       
    H1_TO_H4_BASE_ADDR:
        begin
            H1_TO_H4_WR_EN = WR_EN;
            H1_TO_H4_WDATA = WDATA;
        end
    H1_TO_H5_BASE_ADDR:
        begin
            H1_TO_H5_WR_EN = WR_EN;
            H1_TO_H5_WDATA = WDATA;
        end         
    H2_TO_H0_BASE_ADDR:
        begin
            H2_TO_H0_WR_EN = WR_EN;
            H2_TO_H0_WDATA = WDATA;
        end 
    H2_TO_H1_BASE_ADDR:
        begin
            H2_TO_H1_WR_EN = WR_EN;
            H2_TO_H1_WDATA = WDATA;
        end         
    H2_TO_H3_BASE_ADDR:
        begin
            H2_TO_H3_WR_EN = WR_EN;
            H2_TO_H3_WDATA = WDATA;
        end 
    H2_TO_H4_BASE_ADDR:
        begin
            H2_TO_H4_WR_EN = WR_EN;
            H2_TO_H4_WDATA = WDATA;
        end
    H2_TO_H5_BASE_ADDR:
        begin
            H2_TO_H5_WR_EN = WR_EN;
            H2_TO_H5_WDATA = WDATA;
        end                   
    H3_TO_H0_BASE_ADDR:
        begin
            H3_TO_H0_WR_EN = WR_EN;
            H3_TO_H0_WDATA = WDATA;
        end 
    H3_TO_H1_BASE_ADDR:
        begin
            H3_TO_H1_WR_EN = WR_EN;
            H3_TO_H1_WDATA = WDATA;
        end
    H3_TO_H2_BASE_ADDR:
        begin
            H3_TO_H2_WR_EN = WR_EN;
            H3_TO_H2_WDATA = WDATA;
        end 
    H3_TO_H4_BASE_ADDR:
        begin
            H3_TO_H4_WR_EN = WR_EN;
            H3_TO_H4_WDATA = WDATA;
        end
    H3_TO_H5_BASE_ADDR:
        begin
            H3_TO_H5_WR_EN = WR_EN;
            H3_TO_H5_WDATA = WDATA;
        end                   
    H4_TO_H0_BASE_ADDR:
        begin
            H4_TO_H0_WR_EN = WR_EN;
            H4_TO_H0_WDATA = WDATA;
        end  
    H4_TO_H1_BASE_ADDR:
        begin
            H4_TO_H1_WR_EN = WR_EN;
            H4_TO_H1_WDATA = WDATA;
        end        
    H4_TO_H2_BASE_ADDR:
        begin
            H4_TO_H2_WR_EN = WR_EN;
            H4_TO_H2_WDATA = WDATA;
        end 
    H4_TO_H3_BASE_ADDR:
        begin
            H4_TO_H3_WR_EN = WR_EN;
            H4_TO_H3_WDATA = WDATA;
        end
    H4_TO_H5_BASE_ADDR:
        begin
            H4_TO_H5_WR_EN = WR_EN;
            H4_TO_H5_WDATA = WDATA;
        end
    H5_TO_H0_BASE_ADDR:
        begin
            H5_TO_H0_WR_EN = WR_EN;
            H5_TO_H0_WDATA = WDATA;
        end  
    H5_TO_H1_BASE_ADDR:
        begin
            H5_TO_H1_WR_EN = WR_EN;
            H5_TO_H1_WDATA = WDATA;
        end        
    H5_TO_H2_BASE_ADDR:
        begin
            H5_TO_H2_WR_EN = WR_EN;
            H5_TO_H2_WDATA = WDATA;
        end 
    H5_TO_H3_BASE_ADDR:
        begin
            H5_TO_H3_WR_EN = WR_EN;
            H5_TO_H3_WDATA = WDATA;
        end
    H5_TO_H4_BASE_ADDR:
        begin
            H5_TO_H4_WR_EN = WR_EN;
            H5_TO_H4_WDATA = WDATA;
        end
    H0_IRQ_MODULE_BASE_ADDR:
        begin
            H0_IRQ_MODULE_WR_EN = WR_EN;
            H0_IRQ_MODULE_WDATA = WDATA;
        end
    H1_IRQ_MODULE_BASE_ADDR:
        begin
            H1_IRQ_MODULE_WR_EN = WR_EN;
            H1_IRQ_MODULE_WDATA = WDATA;
        end 
    H2_IRQ_MODULE_BASE_ADDR:
        begin
            H2_IRQ_MODULE_WR_EN = WR_EN;
            H2_IRQ_MODULE_WDATA = WDATA;
        end                
    H3_IRQ_MODULE_BASE_ADDR:
        begin
            H3_IRQ_MODULE_WR_EN = WR_EN;
            H3_IRQ_MODULE_WDATA = WDATA;
        end   
    H4_IRQ_MODULE_BASE_ADDR:
        begin
            H4_IRQ_MODULE_WR_EN = WR_EN;
            H4_IRQ_MODULE_WDATA = WDATA;
        end 
    H5_IRQ_MODULE_BASE_ADDR:
        begin
            H5_IRQ_MODULE_WR_EN = WR_EN;
            H5_IRQ_MODULE_WDATA = WDATA;
        end              
    default:
        begin
            H0_TO_H1_WR_EN = 'b0;            
            H0_TO_H1_WDATA = 'b0;
                        
            H0_TO_H2_WR_EN = 'b0;            
            H0_TO_H2_WDATA = 'b0;
            
            H0_TO_H3_WR_EN = 'b0;            
            H0_TO_H3_WDATA = 'b0;
            
            H0_TO_H4_WR_EN = 'b0;            
            H0_TO_H4_WDATA = 'b0;
            
            H0_TO_H5_WR_EN = 'b0;            
            H0_TO_H5_WDATA = 'b0;
            

            H1_TO_H0_WR_EN = 'b0;
            H1_TO_H0_WDATA = 'b0;
            
            H1_TO_H2_WR_EN = 'b0;
            H1_TO_H2_WDATA = 'b0;
            
            H1_TO_H3_WR_EN = 'b0;
            H1_TO_H3_WDATA = 'b0;
            
            H1_TO_H4_WR_EN = 'b0;
            H1_TO_H4_WDATA = 'b0;
            
            H1_TO_H5_WR_EN = 'b0;            
            H1_TO_H5_WDATA = 'b0;
            

            H2_TO_H0_WR_EN = 'b0;
            H2_TO_H0_WDATA = 'b0;
            
            H2_TO_H1_WR_EN = 'b0;
            H2_TO_H1_WDATA = 'b0;
            
            H2_TO_H3_WR_EN = 'b0;
            H2_TO_H3_WDATA = 'b0;
            
            H2_TO_H4_WR_EN = 'b0;
            H2_TO_H4_WDATA = 'b0;
            
            H2_TO_H5_WR_EN = 'b0;
            H2_TO_H5_WDATA = 'b0;
            

            H3_TO_H0_WR_EN = 'b0;
            H3_TO_H0_WDATA = 'b0;
            
            H3_TO_H1_WR_EN = 'b0;
            H3_TO_H1_WDATA = 'b0;
            
            H3_TO_H2_WR_EN = 'b0;
            H3_TO_H2_WDATA = 'b0;
            
            H3_TO_H4_WR_EN = 'b0;
            H3_TO_H4_WDATA = 'b0;
            
            H3_TO_H5_WR_EN = 'b0;
            H3_TO_H5_WDATA = 'b0;
            

            H4_TO_H0_WR_EN = 'b0;
            H4_TO_H0_WDATA = 'b0;
            
            H4_TO_H1_WR_EN = 'b0;
            H4_TO_H1_WDATA = 'b0;
            
            H4_TO_H2_WR_EN = 'b0;
            H4_TO_H2_WDATA = 'b0;
            
            H4_TO_H3_WR_EN = 'b0;
            H4_TO_H3_WDATA = 'b0;
            
            H4_TO_H5_WR_EN = 'b0;
            H4_TO_H5_WDATA = 'b0;
            

            H5_TO_H0_WR_EN = 'b0;
            H5_TO_H0_WDATA = 'b0;
            
            H5_TO_H1_WR_EN = 'b0;
            H5_TO_H1_WDATA = 'b0;
            
            H5_TO_H2_WR_EN = 'b0;
            H5_TO_H2_WDATA = 'b0;
            
            H5_TO_H3_WR_EN = 'b0;
            H5_TO_H3_WDATA = 'b0;
            
            H5_TO_H4_WR_EN = 'b0;
            H5_TO_H4_WDATA = 'b0;
            

            H0_IRQ_MODULE_WR_EN = 'b0;
            H0_IRQ_MODULE_WDATA = 'b0;
            
            H1_IRQ_MODULE_WR_EN = 'b0;
            H1_IRQ_MODULE_WDATA = 'b0;
                        
            H2_IRQ_MODULE_WR_EN = 'b0;
            H2_IRQ_MODULE_WDATA = 'b0;
                        
            H3_IRQ_MODULE_WR_EN = 'b0;
            H3_IRQ_MODULE_WDATA = 'b0;
                        
            H4_IRQ_MODULE_WR_EN = 'b0;
            H4_IRQ_MODULE_WDATA = 'b0;
            
            H5_IRQ_MODULE_WR_EN = 'b0;
            H5_IRQ_MODULE_WDATA = 'b0;
        end
    endcase
end

// Read Addressing Mux for RD_EN and RDATA
always@(*)
begin
    H0_TO_H1_RD_EN = 'b0;  
    H0_TO_H2_RD_EN = 'b0;  
    H0_TO_H3_RD_EN = 'b0;  
    H0_TO_H4_RD_EN = 'b0;      
    H0_TO_H5_RD_EN = 'b0;             

    H1_TO_H0_RD_EN = 'b0;
    H1_TO_H2_RD_EN = 'b0;
    H1_TO_H3_RD_EN = 'b0;
    H1_TO_H4_RD_EN = 'b0;
    H1_TO_H5_RD_EN = 'b0;

    H2_TO_H0_RD_EN = 'b0;
    H2_TO_H1_RD_EN = 'b0;
    H2_TO_H3_RD_EN = 'b0;
    H2_TO_H4_RD_EN = 'b0; 
    H2_TO_H5_RD_EN = 'b0; 

    H3_TO_H0_RD_EN = 'b0;
    H3_TO_H1_RD_EN = 'b0;
    H3_TO_H2_RD_EN = 'b0;
    H3_TO_H4_RD_EN = 'b0;
    H3_TO_H5_RD_EN = 'b0;   

    H4_TO_H0_RD_EN = 'b0;
    H4_TO_H1_RD_EN = 'b0;
    H4_TO_H2_RD_EN = 'b0;
    H4_TO_H3_RD_EN = 'b0;
    H4_TO_H5_RD_EN = 'b0;           

    H5_TO_H0_RD_EN = 'b0;
    H5_TO_H1_RD_EN = 'b0;
    H5_TO_H2_RD_EN = 'b0;
    H5_TO_H3_RD_EN = 'b0;
    H5_TO_H4_RD_EN = 'b0;                        
    
    H0_IRQ_MODULE_RD_EN = 'b0;
    H1_IRQ_MODULE_RD_EN = 'b0;
    H2_IRQ_MODULE_RD_EN = 'b0;
    H3_IRQ_MODULE_RD_EN = 'b0;
    H4_IRQ_MODULE_RD_EN = 'b0;
    H5_IRQ_MODULE_RD_EN = 'b0;

    case(ADDR[19:8])
    MIV_IHC_IP_VERSION_ADDR[19:8]:
        begin
            if (ADDR[7:0] == MIV_IHC_IP_VERSION_ADDR[7:0]) begin
                RDATA = MIV_IHC_IP_VERSION;
            end else begin
                RDATA = '0;
            end
        end
    H0_TO_H1_BASE_ADDR:
        begin
            H0_TO_H1_RD_EN = RD_EN;        
            RDATA = H0_TO_H1_RDATA;
        end
    H0_TO_H2_BASE_ADDR:
        begin
            H0_TO_H2_RD_EN = RD_EN;        
            RDATA = H0_TO_H2_RDATA;
        end   
    H0_TO_H3_BASE_ADDR:
        begin
            H0_TO_H3_RD_EN = RD_EN;        
            RDATA = H0_TO_H3_RDATA;
        end   
    H0_TO_H4_BASE_ADDR:
        begin
            H0_TO_H4_RD_EN = RD_EN;        
            RDATA = H0_TO_H4_RDATA;
        end
    H0_TO_H5_BASE_ADDR:
        begin
            H0_TO_H5_RD_EN = RD_EN;        
            RDATA = H0_TO_H5_RDATA;
        end                 
    H1_TO_H0_BASE_ADDR:
        begin
            H1_TO_H0_RD_EN = RD_EN;
            RDATA = H1_TO_H0_RDATA;
        end
    H1_TO_H2_BASE_ADDR:
        begin
            H1_TO_H2_RD_EN = RD_EN;
            RDATA = H1_TO_H2_RDATA;
        end  
    H1_TO_H3_BASE_ADDR:
        begin
            H1_TO_H3_RD_EN = RD_EN;
            RDATA = H1_TO_H3_RDATA;
        end 
    H1_TO_H4_BASE_ADDR:
        begin
            H1_TO_H4_RD_EN = RD_EN;
            RDATA = H1_TO_H4_RDATA;
        end       
    H1_TO_H5_BASE_ADDR:
        begin
            H1_TO_H5_RD_EN = RD_EN;
            RDATA = H1_TO_H5_RDATA;
        end                     
    H2_TO_H0_BASE_ADDR:
        begin
            H2_TO_H0_RD_EN = RD_EN;
            RDATA = H2_TO_H0_RDATA;
        end   
    H2_TO_H1_BASE_ADDR:
        begin
            H2_TO_H1_RD_EN = RD_EN;
            RDATA = H2_TO_H1_RDATA;
        end  
    H2_TO_H3_BASE_ADDR:
        begin
            H2_TO_H3_RD_EN = RD_EN;
            RDATA = H2_TO_H3_RDATA;
        end  
    H2_TO_H4_BASE_ADDR:
        begin
            H2_TO_H4_RD_EN = RD_EN;
            RDATA = H2_TO_H4_RDATA;
        end   
    H2_TO_H5_BASE_ADDR:
        begin
            H2_TO_H5_RD_EN = RD_EN;
            RDATA = H2_TO_H5_RDATA;
        end                         
    H3_TO_H0_BASE_ADDR:
        begin
            H3_TO_H0_RD_EN = RD_EN;
            RDATA = H3_TO_H0_RDATA;
        end 
    H3_TO_H1_BASE_ADDR:
        begin
            H3_TO_H1_RD_EN = RD_EN;
            RDATA = H3_TO_H1_RDATA;
        end   
    H3_TO_H2_BASE_ADDR:
        begin
            H3_TO_H2_RD_EN = RD_EN;
            RDATA = H3_TO_H2_RDATA;
        end     
    H3_TO_H4_BASE_ADDR:
        begin
            H3_TO_H4_RD_EN = RD_EN;
            RDATA = H3_TO_H4_RDATA;
        end     
    H3_TO_H5_BASE_ADDR:
        begin
            H3_TO_H5_RD_EN = RD_EN;
            RDATA = H3_TO_H5_RDATA;
        end                 
    H4_TO_H0_BASE_ADDR:
        begin
            H4_TO_H0_RD_EN = RD_EN;
            RDATA = H4_TO_H0_RDATA;
        end 
    H4_TO_H1_BASE_ADDR:
        begin
            H4_TO_H1_RD_EN = RD_EN;
            RDATA = H4_TO_H1_RDATA;
        end
    H4_TO_H2_BASE_ADDR:
        begin
            H4_TO_H2_RD_EN = RD_EN;
            RDATA = H4_TO_H2_RDATA;
        end                  
    H4_TO_H3_BASE_ADDR:
        begin
            H4_TO_H3_RD_EN = RD_EN;
            RDATA = H4_TO_H3_RDATA;
        end
    H4_TO_H5_BASE_ADDR:
        begin
            H4_TO_H5_RD_EN = RD_EN;
            RDATA = H4_TO_H5_RDATA;
        end 
    H5_TO_H0_BASE_ADDR:
        begin
            H5_TO_H0_RD_EN = RD_EN;
            RDATA = H5_TO_H0_RDATA;
        end 
    H5_TO_H1_BASE_ADDR:
        begin
            H5_TO_H1_RD_EN = RD_EN;
            RDATA = H5_TO_H1_RDATA;
        end
    H5_TO_H2_BASE_ADDR:
        begin
            H5_TO_H2_RD_EN = RD_EN;
            RDATA = H5_TO_H2_RDATA;
        end                  
    H5_TO_H3_BASE_ADDR:
        begin
            H5_TO_H3_RD_EN = RD_EN;
            RDATA = H5_TO_H3_RDATA;
        end
    H5_TO_H4_BASE_ADDR:
        begin
            H5_TO_H4_RD_EN = RD_EN;
            RDATA = H5_TO_H4_RDATA;
        end 
    H0_IRQ_MODULE_BASE_ADDR:
        begin
            H0_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H0_IRQ_MODULE_RDATA;  
        end
    H1_IRQ_MODULE_BASE_ADDR:
        begin
            H1_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H1_IRQ_MODULE_RDATA;  
        end 
    H2_IRQ_MODULE_BASE_ADDR:
        begin
            H2_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H2_IRQ_MODULE_RDATA;  
        end 
    H3_IRQ_MODULE_BASE_ADDR:
        begin
            H3_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H3_IRQ_MODULE_RDATA;  
        end 
    H4_IRQ_MODULE_BASE_ADDR:
        begin
            H4_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H4_IRQ_MODULE_RDATA;  
        end         
    H5_IRQ_MODULE_BASE_ADDR:
        begin
            H5_IRQ_MODULE_RD_EN = RD_EN;
            RDATA = H5_IRQ_MODULE_RDATA;  
        end                                                       
    default:
        begin
            RDATA = 'b0;
            H0_TO_H1_RD_EN = 'b0;  
            H0_TO_H2_RD_EN = 'b0;  
            H0_TO_H3_RD_EN = 'b0;  
            H0_TO_H4_RD_EN = 'b0;      
            H0_TO_H5_RD_EN = 'b0;             

            H1_TO_H0_RD_EN = 'b0;
            H1_TO_H2_RD_EN = 'b0;
            H1_TO_H3_RD_EN = 'b0;
            H1_TO_H4_RD_EN = 'b0;
            H1_TO_H5_RD_EN = 'b0;

            H2_TO_H0_RD_EN = 'b0;
            H2_TO_H1_RD_EN = 'b0;
            H2_TO_H3_RD_EN = 'b0;
            H2_TO_H4_RD_EN = 'b0; 
            H2_TO_H5_RD_EN = 'b0; 

            H3_TO_H0_RD_EN = 'b0;
            H3_TO_H1_RD_EN = 'b0;
            H3_TO_H2_RD_EN = 'b0;
            H3_TO_H4_RD_EN = 'b0;
            H3_TO_H5_RD_EN = 'b0;   

            H4_TO_H0_RD_EN = 'b0;
            H4_TO_H1_RD_EN = 'b0;
            H4_TO_H2_RD_EN = 'b0;
            H4_TO_H3_RD_EN = 'b0;
            H4_TO_H5_RD_EN = 'b0;           

            H5_TO_H0_RD_EN = 'b0;
            H5_TO_H1_RD_EN = 'b0;
            H5_TO_H2_RD_EN = 'b0;
            H5_TO_H3_RD_EN = 'b0;
            H5_TO_H4_RD_EN = 'b0;                        
            
            H0_IRQ_MODULE_RD_EN = 'b0;
            H1_IRQ_MODULE_RD_EN = 'b0;
            H2_IRQ_MODULE_RD_EN = 'b0;
            H3_IRQ_MODULE_RD_EN = 'b0;
            H4_IRQ_MODULE_RD_EN = 'b0;
            H5_IRQ_MODULE_RD_EN = 'b0;
        end
    endcase
end

// Write Addressing Mux for WR_EN and WDATA
always@(*)
begin
    H0_TO_H1_ADDR = 'b0;         
    H0_TO_H2_ADDR = 'b0;          
    H0_TO_H3_ADDR = 'b0;         
    H0_TO_H4_ADDR = 'b0;        
    H0_TO_H5_ADDR = 'b0;

    H1_TO_H0_ADDR = 'b0;
    H1_TO_H2_ADDR = 'b0;
    H1_TO_H3_ADDR = 'b0;
    H1_TO_H4_ADDR = 'b0;         
    H1_TO_H5_ADDR = 'b0;

    H2_TO_H0_ADDR = 'b0;
    H2_TO_H1_ADDR = 'b0;
    H2_TO_H3_ADDR = 'b0;
    H2_TO_H4_ADDR = 'b0;
    H2_TO_H5_ADDR = 'b0;

    H3_TO_H0_ADDR = 'b0;
    H3_TO_H1_ADDR = 'b0;
    H3_TO_H2_ADDR = 'b0;
    H3_TO_H4_ADDR = 'b0;
    H3_TO_H5_ADDR = 'b0;

    H4_TO_H0_ADDR = 'b0;
    H4_TO_H1_ADDR = 'b0;
    H4_TO_H2_ADDR = 'b0;
    H4_TO_H3_ADDR = 'b0;
    H4_TO_H5_ADDR = 'b0;

    H5_TO_H4_ADDR = 'b0;
    H5_TO_H3_ADDR = 'b0;
    H5_TO_H2_ADDR = 'b0;
    H5_TO_H1_ADDR = 'b0;
    H5_TO_H0_ADDR = 'b0;

    H0_IRQ_MODULE_ADDR = 'b0;
    H1_IRQ_MODULE_ADDR = 'b0;
    H2_IRQ_MODULE_ADDR = 'b0;
    H3_IRQ_MODULE_ADDR = 'b0;
    H4_IRQ_MODULE_ADDR = 'b0;
    H5_IRQ_MODULE_ADDR = 'b0;
    
    case(ADDR[19:8])
    H0_TO_H1_BASE_ADDR  :   H0_TO_H1_ADDR = ADDR[7:0];

    H0_TO_H2_BASE_ADDR  :   H0_TO_H2_ADDR = ADDR[7:0];

    H0_TO_H3_BASE_ADDR  :   H0_TO_H3_ADDR = ADDR[7:0];

    H0_TO_H4_BASE_ADDR  :   H0_TO_H4_ADDR = ADDR[7:0];

    H0_TO_H5_BASE_ADDR  :   H0_TO_H5_ADDR = ADDR[7:0];

    H1_TO_H0_BASE_ADDR  :   H1_TO_H0_ADDR = ADDR[7:0];

    H1_TO_H2_BASE_ADDR  :   H1_TO_H2_ADDR = ADDR[7:0];

    H1_TO_H3_BASE_ADDR  :   H1_TO_H3_ADDR = ADDR[7:0];

    H1_TO_H4_BASE_ADDR  :   H1_TO_H4_ADDR = ADDR[7:0];

    H1_TO_H5_BASE_ADDR  :   H1_TO_H5_ADDR = ADDR[7:0];

    H2_TO_H0_BASE_ADDR  :   H2_TO_H0_ADDR = ADDR[7:0];

    H2_TO_H1_BASE_ADDR  :   H2_TO_H1_ADDR = ADDR[7:0];
    
    H2_TO_H3_BASE_ADDR  :   H2_TO_H3_ADDR = ADDR[7:0];

    H2_TO_H4_BASE_ADDR  :   H2_TO_H4_ADDR = ADDR[7:0];

    H2_TO_H5_BASE_ADDR  :   H2_TO_H5_ADDR = ADDR[7:0];
              
    H3_TO_H0_BASE_ADDR  :   H3_TO_H0_ADDR = ADDR[7:0];

    H3_TO_H1_BASE_ADDR  :   H3_TO_H1_ADDR = ADDR[7:0];

    H3_TO_H2_BASE_ADDR  :   H3_TO_H2_ADDR = ADDR[7:0];

    H3_TO_H4_BASE_ADDR  :   H3_TO_H4_ADDR = ADDR[7:0];

    H3_TO_H5_BASE_ADDR  :   H3_TO_H5_ADDR = ADDR[7:0];
              
    H4_TO_H0_BASE_ADDR  :   H4_TO_H0_ADDR = ADDR[7:0];

    H4_TO_H1_BASE_ADDR  :   H4_TO_H1_ADDR = ADDR[7:0];
   
    H4_TO_H2_BASE_ADDR  :   H4_TO_H2_ADDR = ADDR[7:0];

    H4_TO_H3_BASE_ADDR  :   H4_TO_H3_ADDR = ADDR[7:0];

    H4_TO_H5_BASE_ADDR  :   H4_TO_H5_ADDR = ADDR[7:0];

    H5_TO_H0_BASE_ADDR  :   H5_TO_H0_ADDR = ADDR[7:0];

    H5_TO_H1_BASE_ADDR  :   H5_TO_H1_ADDR = ADDR[7:0];
   
    H5_TO_H2_BASE_ADDR  :   H5_TO_H2_ADDR = ADDR[7:0];

    H5_TO_H3_BASE_ADDR  :   H5_TO_H3_ADDR = ADDR[7:0];

    H5_TO_H4_BASE_ADDR  :   H5_TO_H4_ADDR = ADDR[7:0];

    H0_IRQ_MODULE_BASE_ADDR   :   H0_IRQ_MODULE_ADDR = ADDR[7:0];

    H1_IRQ_MODULE_BASE_ADDR   :   H1_IRQ_MODULE_ADDR = ADDR[7:0];

    H2_IRQ_MODULE_BASE_ADDR   :   H2_IRQ_MODULE_ADDR = ADDR[7:0];
        
    H3_IRQ_MODULE_BASE_ADDR   :   H3_IRQ_MODULE_ADDR = ADDR[7:0];

    H4_IRQ_MODULE_BASE_ADDR   :   H4_IRQ_MODULE_ADDR = ADDR[7:0];

    H5_IRQ_MODULE_BASE_ADDR   :   H5_IRQ_MODULE_ADDR = ADDR[7:0];
        
    default:
        begin
            H0_TO_H1_ADDR = 'b0;         
            H0_TO_H2_ADDR = 'b0;          
            H0_TO_H3_ADDR = 'b0;         
            H0_TO_H4_ADDR = 'b0;        
            H0_TO_H5_ADDR = 'b0;

            H1_TO_H0_ADDR = 'b0;
            H1_TO_H2_ADDR = 'b0;
            H1_TO_H3_ADDR = 'b0;
            H1_TO_H4_ADDR = 'b0;         
            H1_TO_H5_ADDR = 'b0;

            H2_TO_H0_ADDR = 'b0;
            H2_TO_H1_ADDR = 'b0;
            H2_TO_H3_ADDR = 'b0;
            H2_TO_H4_ADDR = 'b0;
            H2_TO_H5_ADDR = 'b0;

            H3_TO_H0_ADDR = 'b0;
            H3_TO_H1_ADDR = 'b0;
            H3_TO_H2_ADDR = 'b0;
            H3_TO_H4_ADDR = 'b0;
            H3_TO_H5_ADDR = 'b0;

            H4_TO_H0_ADDR = 'b0;
            H4_TO_H1_ADDR = 'b0;
            H4_TO_H2_ADDR = 'b0;
            H4_TO_H3_ADDR = 'b0;
            H4_TO_H5_ADDR = 'b0;

            H5_TO_H4_ADDR = 'b0;
            H5_TO_H3_ADDR = 'b0;
            H5_TO_H2_ADDR = 'b0;
            H5_TO_H1_ADDR = 'b0;
            H5_TO_H0_ADDR = 'b0;

            H0_IRQ_MODULE_ADDR = 'b0;
            H1_IRQ_MODULE_ADDR = 'b0;
            H2_IRQ_MODULE_ADDR = 'b0;
            H3_IRQ_MODULE_ADDR = 'b0;
            H4_IRQ_MODULE_ADDR = 'b0;
            H5_IRQ_MODULE_ADDR = 'b0;
        end
    endcase
end

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_mailbox_address_decoder (
    // Inputs
    ADDR_IN,
    MB_ACCESS_EN_ARR,
    MB_WR_EN,
    MB_RB_RD_EN,
    MB_A_ACTIVE,

	// Outputs
    COMMON_MB_ADDR_OUT
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MB_ADDR_WIDTH = 12;

parameter A_BUF_PTR_H0_TO_H1 = 0;
parameter B_BUF_PTR_H0_TO_H1 = 0;
parameter A_BUF_PTR_H0_TO_H2 = 0;
parameter B_BUF_PTR_H0_TO_H2 = 0;
parameter A_BUF_PTR_H0_TO_H3 = 0;
parameter B_BUF_PTR_H0_TO_H3 = 0;
parameter A_BUF_PTR_H0_TO_H4 = 0;
parameter B_BUF_PTR_H0_TO_H4 = 0;
parameter A_BUF_PTR_H0_TO_H5 = 0;
parameter B_BUF_PTR_H0_TO_H5 = 0;
parameter A_BUF_PTR_H1_TO_H2 = 0;
parameter B_BUF_PTR_H1_TO_H2 = 0;
parameter A_BUF_PTR_H1_TO_H3 = 0;
parameter B_BUF_PTR_H1_TO_H3 = 0;
parameter A_BUF_PTR_H1_TO_H4 = 0;
parameter B_BUF_PTR_H1_TO_H4 = 0;
parameter A_BUF_PTR_H1_TO_H5 = 0;
parameter B_BUF_PTR_H1_TO_H5 = 0;
parameter A_BUF_PTR_H2_TO_H3 = 0;
parameter B_BUF_PTR_H2_TO_H3 = 0;
parameter A_BUF_PTR_H2_TO_H4 = 0;
parameter B_BUF_PTR_H2_TO_H4 = 0;
parameter A_BUF_PTR_H2_TO_H5 = 0;
parameter B_BUF_PTR_H2_TO_H5 = 0;
parameter A_BUF_PTR_H3_TO_H4 = 0;
parameter B_BUF_PTR_H3_TO_H4 = 0;
parameter A_BUF_PTR_H3_TO_H5 = 0;
parameter B_BUF_PTR_H3_TO_H5 = 0;
parameter A_BUF_PTR_H4_TO_H5 = 0;
parameter B_BUF_PTR_H4_TO_H5 = 0;

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input wire logic [7:0] ADDR_IN;
input wire logic [14:0] MB_ACCESS_EN_ARR;
input wire logic MB_WR_EN;     // 0 = a mailbox read if a mailbox is being accessed, 1 = a mailbox write if a mailbox is being accessed
input wire logic MB_RB_RD_EN;  // 1 = a mailbox readback read if a mailbox is being accessed
input wire logic MB_A_ACTIVE;  // 0 = Mailbox B read/write taking place, 1 = mailbox A read/write taking place
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output logic [MB_ADDR_WIDTH-1:0] COMMON_MB_ADDR_OUT;

//--------------------------------------------------------------------
// localparams
//--------------------------------------------------------------------
// Local Parameters
localparam [7:0] MESSAGE_BASE_ADDR_IN  = 8'h20;  // address for sending and receiving messages is the same for both mailbox a and b
localparam [7:0] MESSAGE_BASE_ADDR_OUT = 8'h90;  // address for sending and receiving messages is the same for both mailbox a and b

//--------------------------------------------------------------------
// Internal Signals
//--------------------------------------------------------------------
reg [MB_ADDR_WIDTH-1:0] A_BUF_PTR;
reg [MB_ADDR_WIDTH-1:0] B_BUF_PTR;
reg [MB_ADDR_WIDTH-1:0] MB_A_WR_RB_DECODE;
reg [MB_ADDR_WIDTH-1:0] MB_B_WR_RB_DECODE;
reg [MB_ADDR_WIDTH-1:0] MB_A_RD_DECODE;
reg [MB_ADDR_WIDTH-1:0] MB_B_RD_DECODE;
wire MB_A_WR_EN;
wire MB_B_WR_EN;
wire MB_A_RD_EN;
wire MB_B_RD_EN;
wire MB_A_RB_RD_EN;
wire MB_B_RB_RD_EN;

//--------------------------------------------------------------------
// Main Code
//--------------------------------------------------------------------
// The APB Arbiter already ensures that only one IHC Channel is active at a time (one-hot) thus arbitration here is unnecessary
always @ (*) begin
    unique case (MB_ACCESS_EN_ARR) inside
        15'b1??????????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H1), MB_ADDR_WIDTH'(B_BUF_PTR_H0_TO_H1)};
        15'b01?????????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H2), MB_ADDR_WIDTH'(B_BUF_PTR_H0_TO_H2)};
        15'b001????????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H3), MB_ADDR_WIDTH'(B_BUF_PTR_H0_TO_H3)};
        15'b0001???????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H4), MB_ADDR_WIDTH'(B_BUF_PTR_H0_TO_H4)};
        15'b00001??????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H5), MB_ADDR_WIDTH'(B_BUF_PTR_H0_TO_H5)};
        15'b000001?????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H2), MB_ADDR_WIDTH'(B_BUF_PTR_H1_TO_H2)};
        15'b0000001????????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H3), MB_ADDR_WIDTH'(B_BUF_PTR_H1_TO_H3)};
        15'b00000001???????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H4), MB_ADDR_WIDTH'(B_BUF_PTR_H1_TO_H4)};
        15'b000000001??????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H5), MB_ADDR_WIDTH'(B_BUF_PTR_H1_TO_H5)};
        15'b0000000001?????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H3), MB_ADDR_WIDTH'(B_BUF_PTR_H2_TO_H3)};
        15'b00000000001????: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H4), MB_ADDR_WIDTH'(B_BUF_PTR_H2_TO_H4)};
        15'b000000000001???: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H5), MB_ADDR_WIDTH'(B_BUF_PTR_H2_TO_H5)};
        15'b0000000000001??: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H3_TO_H4), MB_ADDR_WIDTH'(B_BUF_PTR_H3_TO_H4)};
        15'b00000000000001?: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H3_TO_H5), MB_ADDR_WIDTH'(B_BUF_PTR_H3_TO_H5)};
        15'b000000000000001: {A_BUF_PTR, B_BUF_PTR} = {MB_ADDR_WIDTH'(A_BUF_PTR_H4_TO_H5), MB_ADDR_WIDTH'(B_BUF_PTR_H4_TO_H5)};
        default: {A_BUF_PTR, B_BUF_PTR} = 'b0;
    endcase
end

assign MB_A_WR_EN = MB_WR_EN && MB_A_ACTIVE && |MB_ACCESS_EN_ARR;
assign MB_B_WR_EN = MB_WR_EN && !MB_A_ACTIVE && |MB_ACCESS_EN_ARR;
assign MB_A_RD_EN = !MB_WR_EN && MB_A_ACTIVE && |MB_ACCESS_EN_ARR;
assign MB_B_RD_EN = !MB_WR_EN && !MB_A_ACTIVE && |MB_ACCESS_EN_ARR;
assign MB_A_RB_RD_EN = MB_RB_RD_EN && MB_A_ACTIVE && |MB_ACCESS_EN_ARR;
assign MB_B_RB_RD_EN = MB_RB_RD_EN && !MB_A_ACTIVE && |MB_ACCESS_EN_ARR;

assign MB_A_WR_RB_DECODE = A_BUF_PTR + MB_ADDR_WIDTH'((ADDR_IN - MESSAGE_BASE_ADDR_OUT) >> 2);
assign MB_B_WR_RB_DECODE = B_BUF_PTR + MB_ADDR_WIDTH'((ADDR_IN - MESSAGE_BASE_ADDR_OUT) >> 2);
assign MB_A_RD_DECODE = B_BUF_PTR + MB_ADDR_WIDTH'((ADDR_IN - MESSAGE_BASE_ADDR_IN) >> 2);
assign MB_B_RD_DECODE = A_BUF_PTR + MB_ADDR_WIDTH'((ADDR_IN - MESSAGE_BASE_ADDR_IN) >> 2);

assign COMMON_MB_ADDR_OUT = (MB_A_WR_EN || MB_A_RB_RD_EN) ? MB_A_WR_RB_DECODE :
                            (MB_B_WR_EN || MB_B_RB_RD_EN) ? MB_B_WR_RB_DECODE :
                            (MB_A_RD_EN) ? MB_A_RD_DECODE :
                            (MB_B_RD_EN) ? MB_B_RD_DECODE : '0;

endmodule

`default_nettype none

// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_target(   
    CLK,
    RESETN,
    PENABLE,
    PSEL,
    PADDR,
    PWRITE,
    PWDATA,
    PRDATA,
    PREADY,
    PSLVERR,
    WR_EN,
    RD_EN,
    ADDR,
    WDATA,
    RDATA);

// Parameters
    parameter SYNC_RESET = 0;
// APB3 Interface
    localparam ADDR_WIDTH = 32;
    localparam DATA_WIDTH = 32;
    input wire logic                        CLK;
    input wire logic                        RESETN;
    input wire logic                        PENABLE;
    input wire logic                        PSEL;
    input wire logic      [31:0]            PADDR;
    input wire logic                        PWRITE;
    input wire logic      [31:0]            PWDATA;
    output logic          [31:0]            PRDATA;
    output logic                            PREADY;
    output logic                            PSLVERR;

    output logic          [ADDR_WIDTH-1:0]  ADDR;
    output logic          [DATA_WIDTH-1:0]  WDATA;
    output logic                            WR_EN;
    output logic                            RD_EN;
    input wire logic      [DATA_WIDTH-1:0]  RDATA;

reg rd_enable;
reg wr_enable;
reg [1:0]   fsm; //state machine register
// sync/async mode select
wire aresetn;
wire sresetn;

assign aresetn = (SYNC_RESET==1) ? 1'b1 : RESETN;
assign sresetn = (SYNC_RESET==1) ? RESETN : 1'b1;

assign ADDR = PADDR;
assign WDATA = PWDATA;
assign WR_EN = wr_enable;
assign RD_EN = rd_enable;
assign PSLVERR = 1'b0;

always@(posedge CLK or negedge aresetn)
if((!aresetn) || (!sresetn))
  begin
      fsm <= 2'b00;
      rd_enable <= 1'b0;
      wr_enable <= 1'b0;
      PREADY <= 1'b0;
  end
else
  begin
  
  case (fsm)
     2'b00 :  begin
                if (~PSEL)
                        begin
                        fsm <= 2'b00;
                        PREADY <= 1'b0;
                        end
                else        
                        begin
                        fsm <= 2'b01;
                        if (PWRITE)
                                begin 
                                    rd_enable <= 1'b0;
                                    wr_enable <= 1'b1;
                                    PREADY <= 1'b1;
                                end
                        else
                                begin      
                                    rd_enable <= 1'b1;
                                    wr_enable <= 1'b0;
                                    PREADY <= 1'b0;                     
                                end
                        end
               end

     2'b01 :  begin            
                if (PWRITE)
                    begin 
                        rd_enable <= 1'b0;
                        wr_enable <= 1'b0;
                        PREADY <= 1'b1;
                        fsm <= 2'b00; 
                    end
                else
                    begin      
                        rd_enable <= 1'b0;
                        wr_enable <= 1'b0;
                        PREADY <= 1'b0;
                        fsm <= 2'b10; 
                    end
              end

     2'b10 :  begin       
                rd_enable <= 1'b0;
                wr_enable <= 1'b0;
                fsm <= 2'b11;
                PREADY <= 1'b1;                                        
              end
     2'b11 :  begin       
                rd_enable <= 1'b0;
                wr_enable <= 1'b0;
                fsm <= 2'b00;
                PREADY <= 1'b0;                                        
              end

    default : fsm <= 2'b00;
  endcase
end

always  @(posedge CLK or negedge aresetn)
    begin
        if((!aresetn) || (!sresetn))
            begin
                PRDATA <= 'b0;
            end
        else
            begin
                PRDATA <= RDATA;
            end
    end

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_core ( 
    //Inputs
    CLK,
    RESETN,    
    APB3_0_PENABLE,
    APB3_0_PSEL,
    APB3_0_PADDR,
    APB3_0_PWRITE,
    APB3_0_PWDATA,

    //Outputs
    APB3_0_PRDATA,
    APB3_0_PREADY,
    APB3_0_PSLVERR,
	APP_IRQ,
	MON_IRQ
    );

    // Parameters
    parameter SYNC_RESET        = 0;
    parameter IP_VERSION        = 1;
    parameter ONE_HOT_MM        = 0;

    // Channel Enable Parameters 
    parameter H0_TO_H1_CH_EN 	= 1;
    parameter H0_TO_H2_CH_EN 	= 1;
    parameter H0_TO_H3_CH_EN 	= 1;
    parameter H0_TO_H4_CH_EN 	= 1;
    parameter H0_TO_H5_CH_EN 	= 1;
    parameter H1_TO_H2_CH_EN 	= 1;
    parameter H1_TO_H3_CH_EN 	= 1;
    parameter H1_TO_H4_CH_EN 	= 1;
    parameter H1_TO_H5_CH_EN 	= 1;
    parameter H2_TO_H3_CH_EN 	= 1;
    parameter H2_TO_H4_CH_EN 	= 1;
    parameter H2_TO_H5_CH_EN 	= 1;
    parameter H3_TO_H4_CH_EN 	= 1;
    parameter H3_TO_H5_CH_EN 	= 1;
    parameter H4_TO_H5_CH_EN 	= 1;

    // Interrupt Aggregator Parameters
    parameter H0_IHCIM_EN		= 1;
    parameter H1_IHCIM_EN		= 1;
    parameter H2_IHCIM_EN		= 1;
    parameter H3_IHCIM_EN		= 1;
    parameter H4_IHCIM_EN		= 1;
    parameter H5_IHCIM_EN		= 1;

    parameter ADDR_WIDTH = 32;
    parameter DATA_WIDTH = 32;

    // Message Depth Parameters
    parameter H0_TO_H1_A_MEMORY_DEPTH_N = 4;
    parameter H0_TO_H1_B_MEMORY_DEPTH_M = 4;
    parameter H0_TO_H2_A_MEMORY_DEPTH_N = 4;
    parameter H0_TO_H2_B_MEMORY_DEPTH_M = 4;
    parameter H0_TO_H3_A_MEMORY_DEPTH_N = 4;
    parameter H0_TO_H3_B_MEMORY_DEPTH_M = 4;
    parameter H0_TO_H4_A_MEMORY_DEPTH_N = 4;
    parameter H0_TO_H4_B_MEMORY_DEPTH_M = 4;
    parameter H0_TO_H5_A_MEMORY_DEPTH_N = 4;
    parameter H0_TO_H5_B_MEMORY_DEPTH_M = 4;
    parameter H1_TO_H2_A_MEMORY_DEPTH_N = 4;
    parameter H1_TO_H2_B_MEMORY_DEPTH_M = 4;
    parameter H1_TO_H3_A_MEMORY_DEPTH_N = 4;
    parameter H1_TO_H3_B_MEMORY_DEPTH_M = 4;
    parameter H1_TO_H4_A_MEMORY_DEPTH_N = 4;
    parameter H1_TO_H4_B_MEMORY_DEPTH_M = 4;
    parameter H1_TO_H5_A_MEMORY_DEPTH_N = 4;
    parameter H1_TO_H5_B_MEMORY_DEPTH_M = 4;
    parameter H2_TO_H3_A_MEMORY_DEPTH_N = 4;
    parameter H2_TO_H3_B_MEMORY_DEPTH_M = 4;
    parameter H2_TO_H4_A_MEMORY_DEPTH_N = 4;
    parameter H2_TO_H4_B_MEMORY_DEPTH_M = 4;
    parameter H2_TO_H5_A_MEMORY_DEPTH_N = 4;
    parameter H2_TO_H5_B_MEMORY_DEPTH_M = 4;
    parameter H3_TO_H4_A_MEMORY_DEPTH_N = 4;
    parameter H3_TO_H4_B_MEMORY_DEPTH_M = 4;
    parameter H3_TO_H5_A_MEMORY_DEPTH_N = 4;
    parameter H3_TO_H5_B_MEMORY_DEPTH_M = 4;
    parameter H4_TO_H5_A_MEMORY_DEPTH_N = 4;
    parameter H4_TO_H5_B_MEMORY_DEPTH_M = 4;

    input wire logic                      CLK;
    input wire logic		              RESETN;    
    input wire logic                      APB3_0_PENABLE;
    input wire logic                      APB3_0_PSEL;
    input wire logic  [DATA_WIDTH-1:0]    APB3_0_PADDR;
    input wire logic                      APB3_0_PWRITE;
    input wire logic  [DATA_WIDTH-1:0]    APB3_0_PWDATA;
    output logic      [DATA_WIDTH-1:0]    APB3_0_PRDATA;
    output logic                          APB3_0_PREADY;
    output logic                          APB3_0_PSLVERR;
	output logic      [5:0]               APP_IRQ;
	output logic      [5:0]               MON_IRQ;

wire [1:0] MP_IRQ_H0_H1;
wire [1:0] MP_IRQ_H0_H2;
wire [1:0] MP_IRQ_H0_H3;
wire [1:0] MP_IRQ_H0_H4;
wire [1:0] MP_IRQ_H0_H5;
wire [1:0] MP_IRQ_H1_H2;
wire [1:0] MP_IRQ_H1_H3;
wire [1:0] MP_IRQ_H1_H4;
wire [1:0] MP_IRQ_H1_H5;
wire [1:0] MP_IRQ_H2_H3;
wire [1:0] MP_IRQ_H2_H4;
wire [1:0] MP_IRQ_H2_H5;
wire [1:0] MP_IRQ_H3_H4;
wire [1:0] MP_IRQ_H3_H5;
wire [1:0] MP_IRQ_H4_H5;

wire [1:0] MP_ACK_H0_H1;
wire [1:0] MP_ACK_H0_H2;
wire [1:0] MP_ACK_H0_H3;
wire [1:0] MP_ACK_H0_H4;
wire [1:0] MP_ACK_H0_H5;
wire [1:0] MP_ACK_H1_H2;
wire [1:0] MP_ACK_H1_H3;
wire [1:0] MP_ACK_H1_H4;
wire [1:0] MP_ACK_H1_H5;
wire [1:0] MP_ACK_H2_H3;
wire [1:0] MP_ACK_H2_H4;
wire [1:0] MP_ACK_H2_H5;
wire [1:0] MP_ACK_H3_H4;
wire [1:0] MP_ACK_H3_H5;
wire [1:0] MP_ACK_H4_H5;

// Local Parameters
localparam RAM_DEPTH_REQUIRED   =   H0_TO_H1_CH_EN * (H0_TO_H1_A_MEMORY_DEPTH_N + H0_TO_H1_B_MEMORY_DEPTH_M) + 
                                    H0_TO_H2_CH_EN * (H0_TO_H2_A_MEMORY_DEPTH_N + H0_TO_H2_B_MEMORY_DEPTH_M) +
                                    H0_TO_H3_CH_EN * (H0_TO_H3_A_MEMORY_DEPTH_N + H0_TO_H3_B_MEMORY_DEPTH_M) +
                                    H0_TO_H4_CH_EN * (H0_TO_H4_A_MEMORY_DEPTH_N + H0_TO_H4_B_MEMORY_DEPTH_M) +
                                    H0_TO_H5_CH_EN * (H0_TO_H5_A_MEMORY_DEPTH_N + H0_TO_H5_B_MEMORY_DEPTH_M) +
                                    H1_TO_H2_CH_EN * (H1_TO_H2_A_MEMORY_DEPTH_N + H1_TO_H2_B_MEMORY_DEPTH_M) +
                                    H1_TO_H3_CH_EN * (H1_TO_H3_A_MEMORY_DEPTH_N + H1_TO_H3_B_MEMORY_DEPTH_M) +
                                    H1_TO_H4_CH_EN * (H1_TO_H4_A_MEMORY_DEPTH_N + H1_TO_H4_B_MEMORY_DEPTH_M) +
                                    H1_TO_H5_CH_EN * (H1_TO_H5_A_MEMORY_DEPTH_N + H1_TO_H5_B_MEMORY_DEPTH_M) +
                                    H2_TO_H3_CH_EN * (H2_TO_H3_A_MEMORY_DEPTH_N + H2_TO_H3_B_MEMORY_DEPTH_M) +
                                    H2_TO_H4_CH_EN * (H2_TO_H4_A_MEMORY_DEPTH_N + H2_TO_H4_B_MEMORY_DEPTH_M) +
                                    H2_TO_H5_CH_EN * (H2_TO_H5_A_MEMORY_DEPTH_N + H2_TO_H5_B_MEMORY_DEPTH_M) +
                                    H3_TO_H4_CH_EN * (H3_TO_H4_A_MEMORY_DEPTH_N + H3_TO_H4_B_MEMORY_DEPTH_M) +
                                    H3_TO_H5_CH_EN * (H3_TO_H5_A_MEMORY_DEPTH_N + H3_TO_H5_B_MEMORY_DEPTH_M) +
                                    H4_TO_H5_CH_EN * (H4_TO_H5_A_MEMORY_DEPTH_N + H4_TO_H5_B_MEMORY_DEPTH_M);

localparam BUFF_RAM_ADDR_WIDTH = $clog2(RAM_DEPTH_REQUIRED);
localparam BUFF_RAM_DEPTH = 1 << BUFF_RAM_ADDR_WIDTH;

localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H0_TO_H1 = BUFF_RAM_ADDR_WIDTH'(0);
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H0_TO_H2 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H1 + H0_TO_H1_CH_EN * (H0_TO_H1_A_MEMORY_DEPTH_N + H0_TO_H1_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H0_TO_H3 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H2 + H0_TO_H2_CH_EN * (H0_TO_H2_A_MEMORY_DEPTH_N + H0_TO_H2_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H0_TO_H4 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H3 + H0_TO_H3_CH_EN * (H0_TO_H3_A_MEMORY_DEPTH_N + H0_TO_H3_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H0_TO_H5 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H4 + H0_TO_H4_CH_EN * (H0_TO_H4_A_MEMORY_DEPTH_N + H0_TO_H4_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H1_TO_H2 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H0_TO_H5 + H0_TO_H5_CH_EN * (H0_TO_H5_A_MEMORY_DEPTH_N + H0_TO_H5_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H1_TO_H3 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H2 + H1_TO_H2_CH_EN * (H1_TO_H2_A_MEMORY_DEPTH_N + H1_TO_H2_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H1_TO_H4 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H3 + H1_TO_H3_CH_EN * (H1_TO_H3_A_MEMORY_DEPTH_N + H1_TO_H3_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H1_TO_H5 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H4 + H1_TO_H4_CH_EN * (H1_TO_H4_A_MEMORY_DEPTH_N + H1_TO_H4_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H2_TO_H3 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H1_TO_H5 + H1_TO_H5_CH_EN * (H1_TO_H5_A_MEMORY_DEPTH_N + H1_TO_H5_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H2_TO_H4 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H3 + H2_TO_H3_CH_EN * (H2_TO_H3_A_MEMORY_DEPTH_N + H2_TO_H3_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H2_TO_H5 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H4 + H2_TO_H4_CH_EN * (H2_TO_H4_A_MEMORY_DEPTH_N + H2_TO_H4_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H3_TO_H4 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H2_TO_H5 + H2_TO_H5_CH_EN * (H2_TO_H5_A_MEMORY_DEPTH_N + H2_TO_H5_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H3_TO_H5 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H3_TO_H4 + H3_TO_H4_CH_EN * (H3_TO_H4_A_MEMORY_DEPTH_N + H3_TO_H4_B_MEMORY_DEPTH_M));
localparam [BUFF_RAM_ADDR_WIDTH-1:0] A_BUF_PTR_H4_TO_H5 = BUFF_RAM_ADDR_WIDTH'(A_BUF_PTR_H3_TO_H5 + H3_TO_H5_CH_EN * (H3_TO_H5_A_MEMORY_DEPTH_N + H3_TO_H5_B_MEMORY_DEPTH_M));

localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H0_TO_H1 = A_BUF_PTR_H0_TO_H1 + H0_TO_H1_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H0_TO_H2 = A_BUF_PTR_H0_TO_H2 + H0_TO_H2_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H0_TO_H3 = A_BUF_PTR_H0_TO_H3 + H0_TO_H3_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H0_TO_H4 = A_BUF_PTR_H0_TO_H4 + H0_TO_H4_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H0_TO_H5 = A_BUF_PTR_H0_TO_H5 + H0_TO_H5_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H1_TO_H2 = A_BUF_PTR_H1_TO_H2 + H1_TO_H2_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H1_TO_H3 = A_BUF_PTR_H1_TO_H3 + H1_TO_H3_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H1_TO_H4 = A_BUF_PTR_H1_TO_H4 + H1_TO_H4_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H1_TO_H5 = A_BUF_PTR_H1_TO_H5 + H1_TO_H5_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H2_TO_H3 = A_BUF_PTR_H2_TO_H3 + H2_TO_H3_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H2_TO_H4 = A_BUF_PTR_H2_TO_H4 + H2_TO_H4_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H2_TO_H5 = A_BUF_PTR_H2_TO_H5 + H2_TO_H5_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H3_TO_H4 = A_BUF_PTR_H3_TO_H4 + H3_TO_H4_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H3_TO_H5 = A_BUF_PTR_H3_TO_H5 + H3_TO_H5_A_MEMORY_DEPTH_N;
localparam [BUFF_RAM_ADDR_WIDTH-1:0] B_BUF_PTR_H4_TO_H5 = A_BUF_PTR_H4_TO_H5 + H4_TO_H5_A_MEMORY_DEPTH_N;

// wire declaration
wire                    WR_EN;
wire [DATA_WIDTH-1:0]   ADDR;
wire [DATA_WIDTH-1:0]   WDATA; 
wire [DATA_WIDTH-1:0]   RDATA;
wire                    RD_EN;

// Address Controller signals
wire                        H0_TO_H1_WR_EN;
wire                        H0_TO_H1_RD_EN;
wire [7:0]                  H0_TO_H1_ADDR;
wire [DATA_WIDTH-1:0]       H0_TO_H1_WDATA;
wire [DATA_WIDTH-1:0]       H0_TO_H1_RDATA;

wire                        H0_TO_H2_WR_EN;
wire                        H0_TO_H2_RD_EN;
wire [7:0]                  H0_TO_H2_ADDR;
wire [DATA_WIDTH-1:0]       H0_TO_H2_WDATA;
wire [DATA_WIDTH-1:0]       H0_TO_H2_RDATA;

wire                        H0_TO_H3_WR_EN;
wire                        H0_TO_H3_RD_EN;
wire [7:0]                  H0_TO_H3_ADDR;
wire [DATA_WIDTH-1:0]       H0_TO_H3_WDATA;
wire [DATA_WIDTH-1:0]       H0_TO_H3_RDATA;

wire                        H0_TO_H4_WR_EN;
wire                        H0_TO_H4_RD_EN;
wire [7:0]                  H0_TO_H4_ADDR;
wire [DATA_WIDTH-1:0]       H0_TO_H4_WDATA;
wire [DATA_WIDTH-1:0]       H0_TO_H4_RDATA;

wire                        H0_TO_H5_WR_EN;
wire                        H0_TO_H5_RD_EN;
wire [7:0]                  H0_TO_H5_ADDR;
wire [DATA_WIDTH-1:0]       H0_TO_H5_WDATA;
wire [DATA_WIDTH-1:0]       H0_TO_H5_RDATA;

wire                        H1_TO_H0_WR_EN;
wire                        H1_TO_H0_RD_EN;
wire [7:0]                  H1_TO_H0_ADDR;
wire [31:0]                 H1_TO_H0_WDATA;
wire [31:0]                 H1_TO_H0_RDATA;

wire                        H1_TO_H2_WR_EN;
wire                        H1_TO_H2_RD_EN;
wire [7:0]                  H1_TO_H2_ADDR;
wire [DATA_WIDTH-1:0]       H1_TO_H2_WDATA;
wire [DATA_WIDTH-1:0]       H1_TO_H2_RDATA;

wire                        H1_TO_H3_WR_EN;
wire                        H1_TO_H3_RD_EN;
wire [7:0]                  H1_TO_H3_ADDR;
wire [DATA_WIDTH-1:0]       H1_TO_H3_WDATA;
wire [DATA_WIDTH-1:0]       H1_TO_H3_RDATA;

wire                        H1_TO_H4_WR_EN;
wire                        H1_TO_H4_RD_EN;
wire [7:0]                  H1_TO_H4_ADDR;
wire [DATA_WIDTH-1:0]       H1_TO_H4_WDATA;
wire [DATA_WIDTH-1:0]       H1_TO_H4_RDATA;

wire                        H1_TO_H5_WR_EN;
wire                        H1_TO_H5_RD_EN;
wire [7:0]                  H1_TO_H5_ADDR;
wire [DATA_WIDTH-1:0]       H1_TO_H5_WDATA;
wire [DATA_WIDTH-1:0]       H1_TO_H5_RDATA;

wire                        H2_TO_H0_WR_EN;
wire                        H2_TO_H0_RD_EN;
wire [7:0]                  H2_TO_H0_ADDR;
wire [31:0]                 H2_TO_H0_WDATA;
wire [31:0]                 H2_TO_H0_RDATA;

wire                        H2_TO_H1_WR_EN;
wire                        H2_TO_H1_RD_EN;
wire [7:0]                  H2_TO_H1_ADDR;
wire [31:0]                 H2_TO_H1_WDATA;
wire [31:0]                 H2_TO_H1_RDATA;

wire                        H2_TO_H3_WR_EN;
wire                        H2_TO_H3_RD_EN;
wire [7:0]                  H2_TO_H3_ADDR;
wire [DATA_WIDTH-1:0]       H2_TO_H3_WDATA;
wire [DATA_WIDTH-1:0]       H2_TO_H3_RDATA;

wire                        H2_TO_H4_WR_EN;
wire                        H2_TO_H4_RD_EN;
wire [7:0]                  H2_TO_H4_ADDR;
wire [DATA_WIDTH-1:0]       H2_TO_H4_WDATA;
wire [DATA_WIDTH-1:0]       H2_TO_H4_RDATA;

wire                        H2_TO_H5_WR_EN;
wire                        H2_TO_H5_RD_EN;
wire [7:0]                  H2_TO_H5_ADDR;
wire [DATA_WIDTH-1:0]       H2_TO_H5_WDATA;
wire [DATA_WIDTH-1:0]       H2_TO_H5_RDATA;

wire                        H3_TO_H0_WR_EN;
wire                        H3_TO_H0_RD_EN;
wire [7:0]                  H3_TO_H0_ADDR;
wire [31:0]                 H3_TO_H0_WDATA;
wire [31:0]                 H3_TO_H0_RDATA;

wire                        H3_TO_H1_WR_EN;
wire                        H3_TO_H1_RD_EN;
wire [7:0]                  H3_TO_H1_ADDR;
wire [31:0]                 H3_TO_H1_WDATA;
wire [31:0]                 H3_TO_H1_RDATA;

wire                        H3_TO_H2_WR_EN;
wire                        H3_TO_H2_RD_EN;
wire [7:0]                  H3_TO_H2_ADDR;
wire [31:0]                 H3_TO_H2_WDATA;
wire [31:0]                 H3_TO_H2_RDATA;

wire                        H3_TO_H4_WR_EN;
wire                        H3_TO_H4_RD_EN;
wire [7:0]                  H3_TO_H4_ADDR;
wire [31:0]                 H3_TO_H4_WDATA;
wire [31:0]                 H3_TO_H4_RDATA;

wire                        H3_TO_H5_WR_EN;
wire                        H3_TO_H5_RD_EN;
wire [7:0]                  H3_TO_H5_ADDR;
wire [31:0]                 H3_TO_H5_WDATA;
wire [31:0]                 H3_TO_H5_RDATA;

wire                        H4_TO_H0_WR_EN;
wire                        H4_TO_H0_RD_EN;
wire [7:0]                  H4_TO_H0_ADDR;
wire [31:0]                 H4_TO_H0_WDATA;
wire [31:0]                 H4_TO_H0_RDATA;

wire                        H4_TO_H1_WR_EN;
wire                        H4_TO_H1_RD_EN;
wire [7:0]                  H4_TO_H1_ADDR;
wire [31:0]                 H4_TO_H1_WDATA;
wire [31:0]                 H4_TO_H1_RDATA;

wire                        H4_TO_H2_WR_EN;
wire                        H4_TO_H2_RD_EN;
wire [7:0]                  H4_TO_H2_ADDR;
wire [31:0]                 H4_TO_H2_WDATA;
wire [31:0]                 H4_TO_H2_RDATA;

wire                        H4_TO_H3_WR_EN;
wire                        H4_TO_H3_RD_EN;
wire [7:0]                  H4_TO_H3_ADDR;
wire [31:0]                 H4_TO_H3_WDATA;
wire [31:0]                 H4_TO_H3_RDATA;

wire                        H4_TO_H5_WR_EN;
wire                        H4_TO_H5_RD_EN;
wire [7:0]                  H4_TO_H5_ADDR;
wire [31:0]                 H4_TO_H5_WDATA;
wire [31:0]                 H4_TO_H5_RDATA;

wire                        H5_TO_H0_WR_EN;
wire                        H5_TO_H0_RD_EN;
wire [7:0]                  H5_TO_H0_ADDR;
wire [31:0]                 H5_TO_H0_WDATA;
wire [31:0]                 H5_TO_H0_RDATA;

wire                        H5_TO_H1_WR_EN;
wire                        H5_TO_H1_RD_EN;
wire [7:0]                  H5_TO_H1_ADDR;
wire [31:0]                 H5_TO_H1_WDATA;
wire [31:0]                 H5_TO_H1_RDATA;

wire                        H5_TO_H2_WR_EN;
wire                        H5_TO_H2_RD_EN;
wire [7:0]                  H5_TO_H2_ADDR;
wire [31:0]                 H5_TO_H2_WDATA;
wire [31:0]                 H5_TO_H2_RDATA;

wire                        H5_TO_H3_WR_EN;
wire                        H5_TO_H3_RD_EN;
wire [7:0]                  H5_TO_H3_ADDR;
wire [31:0]                 H5_TO_H3_WDATA;
wire [31:0]                 H5_TO_H3_RDATA;

wire                        H5_TO_H4_WR_EN;
wire                        H5_TO_H4_RD_EN;
wire [7:0]                  H5_TO_H4_ADDR;
wire [31:0]                 H5_TO_H4_WDATA;
wire [31:0]                 H5_TO_H4_RDATA;

wire                        H0_IRQ_MODULE_WR_EN;
wire                        H0_IRQ_MODULE_RD_EN;
wire [7:0]                  H0_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H0_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H0_IRQ_MODULE_RDATA;

wire                        H1_IRQ_MODULE_WR_EN;
wire                        H1_IRQ_MODULE_RD_EN;
wire [7:0]                  H1_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H1_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H1_IRQ_MODULE_RDATA;

wire                        H2_IRQ_MODULE_WR_EN;
wire                        H2_IRQ_MODULE_RD_EN;
wire [7:0]                  H2_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H2_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H2_IRQ_MODULE_RDATA;

wire                        H3_IRQ_MODULE_WR_EN;
wire                        H3_IRQ_MODULE_RD_EN;
wire [7:0]                  H3_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H3_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H3_IRQ_MODULE_RDATA;

wire                        H4_IRQ_MODULE_WR_EN;
wire                        H4_IRQ_MODULE_RD_EN;
wire [7:0]                  H4_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H4_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H4_IRQ_MODULE_RDATA;

wire                        H5_IRQ_MODULE_WR_EN;
wire                        H5_IRQ_MODULE_RD_EN;
wire [7:0]                  H5_IRQ_MODULE_ADDR;
wire [DATA_WIDTH-1:0]       H5_IRQ_MODULE_WDATA;
wire [DATA_WIDTH-1:0]       H5_IRQ_MODULE_RDATA;

wire H0_MON_IRQ;
wire H1_MON_IRQ;
wire H2_MON_IRQ;
wire H3_MON_IRQ;
wire H4_MON_IRQ;
wire H5_MON_IRQ;

wire H0_APP_IRQ; 
wire H1_APP_IRQ; 
wire H2_APP_IRQ; 
wire H3_APP_IRQ; 
wire H4_APP_IRQ;
wire H5_APP_IRQ;

// Wires to facilitate read/writes between channels and the common memory
wire MB_ACCESS_EN_H0_H1;
wire MB_WR_EN_H0_H1;

wire MB_ACCESS_EN_H0_H2;
wire MB_WR_EN_H0_H2;

wire MB_ACCESS_EN_H0_H3;
wire MB_WR_EN_H0_H3;

wire MB_ACCESS_EN_H0_H4;
wire MB_WR_EN_H0_H4;

wire MB_ACCESS_EN_H0_H5;
wire MB_WR_EN_H0_H5;

wire MB_ACCESS_EN_H1_H2;
wire MB_WR_EN_H1_H2;

wire MB_ACCESS_EN_H1_H3;
wire MB_WR_EN_H1_H3;

wire MB_ACCESS_EN_H1_H4;
wire MB_WR_EN_H1_H4;

wire MB_ACCESS_EN_H1_H5;
wire MB_WR_EN_H1_H5;

wire MB_ACCESS_EN_H2_H3;
wire MB_WR_EN_H2_H3;

wire MB_ACCESS_EN_H2_H4;
wire MB_WR_EN_H2_H4;

wire MB_ACCESS_EN_H2_H5;
wire MB_WR_EN_H2_H5;

wire MB_ACCESS_EN_H3_H4;
wire MB_WR_EN_H3_H4;

wire MB_ACCESS_EN_H3_H5;
wire MB_WR_EN_H3_H5;

wire MB_ACCESS_EN_H4_H5;
wire MB_WR_EN_H4_H5;

wire MB_A_ACTIVE_H0_H1;
wire MB_A_ACTIVE_H0_H2;
wire MB_A_ACTIVE_H0_H3;
wire MB_A_ACTIVE_H0_H4;
wire MB_A_ACTIVE_H0_H5;
wire MB_A_ACTIVE_H1_H2;
wire MB_A_ACTIVE_H1_H3;
wire MB_A_ACTIVE_H1_H4;
wire MB_A_ACTIVE_H1_H5;
wire MB_A_ACTIVE_H2_H3;
wire MB_A_ACTIVE_H2_H4;
wire MB_A_ACTIVE_H2_H5;
wire MB_A_ACTIVE_H3_H4;
wire MB_A_ACTIVE_H3_H5;
wire MB_A_ACTIVE_H4_H5;

wire MB_RB_RD_EN_H0_H1;
wire MB_RB_RD_EN_H0_H2;
wire MB_RB_RD_EN_H0_H3;
wire MB_RB_RD_EN_H0_H4;
wire MB_RB_RD_EN_H0_H5;
wire MB_RB_RD_EN_H1_H2;
wire MB_RB_RD_EN_H1_H3;
wire MB_RB_RD_EN_H1_H4;
wire MB_RB_RD_EN_H1_H5;
wire MB_RB_RD_EN_H2_H3;
wire MB_RB_RD_EN_H2_H4;
wire MB_RB_RD_EN_H2_H5;
wire MB_RB_RD_EN_H3_H4;
wire MB_RB_RD_EN_H3_H5;
wire MB_RB_RD_EN_H4_H5;

wire [BUFF_RAM_ADDR_WIDTH-1:0] COMMON_MB_ADDR_OUT;
wire [14:0]             MB_ACCESS_EN_ARR;
wire [DATA_WIDTH-1:0]   COMMON_MB_RAM_DOUT;
wire                    COMMON_MB_RAM_WR;
wire                    MB_A_ACTIVE;
wire                    MB_RB_RD_EN;

// to keep track of which mailbox is being accessed. a mailbox is accessed when a write/read occurs to the mailbox
assign MB_ACCESS_EN_ARR = {MB_ACCESS_EN_H0_H1, MB_ACCESS_EN_H0_H2, MB_ACCESS_EN_H0_H3, MB_ACCESS_EN_H0_H4, MB_ACCESS_EN_H0_H5,
                            MB_ACCESS_EN_H1_H2, MB_ACCESS_EN_H1_H3, MB_ACCESS_EN_H1_H4, MB_ACCESS_EN_H1_H5, MB_ACCESS_EN_H2_H3,
                            MB_ACCESS_EN_H2_H4, MB_ACCESS_EN_H2_H5, MB_ACCESS_EN_H3_H4, MB_ACCESS_EN_H3_H5, MB_ACCESS_EN_H4_H5};
// to indicate if mailbox A is active. if mailbox A is not active during a mailbox access then mailbox B is active
assign MB_A_ACTIVE      = MB_A_ACTIVE_H0_H1 || MB_A_ACTIVE_H0_H2 || MB_A_ACTIVE_H0_H3 || MB_A_ACTIVE_H0_H4 || MB_A_ACTIVE_H0_H5 ||
                          MB_A_ACTIVE_H1_H2 || MB_A_ACTIVE_H1_H3 || MB_A_ACTIVE_H1_H4 || MB_A_ACTIVE_H1_H5 || MB_A_ACTIVE_H2_H3 ||
                          MB_A_ACTIVE_H2_H4 || MB_A_ACTIVE_H2_H5 || MB_A_ACTIVE_H3_H4 || MB_A_ACTIVE_H3_H5 || MB_A_ACTIVE_H4_H5;
// to indicate if a mailbox readback is occuring. this is a read to confirm that the written message is correct and *not* to read a message from another hart
assign MB_RB_RD_EN      = MB_RB_RD_EN_H0_H1 || MB_RB_RD_EN_H0_H2 || MB_RB_RD_EN_H0_H3 || MB_RB_RD_EN_H0_H4 || MB_RB_RD_EN_H0_H5 ||
                          MB_RB_RD_EN_H1_H2 || MB_RB_RD_EN_H1_H3 || MB_RB_RD_EN_H1_H4 || MB_RB_RD_EN_H1_H5 || MB_RB_RD_EN_H2_H3 ||
                          MB_RB_RD_EN_H2_H4 || MB_RB_RD_EN_H2_H5 || MB_RB_RD_EN_H3_H4 || MB_RB_RD_EN_H3_H5 || MB_RB_RD_EN_H4_H5;
// to indicate to common RAM block whether to write or read during a mailbox access
assign COMMON_MB_RAM_WR = MB_WR_EN_H0_H1 || MB_WR_EN_H0_H2 || MB_WR_EN_H0_H3 || MB_WR_EN_H0_H4 || MB_WR_EN_H0_H5 || MB_WR_EN_H1_H2 || 
                          MB_WR_EN_H1_H3 || MB_WR_EN_H1_H4 || MB_WR_EN_H1_H5 || MB_WR_EN_H2_H3 || MB_WR_EN_H2_H4 || MB_WR_EN_H2_H5 || 
                          MB_WR_EN_H3_H4 || MB_WR_EN_H3_H5 || MB_WR_EN_H4_H5;
assign MON_IRQ = {H5_MON_IRQ, H4_MON_IRQ, H3_MON_IRQ, H2_MON_IRQ, H1_MON_IRQ, H0_MON_IRQ};
assign APP_IRQ = {H5_APP_IRQ, H4_APP_IRQ, H3_APP_IRQ, H2_APP_IRQ, H1_APP_IRQ, H0_APP_IRQ};

// APB3 Interface
miv_ihc_apb_target #(
    .SYNC_RESET(SYNC_RESET)
    )
    apb_target_0 (
    .CLK(CLK),
    .RESETN(RESETN),
    
    .PENABLE(APB3_0_PENABLE),
    .PSEL(APB3_0_PSEL),
    .PADDR(APB3_0_PADDR),
    .PWRITE(APB3_0_PWRITE),
    .PWDATA(APB3_0_PWDATA),
    .PRDATA(APB3_0_PRDATA),
    .PREADY(APB3_0_PREADY),
    .PSLVERR(APB3_0_PSLVERR),

    .WR_EN(WR_EN),
    .ADDR(ADDR),
    .WDATA(WDATA),
    .RD_EN(RD_EN),
    .RDATA(RDATA)
);  

// Addressing Mux
miv_ihc_address_controller #(
    .ADDR_WIDTH(ADDR_WIDTH), 
    .DATA_WIDTH(DATA_WIDTH),
    .MIV_IHC_IP_VERSION(IP_VERSION),
    .ONE_HOT_MM(ONE_HOT_MM)
    )
    addr_mux_0 (
    .WR_EN(WR_EN),
    .RD_EN(RD_EN),
    .ADDR(ADDR),
    .WDATA(WDATA),
    .RDATA(RDATA ),

    .H0_TO_H1_WR_EN(H0_TO_H1_WR_EN),
    .H0_TO_H1_RD_EN(H0_TO_H1_RD_EN),
    .H0_TO_H1_ADDR(H0_TO_H1_ADDR),
    .H0_TO_H1_WDATA(H0_TO_H1_WDATA),
    .H0_TO_H1_RDATA(H0_TO_H1_RDATA),

    .H0_TO_H2_WR_EN(H0_TO_H2_WR_EN),
    .H0_TO_H2_RD_EN(H0_TO_H2_RD_EN),
    .H0_TO_H2_ADDR(H0_TO_H2_ADDR),
    .H0_TO_H2_WDATA(H0_TO_H2_WDATA),
    .H0_TO_H2_RDATA(H0_TO_H2_RDATA),

    .H0_TO_H3_WR_EN(H0_TO_H3_WR_EN),
    .H0_TO_H3_RD_EN(H0_TO_H3_RD_EN),
    .H0_TO_H3_ADDR(H0_TO_H3_ADDR),
    .H0_TO_H3_WDATA(H0_TO_H3_WDATA),
    .H0_TO_H3_RDATA(H0_TO_H3_RDATA),    

    .H0_TO_H4_WR_EN(H0_TO_H4_WR_EN),
    .H0_TO_H4_RD_EN(H0_TO_H4_RD_EN),
    .H0_TO_H4_ADDR(H0_TO_H4_ADDR),
    .H0_TO_H4_WDATA(H0_TO_H4_WDATA),
    .H0_TO_H4_RDATA(H0_TO_H4_RDATA),

    .H0_TO_H5_WR_EN(H0_TO_H5_WR_EN),
    .H0_TO_H5_RD_EN(H0_TO_H5_RD_EN),
    .H0_TO_H5_ADDR(H0_TO_H5_ADDR),
    .H0_TO_H5_WDATA(H0_TO_H5_WDATA),
    .H0_TO_H5_RDATA(H0_TO_H5_RDATA),

    .H1_TO_H0_WR_EN(H1_TO_H0_WR_EN),
    .H1_TO_H0_RD_EN(H1_TO_H0_RD_EN),
    .H1_TO_H0_ADDR(H1_TO_H0_ADDR),
    .H1_TO_H0_WDATA(H1_TO_H0_WDATA),
    .H1_TO_H0_RDATA(H1_TO_H0_RDATA),
    
    .H1_TO_H2_WR_EN(H1_TO_H2_WR_EN),
    .H1_TO_H2_RD_EN(H1_TO_H2_RD_EN),
    .H1_TO_H2_ADDR(H1_TO_H2_ADDR),
    .H1_TO_H2_WDATA(H1_TO_H2_WDATA),
    .H1_TO_H2_RDATA(H1_TO_H2_RDATA),

    .H1_TO_H3_WR_EN(H1_TO_H3_WR_EN),
    .H1_TO_H3_RD_EN(H1_TO_H3_RD_EN),
    .H1_TO_H3_ADDR(H1_TO_H3_ADDR),
    .H1_TO_H3_WDATA(H1_TO_H3_WDATA),
    .H1_TO_H3_RDATA(H1_TO_H3_RDATA),        

    .H1_TO_H4_WR_EN(H1_TO_H4_WR_EN),
    .H1_TO_H4_RD_EN(H1_TO_H4_RD_EN),
    .H1_TO_H4_ADDR(H1_TO_H4_ADDR),
    .H1_TO_H4_WDATA(H1_TO_H4_WDATA),
    .H1_TO_H4_RDATA(H1_TO_H4_RDATA),

    .H1_TO_H5_WR_EN(H1_TO_H5_WR_EN),
    .H1_TO_H5_RD_EN(H1_TO_H5_RD_EN),
    .H1_TO_H5_ADDR(H1_TO_H5_ADDR),
    .H1_TO_H5_WDATA(H1_TO_H5_WDATA),
    .H1_TO_H5_RDATA(H1_TO_H5_RDATA),

    .H2_TO_H0_WR_EN(H2_TO_H0_WR_EN),
    .H2_TO_H0_RD_EN(H2_TO_H0_RD_EN),
    .H2_TO_H0_ADDR(H2_TO_H0_ADDR),
    .H2_TO_H0_WDATA(H2_TO_H0_WDATA),
    .H2_TO_H0_RDATA(H2_TO_H0_RDATA),

    .H2_TO_H1_WR_EN(H2_TO_H1_WR_EN),
    .H2_TO_H1_RD_EN(H2_TO_H1_RD_EN),
    .H2_TO_H1_ADDR(H2_TO_H1_ADDR),
    .H2_TO_H1_WDATA(H2_TO_H1_WDATA),
    .H2_TO_H1_RDATA(H2_TO_H1_RDATA),

    .H2_TO_H3_WR_EN(H2_TO_H3_WR_EN),
    .H2_TO_H3_RD_EN(H2_TO_H3_RD_EN),
    .H2_TO_H3_ADDR(H2_TO_H3_ADDR),
    .H2_TO_H3_WDATA(H2_TO_H3_WDATA),
    .H2_TO_H3_RDATA(H2_TO_H3_RDATA),    

    .H2_TO_H4_WR_EN(H2_TO_H4_WR_EN),
    .H2_TO_H4_RD_EN(H2_TO_H4_RD_EN),
    .H2_TO_H4_ADDR(H2_TO_H4_ADDR),
    .H2_TO_H4_WDATA(H2_TO_H4_WDATA),
    .H2_TO_H4_RDATA(H2_TO_H4_RDATA), 

    .H2_TO_H5_WR_EN(H2_TO_H5_WR_EN),
    .H2_TO_H5_RD_EN(H2_TO_H5_RD_EN),
    .H2_TO_H5_ADDR(H2_TO_H5_ADDR),
    .H2_TO_H5_WDATA(H2_TO_H5_WDATA),
    .H2_TO_H5_RDATA(H2_TO_H5_RDATA),  

    .H3_TO_H0_WR_EN(H3_TO_H0_WR_EN),
    .H3_TO_H0_RD_EN(H3_TO_H0_RD_EN),
    .H3_TO_H0_ADDR(H3_TO_H0_ADDR),
    .H3_TO_H0_WDATA(H3_TO_H0_WDATA),
    .H3_TO_H0_RDATA(H3_TO_H0_RDATA),      

    .H3_TO_H1_WR_EN(H3_TO_H1_WR_EN),
    .H3_TO_H1_RD_EN(H3_TO_H1_RD_EN),
    .H3_TO_H1_ADDR(H3_TO_H1_ADDR),
    .H3_TO_H1_WDATA(H3_TO_H1_WDATA),
    .H3_TO_H1_RDATA(H3_TO_H1_RDATA),      

    .H3_TO_H2_WR_EN(H3_TO_H2_WR_EN),
    .H3_TO_H2_RD_EN(H3_TO_H2_RD_EN),
    .H3_TO_H2_ADDR(H3_TO_H2_ADDR),
    .H3_TO_H2_WDATA(H3_TO_H2_WDATA),
    .H3_TO_H2_RDATA(H3_TO_H2_RDATA),      

    .H3_TO_H4_WR_EN(H3_TO_H4_WR_EN),
    .H3_TO_H4_RD_EN(H3_TO_H4_RD_EN),
    .H3_TO_H4_ADDR(H3_TO_H4_ADDR),
    .H3_TO_H4_WDATA(H3_TO_H4_WDATA),
    .H3_TO_H4_RDATA(H3_TO_H4_RDATA),

    .H3_TO_H5_WR_EN(H3_TO_H5_WR_EN),
    .H3_TO_H5_RD_EN(H3_TO_H5_RD_EN),
    .H3_TO_H5_ADDR(H3_TO_H5_ADDR),
    .H3_TO_H5_WDATA(H3_TO_H5_WDATA),
    .H3_TO_H5_RDATA(H3_TO_H5_RDATA),

    .H4_TO_H0_WR_EN(H4_TO_H0_WR_EN),
    .H4_TO_H0_RD_EN(H4_TO_H0_RD_EN),
    .H4_TO_H0_ADDR(H4_TO_H0_ADDR),
    .H4_TO_H0_WDATA(H4_TO_H0_WDATA),
    .H4_TO_H0_RDATA(H4_TO_H0_RDATA),

    .H4_TO_H1_WR_EN(H4_TO_H1_WR_EN),
    .H4_TO_H1_RD_EN(H4_TO_H1_RD_EN),
    .H4_TO_H1_ADDR(H4_TO_H1_ADDR),
    .H4_TO_H1_WDATA(H4_TO_H1_WDATA),
    .H4_TO_H1_RDATA(H4_TO_H1_RDATA), 

    .H4_TO_H2_WR_EN(H4_TO_H2_WR_EN),
    .H4_TO_H2_RD_EN(H4_TO_H2_RD_EN),
    .H4_TO_H2_ADDR(H4_TO_H2_ADDR),
    .H4_TO_H2_WDATA(H4_TO_H2_WDATA),
    .H4_TO_H2_RDATA(H4_TO_H2_RDATA),       

    .H4_TO_H3_WR_EN(H4_TO_H3_WR_EN),
    .H4_TO_H3_RD_EN(H4_TO_H3_RD_EN),
    .H4_TO_H3_ADDR(H4_TO_H3_ADDR),
    .H4_TO_H3_WDATA(H4_TO_H3_WDATA),
    .H4_TO_H3_RDATA(H4_TO_H3_RDATA),

    .H4_TO_H5_WR_EN(H4_TO_H5_WR_EN),
    .H4_TO_H5_RD_EN(H4_TO_H5_RD_EN),
    .H4_TO_H5_ADDR(H4_TO_H5_ADDR),
    .H4_TO_H5_WDATA(H4_TO_H5_WDATA),
    .H4_TO_H5_RDATA(H4_TO_H5_RDATA),

    .H5_TO_H0_WR_EN(H5_TO_H0_WR_EN),
    .H5_TO_H0_RD_EN(H5_TO_H0_RD_EN),
    .H5_TO_H0_ADDR(H5_TO_H0_ADDR),
    .H5_TO_H0_WDATA(H5_TO_H0_WDATA),
    .H5_TO_H0_RDATA(H5_TO_H0_RDATA),

    .H5_TO_H1_WR_EN(H5_TO_H1_WR_EN),
    .H5_TO_H1_RD_EN(H5_TO_H1_RD_EN),
    .H5_TO_H1_ADDR(H5_TO_H1_ADDR),
    .H5_TO_H1_WDATA(H5_TO_H1_WDATA),
    .H5_TO_H1_RDATA(H5_TO_H1_RDATA),

    .H5_TO_H2_WR_EN(H5_TO_H2_WR_EN),
    .H5_TO_H2_RD_EN(H5_TO_H2_RD_EN),
    .H5_TO_H2_ADDR(H5_TO_H2_ADDR),
    .H5_TO_H2_WDATA(H5_TO_H2_WDATA),
    .H5_TO_H2_RDATA(H5_TO_H2_RDATA),

    .H5_TO_H3_WR_EN(H5_TO_H3_WR_EN),
    .H5_TO_H3_RD_EN(H5_TO_H3_RD_EN),
    .H5_TO_H3_ADDR(H5_TO_H3_ADDR),
    .H5_TO_H3_WDATA(H5_TO_H3_WDATA),
    .H5_TO_H3_RDATA(H5_TO_H3_RDATA),

    .H5_TO_H4_WR_EN(H5_TO_H4_WR_EN),
    .H5_TO_H4_RD_EN(H5_TO_H4_RD_EN),
    .H5_TO_H4_ADDR(H5_TO_H4_ADDR),
    .H5_TO_H4_WDATA(H5_TO_H4_WDATA),
    .H5_TO_H4_RDATA(H5_TO_H4_RDATA),

    .H0_IRQ_MODULE_WR_EN(H0_IRQ_MODULE_WR_EN),
    .H0_IRQ_MODULE_RD_EN(H0_IRQ_MODULE_RD_EN),
    .H0_IRQ_MODULE_ADDR(H0_IRQ_MODULE_ADDR),
    .H0_IRQ_MODULE_WDATA(H0_IRQ_MODULE_WDATA),
    .H0_IRQ_MODULE_RDATA(H0_IRQ_MODULE_RDATA),  

    .H1_IRQ_MODULE_WR_EN(H1_IRQ_MODULE_WR_EN),
    .H1_IRQ_MODULE_RD_EN(H1_IRQ_MODULE_RD_EN),
    .H1_IRQ_MODULE_ADDR(H1_IRQ_MODULE_ADDR),
    .H1_IRQ_MODULE_WDATA(H1_IRQ_MODULE_WDATA),
    .H1_IRQ_MODULE_RDATA(H1_IRQ_MODULE_RDATA),

    .H2_IRQ_MODULE_WR_EN(H2_IRQ_MODULE_WR_EN),
    .H2_IRQ_MODULE_RD_EN(H2_IRQ_MODULE_RD_EN),
    .H2_IRQ_MODULE_ADDR(H2_IRQ_MODULE_ADDR),
    .H2_IRQ_MODULE_WDATA(H2_IRQ_MODULE_WDATA),
    .H2_IRQ_MODULE_RDATA(H2_IRQ_MODULE_RDATA),

    .H3_IRQ_MODULE_WR_EN(H3_IRQ_MODULE_WR_EN),
    .H3_IRQ_MODULE_RD_EN(H3_IRQ_MODULE_RD_EN),
    .H3_IRQ_MODULE_ADDR(H3_IRQ_MODULE_ADDR),
    .H3_IRQ_MODULE_WDATA(H3_IRQ_MODULE_WDATA),
    .H3_IRQ_MODULE_RDATA(H3_IRQ_MODULE_RDATA),   

    .H4_IRQ_MODULE_WR_EN(H4_IRQ_MODULE_WR_EN),
    .H4_IRQ_MODULE_RD_EN(H4_IRQ_MODULE_RD_EN),
    .H4_IRQ_MODULE_ADDR(H4_IRQ_MODULE_ADDR),
    .H4_IRQ_MODULE_WDATA(H4_IRQ_MODULE_WDATA),
    .H4_IRQ_MODULE_RDATA(H4_IRQ_MODULE_RDATA),

    .H5_IRQ_MODULE_WR_EN(H5_IRQ_MODULE_WR_EN),
    .H5_IRQ_MODULE_RD_EN(H5_IRQ_MODULE_RD_EN),
    .H5_IRQ_MODULE_ADDR(H5_IRQ_MODULE_ADDR),
    .H5_IRQ_MODULE_WDATA(H5_IRQ_MODULE_WDATA),
    .H5_IRQ_MODULE_RDATA(H5_IRQ_MODULE_RDATA)    
);    

// Channel H0 <-> H1
generate
    if (H0_TO_H1_CH_EN)
        begin: gen_h0_h1
            	miv_ihc_channel #(
                    .SYNC_RESET(SYNC_RESET),
                    .A_MEMORY_DEPTH_N(H0_TO_H1_A_MEMORY_DEPTH_N), 
                    .B_MEMORY_DEPTH_M(H0_TO_H1_B_MEMORY_DEPTH_M),
                    .A_DEBUG_ID(8'd0),
                    .B_DEBUG_ID(8'd1),
                    .DATA_WIDTH(DATA_WIDTH),
                    .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)
                    )
                    CH_H0_H1(
            	    .clk(CLK),
            	    .resetn(RESETN), 

                    .WR_EN_CH_A(H0_TO_H1_WR_EN), 
            	    .RD_EN_CH_A(H0_TO_H1_RD_EN),  
            	    .ADDR_CH_A(H0_TO_H1_ADDR), 
            	    .WDATA_CH_A(H0_TO_H1_WDATA), 
            	    .RDATA_CH_A(H0_TO_H1_RDATA), 
            	    	
            	    .WR_EN_CH_B(H1_TO_H0_WR_EN), 
            	    .RD_EN_CH_B(H1_TO_H0_RD_EN),  
            	    .ADDR_CH_B(H1_TO_H0_ADDR), 
            	    .WDATA_CH_B(H1_TO_H0_WDATA), 
            	    .RDATA_CH_B(H1_TO_H0_RDATA), 

                    .MB_RDATA(COMMON_MB_RAM_DOUT),
                    .MB_A_ACTIVE(MB_A_ACTIVE_H0_H1),            	    
                    .MB_ACCESS_EN(MB_ACCESS_EN_H0_H1),
                    .MB_RB_RD_EN(MB_RB_RD_EN_H0_H1),
                    .MB_WR_EN(MB_WR_EN_H0_H1),
            	    .MP_IRQ(MP_IRQ_H0_H1),
            	    .MP_ACK(MP_ACK_H0_H1));
        end
    else
        begin: ngen_h0_h1
            assign H0_TO_H1_RDATA = 'b0;
            assign H1_TO_H0_RDATA = 'b0;
            assign MP_IRQ_H0_H1 = 'b0;
            assign MP_ACK_H0_H1 = 'b0;
            assign MB_ACCESS_EN_H0_H1 = 'b0;
            assign MB_WR_EN_H0_H1 = 'b0;
            assign MB_A_ACTIVE_H0_H1 = 'b0;
            assign MB_RB_RD_EN_H0_H1 = 'b0;
        end
endgenerate        

// Channel H0 <-> H2
generate 
    if (H0_TO_H2_CH_EN)    
        begin: gen_h0_h2
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H0_TO_H2_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H0_TO_H2_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd0),
                .B_DEBUG_ID(8'd2),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)
                )
                CH_H0_H2(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H0_TO_H2_WR_EN), 
                .RD_EN_CH_A(H0_TO_H2_RD_EN),  
                .ADDR_CH_A(H0_TO_H2_ADDR), 
                .WDATA_CH_A(H0_TO_H2_WDATA), 
                .RDATA_CH_A(H0_TO_H2_RDATA), 

                .WR_EN_CH_B(H2_TO_H0_WR_EN), 
                .RD_EN_CH_B(H2_TO_H0_RD_EN),  
                .ADDR_CH_B(H2_TO_H0_ADDR), 
                .WDATA_CH_B(H2_TO_H0_WDATA), 
                .RDATA_CH_B(H2_TO_H0_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H0_H2),
                .MB_ACCESS_EN(MB_ACCESS_EN_H0_H2),
                .MB_RB_RD_EN(MB_RB_RD_EN_H0_H2),
                .MB_WR_EN(MB_WR_EN_H0_H2),
                .MP_IRQ(MP_IRQ_H0_H2),
                .MP_ACK(MP_ACK_H0_H2));    
        end
    else
        begin: ngen_h0_h2
            assign H0_TO_H2_RDATA = 'b0;
            assign H2_TO_H0_RDATA = 'b0;
            assign MP_IRQ_H0_H2 = 'b0;
            assign MP_ACK_H0_H2 = 'b0; 
            assign MB_ACCESS_EN_H0_H2 = 'b0;
            assign MB_WR_EN_H0_H2 = 'b0; 
            assign MB_A_ACTIVE_H0_H2 = 'b0;
            assign MB_RB_RD_EN_H0_H2 = 'b0;
        end
endgenerate

// Channel H0 <-> H3
generate 
    if (H0_TO_H3_CH_EN)
        begin: gen_h0_h3    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H0_TO_H3_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H0_TO_H3_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd0),
                .B_DEBUG_ID(8'd3),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)          
                )
                CH_H0_H3(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H0_TO_H3_WR_EN), 
                .RD_EN_CH_A(H0_TO_H3_RD_EN),  
                .ADDR_CH_A(H0_TO_H3_ADDR), 
                .WDATA_CH_A(H0_TO_H3_WDATA), 
                .RDATA_CH_A(H0_TO_H3_RDATA), 

                .WR_EN_CH_B(H3_TO_H0_WR_EN), 
                .RD_EN_CH_B(H3_TO_H0_RD_EN),  
                .ADDR_CH_B(H3_TO_H0_ADDR), 
                .WDATA_CH_B(H3_TO_H0_WDATA), 
                .RDATA_CH_B(H3_TO_H0_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H0_H3),
                .MB_ACCESS_EN(MB_ACCESS_EN_H0_H3),
                .MB_RB_RD_EN(MB_RB_RD_EN_H0_H3),
                .MB_WR_EN(MB_WR_EN_H0_H3),
                .MP_IRQ(MP_IRQ_H0_H3),
                .MP_ACK(MP_ACK_H0_H3));
        end
    else
        begin: ngen_h0_h3
            assign H0_TO_H3_RDATA = 'b0;
            assign H3_TO_H0_RDATA = 'b0;
            assign MP_IRQ_H0_H3 = 'b0;
            assign MP_ACK_H0_H3 = 'b0;    
            assign MB_ACCESS_EN_H0_H3 = 'b0;
            assign MB_WR_EN_H0_H3 = 'b0;
            assign MB_A_ACTIVE_H0_H3 = 'b0;
            assign MB_RB_RD_EN_H0_H3 = 'b0;
        end
endgenerate

// Channel H0 <-> H4
generate
    if (H0_TO_H4_CH_EN)
        begin: gen_h0_h4    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H0_TO_H4_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H0_TO_H4_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd0),
                .B_DEBUG_ID(8'd4),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)                
                )
                CH_H0_H4(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H0_TO_H4_WR_EN), 
                .RD_EN_CH_A(H0_TO_H4_RD_EN),  
                .ADDR_CH_A(H0_TO_H4_ADDR), 
                .WDATA_CH_A(H0_TO_H4_WDATA), 
                .RDATA_CH_A(H0_TO_H4_RDATA), 

                .WR_EN_CH_B(H4_TO_H0_WR_EN), 
                .RD_EN_CH_B(H4_TO_H0_RD_EN),  
                .ADDR_CH_B(H4_TO_H0_ADDR), 
                .WDATA_CH_B(H4_TO_H0_WDATA), 
                .RDATA_CH_B(H4_TO_H0_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H0_H4),
                .MB_ACCESS_EN(MB_ACCESS_EN_H0_H4),
                .MB_RB_RD_EN(MB_RB_RD_EN_H0_H4),
                .MB_WR_EN(MB_WR_EN_H0_H4),
                .MP_IRQ(MP_IRQ_H0_H4),
                .MP_ACK(MP_ACK_H0_H4));
        end
    else
        begin: ngen_h0_h4
            assign H0_TO_H4_RDATA = 'b0;
            assign H4_TO_H0_RDATA = 'b0;
            assign MP_IRQ_H0_H4 = 'b0;
            assign MP_ACK_H0_H4 = 'b0; 
            assign MB_ACCESS_EN_H0_H4 = 'b0;
            assign MB_WR_EN_H0_H4 = 'b0;
            assign MB_A_ACTIVE_H0_H4 = 'b0;
            assign MB_RB_RD_EN_H0_H4 = 'b0;
        end
endgenerate

// Channel H0 <-> H5
generate
    if (H0_TO_H5_CH_EN)
        begin: gen_h0_h5    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H0_TO_H5_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H0_TO_H5_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd0),
                .B_DEBUG_ID(8'd5),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)         
                )
                CH_H0_H5(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H0_TO_H5_WR_EN), 
                .RD_EN_CH_A(H0_TO_H5_RD_EN),  
                .ADDR_CH_A(H0_TO_H5_ADDR), 
                .WDATA_CH_A(H0_TO_H5_WDATA), 
                .RDATA_CH_A(H0_TO_H5_RDATA), 

                .WR_EN_CH_B(H5_TO_H0_WR_EN), 
                .RD_EN_CH_B(H5_TO_H0_RD_EN),  
                .ADDR_CH_B(H5_TO_H0_ADDR), 
                .WDATA_CH_B(H5_TO_H0_WDATA), 
                .RDATA_CH_B(H5_TO_H0_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H0_H5),
                .MB_ACCESS_EN(MB_ACCESS_EN_H0_H5),
                .MB_RB_RD_EN(MB_RB_RD_EN_H0_H5),
                .MB_WR_EN(MB_WR_EN_H0_H5),
                .MP_IRQ(MP_IRQ_H0_H5),
                .MP_ACK(MP_ACK_H0_H5));
        end
    else
        begin: ngen_h0_h5
            assign H0_TO_H5_RDATA = 'b0;
            assign H5_TO_H0_RDATA = 'b0;
            assign MP_IRQ_H0_H5 = 'b0;
            assign MP_ACK_H0_H5 = 'b0;  
            assign MB_ACCESS_EN_H0_H5 = 'b0;
            assign MB_WR_EN_H0_H5 = 'b0;
            assign MB_A_ACTIVE_H0_H5 = 'b0;
            assign MB_RB_RD_EN_H0_H5 = 'b0;
        end
endgenerate

// Channel H1 <-> H2
generate 
    if (H1_TO_H2_CH_EN)    
        begin: gen_h1_h2
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H1_TO_H2_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H1_TO_H2_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd1),
                .B_DEBUG_ID(8'd2),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)    
                )
                CH_H1_H2(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H1_TO_H2_WR_EN), 
                .RD_EN_CH_A(H1_TO_H2_RD_EN),  
                .ADDR_CH_A(H1_TO_H2_ADDR), 
                .WDATA_CH_A(H1_TO_H2_WDATA), 
                .RDATA_CH_A(H1_TO_H2_RDATA), 

                .WR_EN_CH_B(H2_TO_H1_WR_EN), 
                .RD_EN_CH_B(H2_TO_H1_RD_EN),  
                .ADDR_CH_B(H2_TO_H1_ADDR), 
                .WDATA_CH_B(H2_TO_H1_WDATA), 
                .RDATA_CH_B(H2_TO_H1_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H1_H2),
                .MB_ACCESS_EN(MB_ACCESS_EN_H1_H2),
                .MB_RB_RD_EN(MB_RB_RD_EN_H1_H2),
                .MB_WR_EN(MB_WR_EN_H1_H2),
                .MP_IRQ(MP_IRQ_H1_H2),
                .MP_ACK(MP_ACK_H1_H2));
        end
    else
        begin: ngen_h1_h2
            assign H1_TO_H2_RDATA = 'b0;
            assign H2_TO_H1_RDATA = 'b0;
            assign MP_IRQ_H1_H2 = 'b0;
            assign MP_ACK_H1_H2 = 'b0; 
            assign MB_ACCESS_EN_H1_H2 = 'b0;
            assign MB_WR_EN_H1_H2 = 'b0; 
            assign MB_A_ACTIVE_H1_H2 = 'b0;
            assign MB_RB_RD_EN_H1_H2 = 'b0;
        end
endgenerate    

// Channel H1 <-> H3
generate 
    if (H1_TO_H3_CH_EN)    
        begin: gen_h1_h3
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H1_TO_H3_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H1_TO_H3_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd1),
                .B_DEBUG_ID(8'd3),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H1_H3(
                .clk(CLK),
                .resetn(RESETN),

                .WR_EN_CH_A(H1_TO_H3_WR_EN), 
                .RD_EN_CH_A(H1_TO_H3_RD_EN),  
                .ADDR_CH_A(H1_TO_H3_ADDR), 
                .WDATA_CH_A(H1_TO_H3_WDATA), 
                .RDATA_CH_A(H1_TO_H3_RDATA), 

                .WR_EN_CH_B(H3_TO_H1_WR_EN), 
                .RD_EN_CH_B(H3_TO_H1_RD_EN),  
                .ADDR_CH_B(H3_TO_H1_ADDR), 
                .WDATA_CH_B(H3_TO_H1_WDATA), 
                .RDATA_CH_B(H3_TO_H1_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H1_H3),
                .MB_ACCESS_EN(MB_ACCESS_EN_H1_H3),
                .MB_RB_RD_EN(MB_RB_RD_EN_H1_H3),
                .MB_WR_EN(MB_WR_EN_H1_H3),
                .MP_IRQ(MP_IRQ_H1_H3),
                .MP_ACK(MP_ACK_H1_H3));
        end
    else
        begin: ngen_h1_h3
            assign H1_TO_H3_RDATA = 'b0;
            assign H3_TO_H1_RDATA = 'b0;
            assign MP_IRQ_H1_H3 = 'b0;
            assign MP_ACK_H1_H3 = 'b0;
            assign MB_ACCESS_EN_H1_H3 = 'b0;
            assign MB_WR_EN_H1_H3 = 'b0; 
            assign MB_A_ACTIVE_H1_H3 = 'b0;
            assign MB_RB_RD_EN_H1_H3 = 'b0;
        end
endgenerate
    
// Channel H1 <-> H4
generate 
    if (H1_TO_H4_CH_EN)    
        begin: gen_h1_h4
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H1_TO_H4_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H1_TO_H4_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd1),
                .B_DEBUG_ID(8'd4),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H1_H4(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H1_TO_H4_WR_EN), 
                .RD_EN_CH_A(H1_TO_H4_RD_EN),  
                .ADDR_CH_A(H1_TO_H4_ADDR), 
                .WDATA_CH_A(H1_TO_H4_WDATA), 
                .RDATA_CH_A(H1_TO_H4_RDATA), 

                .WR_EN_CH_B(H4_TO_H1_WR_EN), 
                .RD_EN_CH_B(H4_TO_H1_RD_EN),  
                .ADDR_CH_B(H4_TO_H1_ADDR), 
                .WDATA_CH_B(H4_TO_H1_WDATA), 
                .RDATA_CH_B(H4_TO_H1_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H1_H4),
                .MB_ACCESS_EN(MB_ACCESS_EN_H1_H4),
                .MB_RB_RD_EN(MB_RB_RD_EN_H1_H4),
                .MB_WR_EN(MB_WR_EN_H1_H4),
                .MP_IRQ(MP_IRQ_H1_H4),
                .MP_ACK(MP_ACK_H1_H4));
        end
    else
        begin: ngen_h1_h4
            assign H1_TO_H4_RDATA = 'b0;
            assign H4_TO_H1_RDATA = 'b0;
            assign MP_IRQ_H1_H4 = 'b0;
            assign MP_ACK_H1_H4 = 'b0;
            assign MB_ACCESS_EN_H1_H4 = 'b0;
            assign MB_WR_EN_H1_H4 = 'b0; 
            assign MB_A_ACTIVE_H1_H4 = 'b0;
            assign MB_RB_RD_EN_H1_H4 = 'b0;
        end
endgenerate

// Channel H1 <-> H5
generate 
    if (H1_TO_H5_CH_EN)    
        begin: gen_h1_h5
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H1_TO_H5_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H1_TO_H5_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd1),
                .B_DEBUG_ID(8'd5),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H1_H5(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H1_TO_H5_WR_EN), 
                .RD_EN_CH_A(H1_TO_H5_RD_EN),  
                .ADDR_CH_A(H1_TO_H5_ADDR), 
                .WDATA_CH_A(H1_TO_H5_WDATA), 
                .RDATA_CH_A(H1_TO_H5_RDATA), 

                .WR_EN_CH_B(H5_TO_H1_WR_EN), 
                .RD_EN_CH_B(H5_TO_H1_RD_EN),  
                .ADDR_CH_B(H5_TO_H1_ADDR), 
                .WDATA_CH_B(H5_TO_H1_WDATA), 
                .RDATA_CH_B(H5_TO_H1_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H1_H5),
                .MB_ACCESS_EN(MB_ACCESS_EN_H1_H5),
                .MB_RB_RD_EN(MB_RB_RD_EN_H1_H5),
                .MB_WR_EN(MB_WR_EN_H1_H5),
                .MP_IRQ(MP_IRQ_H1_H5),
                .MP_ACK(MP_ACK_H1_H5));
        end
    else
        begin: ngen_h1_h5
            assign H1_TO_H5_RDATA = 'b0;
            assign H5_TO_H1_RDATA = 'b0;
            assign MP_IRQ_H1_H5 = 'b0;
            assign MP_ACK_H1_H5 = 'b0;
            assign MB_ACCESS_EN_H1_H5 = 'b0;
            assign MB_WR_EN_H1_H5 = 'b0; 
            assign MB_A_ACTIVE_H1_H5 = 'b0;
            assign MB_RB_RD_EN_H1_H5 = 'b0;
        end
endgenerate

// Channel H2 <-> H3
generate
    if (H2_TO_H3_CH_EN)
        begin: gen_h2_h3    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H2_TO_H3_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H2_TO_H3_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd2),
                .B_DEBUG_ID(8'd3),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H2_H3(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H2_TO_H3_WR_EN), 
                .RD_EN_CH_A(H2_TO_H3_RD_EN),  
                .ADDR_CH_A(H2_TO_H3_ADDR), 
                .WDATA_CH_A(H2_TO_H3_WDATA), 
                .RDATA_CH_A(H2_TO_H3_RDATA), 

                .WR_EN_CH_B(H3_TO_H2_WR_EN), 
                .RD_EN_CH_B(H3_TO_H2_RD_EN),  
                .ADDR_CH_B(H3_TO_H2_ADDR), 
                .WDATA_CH_B(H3_TO_H2_WDATA), 
                .RDATA_CH_B(H3_TO_H2_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H2_H3),
                .MB_ACCESS_EN(MB_ACCESS_EN_H2_H3),
                .MB_RB_RD_EN(MB_RB_RD_EN_H2_H3),
                .MB_WR_EN(MB_WR_EN_H2_H3),
                .MP_IRQ(MP_IRQ_H2_H3),
                .MP_ACK(MP_ACK_H2_H3));
        end
    else
        begin: ngen_h2_h3
            assign H2_TO_H3_RDATA = 'b0;
            assign H3_TO_H2_RDATA = 'b0;
            assign MP_IRQ_H2_H3 = 'b0;
            assign MP_ACK_H2_H3 = 'b0; 
            assign MB_ACCESS_EN_H2_H3 = 'b0;
            assign MB_WR_EN_H2_H3 = 'b0;
            assign MB_A_ACTIVE_H2_H3 = 'b0;
            assign MB_RB_RD_EN_H2_H3 = 'b0;
        end
endgenerate

// Channel H2 <-> H4
generate
    if (H2_TO_H4_CH_EN)
        begin: gen_h2_h4
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H2_TO_H4_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H2_TO_H4_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd2),
                .B_DEBUG_ID(8'd4),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H2_H4(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H2_TO_H4_WR_EN), 
                .RD_EN_CH_A(H2_TO_H4_RD_EN),  
                .ADDR_CH_A(H2_TO_H4_ADDR), 
                .WDATA_CH_A(H2_TO_H4_WDATA), 
                .RDATA_CH_A(H2_TO_H4_RDATA), 

                .WR_EN_CH_B(H4_TO_H2_WR_EN), 
                .RD_EN_CH_B(H4_TO_H2_RD_EN),  
                .ADDR_CH_B(H4_TO_H2_ADDR), 
                .WDATA_CH_B(H4_TO_H2_WDATA), 
                .RDATA_CH_B(H4_TO_H2_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H2_H4),
                .MB_ACCESS_EN(MB_ACCESS_EN_H2_H4),
                .MB_RB_RD_EN(MB_RB_RD_EN_H2_H4),
                .MB_WR_EN(MB_WR_EN_H2_H4),
                .MP_IRQ(MP_IRQ_H2_H4),
                .MP_ACK(MP_ACK_H2_H4));
        end
    else
        begin: ngen_h2_h4
            assign H2_TO_H4_RDATA = 'b0;
            assign H4_TO_H2_RDATA = 'b0;
            assign MP_IRQ_H2_H4 = 'b0;
            assign MP_ACK_H2_H4 = 'b0;
            assign MB_ACCESS_EN_H2_H4 = 'b0;
            assign MB_WR_EN_H2_H4 = 'b0; 
            assign MB_A_ACTIVE_H2_H4 = 'b0;
            assign MB_RB_RD_EN_H2_H4 = 'b0;
        end
endgenerate

// Channel H2 <-> H5
generate
    if (H2_TO_H5_CH_EN)
        begin: gen_h2_h5
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H2_TO_H5_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H2_TO_H5_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd2),
                .B_DEBUG_ID(8'd5),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H2_H5(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H2_TO_H5_WR_EN), 
                .RD_EN_CH_A(H2_TO_H5_RD_EN),  
                .ADDR_CH_A(H2_TO_H5_ADDR), 
                .WDATA_CH_A(H2_TO_H5_WDATA), 
                .RDATA_CH_A(H2_TO_H5_RDATA), 

                .WR_EN_CH_B(H5_TO_H2_WR_EN), 
                .RD_EN_CH_B(H5_TO_H2_RD_EN),  
                .ADDR_CH_B(H5_TO_H2_ADDR), 
                .WDATA_CH_B(H5_TO_H2_WDATA), 
                .RDATA_CH_B(H5_TO_H2_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H2_H5),
                .MB_ACCESS_EN(MB_ACCESS_EN_H2_H5),
                .MB_RB_RD_EN(MB_RB_RD_EN_H2_H5),
                .MB_WR_EN(MB_WR_EN_H2_H5),
                .MP_IRQ(MP_IRQ_H2_H5),
                .MP_ACK(MP_ACK_H2_H5));
        end
    else
        begin: ngen_h2_h5
            assign H2_TO_H5_RDATA = 'b0;
            assign H5_TO_H2_RDATA = 'b0;
            assign MP_IRQ_H2_H5 = 'b0;
            assign MP_ACK_H2_H5 = 'b0;
            assign MB_ACCESS_EN_H2_H5 = 'b0;
            assign MB_WR_EN_H2_H5 = 'b0; 
            assign MB_A_ACTIVE_H2_H5 = 'b0;
            assign MB_RB_RD_EN_H2_H5 = 'b0;
        end
endgenerate

// Channel H3 <-> H4
generate 
    if (H3_TO_H4_CH_EN)
        begin: gen_h3_h4    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H3_TO_H4_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H3_TO_H4_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd3),
                .B_DEBUG_ID(8'd4),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H3_H4(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H3_TO_H4_WR_EN), 
                .RD_EN_CH_A(H3_TO_H4_RD_EN),  
                .ADDR_CH_A(H3_TO_H4_ADDR), 
                .WDATA_CH_A(H3_TO_H4_WDATA), 
                .RDATA_CH_A(H3_TO_H4_RDATA), 

                .WR_EN_CH_B(H4_TO_H3_WR_EN), 
                .RD_EN_CH_B(H4_TO_H3_RD_EN),  
                .ADDR_CH_B(H4_TO_H3_ADDR), 
                .WDATA_CH_B(H4_TO_H3_WDATA), 
                .RDATA_CH_B(H4_TO_H3_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H3_H4),
                .MB_ACCESS_EN(MB_ACCESS_EN_H3_H4),
                .MB_RB_RD_EN(MB_RB_RD_EN_H3_H4),
                .MB_WR_EN(MB_WR_EN_H3_H4),
                .MP_IRQ(MP_IRQ_H3_H4),
                .MP_ACK(MP_ACK_H3_H4));    
        end
    else
        begin: ngen_h3_h4
            assign H3_TO_H4_RDATA = 'b0;
            assign H4_TO_H3_RDATA = 'b0;
            assign MP_IRQ_H3_H4 = 'b0;
            assign MP_ACK_H3_H4 = 'b0;  
            assign MB_ACCESS_EN_H3_H4 = 'b0;
            assign MB_WR_EN_H3_H4 = 'b0;
            assign MB_A_ACTIVE_H3_H4 = 'b0;
            assign MB_RB_RD_EN_H3_H4 = 'b0;
        end
endgenerate

// Channel H3 <-> H5
generate 
    if (H3_TO_H5_CH_EN)
        begin: gen_h3_h5    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H3_TO_H5_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H3_TO_H5_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd3),
                .B_DEBUG_ID(8'd5),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H3_H5(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H3_TO_H5_WR_EN), 
                .RD_EN_CH_A(H3_TO_H5_RD_EN),  
                .ADDR_CH_A(H3_TO_H5_ADDR), 
                .WDATA_CH_A(H3_TO_H5_WDATA), 
                .RDATA_CH_A(H3_TO_H5_RDATA), 

                .WR_EN_CH_B(H5_TO_H3_WR_EN), 
                .RD_EN_CH_B(H5_TO_H3_RD_EN),  
                .ADDR_CH_B(H5_TO_H3_ADDR), 
                .WDATA_CH_B(H5_TO_H3_WDATA), 
                .RDATA_CH_B(H5_TO_H3_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H3_H5),
                .MB_ACCESS_EN(MB_ACCESS_EN_H3_H5),
                .MB_RB_RD_EN(MB_RB_RD_EN_H3_H5),
                .MB_WR_EN(MB_WR_EN_H3_H5),
                .MP_IRQ(MP_IRQ_H3_H5),
                .MP_ACK(MP_ACK_H3_H5));    
        end
    else
        begin: ngen_h3_h5
            assign H3_TO_H5_RDATA = 'b0;
            assign H5_TO_H3_RDATA = 'b0;
            assign MP_IRQ_H3_H5 = 'b0;
            assign MP_ACK_H3_H5 = 'b0;
            assign MB_ACCESS_EN_H3_H5 = 'b0;
            assign MB_WR_EN_H3_H5 = 'b0; 
            assign MB_A_ACTIVE_H3_H5 = 'b0;
            assign MB_RB_RD_EN_H3_H5 = 'b0;
        end
endgenerate

// Channel H4 <-> H5
generate 
    if (H4_TO_H5_CH_EN)
        begin: gen_h4_h5    
            miv_ihc_channel #(
                .SYNC_RESET(SYNC_RESET),
                .A_MEMORY_DEPTH_N(H4_TO_H5_A_MEMORY_DEPTH_N), 
                .B_MEMORY_DEPTH_M(H4_TO_H5_B_MEMORY_DEPTH_M),
                .A_DEBUG_ID(8'd4),
                .B_DEBUG_ID(8'd5),
                .DATA_WIDTH(DATA_WIDTH),
                .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH)     
                )
                CH_H4_H5(
                .clk(CLK),
                .resetn(RESETN), 

                .WR_EN_CH_A(H4_TO_H5_WR_EN), 
                .RD_EN_CH_A(H4_TO_H5_RD_EN),  
                .ADDR_CH_A(H4_TO_H5_ADDR), 
                .WDATA_CH_A(H4_TO_H5_WDATA), 
                .RDATA_CH_A(H4_TO_H5_RDATA), 

                .WR_EN_CH_B(H5_TO_H4_WR_EN), 
                .RD_EN_CH_B(H5_TO_H4_RD_EN),  
                .ADDR_CH_B(H5_TO_H4_ADDR), 
                .WDATA_CH_B(H5_TO_H4_WDATA), 
                .RDATA_CH_B(H5_TO_H4_RDATA), 

                .MB_RDATA(COMMON_MB_RAM_DOUT),
                .MB_A_ACTIVE(MB_A_ACTIVE_H4_H5),
                .MB_ACCESS_EN(MB_ACCESS_EN_H4_H5),
                .MB_RB_RD_EN(MB_RB_RD_EN_H4_H5),
                .MB_WR_EN(MB_WR_EN_H4_H5),
                .MP_IRQ(MP_IRQ_H4_H5),
                .MP_ACK(MP_ACK_H4_H5));    
        end
    else
        begin: ngen_h4_h5
            assign H4_TO_H5_RDATA = 'b0;
            assign H5_TO_H4_RDATA = 'b0;
            assign MP_IRQ_H4_H5 = 'b0;
            assign MP_ACK_H4_H5 = 'b0; 
            assign MB_ACCESS_EN_H4_H5 = 'b0;
            assign MB_WR_EN_H4_H5 = 'b0;
            assign MB_A_ACTIVE_H4_H5 = 'b0;
            assign MB_RB_RD_EN_H4_H5 = 'b0;
        end
endgenerate

// IHCC Common Memory for mailboxes
miv_ihc_ram_singleport_addreg #(
    .RAM_DEPTH(BUFF_RAM_DEPTH),
    .ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
    ) 
    common_mailbox_ram (
    .clk(CLK),
    .wr(COMMON_MB_RAM_WR),
    .addr(COMMON_MB_ADDR_OUT),
    .din(WDATA),
    .dout(COMMON_MB_RAM_DOUT)
);

// Select relevant IHC Mailbox signals that receive access to the common ram
miv_ihc_mailbox_address_decoder #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .MB_ADDR_WIDTH(BUFF_RAM_ADDR_WIDTH),
    .A_BUF_PTR_H0_TO_H1(A_BUF_PTR_H0_TO_H1),
    .B_BUF_PTR_H0_TO_H1(B_BUF_PTR_H0_TO_H1),
    .A_BUF_PTR_H0_TO_H2(A_BUF_PTR_H0_TO_H2),
    .B_BUF_PTR_H0_TO_H2(B_BUF_PTR_H0_TO_H2),
    .A_BUF_PTR_H0_TO_H3(A_BUF_PTR_H0_TO_H3),
    .B_BUF_PTR_H0_TO_H3(B_BUF_PTR_H0_TO_H3),
    .A_BUF_PTR_H0_TO_H4(A_BUF_PTR_H0_TO_H4),
    .B_BUF_PTR_H0_TO_H4(B_BUF_PTR_H0_TO_H4),
    .A_BUF_PTR_H0_TO_H5(A_BUF_PTR_H0_TO_H5),
    .B_BUF_PTR_H0_TO_H5(B_BUF_PTR_H0_TO_H5),
    .A_BUF_PTR_H1_TO_H2(A_BUF_PTR_H1_TO_H2),
    .B_BUF_PTR_H1_TO_H2(B_BUF_PTR_H1_TO_H2),
    .A_BUF_PTR_H1_TO_H3(A_BUF_PTR_H1_TO_H3),
    .B_BUF_PTR_H1_TO_H3(B_BUF_PTR_H1_TO_H3),
    .A_BUF_PTR_H1_TO_H4(A_BUF_PTR_H1_TO_H4),
    .B_BUF_PTR_H1_TO_H4(B_BUF_PTR_H1_TO_H4),
    .A_BUF_PTR_H1_TO_H5(A_BUF_PTR_H1_TO_H5),
    .B_BUF_PTR_H1_TO_H5(B_BUF_PTR_H1_TO_H5),
    .A_BUF_PTR_H2_TO_H3(A_BUF_PTR_H2_TO_H3),
    .B_BUF_PTR_H2_TO_H3(B_BUF_PTR_H2_TO_H3),
    .A_BUF_PTR_H2_TO_H4(A_BUF_PTR_H2_TO_H4),
    .B_BUF_PTR_H2_TO_H4(B_BUF_PTR_H2_TO_H4),
    .A_BUF_PTR_H2_TO_H5(A_BUF_PTR_H2_TO_H5),
    .B_BUF_PTR_H2_TO_H5(B_BUF_PTR_H2_TO_H5),
    .A_BUF_PTR_H3_TO_H4(A_BUF_PTR_H3_TO_H4),
    .B_BUF_PTR_H3_TO_H4(B_BUF_PTR_H3_TO_H4),
    .A_BUF_PTR_H3_TO_H5(A_BUF_PTR_H3_TO_H5),
    .B_BUF_PTR_H3_TO_H5(B_BUF_PTR_H3_TO_H5),
    .A_BUF_PTR_H4_TO_H5(A_BUF_PTR_H4_TO_H5),
    .B_BUF_PTR_H4_TO_H5(B_BUF_PTR_H4_TO_H5)
    )
    mb_addr_decoder (
    // ihcc channel signals inputs/outputs
    .ADDR_IN(ADDR[7:0]),
    .MB_ACCESS_EN_ARR(MB_ACCESS_EN_ARR),
    .MB_WR_EN(COMMON_MB_RAM_WR),
    .MB_A_ACTIVE(MB_A_ACTIVE),
    .MB_RB_RD_EN(MB_RB_RD_EN),
    
    // common ram input/output signals
    .COMMON_MB_ADDR_OUT(COMMON_MB_ADDR_OUT)
);

// Logic to figure out the Message Present and Acknowledge into each Interrupt controller.
wire [5:0] H0_MSG_PRESENT_IRQ; 
wire [5:0] H1_MSG_PRESENT_IRQ;
wire [5:0] H2_MSG_PRESENT_IRQ;
wire [5:0] H3_MSG_PRESENT_IRQ;
wire [5:0] H4_MSG_PRESENT_IRQ;
wire [5:0] H5_MSG_PRESENT_IRQ;

wire [5:0] H0_CH_ACK_IRQ;
wire [5:0] H1_CH_ACK_IRQ;
wire [5:0] H2_CH_ACK_IRQ;
wire [5:0] H3_CH_ACK_IRQ;
wire [5:0] H4_CH_ACK_IRQ;
wire [5:0] H5_CH_ACK_IRQ;

assign H0_MSG_PRESENT_IRQ = {MP_IRQ_H0_H5[0], MP_IRQ_H0_H4[0], MP_IRQ_H0_H3[0], MP_IRQ_H0_H2[0], MP_IRQ_H0_H1[0], 1'b0};
assign H0_CH_ACK_IRQ = {MP_ACK_H0_H5[0], MP_ACK_H0_H4[0], MP_ACK_H0_H3[0], MP_ACK_H0_H2[0], MP_ACK_H0_H1[0], 1'b0};

assign H1_MSG_PRESENT_IRQ = {MP_IRQ_H1_H5[0], MP_IRQ_H1_H4[0], MP_IRQ_H1_H3[0], MP_IRQ_H1_H2[0],1'b0, MP_IRQ_H0_H1[1]};
assign H1_CH_ACK_IRQ = {MP_ACK_H1_H5[0], MP_ACK_H1_H4[0], MP_ACK_H1_H3[0], MP_ACK_H1_H2[0], 1'b0, MP_ACK_H0_H1[1]};

assign H2_MSG_PRESENT_IRQ = {MP_IRQ_H2_H5[0], MP_IRQ_H2_H4[0], MP_IRQ_H2_H3[0], 1'b0, MP_IRQ_H1_H2[1], MP_IRQ_H0_H2[1]};
assign H2_CH_ACK_IRQ = {MP_ACK_H2_H5[0], MP_ACK_H2_H4[0], MP_ACK_H2_H3[0], 1'b0, MP_ACK_H1_H2[1], MP_ACK_H0_H2[1]};

assign H3_MSG_PRESENT_IRQ = {MP_IRQ_H3_H5[0], MP_IRQ_H3_H4[0], 1'b0, MP_IRQ_H2_H3[1], MP_IRQ_H1_H3[1], MP_IRQ_H0_H3[1]};
assign H3_CH_ACK_IRQ = {MP_ACK_H3_H5[0], MP_ACK_H3_H4[0], 1'b0, MP_ACK_H2_H3[1], MP_ACK_H1_H3[1], MP_ACK_H0_H3[1]};

assign H4_MSG_PRESENT_IRQ = {MP_IRQ_H4_H5[0], 1'b0, MP_IRQ_H3_H4[1], MP_IRQ_H2_H4[1], MP_IRQ_H1_H4[1], MP_IRQ_H0_H4[1]};
assign H4_CH_ACK_IRQ = {MP_ACK_H4_H5[0], 1'b0, MP_ACK_H3_H4[1], MP_ACK_H2_H4[1], MP_ACK_H1_H4[1], MP_ACK_H0_H4[1]};

assign H5_MSG_PRESENT_IRQ = {1'b0, MP_IRQ_H4_H5[1], MP_IRQ_H3_H5[1], MP_IRQ_H2_H5[1], MP_IRQ_H1_H5[1], MP_IRQ_H0_H5[1]};
assign H5_CH_ACK_IRQ = {1'b0, MP_ACK_H4_H5[1], MP_ACK_H3_H5[1], MP_ACK_H2_H5[1], MP_ACK_H1_H5[1], MP_ACK_H0_H5[1]};

// Hart0 Interrupt Controller
generate 
    if (H0_IHCIM_EN)
        begin: gen_intr_module_h0
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h0_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H0_IRQ_MODULE_WR_EN), 
                .RD_EN(H0_IRQ_MODULE_RD_EN),  
                .ADDR(H0_IRQ_MODULE_ADDR), 
                .WDATA(H0_IRQ_MODULE_WDATA), 
                .RDATA(H0_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H0_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H0_CH_ACK_IRQ),
                .mon_irq(H0_MON_IRQ),
                .app_irq(H0_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h0
            assign H0_IRQ_MODULE_RDATA   = 'b0;
            assign H0_MON_IRQ      = 'b0;
            assign H0_APP_IRQ           = 'b0; 
        end
endgenerate

// Hart1 Interrupt Controller
generate 
    if (H1_IHCIM_EN)
        begin: gen_intr_module_h1
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h1_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H1_IRQ_MODULE_WR_EN), 
                .RD_EN(H1_IRQ_MODULE_RD_EN),  
                .ADDR(H1_IRQ_MODULE_ADDR), 
                .WDATA(H1_IRQ_MODULE_WDATA), 
                .RDATA(H1_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H1_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H1_CH_ACK_IRQ),
                .mon_irq(H1_MON_IRQ),
                .app_irq(H1_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h1
            assign H1_IRQ_MODULE_RDATA    = 'b0;
            assign H1_MON_IRQ       = 'b0;
            assign H1_APP_IRQ            = 'b0; 
        end
endgenerate

// Hart2 Interrupt Controller
generate 
    if (H2_IHCIM_EN)
        begin: gen_intr_module_h2
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h2_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H2_IRQ_MODULE_WR_EN), 
                .RD_EN(H2_IRQ_MODULE_RD_EN),  
                .ADDR(H2_IRQ_MODULE_ADDR), 
                .WDATA(H2_IRQ_MODULE_WDATA), 
                .RDATA(H2_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H2_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H2_CH_ACK_IRQ),
                .mon_irq(H2_MON_IRQ),
                .app_irq(H2_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h2
            assign H2_IRQ_MODULE_RDATA  = 'b0;
            assign H2_MON_IRQ     = 'b0;
            assign H2_APP_IRQ          = 'b0; 
        end
endgenerate

// Hart3 Interrupt Controller
generate 
    if (H3_IHCIM_EN)
        begin: gen_intr_module_h3
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h3_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H3_IRQ_MODULE_WR_EN), 
                .RD_EN(H3_IRQ_MODULE_RD_EN),  
                .ADDR(H3_IRQ_MODULE_ADDR), 
                .WDATA(H3_IRQ_MODULE_WDATA), 
                .RDATA(H3_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H3_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H3_CH_ACK_IRQ),
                .mon_irq(H3_MON_IRQ),
                .app_irq(H3_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h3
            assign H3_IRQ_MODULE_RDATA  = 'b0;
            assign H3_MON_IRQ     = 'b0;
            assign H3_APP_IRQ          = 'b0; 
        end
endgenerate

// Hart4 Interrupt Controller
generate 
    if (H4_IHCIM_EN)
        begin: gen_intr_module_h4
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h4_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H4_IRQ_MODULE_WR_EN), 
                .RD_EN(H4_IRQ_MODULE_RD_EN),  
                .ADDR(H4_IRQ_MODULE_ADDR), 
                .WDATA(H4_IRQ_MODULE_WDATA), 
                .RDATA(H4_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H4_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H4_CH_ACK_IRQ),
                .mon_irq(H4_MON_IRQ),
                .app_irq(H4_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h4
            assign H4_IRQ_MODULE_RDATA  = 'b0;
            assign H4_MON_IRQ     = 'b0;
            assign H4_APP_IRQ          = 'b0; 
        end
endgenerate

// Hart5 Interrupt Controller
generate 
    if (H5_IHCIM_EN)
        begin: gen_intr_module_h5
            miv_ihc_interrupt_module #(
                .SYNC_RESET(SYNC_RESET)
            )
            h5_irq_module (
                .clk(CLK),
                .resetn(RESETN),
                .WR_EN(H5_IRQ_MODULE_WR_EN), 
                .RD_EN(H5_IRQ_MODULE_RD_EN),  
                .ADDR(H5_IRQ_MODULE_ADDR), 
                .WDATA(H5_IRQ_MODULE_WDATA), 
                .RDATA(H5_IRQ_MODULE_RDATA), 
                .CH_MSG_PRESENT_IRQ(H5_MSG_PRESENT_IRQ),
                .CH_ACK_IRQ(H5_CH_ACK_IRQ),
                .mon_irq(H5_MON_IRQ),
                .app_irq(H5_APP_IRQ)
            );
        end
    else
        begin: ngen_intr_module_h5
            assign H5_IRQ_MODULE_RDATA  = 'b0;
            assign H5_MON_IRQ     = 'b0;
            assign H5_APP_IRQ          = 'b0; 
        end
endgenerate

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_arbiter_top (
  // Inputs
	APB_PCLK,
	APB_PRESETN,
	APB_INITIATOR_0_PSEL,
	APB_INITIATOR_0_PENABLE,
	APB_INITIATOR_0_PWRITE,
	APB_INITIATOR_1_PSEL,
	APB_INITIATOR_1_PENABLE,
	APB_INITIATOR_1_PWRITE,
	APB_INITIATOR_2_PSEL,
	APB_INITIATOR_2_PENABLE,
	APB_INITIATOR_2_PWRITE,
	APB_TARGET_0_PREADY,
	APB_TARGET_0_PSLVERR,
	APB_TARGET_0_PRDATA,
	APB_INITIATOR_0_PADDR,
	APB_INITIATOR_0_PWDATA,
	APB_INITIATOR_1_PADDR,
	APB_INITIATOR_1_PWDATA,
	APB_INITIATOR_2_PADDR,
	APB_INITIATOR_2_PWDATA,
	// Outputs
	APB_INITIATOR_0_PREADY,
	APB_INITIATOR_0_PSLVERR,
	APB_INITIATOR_0_PRDATA,
	APB_INITIATOR_1_PREADY,
	APB_INITIATOR_1_PSLVERR,
	APB_INITIATOR_1_PRDATA,
	APB_INITIATOR_2_PREADY,
	APB_INITIATOR_2_PSLVERR,
	APB_INITIATOR_2_PRDATA,
	APB_TARGET_0_PSEL,
	APB_TARGET_0_PENABLE,
	APB_TARGET_0_PWRITE,
	APB_TARGET_0_PADDR,
	APB_TARGET_0_PWDATA
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
parameter SYNC_RESET = 0;
parameter IF_0_EN = 0;
parameter IF_1_EN = 0;
parameter IF_2_EN = 0;

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input wire logic          APB_PCLK;
input wire logic	        APB_PRESETN;
input wire logic	        APB_INITIATOR_0_PSEL;
input wire logic          APB_INITIATOR_0_PENABLE;
input wire logic          APB_INITIATOR_0_PWRITE;
input wire logic          APB_INITIATOR_1_PSEL;
input wire logic          APB_INITIATOR_1_PENABLE;
input wire logic          APB_INITIATOR_1_PWRITE;
input wire logic          APB_INITIATOR_2_PSEL;
input wire logic          APB_INITIATOR_2_PENABLE;
input wire logic	        APB_INITIATOR_2_PWRITE;
input wire logic          APB_TARGET_0_PREADY;
input wire logic	        APB_TARGET_0_PSLVERR;
input wire logic [31:0]   APB_TARGET_0_PRDATA;
input wire logic [31:0]   APB_INITIATOR_0_PADDR;
input wire logic [31:0]   APB_INITIATOR_0_PWDATA;
input wire logic [31:0]   APB_INITIATOR_1_PADDR;
input wire logic [31:0]   APB_INITIATOR_1_PWDATA;
input wire logic [31:0]   APB_INITIATOR_2_PADDR;
input wire logic [31:0]   APB_INITIATOR_2_PWDATA;

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output logic         APB_INITIATOR_0_PREADY;
output logic         APB_INITIATOR_0_PSLVERR;
output logic [31:0]  APB_INITIATOR_0_PRDATA;
output logic         APB_INITIATOR_1_PREADY;
output logic         APB_INITIATOR_1_PSLVERR;
output logic [31:0]  APB_INITIATOR_1_PRDATA;
output logic         APB_INITIATOR_2_PREADY;
output logic         APB_INITIATOR_2_PSLVERR;
output logic [31:0]  APB_INITIATOR_2_PRDATA;
output logic         APB_TARGET_0_PSEL;
output logic         APB_TARGET_0_PENABLE;
output logic         APB_TARGET_0_PWRITE;
output logic [31:0]  APB_TARGET_0_PADDR;
output logic [31:0]  APB_TARGET_0_PWDATA;

//--------------------------------------------------------------------
// Internal Signals
//--------------------------------------------------------------------
// Arbiter Initiator 0 Interface
wire    [31:0] ARBITER_INITIATOR_0_PADDR;   
wire           ARBITER_INITIATOR_0_PSEL;     
wire           ARBITER_INITIATOR_0_PENABLE;  
wire           ARBITER_INITIATOR_0_PWRITE;   
wire    [31:0] ARBITER_INITIATOR_0_PWDATA;  
wire    [31:0] ARBITER_INITIATOR_0_PRDATA;    
wire           ARBITER_INITIATOR_0_PREADY;
wire           ARBITER_INITIATOR_0_PSLVERR;

// Arbiter Initiator 1 Interface
wire    [31:0] ARBITER_INITIATOR_1_PADDR;   
wire           ARBITER_INITIATOR_1_PSEL;     
wire           ARBITER_INITIATOR_1_PENABLE;  
wire           ARBITER_INITIATOR_1_PWRITE;   
wire    [31:0] ARBITER_INITIATOR_1_PWDATA;  
wire    [31:0] ARBITER_INITIATOR_1_PRDATA;    
wire           ARBITER_INITIATOR_1_PREADY;
wire           ARBITER_INITIATOR_1_PSLVERR;

// Arbiter Initiator 2 Interface
wire    [31:0] ARBITER_INITIATOR_2_PADDR;   
wire           ARBITER_INITIATOR_2_PSEL;     
wire           ARBITER_INITIATOR_2_PENABLE;  
wire           ARBITER_INITIATOR_2_PWRITE;   
wire    [31:0] ARBITER_INITIATOR_2_PWDATA;  
wire    [31:0] ARBITER_INITIATOR_2_PRDATA;    
wire           ARBITER_INITIATOR_2_PREADY;
wire           ARBITER_INITIATOR_2_PSLVERR;

//--------------------------------------------------------------------
// The interfaces are assigned to a round-robin arbiter
// with two ports, three ports or simply routed directly to the
// Core logic if there is only one Interface instantiated
//--------------------------------------------------------------------
generate 
    case ({IF_0_EN, IF_1_EN, IF_2_EN})
      3'b001  :  // the case where only I/F 2 is enabled
        begin: if2_connect
            assign APB_TARGET_0_PSEL    = APB_INITIATOR_2_PSEL;
            assign APB_TARGET_0_PENABLE = APB_INITIATOR_2_PENABLE;
            assign APB_TARGET_0_PWRITE  = APB_INITIATOR_2_PWRITE;
            assign APB_TARGET_0_PADDR   = APB_INITIATOR_2_PADDR;
            assign APB_TARGET_0_PWDATA  = APB_INITIATOR_2_PWDATA;
            assign APB_INITIATOR_2_PREADY  = APB_TARGET_0_PREADY;
            assign APB_INITIATOR_2_PSLVERR = APB_TARGET_0_PSLVERR;
            assign APB_INITIATOR_2_PRDATA  = APB_TARGET_0_PRDATA;

            assign APB_INITIATOR_0_PREADY  = 'b0;
            assign APB_INITIATOR_0_PSLVERR = 'b0;
            assign APB_INITIATOR_0_PRDATA  = 'b0;
            assign APB_INITIATOR_1_PREADY  = 'b0;
            assign APB_INITIATOR_1_PSLVERR = 'b0;
            assign APB_INITIATOR_1_PRDATA  = 'b0;
        end
      3'b010  :  // the case where only I/F 1 is enabled
        begin: if1_connect
            assign APB_TARGET_0_PSEL    = APB_INITIATOR_1_PSEL;
            assign APB_TARGET_0_PENABLE = APB_INITIATOR_1_PENABLE;
            assign APB_TARGET_0_PWRITE  = APB_INITIATOR_1_PWRITE;
            assign APB_TARGET_0_PADDR   = APB_INITIATOR_1_PADDR;
            assign APB_TARGET_0_PWDATA  = APB_INITIATOR_1_PWDATA;
            assign APB_INITIATOR_1_PREADY  = APB_TARGET_0_PREADY;
            assign APB_INITIATOR_1_PSLVERR = APB_TARGET_0_PSLVERR;
            assign APB_INITIATOR_1_PRDATA  = APB_TARGET_0_PRDATA;

            assign APB_INITIATOR_0_PREADY  = 'b0;
            assign APB_INITIATOR_0_PSLVERR = 'b0;
            assign APB_INITIATOR_0_PRDATA  = 'b0;
            assign APB_INITIATOR_2_PREADY  = 'b0;
            assign APB_INITIATOR_2_PSLVERR = 'b0;
            assign APB_INITIATOR_2_PRDATA  = 'b0;
        end
      3'b011  : // the case where I/F's 1 & 2 are enabled
        begin: if1_if2_connect
            assign ARBITER_INITIATOR_0_PSEL    = APB_INITIATOR_1_PSEL;
            assign ARBITER_INITIATOR_0_PENABLE = APB_INITIATOR_1_PENABLE;  
            assign ARBITER_INITIATOR_0_PWRITE  = APB_INITIATOR_1_PWRITE;
            assign ARBITER_INITIATOR_0_PADDR   = APB_INITIATOR_1_PADDR;
            assign ARBITER_INITIATOR_0_PWDATA  = APB_INITIATOR_1_PWDATA; 
            assign APB_INITIATOR_1_PRDATA      = ARBITER_INITIATOR_0_PRDATA;    
            assign APB_INITIATOR_1_PREADY      = ARBITER_INITIATOR_0_PREADY;
            assign APB_INITIATOR_1_PSLVERR     = ARBITER_INITIATOR_0_PSLVERR;

            assign ARBITER_INITIATOR_1_PSEL    = APB_INITIATOR_2_PSEL;     
            assign ARBITER_INITIATOR_1_PENABLE = APB_INITIATOR_2_PENABLE;  
            assign ARBITER_INITIATOR_1_PWRITE  = APB_INITIATOR_2_PWRITE;
            assign ARBITER_INITIATOR_1_PADDR   = APB_INITIATOR_2_PADDR;
            assign ARBITER_INITIATOR_1_PWDATA  = APB_INITIATOR_2_PWDATA;
            assign APB_INITIATOR_2_PRDATA      = ARBITER_INITIATOR_1_PRDATA;    
            assign APB_INITIATOR_2_PREADY      = ARBITER_INITIATOR_1_PREADY;
            assign APB_INITIATOR_2_PSLVERR     = ARBITER_INITIATOR_1_PSLVERR;

            assign APB_INITIATOR_0_PREADY  = 'b0;
            assign APB_INITIATOR_0_PSLVERR = 'b0;
            assign APB_INITIATOR_0_PRDATA  = 'b0;
        end
      3'b100  : // the case where only I/F 0 is enabled
        begin: if0_connect
            assign APB_TARGET_0_PSEL    = APB_INITIATOR_0_PSEL;
            assign APB_TARGET_0_PENABLE = APB_INITIATOR_0_PENABLE;
            assign APB_TARGET_0_PWRITE  = APB_INITIATOR_0_PWRITE;
            assign APB_TARGET_0_PADDR   = APB_INITIATOR_0_PADDR;
            assign APB_TARGET_0_PWDATA  = APB_INITIATOR_0_PWDATA;
            assign APB_INITIATOR_0_PREADY  = APB_TARGET_0_PREADY;
            assign APB_INITIATOR_0_PSLVERR = APB_TARGET_0_PSLVERR;
            assign APB_INITIATOR_0_PRDATA  = APB_TARGET_0_PRDATA;

            assign APB_INITIATOR_1_PREADY  = 'b0;
            assign APB_INITIATOR_1_PSLVERR = 'b0;
            assign APB_INITIATOR_1_PRDATA  = 'b0;
            assign APB_INITIATOR_2_PREADY  = 'b0;
            assign APB_INITIATOR_2_PSLVERR = 'b0;
            assign APB_INITIATOR_2_PRDATA  = 'b0;
        end
      3'b101  : // the case where I/F's 0 & 2 are enabled
        begin: if0_if2_connect
            assign ARBITER_INITIATOR_0_PSEL    = APB_INITIATOR_0_PSEL;     
            assign ARBITER_INITIATOR_0_PENABLE = APB_INITIATOR_0_PENABLE;  
            assign ARBITER_INITIATOR_0_PWRITE  = APB_INITIATOR_0_PWRITE;
            assign ARBITER_INITIATOR_0_PADDR   = APB_INITIATOR_0_PADDR;
            assign ARBITER_INITIATOR_0_PWDATA  = APB_INITIATOR_0_PWDATA; 
            assign APB_INITIATOR_0_PRDATA      = ARBITER_INITIATOR_0_PRDATA;    
            assign APB_INITIATOR_0_PREADY      = ARBITER_INITIATOR_0_PREADY;
            assign APB_INITIATOR_0_PSLVERR     = ARBITER_INITIATOR_0_PSLVERR;

            assign ARBITER_INITIATOR_1_PSEL    = APB_INITIATOR_2_PSEL;     
            assign ARBITER_INITIATOR_1_PENABLE = APB_INITIATOR_2_PENABLE;  
            assign ARBITER_INITIATOR_1_PWRITE  = APB_INITIATOR_2_PWRITE;
            assign ARBITER_INITIATOR_1_PADDR   = APB_INITIATOR_2_PADDR;
            assign ARBITER_INITIATOR_1_PWDATA  = APB_INITIATOR_2_PWDATA;
            assign APB_INITIATOR_2_PRDATA      = ARBITER_INITIATOR_1_PRDATA;    
            assign APB_INITIATOR_2_PREADY      = ARBITER_INITIATOR_1_PREADY;
            assign APB_INITIATOR_2_PSLVERR     = ARBITER_INITIATOR_1_PSLVERR;

            assign APB_INITIATOR_1_PREADY  = 'b0;
            assign APB_INITIATOR_1_PSLVERR = 'b0;
            assign APB_INITIATOR_1_PRDATA  = 'b0;
        end
      3'b110  : // the case where I/F's 0 & 1 are enabled
        begin: if0_if1_connect
            assign ARBITER_INITIATOR_0_PSEL    = APB_INITIATOR_0_PSEL;     
            assign ARBITER_INITIATOR_0_PENABLE = APB_INITIATOR_0_PENABLE;  
            assign ARBITER_INITIATOR_0_PWRITE  = APB_INITIATOR_0_PWRITE;
            assign ARBITER_INITIATOR_0_PADDR   = APB_INITIATOR_0_PADDR;
            assign ARBITER_INITIATOR_0_PWDATA  = APB_INITIATOR_0_PWDATA; 
            assign APB_INITIATOR_0_PRDATA      = ARBITER_INITIATOR_0_PRDATA;    
            assign APB_INITIATOR_0_PREADY      = ARBITER_INITIATOR_0_PREADY;
            assign APB_INITIATOR_0_PSLVERR     = ARBITER_INITIATOR_0_PSLVERR;

            assign ARBITER_INITIATOR_1_PSEL    = APB_INITIATOR_1_PSEL;     
            assign ARBITER_INITIATOR_1_PENABLE = APB_INITIATOR_1_PENABLE;  
            assign ARBITER_INITIATOR_1_PWRITE  = APB_INITIATOR_1_PWRITE;
            assign ARBITER_INITIATOR_1_PADDR   = APB_INITIATOR_1_PADDR;
            assign ARBITER_INITIATOR_1_PWDATA  = APB_INITIATOR_1_PWDATA;
            assign APB_INITIATOR_1_PRDATA      = ARBITER_INITIATOR_1_PRDATA;    
            assign APB_INITIATOR_1_PREADY      = ARBITER_INITIATOR_1_PREADY;
            assign APB_INITIATOR_1_PSLVERR     = ARBITER_INITIATOR_1_PSLVERR;

            assign APB_INITIATOR_2_PREADY  = 'b0;
            assign APB_INITIATOR_2_PSLVERR = 'b0;
            assign APB_INITIATOR_2_PRDATA  = 'b0;
        end
      3'b111  : 
        begin: all_if_connect
            assign ARBITER_INITIATOR_0_PSEL    = APB_INITIATOR_0_PSEL;     
            assign ARBITER_INITIATOR_0_PENABLE = APB_INITIATOR_0_PENABLE;  
            assign ARBITER_INITIATOR_0_PWRITE  = APB_INITIATOR_0_PWRITE;
            assign ARBITER_INITIATOR_0_PADDR   = APB_INITIATOR_0_PADDR;
            assign ARBITER_INITIATOR_0_PWDATA  = APB_INITIATOR_0_PWDATA; 
            assign APB_INITIATOR_0_PRDATA      = ARBITER_INITIATOR_0_PRDATA;    
            assign APB_INITIATOR_0_PREADY      = ARBITER_INITIATOR_0_PREADY;
            assign APB_INITIATOR_0_PSLVERR     = ARBITER_INITIATOR_0_PSLVERR;

            assign ARBITER_INITIATOR_1_PSEL    = APB_INITIATOR_1_PSEL;     
            assign ARBITER_INITIATOR_1_PENABLE = APB_INITIATOR_1_PENABLE;  
            assign ARBITER_INITIATOR_1_PWRITE  = APB_INITIATOR_1_PWRITE;
            assign ARBITER_INITIATOR_1_PADDR   = APB_INITIATOR_1_PADDR;
            assign ARBITER_INITIATOR_1_PWDATA  = APB_INITIATOR_1_PWDATA;
            assign APB_INITIATOR_1_PRDATA      = ARBITER_INITIATOR_1_PRDATA;    
            assign APB_INITIATOR_1_PREADY      = ARBITER_INITIATOR_1_PREADY;
            assign APB_INITIATOR_1_PSLVERR     = ARBITER_INITIATOR_1_PSLVERR;

            assign ARBITER_INITIATOR_2_PSEL    = APB_INITIATOR_2_PSEL;     
            assign ARBITER_INITIATOR_2_PENABLE = APB_INITIATOR_2_PENABLE;  
            assign ARBITER_INITIATOR_2_PWRITE  = APB_INITIATOR_2_PWRITE;
            assign ARBITER_INITIATOR_2_PADDR   = APB_INITIATOR_2_PADDR;
            assign ARBITER_INITIATOR_2_PWDATA  = APB_INITIATOR_2_PWDATA;
            assign APB_INITIATOR_2_PRDATA      = ARBITER_INITIATOR_2_PRDATA;    
            assign APB_INITIATOR_2_PREADY      = ARBITER_INITIATOR_2_PREADY;
            assign APB_INITIATOR_2_PSLVERR     = ARBITER_INITIATOR_2_PSLVERR;
        end
      default : // this case should never be triggered. At least 1 I/F should always be enabled
        begin: def_connect
            assign APB_INITIATOR_0_PREADY  = 'b0;
            assign APB_INITIATOR_0_PSLVERR = 'b0;
            assign APB_INITIATOR_0_PRDATA  = 'b0;
            assign APB_INITIATOR_1_PREADY  = 'b0;
            assign APB_INITIATOR_1_PSLVERR = 'b0;
            assign APB_INITIATOR_1_PRDATA  = 'b0;
            assign APB_INITIATOR_2_PREADY  = 'b0;
            assign APB_INITIATOR_2_PSLVERR = 'b0;
            assign APB_INITIATOR_2_PRDATA  = 'b0;
        end
    endcase
endgenerate

generate
    // only generate the apb arbiter with 2 ports if there are exactly two interfaces present
    if ( (!IF_0_EN && IF_1_EN && IF_2_EN) || (IF_0_EN && !IF_1_EN && IF_2_EN) || (IF_0_EN && IF_1_EN && !IF_2_EN) )
		begin: gen_arbtr_2
			miv_ihc_apb_arbiter_2 #(
      .SYNC_RESET(SYNC_RESET)
      )
      apb_arbiter_0 (
			// Inputs
			.APB_PCLK                ( APB_PCLK ),
			.APB_PRESETN             ( APB_PRESETN ),
			.APB_INITIATOR_0_PSEL    ( ARBITER_INITIATOR_0_PSEL ),
			.APB_INITIATOR_0_PENABLE ( ARBITER_INITIATOR_0_PENABLE ),
			.APB_INITIATOR_0_PWRITE  ( ARBITER_INITIATOR_0_PWRITE ),
      .APB_INITIATOR_0_PADDR   ( ARBITER_INITIATOR_0_PADDR ),
			.APB_INITIATOR_0_PWDATA  ( ARBITER_INITIATOR_0_PWDATA ),
			.APB_INITIATOR_1_PSEL    ( ARBITER_INITIATOR_1_PSEL ),
			.APB_INITIATOR_1_PENABLE ( ARBITER_INITIATOR_1_PENABLE ),
			.APB_INITIATOR_1_PWRITE  ( ARBITER_INITIATOR_1_PWRITE ),
			.APB_INITIATOR_1_PADDR   ( ARBITER_INITIATOR_1_PADDR ),
			.APB_INITIATOR_1_PWDATA  ( ARBITER_INITIATOR_1_PWDATA ),
      .APB_TARGET_0_PREADY     ( APB_TARGET_0_PREADY ),
			.APB_TARGET_0_PSLVERR    ( APB_TARGET_0_PSLVERR ),
			.APB_TARGET_0_PRDATA     ( APB_TARGET_0_PRDATA ),
			// Outputs
			.APB_INITIATOR_0_PREADY  ( ARBITER_INITIATOR_0_PREADY ),
			.APB_INITIATOR_0_PSLVERR ( ARBITER_INITIATOR_0_PSLVERR ),
      .APB_INITIATOR_0_PRDATA  ( ARBITER_INITIATOR_0_PRDATA ),
			.APB_INITIATOR_1_PREADY  ( ARBITER_INITIATOR_1_PREADY ),
			.APB_INITIATOR_1_PSLVERR ( ARBITER_INITIATOR_1_PSLVERR ),
			.APB_INITIATOR_1_PRDATA  ( ARBITER_INITIATOR_1_PRDATA ),
			.APB_TARGET_0_PSEL       ( APB_TARGET_0_PSEL ),
			.APB_TARGET_0_PENABLE    ( APB_TARGET_0_PENABLE ),
			.APB_TARGET_0_PWRITE     ( APB_TARGET_0_PWRITE ),
			.APB_TARGET_0_PADDR      ( APB_TARGET_0_PADDR ),
			.APB_TARGET_0_PWDATA     ( APB_TARGET_0_PWDATA ) 
			);

      assign ARBITER_INITIATOR_2_PADDR    = 'b0;  
      assign ARBITER_INITIATOR_2_PSEL     = 'b0;    
      assign ARBITER_INITIATOR_2_PENABLE  = 'b0; 
      assign ARBITER_INITIATOR_2_PWRITE   = 'b0;  
      assign ARBITER_INITIATOR_2_PWDATA   = 'b0; 
      assign ARBITER_INITIATOR_2_PRDATA   = 'b0;   
      assign ARBITER_INITIATOR_2_PREADY   = 'b0;
      assign ARBITER_INITIATOR_2_PSLVERR  = 'b0;
		end
    // only generate the apb arbiter with 3 ports if there are exactly three interfaces present
    else if ( IF_0_EN && IF_1_EN && IF_2_EN )
		begin: gen_arbtr_3
			miv_ihc_apb_arbiter_3 #(
      .SYNC_RESET(SYNC_RESET)
      )
      apb_arbiter_0 (
			// Inputs
			.APB_PCLK                ( APB_PCLK ),
			.APB_PRESETN             ( APB_PRESETN ),
			.APB_INITIATOR_0_PSEL    ( ARBITER_INITIATOR_0_PSEL ),
			.APB_INITIATOR_0_PENABLE ( ARBITER_INITIATOR_0_PENABLE ),
			.APB_INITIATOR_0_PWRITE  ( ARBITER_INITIATOR_0_PWRITE ),
      .APB_INITIATOR_0_PADDR   ( ARBITER_INITIATOR_0_PADDR ),
			.APB_INITIATOR_0_PWDATA  ( ARBITER_INITIATOR_0_PWDATA ),
			.APB_INITIATOR_1_PSEL    ( ARBITER_INITIATOR_1_PSEL ),
			.APB_INITIATOR_1_PENABLE ( ARBITER_INITIATOR_1_PENABLE ),
			.APB_INITIATOR_1_PWRITE  ( ARBITER_INITIATOR_1_PWRITE ),
			.APB_INITIATOR_1_PADDR   ( ARBITER_INITIATOR_1_PADDR ),
			.APB_INITIATOR_1_PWDATA  ( ARBITER_INITIATOR_1_PWDATA ),
			.APB_INITIATOR_2_PSEL    ( ARBITER_INITIATOR_2_PSEL ),
			.APB_INITIATOR_2_PENABLE ( ARBITER_INITIATOR_2_PENABLE ),
			.APB_INITIATOR_2_PWRITE  ( ARBITER_INITIATOR_2_PWRITE ),
      .APB_INITIATOR_2_PADDR   ( ARBITER_INITIATOR_2_PADDR ),
			.APB_INITIATOR_2_PWDATA  ( ARBITER_INITIATOR_2_PWDATA ),
      .APB_TARGET_0_PREADY     ( APB_TARGET_0_PREADY ),
			.APB_TARGET_0_PSLVERR    ( APB_TARGET_0_PSLVERR ),
			.APB_TARGET_0_PRDATA     ( APB_TARGET_0_PRDATA ),
			// Outputs
			.APB_INITIATOR_0_PREADY  ( ARBITER_INITIATOR_0_PREADY ),
			.APB_INITIATOR_0_PSLVERR ( ARBITER_INITIATOR_0_PSLVERR ),
      .APB_INITIATOR_0_PRDATA  ( ARBITER_INITIATOR_0_PRDATA ),
			.APB_INITIATOR_1_PREADY  ( ARBITER_INITIATOR_1_PREADY ),
			.APB_INITIATOR_1_PSLVERR ( ARBITER_INITIATOR_1_PSLVERR ),
			.APB_INITIATOR_1_PRDATA  ( ARBITER_INITIATOR_1_PRDATA ),
			.APB_INITIATOR_2_PREADY  ( ARBITER_INITIATOR_2_PREADY ),
			.APB_INITIATOR_2_PSLVERR ( ARBITER_INITIATOR_2_PSLVERR ),
      .APB_INITIATOR_2_PRDATA  ( ARBITER_INITIATOR_2_PRDATA ),
			.APB_TARGET_0_PSEL       ( APB_TARGET_0_PSEL ),
			.APB_TARGET_0_PENABLE    ( APB_TARGET_0_PENABLE ),
			.APB_TARGET_0_PWRITE     ( APB_TARGET_0_PWRITE ),
			.APB_TARGET_0_PADDR      ( APB_TARGET_0_PADDR ),
			.APB_TARGET_0_PWDATA     ( APB_TARGET_0_PWDATA ) 
			);
		end
    // No arbiter present
    else
    begin: ngen_arb
      assign ARBITER_INITIATOR_0_PADDR    = 'b0;  
      assign ARBITER_INITIATOR_0_PSEL     = 'b0;    
      assign ARBITER_INITIATOR_0_PENABLE  = 'b0; 
      assign ARBITER_INITIATOR_0_PWRITE   = 'b0;  
      assign ARBITER_INITIATOR_0_PWDATA   = 'b0; 
      assign ARBITER_INITIATOR_0_PRDATA   = 'b0;   
      assign ARBITER_INITIATOR_0_PREADY   = 'b0; 
      assign ARBITER_INITIATOR_0_PSLVERR  = 'b0; 

      assign ARBITER_INITIATOR_1_PADDR    = 'b0;  
      assign ARBITER_INITIATOR_1_PSEL     = 'b0;    
      assign ARBITER_INITIATOR_1_PENABLE  = 'b0; 
      assign ARBITER_INITIATOR_1_PWRITE   = 'b0;  
      assign ARBITER_INITIATOR_1_PWDATA   = 'b0; 
      assign ARBITER_INITIATOR_1_PRDATA   = 'b0;   
      assign ARBITER_INITIATOR_1_PREADY   = 'b0;   
      assign ARBITER_INITIATOR_1_PSLVERR  = 'b0;   

      assign ARBITER_INITIATOR_2_PADDR    = 'b0;  
      assign ARBITER_INITIATOR_2_PSEL     = 'b0;    
      assign ARBITER_INITIATOR_2_PENABLE  = 'b0; 
      assign ARBITER_INITIATOR_2_PWRITE   = 'b0;  
      assign ARBITER_INITIATOR_2_PWDATA   = 'b0; 
      assign ARBITER_INITIATOR_2_PRDATA   = 'b0;   
      assign ARBITER_INITIATOR_2_PREADY   = 'b0;
      assign ARBITER_INITIATOR_2_PSLVERR  = 'b0;
    end
endgenerate

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_arbiter_2 ( 

    APB_PCLK,
    APB_PRESETN,
    
// APB Initiator 0 Interface
    APB_INITIATOR_0_PADDR,
    APB_INITIATOR_0_PSEL,
    APB_INITIATOR_0_PENABLE,
    APB_INITIATOR_0_PWRITE,
    APB_INITIATOR_0_PWDATA,
    APB_INITIATOR_0_PRDATA,    
    APB_INITIATOR_0_PREADY,
    APB_INITIATOR_0_PSLVERR,
    
// APB Initiator 1 Interface
    APB_INITIATOR_1_PADDR,
    APB_INITIATOR_1_PSEL,
    APB_INITIATOR_1_PENABLE,
    APB_INITIATOR_1_PWRITE,
    APB_INITIATOR_1_PWDATA,
    APB_INITIATOR_1_PRDATA,    
    APB_INITIATOR_1_PREADY,
    APB_INITIATOR_1_PSLVERR,

// APB Target 0 Interface
    APB_TARGET_0_PADDR,
    APB_TARGET_0_PSEL,
    APB_TARGET_0_PENABLE,
    APB_TARGET_0_PWRITE,
    APB_TARGET_0_PWDATA,
    APB_TARGET_0_PRDATA,    
    APB_TARGET_0_PREADY,
    APB_TARGET_0_PSLVERR
);
//Parameters 
parameter SYNC_RESET = 0;

//Localparams
localparam IDLE_ST_0     = 3'b000,
           SETUP_0_ST    = 3'b001,
           ACCESS_0_ST   = 3'b010,
		   IDLE_ST_1     = 3'b011,
           SETUP_1_ST    = 3'b100,
           ACCESS_1_ST   = 3'b101;
//  I/O's
    input wire logic           APB_PCLK;     
    input wire logic           APB_PRESETN;  
    
// APB Initiator 0 Interface
    input wire logic    [31:0] APB_INITIATOR_0_PADDR;   
    input wire logic           APB_INITIATOR_0_PSEL;     
    input wire logic           APB_INITIATOR_0_PENABLE;  
    input wire logic           APB_INITIATOR_0_PWRITE;   
    input wire logic    [31:0] APB_INITIATOR_0_PWDATA;  
    output logic        [31:0] APB_INITIATOR_0_PRDATA;    
    output logic               APB_INITIATOR_0_PREADY;
    output logic               APB_INITIATOR_0_PSLVERR;
    
// APB Initiator 1 Interface
    input wire logic    [31:0] APB_INITIATOR_1_PADDR;   
    input wire logic           APB_INITIATOR_1_PSEL;     
    input wire logic           APB_INITIATOR_1_PENABLE;  
    input wire logic           APB_INITIATOR_1_PWRITE;   
    input wire logic    [31:0] APB_INITIATOR_1_PWDATA;  
    output logic        [31:0] APB_INITIATOR_1_PRDATA;    
    output logic               APB_INITIATOR_1_PREADY;
    output logic               APB_INITIATOR_1_PSLVERR;
    
// APB Target 0 Interface
    output logic        [31:0] APB_TARGET_0_PADDR;   
    output logic               APB_TARGET_0_PSEL;     
    output logic               APB_TARGET_0_PENABLE;  
    output logic               APB_TARGET_0_PWRITE;   
    output logic        [31:0] APB_TARGET_0_PWDATA;  
    input wire logic    [31:0] APB_TARGET_0_PRDATA;    
    input wire logic           APB_TARGET_0_PREADY;
    input wire logic           APB_TARGET_0_PSLVERR;
    
//Interal Signals    
reg [2:0] apb_grant_st;  
wire aresetn;
wire sresetn; 
	
// Logic
assign aresetn = (SYNC_RESET==1) ? 1'b1 : APB_PRESETN;
assign sresetn = (SYNC_RESET==1) ? APB_PRESETN : 1'b1;
	
// Logic
always @(posedge APB_PCLK or negedge aresetn)
  begin
    if((!aresetn) || (!sresetn)) begin
	    apb_grant_st <= IDLE_ST_0;
	end else begin
      case(apb_grant_st)
        IDLE_ST_0   : begin
		                  if(APB_INITIATOR_0_PSEL) begin
						      apb_grant_st <= SETUP_0_ST;
						  end else if(APB_INITIATOR_1_PSEL) begin
						      apb_grant_st <= SETUP_1_ST;
						  end else begin
						      apb_grant_st <= IDLE_ST_0;
						  end
		              end
        SETUP_0_ST  : begin
		                  apb_grant_st <= ACCESS_0_ST;
		              end
        ACCESS_0_ST : begin
		                  if(APB_TARGET_0_PREADY) begin
						      apb_grant_st <= IDLE_ST_1;
						  end else begin
						      apb_grant_st <= ACCESS_0_ST;
						  end
		              end
        IDLE_ST_1   : begin
		                if(APB_INITIATOR_1_PSEL) begin
						      apb_grant_st <= SETUP_1_ST;
						  end else if(APB_INITIATOR_0_PSEL) begin
						      apb_grant_st <= SETUP_0_ST;
						  end else begin
						      apb_grant_st <= IDLE_ST_0;
						  end
		              end
        SETUP_1_ST  : begin
		                  apb_grant_st <= ACCESS_1_ST;
		              end
        ACCESS_1_ST : begin
		                  if(APB_TARGET_0_PREADY) begin
						      apb_grant_st <= IDLE_ST_0;
						  end else begin
						      apb_grant_st <= ACCESS_1_ST;
						  end
		              end
	        default : begin
	                      apb_grant_st <= IDLE_ST_0;
		              end
	  endcase
	end
  end
  
  
always @(*)
  begin
  
   APB_TARGET_0_PENABLE    = 1'b0;   
   APB_TARGET_0_PWDATA     = 32'b0;  
   APB_TARGET_0_PWRITE     = 1'b0;    
   APB_TARGET_0_PADDR      = 32'b0;   
   APB_TARGET_0_PSEL       = 1'b0;    
   APB_INITIATOR_0_PSLVERR = 1'b0;
   APB_INITIATOR_0_PRDATA  = 32'b0;    
   APB_INITIATOR_0_PREADY  = 1'b0;
   APB_INITIATOR_1_PRDATA  = 1'b0;   
   APB_INITIATOR_1_PREADY  = 1'b0;
   APB_INITIATOR_1_PSLVERR = 1'b0;
   
      case(apb_grant_st)
        IDLE_ST_0   : begin
                        //
						// N/A
						//
		              end
        SETUP_0_ST  : begin
					      APB_TARGET_0_PWDATA = APB_INITIATOR_0_PWDATA;
					      APB_TARGET_0_PWRITE = APB_INITIATOR_0_PWRITE;
		                  APB_TARGET_0_PADDR  = APB_INITIATOR_0_PADDR;
					      APB_TARGET_0_PSEL   = APB_INITIATOR_0_PSEL;
		              end
        ACCESS_0_ST : begin  
						  APB_TARGET_0_PENABLE    = APB_INITIATOR_0_PENABLE;  
					      APB_TARGET_0_PWDATA     = APB_INITIATOR_0_PWDATA;
						  APB_TARGET_0_PWRITE     = APB_INITIATOR_0_PWRITE;
		                  APB_TARGET_0_PADDR      = APB_INITIATOR_0_PADDR;
						  APB_TARGET_0_PSEL       = APB_INITIATOR_0_PSEL;   
						  APB_INITIATOR_0_PSLVERR = APB_TARGET_0_PSLVERR;
						  APB_INITIATOR_0_PRDATA  = APB_TARGET_0_PRDATA;    
						  APB_INITIATOR_0_PREADY  = APB_TARGET_0_PREADY;
		              end
        IDLE_ST_1   : begin
                        //
						// N/A
						//
		              end
        SETUP_1_ST  : begin
					      APB_TARGET_0_PWDATA = APB_INITIATOR_1_PWDATA;
					      APB_TARGET_0_PWRITE = APB_INITIATOR_1_PWRITE;
		                  APB_TARGET_0_PADDR  = APB_INITIATOR_1_PADDR;
					      APB_TARGET_0_PSEL   = APB_INITIATOR_1_PSEL;
		              end
        ACCESS_1_ST : begin  
						  APB_TARGET_0_PENABLE    = APB_INITIATOR_1_PENABLE;  
					      APB_TARGET_0_PWDATA     = APB_INITIATOR_1_PWDATA;
						  APB_TARGET_0_PWRITE     = APB_INITIATOR_1_PWRITE;
		                  APB_TARGET_0_PADDR      = APB_INITIATOR_1_PADDR;
						  APB_TARGET_0_PSEL       = APB_INITIATOR_1_PSEL;  
						  APB_INITIATOR_1_PSLVERR = APB_TARGET_0_PSLVERR;
						  APB_INITIATOR_1_PRDATA  = APB_TARGET_0_PRDATA;    
						  APB_INITIATOR_1_PREADY  = APB_TARGET_0_PREADY;
		              end
	        default : begin
                        APB_TARGET_0_PENABLE    = 1'b0;   
                        APB_TARGET_0_PWDATA     = 32'b0;  
                        APB_TARGET_0_PWRITE     = 1'b0;    
                        APB_TARGET_0_PADDR      = 32'b0;   
                        APB_TARGET_0_PSEL       = 1'b0;    
                        APB_INITIATOR_0_PRDATA  = 32'b0;    
                        APB_INITIATOR_0_PREADY  = 1'b0;
                        APB_INITIATOR_0_PSLVERR = 1'b0;
                        APB_INITIATOR_1_PRDATA  = 1'b0;   
                        APB_INITIATOR_1_PREADY  = 1'b0;
                        APB_INITIATOR_1_PSLVERR = 1'b0;
		              end
	  endcase
  end
endmodule

`default_nettype wire

// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_arbiter_3 ( 

    APB_PCLK,
    APB_PRESETN,
    
// APB Initiator 0 Interface
    APB_INITIATOR_0_PADDR,
    APB_INITIATOR_0_PSEL,
    APB_INITIATOR_0_PENABLE,
    APB_INITIATOR_0_PWRITE,
    APB_INITIATOR_0_PWDATA,
    APB_INITIATOR_0_PRDATA,    
    APB_INITIATOR_0_PREADY,
    APB_INITIATOR_0_PSLVERR,
    
// APB Initiator 1 Interface
    APB_INITIATOR_1_PADDR,
    APB_INITIATOR_1_PSEL,
    APB_INITIATOR_1_PENABLE,
    APB_INITIATOR_1_PWRITE,
    APB_INITIATOR_1_PWDATA,
    APB_INITIATOR_1_PRDATA,    
    APB_INITIATOR_1_PREADY,
    APB_INITIATOR_1_PSLVERR,

// APB Initiator 2 Interface
    APB_INITIATOR_2_PADDR,
    APB_INITIATOR_2_PSEL,
    APB_INITIATOR_2_PENABLE,
    APB_INITIATOR_2_PWRITE,
    APB_INITIATOR_2_PWDATA,
    APB_INITIATOR_2_PRDATA,    
    APB_INITIATOR_2_PREADY,
    APB_INITIATOR_2_PSLVERR,

// APB Target 0 Interface
    APB_TARGET_0_PADDR,
    APB_TARGET_0_PSEL,
    APB_TARGET_0_PENABLE,
    APB_TARGET_0_PWRITE,
    APB_TARGET_0_PWDATA,
    APB_TARGET_0_PRDATA,    
    APB_TARGET_0_PREADY,
    APB_TARGET_0_PSLVERR
);
//Parameters 
parameter SYNC_RESET = 0;

//Localparams
localparam  IDLE_ST_0     = 4'b0000,
            SETUP_0_ST    = 4'b0001,
            ACCESS_0_ST   = 4'b0010,
		    IDLE_ST_1     = 4'b0011,
            SETUP_1_ST    = 4'b0100,
            ACCESS_1_ST   = 4'b0101,
            IDLE_ST_2     = 4'b0110,
            SETUP_2_ST    = 4'b0111,
            ACCESS_2_ST   = 4'b1000;
//  I/O's
    input wire logic           APB_PCLK;     
    input wire logic           APB_PRESETN;  
    
// APB Initiator 0 Interface
    input wire logic           [31:0]  APB_INITIATOR_0_PADDR;   
    input wire logic                   APB_INITIATOR_0_PSEL;     
    input wire logic                   APB_INITIATOR_0_PENABLE;  
    input wire logic                   APB_INITIATOR_0_PWRITE;   
    input wire logic           [31:0]  APB_INITIATOR_0_PWDATA;  
    output logic               [31:0]  APB_INITIATOR_0_PRDATA;    
    output logic                       APB_INITIATOR_0_PREADY;
    output logic                       APB_INITIATOR_0_PSLVERR;
    
// APB Initiator 1 Interface
    input wire logic            [31:0] APB_INITIATOR_1_PADDR;   
    input wire logic                   APB_INITIATOR_1_PSEL;     
    input wire logic                   APB_INITIATOR_1_PENABLE;  
    input wire logic                   APB_INITIATOR_1_PWRITE;   
    input wire logic            [31:0] APB_INITIATOR_1_PWDATA;  
    output logic                [31:0] APB_INITIATOR_1_PRDATA;    
    output logic                       APB_INITIATOR_1_PREADY;
    output logic                       APB_INITIATOR_1_PSLVERR;

// APB Initiator 2 Interface
    input wire logic            [31:0] APB_INITIATOR_2_PADDR;   
    input wire logic                   APB_INITIATOR_2_PSEL;     
    input wire logic                   APB_INITIATOR_2_PENABLE;  
    input wire logic                   APB_INITIATOR_2_PWRITE;   
    input wire logic            [31:0] APB_INITIATOR_2_PWDATA;  
    output logic                [31:0] APB_INITIATOR_2_PRDATA;    
    output logic                       APB_INITIATOR_2_PREADY;
    output logic                       APB_INITIATOR_2_PSLVERR;
    
// APB Target 0 Interface
    output logic                [31:0] APB_TARGET_0_PADDR;   
    output logic                       APB_TARGET_0_PSEL;     
    output logic                       APB_TARGET_0_PENABLE;  
    output logic                       APB_TARGET_0_PWRITE;   
    output logic                [31:0] APB_TARGET_0_PWDATA;  
    input wire logic            [31:0] APB_TARGET_0_PRDATA;    
    input wire logic                   APB_TARGET_0_PREADY;
    input wire logic                   APB_TARGET_0_PSLVERR;
    
//Internal Signals    
reg [3:0] apb_grant_st;
wire aresetn;
wire sresetn; 
	
// Logic
assign aresetn = (SYNC_RESET==1) ? 1'b1 : APB_PRESETN;
assign sresetn = (SYNC_RESET==1) ? APB_PRESETN : 1'b1;

always @(posedge APB_PCLK or negedge aresetn)
  begin
    if((!aresetn) || (!sresetn)) begin
	    apb_grant_st <= IDLE_ST_0;
	end else begin
      case(apb_grant_st)
        IDLE_ST_0   : begin
		                  if(APB_INITIATOR_0_PSEL) begin
						      apb_grant_st <= SETUP_0_ST;
						  end else if(APB_INITIATOR_1_PSEL) begin
						      apb_grant_st <= SETUP_1_ST;
						  end else if(APB_INITIATOR_2_PSEL) begin
						      apb_grant_st <= SETUP_2_ST;
                          end else begin
						      apb_grant_st <= IDLE_ST_0;
						  end
		              end
        SETUP_0_ST  : begin
		                  apb_grant_st <= ACCESS_0_ST;
		              end
        ACCESS_0_ST : begin
		                  if(APB_TARGET_0_PREADY) begin
						      apb_grant_st <= IDLE_ST_1;
						  end else begin
						      apb_grant_st <= ACCESS_0_ST;
						  end
		              end
        IDLE_ST_1   : begin
		                if(APB_INITIATOR_1_PSEL) begin
						    apb_grant_st <= SETUP_1_ST;
                        end else if(APB_INITIATOR_2_PSEL) begin
                            apb_grant_st <= SETUP_2_ST;
                        end else if(APB_INITIATOR_0_PSEL) begin
                            apb_grant_st <= SETUP_0_ST;
                        end else begin
                            apb_grant_st <= IDLE_ST_0;
                        end
		              end
        SETUP_1_ST  : begin
		                  apb_grant_st <= ACCESS_1_ST;
		              end
        ACCESS_1_ST : begin
		                  if(APB_TARGET_0_PREADY) begin
						      apb_grant_st <= IDLE_ST_2;
						  end else begin
						      apb_grant_st <= ACCESS_1_ST;
						  end
		              end
        IDLE_ST_2   : begin
		                  if(APB_INITIATOR_2_PSEL) begin
						      apb_grant_st <= SETUP_2_ST;
						  end else if(APB_INITIATOR_0_PSEL) begin
						      apb_grant_st <= SETUP_0_ST;
						  end else if(APB_INITIATOR_1_PSEL) begin
						      apb_grant_st <= SETUP_1_ST;
                          end else begin
						      apb_grant_st <= IDLE_ST_0;
						  end
		              end
        SETUP_2_ST  : begin
		                  apb_grant_st <= ACCESS_2_ST;
		              end
        ACCESS_2_ST : begin
		                  if(APB_TARGET_0_PREADY) begin
						      apb_grant_st <= IDLE_ST_0;
						  end else begin
						      apb_grant_st <= ACCESS_2_ST;
						  end
		              end
	        default : begin
	                      apb_grant_st <= IDLE_ST_0;
		              end
	  endcase
	end
  end
  
  
always @(*)
  begin
    APB_TARGET_0_PENABLE    = 1'b0;   
    APB_TARGET_0_PWDATA     = 32'b0;  
    APB_TARGET_0_PWRITE     = 1'b0;    
    APB_TARGET_0_PADDR      = 32'b0;   
    APB_TARGET_0_PSEL       = 1'b0;    
    APB_INITIATOR_0_PSLVERR = 1'b0;
    APB_INITIATOR_0_PRDATA  = 32'b0;    
    APB_INITIATOR_0_PREADY  = 1'b0;
    APB_INITIATOR_1_PRDATA  = 1'b0;   
    APB_INITIATOR_1_PREADY  = 1'b0;
    APB_INITIATOR_1_PSLVERR = 1'b0;
    APB_INITIATOR_2_PSLVERR = 1'b0;
    APB_INITIATOR_2_PRDATA  = 32'b0;    
    APB_INITIATOR_2_PREADY  = 1'b0;
   
    case(apb_grant_st)
    IDLE_ST_0   : begin
                    //
                    // N/A
                    //
                    end
    SETUP_0_ST  : begin
                        APB_TARGET_0_PWDATA = APB_INITIATOR_0_PWDATA;
                        APB_TARGET_0_PWRITE = APB_INITIATOR_0_PWRITE;
                        APB_TARGET_0_PADDR  = APB_INITIATOR_0_PADDR;
                        APB_TARGET_0_PSEL   = APB_INITIATOR_0_PSEL;
                    end
    ACCESS_0_ST : begin  
                        APB_TARGET_0_PENABLE    = APB_INITIATOR_0_PENABLE;  
                        APB_TARGET_0_PWDATA     = APB_INITIATOR_0_PWDATA;
                        APB_TARGET_0_PWRITE     = APB_INITIATOR_0_PWRITE;
                        APB_TARGET_0_PADDR      = APB_INITIATOR_0_PADDR;
                        APB_TARGET_0_PSEL       = APB_INITIATOR_0_PSEL;   
                        APB_INITIATOR_0_PSLVERR = APB_TARGET_0_PSLVERR;
                        APB_INITIATOR_0_PRDATA  = APB_TARGET_0_PRDATA;    
                        APB_INITIATOR_0_PREADY  = APB_TARGET_0_PREADY;
                    end
    IDLE_ST_1   : begin
                    //
                    // N/A
                    //
                    end
    SETUP_1_ST  : begin
                        APB_TARGET_0_PWDATA = APB_INITIATOR_1_PWDATA;
                        APB_TARGET_0_PWRITE = APB_INITIATOR_1_PWRITE;
                        APB_TARGET_0_PADDR  = APB_INITIATOR_1_PADDR;
                        APB_TARGET_0_PSEL   = APB_INITIATOR_1_PSEL;
                    end
    ACCESS_1_ST : begin  
                        APB_TARGET_0_PENABLE    = APB_INITIATOR_1_PENABLE;  
                        APB_TARGET_0_PWDATA     = APB_INITIATOR_1_PWDATA;
                        APB_TARGET_0_PWRITE     = APB_INITIATOR_1_PWRITE;
                        APB_TARGET_0_PADDR      = APB_INITIATOR_1_PADDR;
                        APB_TARGET_0_PSEL       = APB_INITIATOR_1_PSEL;  
                        APB_INITIATOR_1_PSLVERR = APB_TARGET_0_PSLVERR;
                        APB_INITIATOR_1_PRDATA  = APB_TARGET_0_PRDATA;    
                        APB_INITIATOR_1_PREADY  = APB_TARGET_0_PREADY;
                    end
    IDLE_ST_2   : begin
                    //
                    // N/A
                    //
                    end
    SETUP_2_ST  : begin
                        APB_TARGET_0_PWDATA = APB_INITIATOR_2_PWDATA;
                        APB_TARGET_0_PWRITE = APB_INITIATOR_2_PWRITE;
                        APB_TARGET_0_PADDR  = APB_INITIATOR_2_PADDR;
                        APB_TARGET_0_PSEL   = APB_INITIATOR_2_PSEL;
                    end
    ACCESS_2_ST : begin  
                        APB_TARGET_0_PENABLE    = APB_INITIATOR_2_PENABLE;  
                        APB_TARGET_0_PWDATA     = APB_INITIATOR_2_PWDATA;
                        APB_TARGET_0_PWRITE     = APB_INITIATOR_2_PWRITE;
                        APB_TARGET_0_PADDR      = APB_INITIATOR_2_PADDR;
                        APB_TARGET_0_PSEL       = APB_INITIATOR_2_PSEL;   
                        APB_INITIATOR_2_PSLVERR = APB_TARGET_0_PSLVERR;
                        APB_INITIATOR_2_PRDATA  = APB_TARGET_0_PRDATA;    
                        APB_INITIATOR_2_PREADY  = APB_TARGET_0_PREADY;
                    end
        default : begin
                    APB_TARGET_0_PENABLE    = 1'b0;   
                    APB_TARGET_0_PWDATA     = 32'b0;  
                    APB_TARGET_0_PWRITE     = 1'b0;    
                    APB_TARGET_0_PADDR      = 32'b0;   
                    APB_TARGET_0_PSEL       = 1'b0;    
                    APB_INITIATOR_0_PRDATA  = 32'b0;    
                    APB_INITIATOR_0_PREADY  = 1'b0;
                    APB_INITIATOR_0_PSLVERR = 1'b0;
                    APB_INITIATOR_1_PRDATA  = 1'b0;   
                    APB_INITIATOR_1_PREADY  = 1'b0;
                    APB_INITIATOR_1_PSLVERR = 1'b0;
                    APB_INITIATOR_2_PRDATA  = 32'b0;    
                    APB_INITIATOR_2_PREADY  = 1'b0;
                    APB_INITIATOR_2_PSLVERR = 1'b0;
                    end
    endcase
  end
endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Copyright 2018 ETH Zurich and University of Bologna.                       //
// Copyright and related rights are licensed under the Solderpad Hardware     //
// License, Version 0.51 (the "License"); you may not use this file except in //
// compliance with the License.  You may obtain a copy of the License at      //
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law  //
// or agreed to in writing, software, hardware and materials distributed under//
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR     //
// CONDITIONS OF ANY KIND, either express or implied. See the License for the //
// specific language governing permissions and limitations under the License. //
//                                                                            //
// Company:        Micrel Lab @ DEIS - University of Bologna                  //
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Igor Loi - igor.loi@unibo.it                               //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    01/01/2019                                                 //
// Design Name:    APB CDC                                                    //
// Module Name:    apb_master_asynch                                          //
// Project Name:   NONE                                                       //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    The master part of the apb cdc: the apb transaction        //
//                 and source clock comes, and they are converted with a      //
//                 simple req_o --> ack_i --> !req_o --> !ack_i               //
//                                                                            //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - 01/01/2019 : File Created                                  //
//                                                                            //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_master_asynch
#(
   parameter SYNC_RESET                  = 0,
   parameter int unsigned APB_DATA_WIDTH = 32,
   parameter int unsigned APB_ADDR_WIDTH = 32
)
(
   input wire logic                         clk,
   input wire logic                         rst_n,

   // SLAVE PORT
   input wire  logic [APB_ADDR_WIDTH-1:0]   PADDR_i,
   input wire  logic [APB_DATA_WIDTH-1:0]   PWDATA_i,
   input wire  logic                        PWRITE_i,
   input wire  logic                        PSEL_i,
   input wire  logic                        PENABLE_i,
   output logic [APB_DATA_WIDTH-1:0]        PRDATA_o,
   output logic                             PREADY_o,
   output logic                             PSLVERR_o,


   // Master ASYNCH PORT
   output logic                             asynch_req_o,
   input wire  logic                        asynch_ack_i,

   output logic [APB_ADDR_WIDTH-1:0]        async_PADDR_o,
   output logic [APB_DATA_WIDTH-1:0]        async_PWDATA_o,
   output logic                             async_PWRITE_o,

   input wire  logic [APB_DATA_WIDTH-1:0]   async_PRDATA_i,
   input wire  logic                        async_PSLVERR_i
);

    enum logic [1:0] { IDLE, REQ_UP, REQ_DOWN } NS, CS;
    logic ack_sync0, ack_sync;
	  logic asynch_req_reg;

    // sync/async reset mode select
    logic aresetn;
    logic sresetn; 
    assign aresetn = (SYNC_RESET==1) ? 1'b1 : rst_n;
    assign sresetn = (SYNC_RESET==1) ? rst_n : 1'b1;

    always_ff @(posedge clk, negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn))
        begin
            ack_sync0 	 <= 1'b0;
            ack_sync  	 <= 1'b0;
			      asynch_req_o <= 1'b0;
            CS         	 <= IDLE;
        end
        else
        begin
            ack_sync0  	 <= asynch_ack_i;
            ack_sync  	 <= ack_sync0;
			      asynch_req_o <= asynch_req_reg;
            CS        	 <= NS;
        end
    end

    always_comb
    begin
      NS = CS;

      asynch_req_reg = 1'b0;
      PRDATA_o       = async_PRDATA_i;
      PREADY_o       = 1'b0;
      PSLVERR_o      = 1'b0;      
      async_PADDR_o  = PADDR_i;
      async_PWDATA_o = PWDATA_i;
      async_PWRITE_o = PWRITE_i;

      case(CS)
        IDLE: begin
            if(PSEL_i & PENABLE_i)
            begin
              NS = REQ_UP;
            end
            else
            begin
              NS = IDLE;
            end
        end

        REQ_UP:
        begin
            asynch_req_reg = 1'b1;
            if(ack_sync)
            begin
              NS       = REQ_DOWN;
              PREADY_o  = 1'b1;
              PSLVERR_o = async_PSLVERR_i;
            end
            else
            begin
               NS = REQ_UP;
            end
        end

        REQ_DOWN:
        begin
            asynch_req_reg  = 1'b0;
            if(~ack_sync)
            begin
              NS = IDLE;
            end
            else
            begin
              NS = REQ_DOWN;
            end
        end

      default:
      begin
        NS = IDLE;
      end
      endcase // CS

    end

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Copyright 2018 ETH Zurich and University of Bologna.                       //
// Copyright and related rights are licensed under the Solderpad Hardware     //
// License, Version 0.51 (the "License"); you may not use this file except in //
// compliance with the License.  You may obtain a copy of the License at      //
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law  //
// or agreed to in writing, software, hardware and materials distributed under//
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR     //
// CONDITIONS OF ANY KIND, either express or implied. See the License for the //
// specific language governing permissions and limitations under the License. //
//                                                                            //
// Company:        Micrel Lab @ DEIS - University of Bologna                  //
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Igor Loi - igor.loi@unibo.it                               //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    01/01/2019                                                 //
// Design Name:    APB CDC                                                    //
// Module Name:    apb_slave_asynch                                           //
// Project Name:   NONE                                                       //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    The slave part of the apb cdc: the asynch apb transaction  //
//                 comes and this is converted in a synch apb transaction     //
//                 using the destination clock                                //
//                 req_i --> ack_o --> !req_i --> !ack_o                      //
//                                                                            //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - 01/01/2019 : File Created                                  //
//                                                                            //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_slave_asynch
#(
   parameter SYNC_RESET                  = 0,
   parameter int unsigned APB_DATA_WIDTH = 32,
   parameter int unsigned APB_ADDR_WIDTH = 32
)
(
   input wire logic                         clk,
   input wire logic                         rst_n,

   // MASTER PORT
   output logic [APB_ADDR_WIDTH-1:0]        PADDR_o,
   output logic [APB_DATA_WIDTH-1:0]        PWDATA_o,
   output logic                             PWRITE_o,
   output logic                             PSEL_o,
   output logic                             PENABLE_o,
   input wire logic [APB_DATA_WIDTH-1:0]    PRDATA_i,
   input wire logic                         PREADY_i,
   input wire logic                         PSLVERR_i,

   // Slave ASYNCH PORT
   input wire logic                         asynch_req_i,
   output logic                             asynch_ack_o,

   input wire logic [APB_ADDR_WIDTH-1:0]    async_PADDR_i,
   input wire logic [APB_DATA_WIDTH-1:0]    async_PWDATA_i,
   input wire logic                         async_PWRITE_i,

   output logic [APB_DATA_WIDTH-1:0]        async_PRDATA_o,
   output logic                             async_PSLVERR_o
);

    enum logic [1:0] { IDLE, WAIT_PREADY, ACK_UP, WAIT_1_CYCLE} NS, CS;
    logic req_sync0, req_sync, sample_req, sample_resp;
	  logic asynch_ack_reg;

    // sync/async reset mode select
    logic aresetn;
    logic sresetn; 
    assign aresetn = (SYNC_RESET==1) ? 1'b1 : rst_n;
    assign sresetn = (SYNC_RESET==1) ? rst_n : 1'b1;
	
    always_ff @(posedge clk, negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn))
        begin
            req_sync0 	  		<= 1'b0;
            req_sync  	  		<= 1'b0;
            CS             		<= IDLE;

            PADDR_o        		<='0;
            PWDATA_o       		<='0;
            PWRITE_o       		<='0;

            async_PRDATA_o  	<='0;
            async_PSLVERR_o		<='0; 
        end
        else
        begin
            req_sync0  <= asynch_req_i;
            req_sync   <= req_sync0;
            CS         <= NS;

            //No flip-flop chain is necessary to receive the transfer data
            //since the hand shake approach has already guaranteed that the transfer data is valid.
            if(sample_req)
            begin
              PADDR_o  <= async_PADDR_i;
              PWDATA_o <= async_PWDATA_i;
              PWRITE_o <= async_PWRITE_i;
            end

            if(sample_resp)
            begin
              async_PRDATA_o  <= PRDATA_i;
              async_PSLVERR_o <= PSLVERR_i;  
            end
        end

    end

	always_ff @(posedge clk, negedge aresetn)
	begin
      if ((!aresetn) || (!sresetn))
        begin
          asynch_ack_o <= 1'b0;
        end
        else
        begin
          asynch_ack_o <= asynch_ack_reg;
        end
	end
	
    always_comb
    begin
	
      sample_req  = 1'b0;
      sample_resp = 1'b0;

      PENABLE_o  = 1'b0;
	    PSEL_o     = 1'b0;

      asynch_ack_reg   = '0;    
      
      NS = CS;

      case(CS)
        IDLE: begin
            sample_req = req_sync;

            if(req_sync)
            begin
              NS = WAIT_1_CYCLE;
            end
            else
            begin
              NS = IDLE;
            end
        end
        WAIT_1_CYCLE: begin
                        PSEL_o = 1'b1;  // A request means psel on an initiator was brought HIGH
                        NS = WAIT_PREADY;
                      end
        WAIT_PREADY:
        begin
            PENABLE_o = 1'b1;  // penable goes high 1 cycle after psel
			      PSEL_o    = 1'b1;
            sample_resp = PREADY_i; 
            if(PREADY_i)
            begin
              NS       = ACK_UP;
            end
            else
            begin
               NS = WAIT_PREADY;
            end
        end

        ACK_UP:
        begin
            asynch_ack_reg = 1'b1;
            if(~req_sync)
            begin
              NS = IDLE;
            end
            else
            begin
              NS = ACK_UP;
            end
        end

        default:
        begin
          NS = IDLE;
        end

      endcase // CS

    end
	
endmodule // miv_ihc_apb_slave_asynch

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Copyright 2018 ETH Zurich and University of Bologna.                       //
// Copyright and related rights are licensed under the Solderpad Hardware     //
// License, Version 0.51 (the "License"); you may not use this file except in //
// compliance with the License.  You may obtain a copy of the License at      //
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law  //
// or agreed to in writing, software, hardware and materials distributed under//
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR     //
// CONDITIONS OF ANY KIND, either express or implied. See the License for the //
// specific language governing permissions and limitations under the License. //
//                                                                            //
// Company:        Micrel Lab @ DEIS - University of Bologna                  //
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Igor Loi - igor.loi@unibo.it                               //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    01/01/2019                                                 //
// Design Name:    APB CDC                                                    //
// Module Name:    apb_cdc                                                    //
// Project Name:   NONE                                                       //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    This Block is a simple APB clocl domain crossin that       //
//                 uses a 4 phases approach. Should not be used if the        //
//                 performance are main concern. Is composed by master        //
//                 and slave part, than can be used separately to be placed   //
//                 in different clock/power domains, then route the asynch    //
//                 signals olver them                                         //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - 01/01/2019 : File Created                                  //
//                                                                            //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_cdc
#(
   parameter SYNC_RESET                  = 0,
   parameter int unsigned APB_DATA_WIDTH = 32,
   parameter int unsigned APB_ADDR_WIDTH = 32
)
(
   input wire logic                         src_clk,
   input wire logic                         src_rst_n,

   // SLAVE PORT
   input wire logic [APB_ADDR_WIDTH-1:0]    src_PADDR_i,
   input wire logic [APB_DATA_WIDTH-1:0]    src_PWDATA_i,
   input wire logic                         src_PWRITE_i,
   input wire logic                         src_PSEL_i,
   input wire logic                         src_PENABLE_i,
   output logic [APB_DATA_WIDTH-1:0]        src_PRDATA_o,
   output logic                             src_PREADY_o,
   output logic                             src_PSLVERR_o,

   input wire logic                         dest_clk,
   input wire logic                         dest_rst_n,
   output logic [APB_ADDR_WIDTH-1:0]        dest_PADDR_o,
   output logic [APB_DATA_WIDTH-1:0]        dest_PWDATA_o,
   output logic                             dest_PWRITE_o,
   output logic                             dest_PSEL_o,
   output logic                             dest_PENABLE_o,
   input wire logic [APB_DATA_WIDTH-1:0]    dest_PRDATA_i,
   input wire logic                         dest_PREADY_i,
   input wire logic                         dest_PSLVERR_i
);

   logic                             asynch_req;
   logic                             asynch_ack;
   logic [APB_ADDR_WIDTH-1:0]        async_PADDR;
   logic [APB_DATA_WIDTH-1:0]        async_PWDATA;
   logic                             async_PWRITE;
   logic [APB_DATA_WIDTH-1:0]        async_PRDATA;
   logic                             async_PSLVERR;


  miv_ihc_apb_master_asynch
  #(
     .SYNC_RESET     ( SYNC_RESET     ),
     .APB_DATA_WIDTH ( APB_DATA_WIDTH ),
     .APB_ADDR_WIDTH ( APB_ADDR_WIDTH )
  )
  i_apb_master_asynch
  (
     .clk             ( src_clk        ),
     .rst_n           ( src_rst_n      ),

     // SLAVE SYNCH PORT
     .PADDR_i         ( src_PADDR_i    ),
     .PWDATA_i        ( src_PWDATA_i   ),
     .PWRITE_i        ( src_PWRITE_i   ),
     .PSEL_i          ( src_PSEL_i     ),
     .PENABLE_i       ( src_PENABLE_i  ),
     .PRDATA_o        ( src_PRDATA_o   ),
     .PREADY_o        ( src_PREADY_o   ),
     .PSLVERR_o       ( src_PSLVERR_o  ),


     // MASTER ASYNCH PORT
     .asynch_req_o    ( asynch_req     ),
     .asynch_ack_i    ( asynch_ack     ),
     .async_PADDR_o   ( async_PADDR    ),
     .async_PWDATA_o  ( async_PWDATA   ),
     .async_PWRITE_o  ( async_PWRITE   ),
     .async_PRDATA_i  ( async_PRDATA   ),
     .async_PSLVERR_i ( async_PSLVERR  )
  );


  miv_ihc_apb_slave_asynch
  #(
     .SYNC_RESET      ( SYNC_RESET     ),
     .APB_DATA_WIDTH  ( APB_DATA_WIDTH ),
     .APB_ADDR_WIDTH  ( APB_ADDR_WIDTH )
  )
  i_apb_slave_asynch
  (
     .clk             ( dest_clk        ),
     .rst_n           ( dest_rst_n      ),

     .PADDR_o         ( dest_PADDR_o    ),
     .PWDATA_o        ( dest_PWDATA_o   ),
     .PWRITE_o        ( dest_PWRITE_o   ),
     .PSEL_o          ( dest_PSEL_o     ),
     .PENABLE_o       ( dest_PENABLE_o  ),
     .PRDATA_i        ( dest_PRDATA_i   ),
     .PREADY_i        ( dest_PREADY_i   ),
     .PSLVERR_i       ( dest_PSLVERR_i  ),

     .asynch_req_i    ( asynch_req      ),
     .asynch_ack_o    ( asynch_ack      ),
     .async_PADDR_i   ( async_PADDR     ),
     .async_PWDATA_i  ( async_PWDATA    ),
     .async_PWRITE_i  ( async_PWRITE    ),
     .async_PRDATA_o  ( async_PRDATA    ),
     .async_PSLVERR_o ( async_PSLVERR   )
  );

endmodule // miv_ihc_apb_cdc

`default_nettype none
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATION BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_mpu (
    // Inputs  
    PADDR_req,    
    PWDATA_req, 	
    PWRITE_req,	    
    PSEL_req,     	
    PENABLE_req,  	 

    // Target Response from the MIV_IHC Core logic
    PRDATA_IHC_resp,    
    PREADY_IHC_resp,   
    PSLVERR_IHC_resp,  

    // Outputs
    // Top-level Target Response after MPU applied
    PRDATA_resp, 	
    PREADY_resp,
    PSLVERR_resp,

    // Initiator activity seen by the MIV_IHC Core logic
    PADDR_IHC_req,
    PENABLE_IHC_req,
    PSEL_IHC_req,
    PWDATA_IHC_req,
    PWRITE_IHC_req
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
parameter H0_ACCESS		= 0;
parameter H1_ACCESS		= 0;
parameter H2_ACCESS		= 0;
parameter H3_ACCESS		= 0;
parameter H4_ACCESS		= 0;
parameter H5_ACCESS		= 0;

parameter ERROR_DATA_RESP   = 32'hBAD00000;

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
localparam start_addr_H0 = 20'h0_4000;  // first address of Hart 0
localparam end_addr_H0   = 20'h0_4600;  // last  address of Hart 0
localparam start_addr_H1 = 20'h0_8000;  // first address of Hart 1
localparam end_addr_H1   = 20'h0_8600;  // last address of Hart 1
localparam start_addr_H2 = 20'h0_C000;  // first address of Hart 2
localparam end_addr_H2   = 20'h0_C600;  // last address of Hart 2
localparam start_addr_H3 = 20'h1_0000;  // first address of Hart 3
localparam end_addr_H3   = 20'h1_0600;  // last address of Hart 3
localparam start_addr_H4 = 20'h1_4000;  // first address of Hart 4
localparam end_addr_H4   = 20'h1_4600;  // last address of Hart 4
localparam start_addr_H5 = 20'h1_8000;  // first address of Hart 5
localparam end_addr_H5   = 20'h1_8600;  // last  address of Hart 5

localparam IP_VERSION_ADDR = 20'h0_3BFC;  // the MIV_IHC IP Version is accessible at 0x3BFC. All harts are allowed to read the IP Version.

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input wire logic  [31:0] PADDR_req;
input wire logic  [31:0] PWDATA_req;
input wire logic         PWRITE_req;
input wire logic         PSEL_req;
input wire logic         PENABLE_req;
input wire logic  [31:0] PRDATA_IHC_resp;
input wire logic         PREADY_IHC_resp;
input wire logic         PSLVERR_IHC_resp;

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output logic [31:0] PRDATA_resp;
output logic        PREADY_resp;
output logic        PSLVERR_resp;
 	     	
output logic [31:0] PADDR_IHC_req;
output logic        PENABLE_IHC_req;
output logic        PSEL_IHC_req;
output logic [31:0] PWDATA_IHC_req;
output logic        PWRITE_IHC_req;

//--------------------------------------------------------------------
// Internal Variables
//--------------------------------------------------------------------
logic valid_addr;

//--------------------------------------------------------------------
// Main Code
//--------------------------------------------------------------------

// Determine boolean value of valid_addr, which is the select line for the APB DEMUX
always @(*)
    begin
        if (PADDR_req[19:0] == IP_VERSION_ADDR) begin  // All harts are allowed to read the IP Version.
            valid_addr = 1'b1;
        end
        else if ( (start_addr_H0 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H0) ) begin  // check if the address is within the Hart 0 legal address region
            valid_addr = (H0_ACCESS) ? 1'b1 : 1'b0;
        end
        else if ( (start_addr_H1 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H1) ) begin  // check if the address is within the Hart 1 legal address region
            valid_addr = (H1_ACCESS) ? 1'b1 : 1'b0;
        end
        else if ( (start_addr_H2 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H2) ) begin  // check if the address is within the Hart 2 legal address region
            valid_addr = (H2_ACCESS) ? 1'b1 : 1'b0;
        end
        else if ( (start_addr_H3 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H3) ) begin  // check if the address is within the Hart 3 legal address region
            valid_addr = (H3_ACCESS) ? 1'b1 : 1'b0;
        end
        else if ( (start_addr_H4 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H4) ) begin  // check if the address is within the Hart 4 legal address region
            valid_addr = (H4_ACCESS) ? 1'b1 : 1'b0;
        end
        else if ( (start_addr_H5 <= PADDR_req[19:0]) && (PADDR_req[19:0] < end_addr_H5) ) begin    // check if the address is within the Hart 5 legal address region
            valid_addr = (H5_ACCESS) ? 1'b1 : 1'b0;
        end
        else begin
            valid_addr = 1'b0;  // address is invalid if it's not within the Hart 0 to Hart 5 legal ranges or the MIV_IHC IP Version address
        end
    end

// APB DEMUX to select between the APB Error Target or the valid transaction response
always @(*)
    begin
        if (valid_addr) begin  // if the address is valid, MPU is transparent
            PRDATA_resp    = PRDATA_IHC_resp;
            PREADY_resp    = PREADY_IHC_resp;
            PSLVERR_resp   = PSLVERR_IHC_resp;

            PADDR_IHC_req   = PADDR_req;
            PENABLE_IHC_req = PENABLE_req;
            PSEL_IHC_req    = PSEL_req;
            PWDATA_IHC_req  = PWDATA_req;
            PWRITE_IHC_req  = PWRITE_req;
        
        end else begin  // if the address is invalid, route the Initiator sigals and response to an Error Target
            // The Error Target will always return an error transaction
            PRDATA_resp  = ERROR_DATA_RESP;

            // Following the APB recommendations, we only assert the error signal if there is actually a request.
            PSLVERR_resp = (PSEL_req & PENABLE_req) ? 1'b1 : 1'b0;
            PREADY_resp  = (PSEL_req & PENABLE_req) ? 1'b1 : 1'b0;

            // If the address is invalid, the core logic will not notice any transaction
            PADDR_IHC_req   = 32'b0;
            PENABLE_IHC_req = 1'b0;
            PSEL_IHC_req    = 1'b0;
            PWDATA_IHC_req  = 32'b0;
            PWRITE_IHC_req  = 1'b1;
        end
    end
endmodule


`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module miv_ihc_apb_target_top (
    // Inputs
    dest_PRDATA_i,
    dest_PREADY_i,
    dest_PSLVERR_i,
    dest_clk,
    dest_rst_n,
    src_PADDR_i,
    src_PENABLE_i,
    src_PSEL_i,
    src_PWDATA_i,
    src_PWRITE_i,
    src_clk,
    src_rst_n,
    // Outputs
    dest_PADDR_o,
    dest_PENABLE_o,
    dest_PSEL_o,
    dest_PWDATA_o,
    dest_PWRITE_o,
    src_PRDATA_o,
    src_PREADY_o,
    src_PSLVERR_o
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
parameter SYNC_RESET = 0;
parameter CDC_EN = 0;
parameter MPU_EN = 0;
parameter H0_ACCESS = 0;
parameter H1_ACCESS	= 0;
parameter H2_ACCESS	= 0;
parameter H3_ACCESS	= 0;
parameter H4_ACCESS	= 0;
parameter H5_ACCESS	= 0;

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input wire logic  [31:0] dest_PRDATA_i;
input wire logic         dest_PREADY_i;
input wire logic         dest_PSLVERR_i;
input wire logic         dest_clk;
input wire logic         dest_rst_n;
input wire logic  [31:0] src_PADDR_i;
input wire logic         src_PENABLE_i;
input wire logic         src_PSEL_i;
input wire logic  [31:0] src_PWDATA_i;
input wire logic         src_PWRITE_i;
input wire logic         src_clk;
input wire logic         src_rst_n;

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output logic [31:0] dest_PADDR_o;
output logic        dest_PENABLE_o;
output logic        dest_PSEL_o;
output logic [31:0] dest_PWDATA_o;
output logic        dest_PWRITE_o;
output logic [31:0] src_PRDATA_o;
output logic        src_PREADY_o;
output logic        src_PSLVERR_o;

//--------------------------------------------------------------------
// Internal Wires
//--------------------------------------------------------------------
wire [31:0] dest_PRDATA_i_net;
wire 		dest_PREADY_i_net;
wire 		dest_PSLVERR_i_net;
wire [31:0] dest_PADDR_o_net;
wire [31:0] dest_PWDATA_o_net;
wire 		dest_PWRITE_o_net;
wire 		dest_PSEL_o_net;
wire 		dest_PENABLE_o_net;

//--------------------------------------------------------------------
// Instantiate an APB CDC if CDC parameter is enabled, 
// Else, pass all signals through
//--------------------------------------------------------------------
generate 
    if (CDC_EN)
        begin: gen_cdc
			miv_ihc_apb_cdc #(
			.SYNC_RESET(SYNC_RESET)
			)
			apb_cdc_0 (
			// Inputs
			.src_clk        ( src_clk ),
			.src_rst_n      ( src_rst_n ),
			.src_PADDR_i    ( src_PADDR_i ),
			.src_PWDATA_i   ( src_PWDATA_i ),
			.src_PWRITE_i   ( src_PWRITE_i ),
			.src_PSEL_i     ( src_PSEL_i ),
			.src_PENABLE_i  ( src_PENABLE_i ),
			.dest_clk       ( dest_clk ),
			.dest_rst_n     ( dest_rst_n ),
			.dest_PRDATA_i  ( dest_PRDATA_i_net ),
			.dest_PREADY_i  ( dest_PREADY_i_net ),
			.dest_PSLVERR_i ( dest_PSLVERR_i_net ),
			// Outputs
			.src_PRDATA_o   ( src_PRDATA_o ),
			.src_PREADY_o   ( src_PREADY_o ),
			.src_PSLVERR_o  ( src_PSLVERR_o ),
			.dest_PADDR_o   ( dest_PADDR_o_net ),
			.dest_PWDATA_o  ( dest_PWDATA_o_net ),
			.dest_PWRITE_o  ( dest_PWRITE_o_net ),
			.dest_PSEL_o    ( dest_PSEL_o_net),
			.dest_PENABLE_o ( dest_PENABLE_o_net ) 
			);
        end
    else
        begin: ngen_cdc
            assign dest_PADDR_o_net 	= src_PADDR_i;
			assign dest_PENABLE_o_net	= src_PENABLE_i;
			assign dest_PSEL_o_net 		= src_PSEL_i;
			assign dest_PWDATA_o_net	= src_PWDATA_i;
			assign dest_PWRITE_o_net 	= src_PWRITE_i;
			assign src_PRDATA_o 		= dest_PRDATA_i_net;
			assign src_PREADY_o 		= dest_PREADY_i_net;
			assign src_PSLVERR_o 		= dest_PSLVERR_i_net;
        end
endgenerate 

//--------------------------------------------------------------------
// Instantiate an MPU to monitor for invalid transactions if MPU_EN enabled, 
// Else, pass all signals through
//--------------------------------------------------------------------
generate
	if (MPU_EN) 
		begin: gen_mpu
			miv_ihc_apb_mpu #(
			.H0_ACCESS(H0_ACCESS),
			.H1_ACCESS(H1_ACCESS),
			.H2_ACCESS(H2_ACCESS),
			.H3_ACCESS(H3_ACCESS),
			.H4_ACCESS(H4_ACCESS),
			.H5_ACCESS(H5_ACCESS)
			)
			apb_mpu_0 (
			// Inputs
			.PADDR_req	     ( dest_PADDR_o_net ),
			.PWDATA_req 	 ( dest_PWDATA_o_net ),
			.PWRITE_req	     ( dest_PWRITE_o_net ),
			.PSEL_req     	 ( dest_PSEL_o_net ),
			.PENABLE_req  	 ( dest_PENABLE_o_net ),

			// Target Response from the MIV_IHC Core logic
			.PRDATA_IHC_resp    ( dest_PRDATA_i ),
			.PREADY_IHC_resp    ( dest_PREADY_i ),
			.PSLVERR_IHC_resp   ( dest_PSLVERR_i ),

			// Outputs
			// Top-level Target Response after MPU applied
			.PRDATA_resp  	( dest_PRDATA_i_net ),
			.PREADY_resp   	( dest_PREADY_i_net ),
			.PSLVERR_resp  	( dest_PSLVERR_i_net ),

			// Initiator activity seen by the MIV_IHC Core logic
			.PADDR_IHC_req(dest_PADDR_o),
			.PENABLE_IHC_req(dest_PENABLE_o),
			.PSEL_IHC_req(dest_PSEL_o),
			.PWDATA_IHC_req(dest_PWDATA_o),
			.PWRITE_IHC_req(dest_PWRITE_o)
			);
		end
	else
		begin: ngen_mpu
			assign dest_PADDR_o 		= dest_PADDR_o_net;
			assign dest_PENABLE_o 		= dest_PENABLE_o_net;
			assign dest_PSEL_o 			= dest_PSEL_o_net;
			assign dest_PWDATA_o 		= dest_PWDATA_o_net;
			assign dest_PWRITE_o 		= dest_PWRITE_o_net;
			assign dest_PRDATA_i_net 	= dest_PRDATA_i;
			assign dest_PREADY_i_net 	= dest_PREADY_i;
			assign dest_PSLVERR_i_net 	= dest_PSLVERR_i;
		end
endgenerate

endmodule

`default_nettype wire
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>

module miv_ihc_fifo_v3 #(
    parameter              SYNC_RESET   = 0,
    parameter bit          FALL_THROUGH = 1'b0, // fifo is in fall-through mode
    parameter int unsigned DATA_WIDTH   = 32,   // default data width if the fifo is of type logic
    parameter int unsigned DEPTH        = 8,    // depth can be arbitrary from 0 to 2**32
    parameter type dtype                = logic [DATA_WIDTH-1:0],
    // DO NOT OVERWRITE THIS PARAMETER
    parameter int unsigned ADDR_DEPTH   = (DEPTH > 1) ? $clog2(DEPTH) : 1
)(
    input  logic  clk_i,            // Clock
    input  logic  rst_ni,           // reset active low
    input  logic  flush_i,          // flush the queue
    input  logic  testmode_i,       // test_mode to bypass clock gating
    // status flags
    output logic  full_o,           // queue is full
    output logic  empty_o,          // queue is empty
    output logic  [ADDR_DEPTH-1:0] usage_o,  // fill pointer
    // as long as the queue is not full we can push new data
    input  dtype  data_i,           // data to push into the queue
    input  logic  push_i,           // data is valid and can be pushed to the queue
    // as long as the queue is not empty we can pop new elements
    output dtype  data_o,           // output data
    input  logic  pop_i             // pop head from queue
);
    // local parameter
    // FIFO depth - handle the case of pass-through, synthesizer will do constant propagation
    localparam int unsigned FIFO_DEPTH = (DEPTH > 0) ? DEPTH : 1;

    // asynchronous/synchronous signals
    logic aresetn;
    logic sresetn; 

    // clock gating control
    logic gate_clock;
    // pointer to the read and write section of the queue
    logic [ADDR_DEPTH - 1:0] read_pointer_n, read_pointer_q, write_pointer_n, write_pointer_q;
    // keep a counter to keep track of the current queue status
    logic [ADDR_DEPTH:0] status_cnt_n, status_cnt_q; // this integer will be truncated by the synthesis tool
    // actual memory
    dtype [FIFO_DEPTH - 1:0] mem_n, mem_q;

    assign aresetn = (SYNC_RESET==1) ? 1'b1 : rst_ni;
    assign sresetn = (SYNC_RESET==1) ? rst_ni : 1'b1;

    assign usage_o = status_cnt_q[ADDR_DEPTH-1:0];

    if (DEPTH == 0) begin
        assign empty_o     = ~push_i;
        assign full_o      = ~pop_i;
    end else begin
        assign full_o       = (status_cnt_q == FIFO_DEPTH[ADDR_DEPTH:0]);
        assign empty_o      = (status_cnt_q == 0) & ~(FALL_THROUGH & push_i);
    end
    // status flags

    // read and write queue logic
    always_comb begin : read_write_comb
        // default assignment
        read_pointer_n  = read_pointer_q;
        write_pointer_n = write_pointer_q;
        status_cnt_n    = status_cnt_q;
        data_o          = (DEPTH == 0) ? data_i : mem_q[read_pointer_q];
        mem_n           = mem_q;
        gate_clock      = 1'b1;

        // push a new element to the queue
        if (push_i && ~full_o) begin
            // push the data onto the queue
            mem_n[write_pointer_q] = data_i;
            // un-gate the clock, we want to write something
            gate_clock = 1'b0;
            // increment the write counter
            if (write_pointer_q == FIFO_DEPTH[ADDR_DEPTH-1:0] - 1)
                write_pointer_n = '0;
            else
                write_pointer_n = write_pointer_q + 1;
            // increment the overall counter
            status_cnt_n    = status_cnt_q + 1;
        end

        if (pop_i && ~empty_o) begin
            // read from the queue is a default assignment
            // but increment the read pointer...
            if (read_pointer_n == FIFO_DEPTH[ADDR_DEPTH-1:0] - 1)
                read_pointer_n = '0;
            else
                read_pointer_n = read_pointer_q + 1;
            // ... and decrement the overall count
            status_cnt_n   = status_cnt_q - 1;
        end

        // keep the count pointer stable if we push and pop at the same time
        if (push_i && pop_i &&  ~full_o && ~empty_o)
            status_cnt_n   = status_cnt_q;

        // FIFO is in pass through mode -> do not change the pointers
        if (FALL_THROUGH && (status_cnt_q == 0) && push_i) begin
            data_o = data_i;
            if (pop_i) begin
                status_cnt_n = status_cnt_q;
                read_pointer_n = read_pointer_q;
                write_pointer_n = write_pointer_q;
            end
        end
    end

    // sequential process
    always_ff @(posedge clk_i or negedge aresetn) begin
        if((!aresetn) || (!sresetn)) begin
            read_pointer_q  <= '0;
            write_pointer_q <= '0;
            status_cnt_q    <= '0;
        end else begin
            if (flush_i) begin
                read_pointer_q  <= '0;
                write_pointer_q <= '0;
                status_cnt_q    <= '0;
             end else begin
                read_pointer_q  <= read_pointer_n;
                write_pointer_q <= write_pointer_n;
                status_cnt_q    <= status_cnt_n;
            end
        end
    end

    always_ff @(posedge clk_i or negedge aresetn) begin
        if((!aresetn) || (!sresetn)) begin
            mem_q <= '0;
        end else if (!gate_clock) begin
            mem_q <= mem_n;
        end
    end

// pragma translate_off
`ifndef VERILATOR
    initial begin
        assert (DEPTH > 0)             else $error("DEPTH must be greater than 0.");
    end

    full_write : assert property(
        @(posedge clk_i) disable iff (~rst_ni) (full_o |-> ~push_i))
        else $fatal (1, "Trying to push new data although the FIFO is full.");

    empty_read : assert property(
        @(posedge clk_i) disable iff (~rst_ni) (empty_o |-> ~pop_i))
        else $fatal (1, "Trying to pop data although the FIFO is empty.");
`endif
// pragma translate_on

endmodule // miv_ihc_fifo_v3
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>

module miv_ihc_fifo_v2 #(
    parameter              SYNC_RESET   = 0,
    parameter bit          FALL_THROUGH = 1'b0, // fifo is in fall-through mode
    parameter int unsigned DATA_WIDTH   = 32,   // default data width if the fifo is of type logic
    parameter int unsigned DEPTH        = 8,    // depth can be arbitrary from 0 to 2**32
    parameter int unsigned ALM_EMPTY_TH = 1,    // almost empty threshold (when to assert alm_empty_o)
    parameter int unsigned ALM_FULL_TH  = 1,    // almost full threshold (when to assert alm_full_o)
    parameter type dtype                = logic [DATA_WIDTH-1:0],
    // DO NOT OVERWRITE THIS PARAMETER
    parameter int unsigned ADDR_DEPTH   = (DEPTH > 1) ? $clog2(DEPTH) : 1
)(
    input  logic  clk_i,            // Clock
    input  logic  rst_ni,           // Asynchronous reset active low
    input  logic  flush_i,          // flush the queue
    input  logic  testmode_i,       // test_mode to bypass clock gating
    // status flags
    output logic  full_o,           // queue is full
    output logic  empty_o,          // queue is empty
    output logic  alm_full_o,       // FIFO fillstate >= the specified threshold
    output logic  alm_empty_o,      // FIFO fillstate <= the specified threshold
    // as long as the queue is not full we can push new data
    input  dtype  data_i,           // data to push into the queue
    input  logic  push_i,           // data is valid and can be pushed to the queue
    // as long as the queue is not empty we can pop new elements
    output dtype  data_o,           // output data
    input  logic  pop_i             // pop head from queue
);

    logic [ADDR_DEPTH-1:0] usage;

    // generate threshold parameters
    if (DEPTH == 0) begin
        assign alm_full_o  = 1'b0; // that signal does not make any sense in a FIFO of depth 0
        assign alm_empty_o = 1'b0; // that signal does not make any sense in a FIFO of depth 0
    end else begin
        assign alm_full_o   = (usage >= ALM_FULL_TH[ADDR_DEPTH-1:0]);
        assign alm_empty_o  = (usage <= ALM_EMPTY_TH[ADDR_DEPTH-1:0]);
    end

    miv_ihc_fifo_v3 #(
        .SYNC_RESET   ( SYNC_RESET   ),
        .FALL_THROUGH ( FALL_THROUGH ),
        .DATA_WIDTH   ( DATA_WIDTH   ),
        .DEPTH        ( DEPTH        ),
        .dtype        ( dtype        )
    ) i_fifo_v3 (
        .clk_i,
        .rst_ni,
        .flush_i,
        .testmode_i,
        .full_o,
        .empty_o,
        .usage_o (usage),
        .data_i,
        .push_i,
        .data_o,
        .pop_i
    );

    // pragma translate_off
    `ifndef VERILATOR
        initial begin
            assert (ALM_FULL_TH <= DEPTH)  else $error("ALM_FULL_TH can't be larger than the DEPTH.");
            assert (ALM_EMPTY_TH <= DEPTH) else $error("ALM_EMPTY_TH can't be larger than the DEPTH.");
        end
    `endif
    // pragma translate_on

endmodule // miv_ihc_fifo_v2
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>

/* verilator lint_off DECLFILENAME */

module miv_ihc_fifo #(
    parameter              SYNC_RESET   = 0,
    parameter bit          FALL_THROUGH = 1'b0, // fifo is in fall-through mode
    parameter int unsigned DATA_WIDTH   = 32,   // default data width if the fifo is of type logic
    parameter int unsigned DEPTH        = 8,    // depth can be arbitrary from 0 to 2**32
    parameter int unsigned THRESHOLD    = 1,    // fill count until when to assert threshold_o
    parameter type dtype                = logic [DATA_WIDTH-1:0]
)(
    input  logic  clk_i,            // Clock
    input  logic  rst_ni,           // Asynchronous reset active low
    input  logic  flush_i,          // flush the queue
    input  logic  testmode_i,       // test_mode to bypass clock gating
    // status flags
    output logic  full_o,           // queue is full
    output logic  empty_o,          // queue is empty
    output logic  threshold_o,      // the FIFO is above the specified threshold
    // as long as the queue is not full we can push new data
    input  dtype  data_i,           // data to push into the queue
    input  logic  push_i,           // data is valid and can be pushed to the queue
    // as long as the queue is not empty we can pop new elements
    output dtype  data_o,           // output data
    input  logic  pop_i             // pop head from queue
);
    miv_ihc_fifo_v2 #(
        .SYNC_RESET   ( SYNC_RESET   ),
        .FALL_THROUGH ( FALL_THROUGH ),
        .DATA_WIDTH   ( DATA_WIDTH   ),
        .DEPTH        ( DEPTH        ),
        .ALM_FULL_TH  ( THRESHOLD    ),
        .dtype        ( dtype        )
    ) impl (
        .clk_i       ( clk_i       ),
        .rst_ni      ( rst_ni      ),
        .flush_i     ( flush_i     ),
        .testmode_i  ( testmode_i  ),
        .full_o      ( full_o      ),
        .empty_o     ( empty_o     ),
        .alm_full_o  ( threshold_o ),
        .alm_empty_o (             ),
        .data_i      ( data_i      ),
        .push_i      ( push_i      ),
        .data_o      ( data_o      ),
        .pop_i       ( pop_i       )
    );

endmodule
/* verilator lint_on DECLFILENAME */
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/// Wrapper for a generic fifo

module miv_ihc_axi_single_slice #(
    parameter SYNC_RESET       = 0,
    parameter int BUFFER_DEPTH = -1,
    parameter int DATA_WIDTH   = -1
) (
    input  logic                  clk_i,    // Clock
    input  logic                  rst_ni,  // Asynchronous reset active low
    input  logic                  testmode_i,
    input  logic                  valid_i,
    output logic                  ready_o,
    input  logic [DATA_WIDTH-1:0] data_i,

    input  logic                  ready_i,
    output logic                  valid_o,
    output logic [DATA_WIDTH-1:0] data_o
);

    logic full, empty;

    assign ready_o = ~full;
    assign valid_o = ~empty;

    miv_ihc_fifo #(
        .SYNC_RESET   ( SYNC_RESET   ),
        .FALL_THROUGH ( 1'b0         ),
        .DATA_WIDTH   ( DATA_WIDTH   ),
        .DEPTH        ( BUFFER_DEPTH )
    ) i_fifo (
        .clk_i      ( clk_i             ),
        .rst_ni     ( rst_ni            ),
        .flush_i    ( 1'b0              ),
        .threshold_o (), // NC
        .testmode_i ( testmode_i        ),
        .full_o     ( full              ),
        .empty_o    ( empty             ),
        .data_i     ( data_i            ),
        .push_i     ( valid_i & ready_o ),
        .data_o     ( data_o            ),
        .pop_i      ( ready_i & valid_o )
    );

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Davide Rossi <davide.rossi@unibo.it>

module miv_ihc_axi_ar_buffer #(
    parameter SYNC_RESET       =  0,
    parameter int ID_WIDTH     = -1,
    parameter int ADDR_WIDTH   = -1,
    parameter int USER_WIDTH   = -1,
    parameter int BUFFER_DEPTH = -1
)(

    input logic                   clk_i,
    input logic                   rst_ni,
    input logic                   test_en_i,

    input  logic                  slave_valid_i,
    input  logic [ADDR_WIDTH-1:0] slave_addr_i,
    input  logic [2:0]            slave_prot_i,
    input  logic [3:0]            slave_region_i,
    input  logic [7:0]            slave_len_i,
    input  logic [2:0]            slave_size_i,
    input  logic [1:0]            slave_burst_i,
    input  logic                  slave_lock_i,
    input  logic [3:0]            slave_cache_i,
    input  logic [3:0]            slave_qos_i,
    input  logic [ID_WIDTH-1:0]   slave_id_i,
    input  logic [USER_WIDTH-1:0] slave_user_i,
    output logic                  slave_ready_o,

    output logic                  master_valid_o,
    output logic [ADDR_WIDTH-1:0] master_addr_o,
    output logic [2:0]            master_prot_o,
    output logic [3:0]            master_region_o,
    output logic [7:0]            master_len_o,
    output logic [2:0]            master_size_o,
    output logic [1:0]            master_burst_o,
    output logic                  master_lock_o,
    output logic [3:0]            master_cache_o,
    output logic [3:0]            master_qos_o,
    output logic [ID_WIDTH-1:0]   master_id_o,
    output logic [USER_WIDTH-1:0] master_user_o,
    input  logic                  master_ready_i
);

   logic [29+ADDR_WIDTH+USER_WIDTH+ID_WIDTH-1:0] s_data_in;
   logic [29+ADDR_WIDTH+USER_WIDTH+ID_WIDTH-1:0] s_data_out;

   assign s_data_in = {slave_cache_i,  slave_prot_i,  slave_lock_i,  slave_burst_i,  slave_size_i,  slave_len_i,  slave_qos_i,  slave_region_i,  slave_addr_i,  slave_user_i,  slave_id_i} ;
   assign             {master_cache_o, master_prot_o, master_lock_o, master_burst_o, master_size_o, master_len_o, master_qos_o, master_region_o, master_addr_o, master_user_o, master_id_o} =  s_data_out;



  miv_ihc_axi_single_slice #(.BUFFER_DEPTH(BUFFER_DEPTH), .DATA_WIDTH(29+ADDR_WIDTH+USER_WIDTH+ID_WIDTH), .SYNC_RESET(SYNC_RESET)) i_axi_single_slice (
    .clk_i      ( clk_i          ),
    .rst_ni     ( rst_ni         ),
    .testmode_i ( test_en_i      ),
    .valid_i    ( slave_valid_i  ),
    .ready_o    ( slave_ready_o  ),
    .data_i     ( s_data_in      ),
    .ready_i    ( master_ready_i ),
    .valid_o    ( master_valid_o ),
    .data_o     ( s_data_out     )
  );

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Davide Rossi <davide.rossi@unibo.it>

module miv_ihc_axi_aw_buffer #(
    parameter SYNC_RESET       = 0,
    parameter int ID_WIDTH     = -1,
    parameter int ADDR_WIDTH   = -1,
    parameter int USER_WIDTH   = -1,
    parameter int BUFFER_DEPTH = -1
)(

    input logic                   clk_i,
    input logic                   rst_ni,
    input logic                   test_en_i,

    input  logic                  slave_valid_i,
    input  logic [ADDR_WIDTH-1:0] slave_addr_i,
    input  logic [2:0]            slave_prot_i,
    input  logic [3:0]            slave_region_i,
    input  logic [7:0]            slave_len_i,
    input  logic [2:0]            slave_size_i,
    input  logic [1:0]            slave_burst_i,
    input  logic                  slave_lock_i,
    input  logic [5:0]            slave_atop_i,
    input  logic [3:0]            slave_cache_i,
    input  logic [3:0]            slave_qos_i,
    input  logic [ID_WIDTH-1:0]   slave_id_i,
    input  logic [USER_WIDTH-1:0] slave_user_i,
    output logic                  slave_ready_o,

    output logic                  master_valid_o,
    output logic [ADDR_WIDTH-1:0] master_addr_o,
    output logic [2:0]            master_prot_o,
    output logic [3:0]            master_region_o,
    output logic [7:0]            master_len_o,
    output logic [2:0]            master_size_o,
    output logic [1:0]            master_burst_o,
    output logic                  master_lock_o,
    output logic [5:0]            master_atop_o,
    output logic [3:0]            master_cache_o,
    output logic [3:0]            master_qos_o,
    output logic [ID_WIDTH-1:0]   master_id_o,
    output logic [USER_WIDTH-1:0] master_user_o,
    input  logic                  master_ready_i
);

   localparam int unsigned DATA_WIDTH = 29+6+ADDR_WIDTH+USER_WIDTH+ID_WIDTH;

   logic [DATA_WIDTH-1:0] s_data_in;
   logic [DATA_WIDTH-1:0] s_data_out;



   assign s_data_in = {slave_cache_i,  slave_prot_i,  slave_lock_i,  slave_atop_i,  slave_burst_i,  slave_size_i,  slave_len_i,  slave_qos_i,  slave_region_i,  slave_addr_i,  slave_user_i,  slave_id_i};
   assign             {master_cache_o, master_prot_o, master_lock_o, master_atop_o, master_burst_o, master_size_o, master_len_o, master_qos_o, master_region_o, master_addr_o, master_user_o, master_id_o} = s_data_out;


    miv_ihc_axi_single_slice #(.BUFFER_DEPTH(BUFFER_DEPTH), .DATA_WIDTH(DATA_WIDTH), .SYNC_RESET(SYNC_RESET)) i_axi_single_slice (
      .clk_i      ( clk_i          ),
      .rst_ni     ( rst_ni         ),
      .testmode_i ( test_en_i      ),
      .valid_i    ( slave_valid_i  ),
      .ready_o    ( slave_ready_o  ),
      .data_i     ( s_data_in      ),
      .ready_i    ( master_ready_i ),
      .valid_o    ( master_valid_o ),
      .data_o     ( s_data_out     )
    );

endmodule

// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Davide Rossi <davide.rossi@unibo.it>

module miv_ihc_axi_b_buffer #(
    parameter SYNC_RESET       =  0,
    parameter int ID_WIDTH     = -1,
    parameter int USER_WIDTH   = -1,
    parameter int BUFFER_DEPTH = -1
)(
   input logic                   clk_i,
   input logic                   rst_ni,
   input logic                   test_en_i,

   input logic                   slave_valid_i,
   input logic  [1:0]            slave_resp_i,
   input logic  [ID_WIDTH-1:0]   slave_id_i,
   input logic  [USER_WIDTH-1:0] slave_user_i,
   output logic                  slave_ready_o,

   output logic                  master_valid_o,
   output logic [1:0]            master_resp_o,
   output logic [ID_WIDTH-1:0]   master_id_o,
   output logic [USER_WIDTH-1:0] master_user_o,
   input  logic                  master_ready_i
);

    logic [2+USER_WIDTH+ID_WIDTH-1:0] s_data_in;
    logic [2+USER_WIDTH+ID_WIDTH-1:0] s_data_out;

    assign s_data_in = {slave_id_i,  slave_user_i,  slave_resp_i};
    assign             {master_id_o, master_user_o, master_resp_o} = s_data_out;


    miv_ihc_axi_single_slice #(.BUFFER_DEPTH(BUFFER_DEPTH), .DATA_WIDTH(2+USER_WIDTH+ID_WIDTH), .SYNC_RESET(SYNC_RESET)) i_axi_single_slice (
      .clk_i      ( clk_i          ),
      .rst_ni     ( rst_ni         ),
      .testmode_i ( test_en_i      ),
      .valid_i    ( slave_valid_i  ),
      .ready_o    ( slave_ready_o  ),
      .data_i     ( s_data_in      ),
      .ready_i    ( master_ready_i ),
      .valid_o    ( master_valid_o ),
      .data_o     ( s_data_out     )
    );

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Davide Rossi <davide.rossi@unibo.it>

module miv_ihc_axi_r_buffer #(
   parameter SYNC_RESET    = 0,
   parameter ID_WIDTH      = 4,
   parameter DATA_WIDTH    = 64,
   parameter USER_WIDTH    = 6,
   parameter BUFFER_DEPTH  = 8,
   parameter STRB_WIDTH    = DATA_WIDTH/8   // DO NOT OVERRIDE
)(
   input logic                   clk_i,
   input logic                   rst_ni,
   input logic                   test_en_i,

   input logic                   slave_valid_i,
   input logic  [DATA_WIDTH-1:0] slave_data_i,
   input logic  [1:0]            slave_resp_i,
   input logic  [USER_WIDTH-1:0] slave_user_i,
   input logic  [ID_WIDTH-1:0]   slave_id_i,
   input logic                   slave_last_i,
   output logic                  slave_ready_o,

   output logic                  master_valid_o,
   output logic [DATA_WIDTH-1:0] master_data_o,
   output logic [1:0]            master_resp_o,
   output logic [USER_WIDTH-1:0] master_user_o,
   output logic [ID_WIDTH-1:0]   master_id_o,
   output logic                  master_last_o,
   input  logic                  master_ready_i
);

   logic [2+DATA_WIDTH+USER_WIDTH+ID_WIDTH:0] s_data_in;
   logic [2+DATA_WIDTH+USER_WIDTH+ID_WIDTH:0] s_data_out;


   assign s_data_in =  {slave_id_i,  slave_user_i,  slave_data_i,  slave_resp_i,  slave_last_i};
   assign              {master_id_o, master_user_o, master_data_o, master_resp_o, master_last_o} = s_data_out;

   miv_ihc_axi_single_slice #(.BUFFER_DEPTH(BUFFER_DEPTH), .DATA_WIDTH(3+DATA_WIDTH+USER_WIDTH+ID_WIDTH), .SYNC_RESET(SYNC_RESET)) i_axi_single_slice (
     .clk_i      ( clk_i          ),
     .rst_ni     ( rst_ni         ),
     .testmode_i ( test_en_i      ),
     .valid_i    ( slave_valid_i  ),
     .ready_o    ( slave_ready_o  ),
     .data_i     ( s_data_in      ),
     .ready_i    ( master_ready_i ),
     .valid_o    ( master_valid_o ),
     .data_o     ( s_data_out     )
   );

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Davide Rossi <davide.rossi@unibo.it>

module miv_ihc_axi_w_buffer #(
    parameter SYNC_RESET       =  0,
    parameter int DATA_WIDTH   = -1,
    parameter int USER_WIDTH   = -1,
    parameter int BUFFER_DEPTH = -1,
    parameter int STRB_WIDTH   = DATA_WIDTH/8   // DO NOT OVERRIDE
)(
    input logic                   clk_i,
    input logic                   rst_ni,
    input logic                   test_en_i,

    input logic                   slave_valid_i,
    input logic  [DATA_WIDTH-1:0] slave_data_i,
    input logic  [STRB_WIDTH-1:0] slave_strb_i,
    input logic  [USER_WIDTH-1:0] slave_user_i,
    input logic                   slave_last_i,
    output logic                  slave_ready_o,

    output logic                  master_valid_o,
    output logic [DATA_WIDTH-1:0] master_data_o,
    output logic [STRB_WIDTH-1:0] master_strb_o,
    output logic [USER_WIDTH-1:0] master_user_o,
    output logic                  master_last_o,
    input  logic                  master_ready_i
);

    logic [DATA_WIDTH+STRB_WIDTH+USER_WIDTH:0] s_data_in;
    logic [DATA_WIDTH+STRB_WIDTH+USER_WIDTH:0] s_data_out;

    assign s_data_in = { slave_user_i,  slave_strb_i,  slave_data_i,  slave_last_i  };
    assign             { master_user_o, master_strb_o, master_data_o, master_last_o } = s_data_out;

    miv_ihc_axi_single_slice #(.BUFFER_DEPTH(BUFFER_DEPTH), .DATA_WIDTH(1+DATA_WIDTH+STRB_WIDTH+USER_WIDTH), .SYNC_RESET(SYNC_RESET)) i_axi_single_slice (
      .clk_i      ( clk_i          ),
      .rst_ni     ( rst_ni         ),
      .testmode_i ( test_en_i      ),
      .valid_i    ( slave_valid_i  ),
      .ready_o    ( slave_ready_o  ),
      .data_i     ( s_data_in      ),
      .ready_i    ( master_ready_i ),
      .valid_o    ( master_valid_o ),
      .data_o     ( s_data_out     )
    );

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

// Copyright 2014-2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Igor Loi <igor.loi@unibo.it>
// Davide Rossi <davide.rossi@unibo.it>
// Florian Zaruba <zarubaf@iis.ee.ethz.ch>

`define OKAY   2'b00
`define EXOKAY 2'b01
`define SLVERR 2'b10
`define DECERR 2'b11

module miv_ihc_axi2apb
#(
    parameter SYNC_RESET         = 0,
    parameter AXI4_ADDRESS_WIDTH = 32,
    parameter AXI4_RDATA_WIDTH   = 32,
    parameter AXI4_WDATA_WIDTH   = 32,
    parameter AXI4_ID_WIDTH      = 16,
    parameter AXI4_USER_WIDTH    = 10,
    parameter AXI_NUMBYTES       = AXI4_WDATA_WIDTH/8,

    parameter BUFF_DEPTH_SLAVE   = 4,
    parameter APB_ADDR_WIDTH     = 32
)
(
    input logic                           ACLK,
    input logic                           ARESETn,
    input logic                           test_en_i,

    input  logic [AXI4_ID_WIDTH-1:0]      AWID_i,
    input  logic [AXI4_ADDRESS_WIDTH-1:0] AWADDR_i,
    input  logic [ 7:0]                   AWLEN_i,
    input  logic [ 2:0]                   AWSIZE_i,
    input  logic [ 1:0]                   AWBURST_i,
    input  logic                          AWLOCK_i,
    input  logic [ 3:0]                   AWCACHE_i,
    input  logic [ 2:0]                   AWPROT_i,
    input  logic [ 3:0]                   AWREGION_i,
    input  logic [ AXI4_USER_WIDTH-1:0]   AWUSER_i,
    input  logic [ 3:0]                   AWQOS_i,
    input  logic                          AWVALID_i,
    output logic                          AWREADY_o,

    input  logic [AXI4_WDATA_WIDTH-1:0]   WDATA_i,
    input  logic [AXI_NUMBYTES-1:0]       WSTRB_i,
    input  logic                          WLAST_i,
    input  logic [AXI4_USER_WIDTH-1:0]    WUSER_i,
    input  logic                          WVALID_i,
    output logic                          WREADY_o,

    output logic   [AXI4_ID_WIDTH-1:0]    BID_o,
    output logic   [ 1:0]                 BRESP_o,
    output logic                          BVALID_o,
    output logic   [AXI4_USER_WIDTH-1:0]  BUSER_o,
    input  logic                          BREADY_i,

    input  logic [AXI4_ID_WIDTH-1:0]      ARID_i,
    input  logic [AXI4_ADDRESS_WIDTH-1:0] ARADDR_i,
    input  logic [ 7:0]                   ARLEN_i,
    input  logic [ 2:0]                   ARSIZE_i,
    input  logic [ 1:0]                   ARBURST_i,
    input  logic                          ARLOCK_i,
    input  logic [ 3:0]                   ARCACHE_i,
    input  logic [ 2:0]                   ARPROT_i,
    input  logic [ 3:0]                   ARREGION_i,
    input  logic [ AXI4_USER_WIDTH-1:0]   ARUSER_i,
    input  logic [ 3:0]                   ARQOS_i,
    input  logic                          ARVALID_i,
    output logic                          ARREADY_o,

    output  logic [AXI4_ID_WIDTH-1:0]     RID_o,
    output  logic [AXI4_RDATA_WIDTH-1:0]  RDATA_o,
    output  logic [ 1:0]                  RRESP_o,
    output  logic                         RLAST_o,
    output  logic [AXI4_USER_WIDTH-1:0]   RUSER_o,
    output  logic                         RVALID_o,
    input   logic                         RREADY_i,

    output logic                          PENABLE,
    output logic                          PWRITE,
    output logic [APB_ADDR_WIDTH-1:0]     PADDR,
    output logic                          PSEL,
    output logic [AXI4_WDATA_WIDTH-1:0]   PWDATA,
    input  logic [AXI4_RDATA_WIDTH-1:0]   PRDATA,
    input  logic                          PREADY,
    input  logic                          PSLVERR
);

    // --------------------
    // sync/async reset mode
    // --------------------
    logic aresetn;
    logic sresetn; 

    // --------------------
    // AXI write address bus
    // --------------------
    logic [AXI4_ID_WIDTH-1:0]       AWID;
    logic [AXI4_ADDRESS_WIDTH-1:0]  AWADDR;
    logic [ 7:0]                    AWLEN;
    logic [ 2:0]                    AWSIZE;
    logic [ 1:0]                    AWBURST;
    logic                           AWLOCK;
    logic [ 3:0]                    AWCACHE;
    logic [ 2:0]                    AWPROT;
    logic [ 3:0]                    AWREGION;
    logic [ AXI4_USER_WIDTH-1:0]    AWUSER;
    logic [ 3:0]                    AWQOS;
    logic                           AWVALID;
    logic                           AWREADY;
    // --------------------
    // AXI write data bus
    // --------------------
    logic [AXI4_WDATA_WIDTH-1:0]    WDATA;  // from FIFO
    logic [AXI_NUMBYTES-1:0]        WSTRB;  // from FIFO
    logic                           WLAST;  // from FIFO
    logic [AXI4_USER_WIDTH-1:0]     WUSER;  // from FIFO
    logic                           WVALID; // from FIFO
    logic                           WREADY; // TO FIFO
    // --------------------
    // AXI write response bus
    // --------------------
    logic   [AXI4_ID_WIDTH-1:0]     BID;
    logic   [ 1:0]                  BRESP;
    logic                           BVALID;
    logic   [AXI4_USER_WIDTH-1:0]   BUSER;
    logic                           BREADY;
    // --------------------
    // AXI read address bus
    // --------------------
    logic [AXI4_ID_WIDTH-1:0]       ARID;
    logic [AXI4_ADDRESS_WIDTH-1:0]  ARADDR;
    logic [ 7:0]                    ARLEN;
    logic [ 2:0]                    ARSIZE;
    logic [ 1:0]                    ARBURST;
    logic                           ARLOCK;
    logic [ 3:0]                    ARCACHE;
    logic [ 2:0]                    ARPROT;
    logic [ 3:0]                    ARREGION;
    logic [ AXI4_USER_WIDTH-1:0]    ARUSER;
    logic [ 3:0]                    ARQOS;
    logic                           ARVALID;
    logic                           ARREADY;
    // --------------------
    // AXI read data bus
    // --------------------
    logic [AXI4_ID_WIDTH-1:0]       RID;
    logic [AXI4_RDATA_WIDTH-1:0]    RDATA;
    logic [ 1:0]                    RRESP;
    logic                           RLAST;
    logic [AXI4_USER_WIDTH-1:0]     RUSER;
    logic                           RVALID;
    logic                           RREADY;

  enum logic [2:0] { IDLE,
                     ACCESS_RD,
                     ACCESS_WR,
                     SETUP_WR,
                     DONE_SINGLE_RD,
                     WAIT_W_PREADY,
                     WAIT_R_PREADY,
                     SEND_B_RESP
                    } CS, NS;

  logic [AXI4_ADDRESS_WIDTH-1:0] address;
  logic sample_RDATA;

  logic [AXI4_RDATA_WIDTH-1:0] RDATA_Q;

  logic read_req;
  logic write_req;

  assign PENABLE = write_req | read_req;
  //assign PWRITE  = write_req;
  assign PADDR   = address[APB_ADDR_WIDTH-1:0];
  assign PWDATA  = WDATA;
  //assign PSEL    = 1'b1;

  assign aresetn = (SYNC_RESET==1) ? 1'b1 : ARESETn;
  assign sresetn = (SYNC_RESET==1) ? ARESETn : 1'b1;

   // AXI WRITE ADDRESS CHANNEL BUFFER
   miv_ihc_axi_aw_buffer #(
       .SYNC_RESET   ( SYNC_RESET         ),
       .ID_WIDTH     ( AXI4_ID_WIDTH      ),
       .ADDR_WIDTH   ( AXI4_ADDRESS_WIDTH ),
       .USER_WIDTH   ( AXI4_USER_WIDTH    ),
       .BUFFER_DEPTH ( BUFF_DEPTH_SLAVE   )
   ) slave_aw_buffer_i (
      .clk_i           ( ACLK        ),
      .rst_ni          ( ARESETn     ),
      .test_en_i       ( test_en_i   ),

      .slave_valid_i   ( AWVALID_i   ),
      .slave_addr_i    ( AWADDR_i    ),
      .slave_prot_i    ( AWPROT_i    ),
      .slave_region_i  ( AWREGION_i  ),
      .slave_len_i     ( AWLEN_i     ),
      .slave_size_i    ( AWSIZE_i    ),
      .slave_burst_i   ( AWBURST_i   ),
      .slave_lock_i    ( AWLOCK_i    ),
      .slave_cache_i   ( AWCACHE_i   ),
      .slave_qos_i     ( AWQOS_i     ),
      .slave_id_i      ( AWID_i      ),
      .slave_user_i    ( AWUSER_i    ),
      .slave_ready_o   ( AWREADY_o   ),

      .master_valid_o  ( AWVALID     ),
      .master_addr_o   ( AWADDR      ),
      .master_prot_o   ( AWPROT      ),
      .master_region_o ( AWREGION    ),
      .master_len_o    ( AWLEN       ),
      .master_size_o   ( AWSIZE      ),
      .master_burst_o  ( AWBURST     ),
      .master_lock_o   ( AWLOCK      ),
      .master_cache_o  ( AWCACHE     ),
      .master_qos_o    ( AWQOS       ),
      .master_id_o     ( AWID        ),
      .master_user_o   ( AWUSER      ),
      .master_ready_i  ( AWREADY     )
   );

   // AXI WRITE ADDRESS CHANNEL BUFFER
   miv_ihc_axi_ar_buffer #(
       .SYNC_RESET   ( SYNC_RESET         ),
       .ID_WIDTH     ( AXI4_ID_WIDTH      ),
       .ADDR_WIDTH   ( AXI4_ADDRESS_WIDTH ),
       .USER_WIDTH   ( AXI4_USER_WIDTH    ),
       .BUFFER_DEPTH ( BUFF_DEPTH_SLAVE   )
   ) slave_ar_buffer_i (
      .clk_i           ( ACLK       ),
      .rst_ni          ( ARESETn    ),
      .test_en_i       ( test_en_i  ),

      .slave_valid_i   ( ARVALID_i  ),
      .slave_addr_i    ( ARADDR_i   ),
      .slave_prot_i    ( ARPROT_i   ),
      .slave_region_i  ( ARREGION_i ),
      .slave_len_i     ( ARLEN_i    ),
      .slave_size_i    ( ARSIZE_i   ),
      .slave_burst_i   ( ARBURST_i  ),
      .slave_lock_i    ( ARLOCK_i   ),
      .slave_cache_i   ( ARCACHE_i  ),
      .slave_qos_i     ( ARQOS_i    ),
      .slave_id_i      ( ARID_i     ),
      .slave_user_i    ( ARUSER_i   ),
      .slave_ready_o   ( ARREADY_o  ),

      .master_valid_o  ( ARVALID    ),
      .master_addr_o   ( ARADDR     ),
      .master_prot_o   ( ARPROT     ),
      .master_region_o ( ARREGION   ),
      .master_len_o    ( ARLEN      ),
      .master_size_o   ( ARSIZE     ),
      .master_burst_o  ( ARBURST    ),
      .master_lock_o   ( ARLOCK     ),
      .master_cache_o  ( ARCACHE    ),
      .master_qos_o    ( ARQOS      ),
      .master_id_o     ( ARID       ),
      .master_user_o   ( ARUSER     ),
      .master_ready_i  ( ARREADY    )
   );


   miv_ihc_axi_w_buffer #(
       .SYNC_RESET     ( SYNC_RESET       ),
       .DATA_WIDTH     ( AXI4_WDATA_WIDTH ),
       .USER_WIDTH     ( AXI4_USER_WIDTH  ),
       .BUFFER_DEPTH   ( BUFF_DEPTH_SLAVE )
   ) slave_w_buffer_i (
        .clk_i          ( ACLK      ),
        .rst_ni         ( ARESETn   ),
        .test_en_i      ( test_en_i ),

        .slave_valid_i  ( WVALID_i  ),
        .slave_data_i   ( WDATA_i   ),
        .slave_strb_i   ( WSTRB_i   ),
        .slave_user_i   ( WUSER_i   ),
        .slave_last_i   ( WLAST_i   ),
        .slave_ready_o  ( WREADY_o  ),

        .master_valid_o ( WVALID    ),
        .master_data_o  ( WDATA     ),
        .master_strb_o  ( WSTRB     ),
        .master_user_o  ( WUSER     ),
        .master_last_o  ( WLAST     ),
        .master_ready_i ( WREADY    )
    );

   miv_ihc_axi_r_buffer #(
        .SYNC_RESET   ( SYNC_RESET       ),
        .ID_WIDTH     ( AXI4_ID_WIDTH    ),
        .DATA_WIDTH   ( AXI4_RDATA_WIDTH ),
        .USER_WIDTH   ( AXI4_USER_WIDTH  ),
        .BUFFER_DEPTH ( BUFF_DEPTH_SLAVE )
   ) slave_r_buffer_i (
        .clk_i          ( ACLK       ),
        .rst_ni         ( ARESETn    ),
        .test_en_i      ( test_en_i  ),

        .slave_valid_i  ( RVALID     ),
        .slave_data_i   ( RDATA      ),
        .slave_resp_i   ( RRESP      ),
        .slave_user_i   ( RUSER      ),
        .slave_id_i     ( RID        ),
        .slave_last_i   ( RLAST      ),
        .slave_ready_o  ( RREADY     ),

        .master_valid_o ( RVALID_o   ),
        .master_data_o  ( RDATA_o    ),
        .master_resp_o  ( RRESP_o    ),
        .master_user_o  ( RUSER_o    ),
        .master_id_o    ( RID_o      ),
        .master_last_o  ( RLAST_o    ),
        .master_ready_i ( RREADY_i   )
   );

   miv_ihc_axi_b_buffer #(
        .SYNC_RESET     ( SYNC_RESET       ),
        .ID_WIDTH       ( AXI4_ID_WIDTH    ),
        .USER_WIDTH     ( AXI4_USER_WIDTH  ),
        .BUFFER_DEPTH   ( BUFF_DEPTH_SLAVE )
   ) slave_b_buffer (
        .clk_i          ( ACLK      ),
        .rst_ni         ( ARESETn   ),
        .test_en_i      ( test_en_i ),

        .slave_valid_i  ( BVALID    ),
        .slave_resp_i   ( BRESP     ),
        .slave_id_i     ( BID       ),
        .slave_user_i   ( BUSER     ),
        .slave_ready_o  ( BREADY    ),

        .master_valid_o ( BVALID_o  ),
        .master_resp_o  ( BRESP_o   ),
        .master_id_o    ( BID_o     ),
        .master_user_o  ( BUSER_o   ),
        .master_ready_i ( BREADY_i  )
    );

    always_comb begin

      read_req     = 1'b0;
      write_req    = 1'b0;
      address      = '0;

      sample_RDATA = 1'b0;

      ARREADY      = 1'b0;
      AWREADY      = 1'b0;
      WREADY       = 1'b0;

      BVALID       = 1'b0;
      BRESP        = `OKAY;
      BID          = AWID;
      BUSER        = AWUSER;

      RVALID       = 1'b0;
      RLAST        = 1'b0;
      RID          = ARID;
      RUSER        = ARUSER;
      RRESP        = `OKAY;
      RDATA        = RDATA_Q;

      PSEL  	   = 1'b0;
      PWRITE       = 1'b0;

      case(CS)

        WAIT_R_PREADY: begin
            PSEL = 1'b1;  // PSEL remains high until end of transfer
            read_req     = 1'b1;
            address      = ARADDR[APB_ADDR_WIDTH  - 1 : 0];
            sample_RDATA = PREADY;
            NS = WAIT_R_PREADY;

            if (PREADY == 1'b1) begin // APB is READY --> RDATA is AVAILABLE
               NS = DONE_SINGLE_RD;
            end
        end

        WAIT_W_PREADY: begin
            PSEL = 1'b1;  // PSEL remains high until end of transfer
            PWRITE = 1'b1; // PWRITE must remain stable until end of transfer
            write_req   = 1'b1;
            address     = AWADDR[APB_ADDR_WIDTH - 1:0];
            NS = WAIT_W_PREADY;

            // There is a Pending WRITE!!
            if (PREADY == 1'b1) begin // APB is READY --> WDATA is LAtched
                NS = SEND_B_RESP;
            end
        end

        IDLE: begin
            if (ARVALID == 1'b1) begin
                PSEL = 1'b1;
                NS = ACCESS_RD;
                address      = ARADDR[APB_ADDR_WIDTH - 1:0];
                //sample_RDATA = PREADY;
            end else if (AWVALID) begin
                NS = SETUP_WR;
                address =  AWADDR[APB_ADDR_WIDTH - 1:0];
            end else begin
                NS = IDLE;
            end
        end

        ACCESS_RD: begin
            PSEL = 1'b1;  // PSEL remains high until end of transfer
            read_req     = 1'b1;  // raise PENABLE as it's one cycle after PSEL
            address      = ARADDR[APB_ADDR_WIDTH - 1:0];
            sample_RDATA = PREADY;

            if(PREADY == 1'b1) begin // APB is READY --> RDATA is AVAILABLE
                NS   = DONE_SINGLE_RD;
            end else begin // APB not ready
                NS = WAIT_R_PREADY;
            end            
        end
        
        SETUP_WR: begin
            //if (AWVALID) begin
                if (WVALID) begin
                    address =  AWADDR[APB_ADDR_WIDTH - 1:0];
                    PWRITE = 1'b1;
                    PSEL = 1'b1;
                    NS = ACCESS_WR;
                end else begin // GOT ADDRESS WRITE, not DATA
                    write_req       = 1'b0;
                    address         = '0;
                    NS              = IDLE;
                end
            //end
        end
        
        ACCESS_WR: begin
            PWRITE = 1'b1;
            PSEL = 1'b1;
            write_req = 1'b1;  // raise PENABLE as it's one cycle after PSEL
            address =  AWADDR[APB_ADDR_WIDTH - 1:0];

            // There is a Pending WRITE!
            if (PREADY == 1'b1) begin// APB is READY --> WDATA is Latched
                NS = SEND_B_RESP;
            end else begin // APB not READY
               NS = WAIT_W_PREADY;
            end
        end
        
        SEND_B_RESP: begin

            BVALID   = 1'b1;
            address  = '0;
            NS       = SEND_B_RESP;
            if (BREADY) begin
                NS      = IDLE;
                AWREADY = 1'b1;
                WREADY  = 1'b1;
            end
        end

        DONE_SINGLE_RD: begin

            RVALID    = 1'b1;
            RLAST     = 1;
            address   = '0;
            NS = DONE_SINGLE_RD;

            if (RREADY) begin // ready to send back the rdata
                NS = IDLE;
                ARREADY = 1'b1;
            end
        end

        default: NS = IDLE;

      endcase
    end

    always_ff @(posedge ACLK, negedge aresetn) begin
        if ((!aresetn) || (!sresetn)) begin
            CS      <= IDLE;
            RDATA_Q <= '0;
        end else begin
            CS      <= NS;

            if (sample_RDATA)
                RDATA_Q <= PRDATA;
        end
    end

endmodule
// Copyright (c) 2024, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2024, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype wire

module miv_ihc_axi_target_top(
    // Inputs
    ACLK,
    ARADDR_i,
    ARBURST_i,
    ARCACHE_i,
    ARESETn,
    ARID_i,
    ARLEN_i,
    ARLOCK_i,
    ARPROT_i,
    ARQOS_i,
    ARREGION_i,
    ARSIZE_i,
    ARUSER_i,
    ARVALID_i,
    AWADDR_i,
    AWBURST_i,
    AWCACHE_i,
    AWID_i,
    AWLEN_i,
    AWLOCK_i,
    AWPROT_i,
    AWQOS_i,
    AWREGION_i,
    AWSIZE_i,
    AWUSER_i,
    AWVALID_i,
    BREADY_i,
    RREADY_i,
    WDATA_i,
    WLAST_i,
    WSTRB_i,
    WUSER_i,
    WVALID_i,
    dest_PRDATA_i,
    dest_PREADY_i,
    dest_PSLVERR_i,
    dest_clk,
    dest_rst_n,
    // Outputs
    ARREADY_o,
    AWREADY_o,
    BID_o,
    BRESP_o,
    BUSER_o,
    BVALID_o,
    RDATA_o,
    RID_o,
    RLAST_o,
    RRESP_o,
    RUSER_o,
    RVALID_o,
    WREADY_o,
    dest_PADDR_o,
    dest_PENABLE_o,
    dest_PSEL_o,
    dest_PWDATA_o,
    dest_PWRITE_o
);

//--------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------
parameter SYNC_RESET = 0;
parameter CDC_EN = 0;
parameter MPU_EN = 0;
parameter H0_ACCESS = 0;
parameter H1_ACCESS	= 0;
parameter H2_ACCESS	= 0;
parameter H3_ACCESS	= 0;
parameter H4_ACCESS	= 0;
parameter H5_ACCESS	= 0;

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK;
input  [31:0] ARADDR_i;
input  [1:0]  ARBURST_i;
input  [3:0]  ARCACHE_i;
input         ARESETn;
input  [15:0] ARID_i;
input  [7:0]  ARLEN_i;
input         ARLOCK_i;
input  [2:0]  ARPROT_i;
input  [3:0]  ARQOS_i;
input  [3:0]  ARREGION_i;
input  [2:0]  ARSIZE_i;
input  [9:0]  ARUSER_i;
input         ARVALID_i;
input  [31:0] AWADDR_i;
input  [1:0]  AWBURST_i;
input  [3:0]  AWCACHE_i;
input  [15:0] AWID_i;
input  [7:0]  AWLEN_i;
input         AWLOCK_i;
input  [2:0]  AWPROT_i;
input  [3:0]  AWQOS_i;
input  [3:0]  AWREGION_i;
input  [2:0]  AWSIZE_i;
input  [9:0]  AWUSER_i;
input         AWVALID_i;
input         BREADY_i;
input         RREADY_i;
input  [31:0] WDATA_i;
input         WLAST_i;
input  [3:0]  WSTRB_i;
input  [9:0]  WUSER_i;
input         WVALID_i;
input  [31:0] dest_PRDATA_i;
input         dest_PREADY_i;
input         dest_PSLVERR_i;
input         dest_clk;
input         dest_rst_n;

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        ARREADY_o;
output        AWREADY_o;
output [15:0] BID_o;
output [1:0]  BRESP_o;
output [9:0]  BUSER_o;
output        BVALID_o;
output [31:0] RDATA_o;
output [15:0] RID_o;
output        RLAST_o;
output [1:0]  RRESP_o;
output [9:0]  RUSER_o;
output        RVALID_o;
output        WREADY_o;
output [31:0] dest_PADDR_o;
output        dest_PENABLE_o;
output        dest_PSEL_o;
output [31:0] dest_PWDATA_o;
output        dest_PWRITE_o;

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] axi2apb_0_src_PRDATA_o;
wire          axi2apb_0_src_PREADY_o;
wire          axi2apb_0_src_PSLVERR_o;
wire   [31:0] axi2apb_0_PADDR;
wire          axi2apb_0_PENABLE;
wire          axi2apb_0_PSEL;
wire   [31:0] axi2apb_0_PWDATA;
wire          axi2apb_0_PWRITE;

wire [31:0] dest_PRDATA_i_net;
wire 		dest_PREADY_i_net;
wire 		dest_PSLVERR_i_net;
wire [31:0] dest_PADDR_o_net;
wire [31:0] dest_PWDATA_o_net;
wire 		dest_PWRITE_o_net;
wire 		dest_PSEL_o_net;
wire 		dest_PENABLE_o_net;

//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;

//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;

//--------------------------------------------------------------------
// Instantiate axi2apb module
//--------------------------------------------------------------------
miv_ihc_axi2apb #(
        .SYNC_RESET(SYNC_RESET)
        )
        axi2apb_0 (
        // Inputs
        .ACLK       ( ACLK ),
        .ARESETn    ( ARESETn ),
        .test_en_i  ( GND_net ),
        .AWLOCK_i   ( AWLOCK_i ),
        .AWVALID_i  ( AWVALID_i ),
        .WLAST_i    ( WLAST_i ),
        .WVALID_i   ( WVALID_i ),
        .BREADY_i   ( BREADY_i ),
        .ARLOCK_i   ( ARLOCK_i ),
        .ARVALID_i  ( ARVALID_i ),
        .RREADY_i   ( RREADY_i ),
        .PREADY     ( axi2apb_0_src_PREADY_o ),
        .PSLVERR    ( axi2apb_0_src_PSLVERR_o ),
        .AWID_i     ( AWID_i ),
        .AWADDR_i   ( AWADDR_i ),
        .AWLEN_i    ( AWLEN_i ),
        .AWSIZE_i   ( AWSIZE_i ),
        .AWBURST_i  ( AWBURST_i ),
        .AWCACHE_i  ( AWCACHE_i ),
        .AWPROT_i   ( AWPROT_i ),
        .AWREGION_i ( AWREGION_i ),
        .AWUSER_i   ( AWUSER_i ),
        .AWQOS_i    ( AWQOS_i ),
        .WDATA_i    ( WDATA_i ),
        .WSTRB_i    ( WSTRB_i ),
        .WUSER_i    ( WUSER_i ),
        .ARID_i     ( ARID_i ),
        .ARADDR_i   ( ARADDR_i ),
        .ARLEN_i    ( ARLEN_i ),
        .ARSIZE_i   ( ARSIZE_i ),
        .ARBURST_i  ( ARBURST_i ),
        .ARCACHE_i  ( ARCACHE_i ),
        .ARPROT_i   ( ARPROT_i ),
        .ARREGION_i ( ARREGION_i ),
        .ARUSER_i   ( ARUSER_i ),
        .ARQOS_i    ( ARQOS_i ),
        .PRDATA     ( axi2apb_0_src_PRDATA_o ),
        // Outputs
        .AWREADY_o  ( AWREADY_o ),
        .WREADY_o   ( WREADY_o ),
        .BVALID_o   ( BVALID_o ),
        .ARREADY_o  ( ARREADY_o ),
        .RLAST_o    ( RLAST_o ),
        .RVALID_o   ( RVALID_o ),
        .PENABLE    ( axi2apb_0_PENABLE ),
        .PWRITE     ( axi2apb_0_PWRITE ),
        .PSEL       ( axi2apb_0_PSEL ),
        .BID_o      ( BID_o ),
        .BRESP_o    ( BRESP_o ),
        .BUSER_o    ( BUSER_o ),
        .RID_o      ( RID_o ),
        .RDATA_o    ( RDATA_o ),
        .RRESP_o    ( RRESP_o ),
        .RUSER_o    ( RUSER_o ),
        .PADDR      ( axi2apb_0_PADDR ),
        .PWDATA     ( axi2apb_0_PWDATA ) 
        );

//--------------------------------------------------------------------
// Instantiate APB_CDC if CDC parameter is enabled, 
// Else, pass all signals through
//--------------------------------------------------------------------
generate 
    if (CDC_EN)
        begin: gen_cdc
			miv_ihc_apb_cdc #(
            .SYNC_RESET(SYNC_RESET)
            )
            apb_cdc_0 (
			// Inputs
			.src_clk        ( ACLK ),
			.src_rst_n      ( ARESETn ),
			.src_PWRITE_i   ( axi2apb_0_PWRITE ),
			.src_PSEL_i     ( axi2apb_0_PSEL ),
			.src_PENABLE_i  ( axi2apb_0_PENABLE ),
			.dest_clk       ( dest_clk ),
			.dest_rst_n     ( dest_rst_n ),
			.dest_PREADY_i  ( dest_PREADY_i_net ),
			.dest_PSLVERR_i ( dest_PSLVERR_i_net ),
			.src_PADDR_i    ( axi2apb_0_PADDR ),
			.src_PWDATA_i   ( axi2apb_0_PWDATA ),
			.dest_PRDATA_i  ( dest_PRDATA_i_net ),
			// Outputs
			.src_PREADY_o   ( axi2apb_0_src_PREADY_o ),
			.src_PSLVERR_o  ( axi2apb_0_src_PSLVERR_o ),
			.dest_PWRITE_o  ( dest_PWRITE_o_net ),
			.dest_PSEL_o    ( dest_PSEL_o_net ),
			.dest_PENABLE_o ( dest_PENABLE_o_net ),
			.src_PRDATA_o   ( axi2apb_0_src_PRDATA_o ),
			.dest_PADDR_o   ( dest_PADDR_o_net ),
			.dest_PWDATA_o  ( dest_PWDATA_o_net ) 
			);
        end
    else
        begin: ngen_cdc
			assign dest_PADDR_o_net = axi2apb_0_PADDR;
			assign dest_PENABLE_o_net = axi2apb_0_PENABLE;
			assign dest_PSEL_o_net = axi2apb_0_PSEL;
			assign dest_PWDATA_o_net = axi2apb_0_PWDATA;
			assign dest_PWRITE_o_net = axi2apb_0_PWRITE;
			
			assign axi2apb_0_src_PREADY_o = dest_PREADY_i_net;
			assign axi2apb_0_src_PSLVERR_o = dest_PSLVERR_i_net;
			assign axi2apb_0_src_PRDATA_o = dest_PRDATA_i_net;
        end
endgenerate 

//--------------------------------------------------------------------
// Instantiate an MPU to monitor for invalid transactions if MPU_EN enabled, 
// Else, pass all signals through
//--------------------------------------------------------------------
generate
	if (MPU_EN) 
		begin: gen_mpu
			miv_ihc_apb_mpu #(
			.H0_ACCESS(H0_ACCESS),
			.H1_ACCESS(H1_ACCESS),
			.H2_ACCESS(H2_ACCESS),
			.H3_ACCESS(H3_ACCESS),
			.H4_ACCESS(H4_ACCESS),
			.H5_ACCESS(H5_ACCESS)
			)
			apb_mpu_0 (
			// Inputs
			.PADDR_req	     ( dest_PADDR_o_net ),
			.PWDATA_req 	 ( dest_PWDATA_o_net ),
			.PWRITE_req	     ( dest_PWRITE_o_net ),
			.PSEL_req     	 ( dest_PSEL_o_net ),
			.PENABLE_req  	 ( dest_PENABLE_o_net ),

			// Target Response from the MIV_IHC Core logic
			.PRDATA_IHC_resp    ( dest_PRDATA_i ),
			.PREADY_IHC_resp    ( dest_PREADY_i ),
			.PSLVERR_IHC_resp   ( dest_PSLVERR_i ),

			// Outputs
			// Top-level Target Response after MPU applied
			.PRDATA_resp  	( dest_PRDATA_i_net ),
			.PREADY_resp   	( dest_PREADY_i_net ),
			.PSLVERR_resp  	( dest_PSLVERR_i_net ),

			// Initiator activity seen by the MIV_IHC Core logic
			.PADDR_IHC_req(dest_PADDR_o),
			.PENABLE_IHC_req(dest_PENABLE_o),
			.PSEL_IHC_req(dest_PSEL_o),
			.PWDATA_IHC_req(dest_PWDATA_o),
			.PWRITE_IHC_req(dest_PWRITE_o)
			);
		end
	else
		begin: ngen_mpu
			assign dest_PADDR_o 		= dest_PADDR_o_net;
			assign dest_PENABLE_o 		= dest_PENABLE_o_net;
			assign dest_PSEL_o 			= dest_PSEL_o_net;
			assign dest_PWDATA_o 		= dest_PWDATA_o_net;
			assign dest_PWRITE_o 		= dest_PWRITE_o_net;
			assign dest_PRDATA_i_net 	= dest_PRDATA_i;
			assign dest_PREADY_i_net 	= dest_PREADY_i;
			assign dest_PSLVERR_i_net 	= dest_PSLVERR_i;
		end
endgenerate

endmodule

`default_nettype wire
