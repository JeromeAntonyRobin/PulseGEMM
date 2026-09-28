///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Microchip Corporation
//
// File: testbench.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// User Testbench. Shows mailbox read/writes to/from different harts and interrupts being raised/serviced.
// This self-checking testbench adapts the testing and verification criteria based on the specific parameters set at the top-level of the MIV_IHC
//
// There can be up to three interfaces enabled on the MIV_IHC core. The frequencies of these interfaces can be adjusted using the CLOCK_TYPE parameter.
// Ensure the relevant CDC parameters are enabled if using any setting other than 'Synchronous Targets Same Frequency'
//
// Targeted device: <Family::PolarFire> <Die::MPF500T> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

`timescale 1ns/100ps

module testbench;
//--------------------------------------------------------------------
// User Configurable Testbench Parameters
//--------------------------------------------------------------------
parameter CLOCK_TYPE = 0;

// CLOCK_TYPE Parameter values explanation
// 0 : Synchronous Targets Same Frequency.  All 100MHz
// 1 : Asynchronous Targets Same Frequency. All 100MHz
// 2 : Target 0=250MHz > Target 1=166MHz > Target 2=100MHz > Core    =66MHz (Frequency)
// 3 : Target 0=250MHz > Target 2=166MHz > Core=100MHz     > Target 1=66MHz (Frequency)
// 4 : Target 1=250MHz > Core=166MHz     > Target 0=100MHz > Target 2=66MHz (Frequency)
// 5 : Core=250MHz     > Target 1=166MHz > Target 2=100MHz > Target 0=66MHz (Frequency)
// 6 : Target 2=250MHz > Core=166MHz     > Target 0=100MHz > Target 1=66MHz (Frequency)
// 7 : Target 2=250MHz > Target 1=166MHz > Core=100MHz     > Target 0=66MHz (Frequency)

//--------------------------------------------------------------------
// Automatically Determined Parameters - Do not change!
//--------------------------------------------------------------------
parameter TARGET_0_PERIOD = (CLOCK_TYPE == 0 || CLOCK_TYPE == 1) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 2) ? 4  : // 250MHz or 4ns
                            (CLOCK_TYPE == 3) ? 4  : // 250MHz or 4ns
                            (CLOCK_TYPE == 4) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 5) ? 15 : // 66MHz  or 15ns
                            (CLOCK_TYPE == 6) ? 10 : // 100MHz or 10ns
                                                15 ; // 66MHz  or 15ns
                            
parameter TARGET_1_PERIOD = (CLOCK_TYPE == 0 || CLOCK_TYPE == 1) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 2) ? 6  : // 166MHz or 6ns
                            (CLOCK_TYPE == 3) ? 15 : // 66MHz  or 15ns
                            (CLOCK_TYPE == 4) ? 4  : // 250MHz or 4ns
                            (CLOCK_TYPE == 5) ? 6  : // 166MHz or 6ns
                            (CLOCK_TYPE == 6) ? 15 : // 66MHz  or 15ns
                                                6  ; // 166MHz or 6ns

parameter TARGET_2_PERIOD = (CLOCK_TYPE == 0 || CLOCK_TYPE == 1) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 2) ? 10 : // 100MHz or 10ns 
                            (CLOCK_TYPE == 3) ? 6  : // 166MHz or 6ns
                            (CLOCK_TYPE == 4) ? 15 : // 66MHz  or 15ns
                            (CLOCK_TYPE == 5) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 6) ? 4  : // 250MHz or 4ns
                                                4  ; // 250MHz or 4ns
                                                
parameter CORE_PERIOD =     (CLOCK_TYPE == 0 || CLOCK_TYPE == 1) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 2) ? 15 : // 66MHz  or 15ns
                            (CLOCK_TYPE == 3) ? 10 : // 100MHz or 10ns
                            (CLOCK_TYPE == 4) ? 6  : // 166MHz or 6ns
                            (CLOCK_TYPE == 5) ? 4  : // 250MHz or 4ns
                            (CLOCK_TYPE == 6) ? 6  : // 166MHz or 6ns
                                                10 ; // 100MHz or 10ns
                                                
//--------------------------------------------------------------------
// MIV_IHC Core Parameters
//--------------------------------------------------------------------
`include "../../../coreparameters.v"

//--------------------------------------------------------------------
// Local Parameters
//--------------------------------------------------------------------
localparam APB_INTERFACE_0 = (INF_0_TYPE == 1);
localparam APB_INTERFACE_1 = (INF_1_TYPE == 1);
localparam APB_INTERFACE_2 = (INF_2_TYPE == 1);
localparam AXI_INTERFACE_0 = (INF_0_TYPE == 2 || INF_0_TYPE == 3);
localparam AXI_INTERFACE_1 = (INF_1_TYPE == 2 || INF_1_TYPE == 3);
localparam AXI_INTERFACE_2 = (INF_2_TYPE == 2 || INF_2_TYPE == 3);

// From miv_ihc_address_controller - For address bits [19:8]
// HART0 - E51
localparam [11:0] H0_TO_H1_BASE_ADDR 	= 12'h0_41;
localparam [11:0] H0_TO_H2_BASE_ADDR 	= 12'h0_42;
localparam [11:0] H0_TO_H3_BASE_ADDR 	= 12'h0_43;
localparam [11:0] H0_TO_H4_BASE_ADDR 	= 12'h0_44;
localparam [11:0] H0_TO_H5_BASE_ADDR 	= 12'h0_45;

// HART1 - U54_1
localparam [11:0] H1_TO_H0_BASE_ADDR 	= 12'h0_81;

// HART2 - U54_2
localparam [11:0] H2_TO_H0_BASE_ADDR  = 12'h0_C1;

// HART3 - U54_3
localparam [11:0] H3_TO_H0_BASE_ADDR 	= 12'h1_01;

// HART4 - U54_4
localparam [11:0] H4_TO_H0_BASE_ADDR 	= 12'h1_41;

// HART5 - MIV_RV32
localparam [11:0] H5_TO_H0_BASE_ADDR 	= 12'h1_81;

// Interrupt Modules
localparam [11:0] H0_IRQ_CTRL_BASE_ADDR = 12'h0_40;
localparam [11:0] H1_IRQ_CTRL_BASE_ADDR = 12'h0_80;
localparam [11:0] H2_IRQ_CTRL_BASE_ADDR = 12'h0_C0; 
localparam [11:0] H3_IRQ_CTRL_BASE_ADDR = 12'h1_00;
localparam [11:0] H4_IRQ_CTRL_BASE_ADDR = 12'h1_40;
localparam [11:0] H5_IRQ_CTRL_BASE_ADDR = 12'h1_80;

// Defined for mailbox testing in a for-loop logic structure
localparam [5*12-1:0] H0_TO_HX_BASE_ADDR   = {H0_TO_H5_BASE_ADDR, H0_TO_H4_BASE_ADDR, H0_TO_H3_BASE_ADDR, H0_TO_H2_BASE_ADDR, H0_TO_H1_BASE_ADDR};  // HART0 can write to all hart mailboxes by indexing these IHCC base addresses
localparam [5*12-1:0] HX_TO_H0_BASE_ADDR   = {H5_TO_H0_BASE_ADDR, H4_TO_H0_BASE_ADDR, H3_TO_H0_BASE_ADDR, H2_TO_H0_BASE_ADDR, H1_TO_H0_BASE_ADDR};  // All HARTX ordered IHCC base addresses receiving data from HART0 

// localparam to hold all base addresses for all Interrupt Modules
localparam [6*12-1:0] BASE_ADDR_IRQ_CTRL = {H5_IRQ_CTRL_BASE_ADDR, H4_IRQ_CTRL_BASE_ADDR, H3_IRQ_CTRL_BASE_ADDR, H2_IRQ_CTRL_BASE_ADDR, H1_IRQ_CTRL_BASE_ADDR, H0_IRQ_CTRL_BASE_ADDR};

localparam [31:0] IP_VERSION               = 32'h02000064;  // MIV_IHC IP Version
localparam [31:0] MIV_IHC_IP_VERSION_ADDR  = 32'h0000_3BFC;

// IHCC register offsets
localparam [7:0] CONTROL_ADDR            = 8'h00;
localparam [7:0] DEBUG_ID_ADDR           = 8'h04;
localparam [7:0] MESSAGE_DEPTH_ADDR      = 8'h08;

// Mailbox offsets
localparam [7:0] MESSAGE_BASE_ADDR_IN    = 8'h20;
localparam [7:0] MESSAGE_BASE_ADDR_OUT   = 8'h90;

localparam [7:0] IRQ_MASK_ADDR     = 8'h00;  // register in Interrupt Module for masking interrupts coming from the IHCCs
localparam [7:0] IRQ_STATUS_ADDR   = 8'h08;

// Vector that is indexed by tests to determine which IHCC hart channels are enabled between H0 and other harts (this will determine expected behaviour)
localparam [6*6-1:0] hart_en_vector = {1'(H0_TO_H5_CH_EN), 1'(H0_TO_H4_CH_EN), 1'(H0_TO_H3_CH_EN), 1'(H0_TO_H2_CH_EN), 1'(H0_TO_H1_CH_EN), 1'b0};

// vector that indicates if an interrupt module is enabled/disabled
localparam l_h0_ihcim_en = H0_IHCIM_EN && (H0_TO_H1_CH_EN || H0_TO_H2_CH_EN || H0_TO_H3_CH_EN || H0_TO_H4_CH_EN || H0_TO_H5_CH_EN);
localparam l_h1_ihcim_en = H1_IHCIM_EN && (H0_TO_H1_CH_EN || H1_TO_H2_CH_EN || H1_TO_H3_CH_EN || H1_TO_H4_CH_EN || H1_TO_H5_CH_EN);
localparam l_h2_ihcim_en = H2_IHCIM_EN && (H0_TO_H2_CH_EN || H1_TO_H2_CH_EN || H2_TO_H3_CH_EN || H2_TO_H4_CH_EN || H2_TO_H5_CH_EN);
localparam l_h3_ihcim_en = H3_IHCIM_EN && (H0_TO_H3_CH_EN || H1_TO_H3_CH_EN || H2_TO_H3_CH_EN || H3_TO_H4_CH_EN || H3_TO_H5_CH_EN);
localparam l_h4_ihcim_en = H4_IHCIM_EN && (H0_TO_H4_CH_EN || H1_TO_H4_CH_EN || H2_TO_H4_CH_EN || H3_TO_H4_CH_EN || H4_TO_H5_CH_EN);
localparam l_h5_ihcim_en = H5_IHCIM_EN && (H0_TO_H5_CH_EN || H1_TO_H5_CH_EN || H2_TO_H5_CH_EN || H3_TO_H5_CH_EN || H4_TO_H5_CH_EN);
localparam [5:0] enabled_interrupt_modules = {1'(l_h5_ihcim_en == 1), 1'(l_h4_ihcim_en == 1), 1'(l_h3_ihcim_en == 1), 1'(l_h2_ihcim_en == 1), 1'(l_h1_ihcim_en == 1), 1'(l_h0_ihcim_en == 1)};

// Matrix that is indexed by tests to determine which targets have access to which hart's address space (this will determine expected behaviour)
localparam [3*6-1:0] target_perm_matrix  = {
  1'(INF_2_H5_ACCESS), 1'(INF_2_H4_ACCESS), 1'(INF_2_H3_ACCESS), 1'(INF_2_H2_ACCESS), 1'(INF_2_H1_ACCESS), 1'(INF_2_H0_ACCESS),
  1'(INF_1_H5_ACCESS), 1'(INF_1_H4_ACCESS), 1'(INF_1_H3_ACCESS), 1'(INF_1_H2_ACCESS), 1'(INF_1_H1_ACCESS), 1'(INF_1_H0_ACCESS),
  1'(INF_0_H5_ACCESS), 1'(INF_0_H4_ACCESS), 1'(INF_0_H3_ACCESS), 1'(INF_0_H2_ACCESS), 1'(INF_0_H1_ACCESS), 1'(INF_0_H0_ACCESS) 
  };

localparam [2:0] enabled_targets = {1'(INF_2_TYPE != 0), 1'(INF_1_TYPE != 0), 1'(INF_0_TYPE != 0)};  // vector that indicates if a target interface is enabled/disabled

//--------------------------------------------------------------------
// Integers
//--------------------------------------------------------------------
integer i=0, h=0, t=0;
integer num_harts = 6;    // maximum total number of harts (5x MSS + 1x MIV_RV32)
integer num_targets = 3;  // maximum number of possible targets is 3

//--------------------------------------------------------------------
// AMBA Signals
//--------------------------------------------------------------------
// APB Target 0
reg         APB_0_NSYSRESET;
reg         APB_0_PWRITE;
reg  [31:0] APB_0_PADDR;
reg         APB_0_PCLK;
reg         APB_0_PENABLE;
reg         APB_0_PSEL;
reg  [31:0] APB_0_PWDATA;

wire [31:0] APB_0_PRDATA;
wire        APB_0_PREADY;
wire        APB_0_PSLVERR;

// APB Target 1
reg         APB_1_NSYSRESET;
reg  [31:0] APB_1_PADDR;
reg         APB_1_PCLK;
reg         APB_1_PENABLE;
reg         APB_1_PSEL;
reg  [31:0] APB_1_PWDATA;
reg         APB_1_PWRITE;

wire [31:0] APB_1_PRDATA;
wire        APB_1_PREADY;
wire        APB_1_PSLVERR;

// APB Target 2
reg         APB_2_NSYSRESET;
reg  [31:0] APB_2_PADDR;
reg         APB_2_PCLK;
reg         APB_2_PENABLE;
reg         APB_2_PSEL;
reg  [31:0] APB_2_PWDATA;
reg         APB_2_PWRITE;

wire [31:0] APB_2_PRDATA;
wire        APB_2_PREADY;
wire        APB_2_PSLVERR;

// AXI Target 0
reg AXI_0_NSYSRESET;
reg AXI_0_ACLK;
reg AXI_0_ARVALID;
reg AXI_0_WVALID;
reg AXI_0_AWVALID;
reg AXI_0_BREADY;
reg AXI_0_RREADY;
reg [31:0] AXI_0_AWADDR;
reg [31:0] AXI_0_WDATA;
reg [2:0]  AXI_0_AWPROT;
reg [3:0]  AXI_0_WSTRB;
reg [31:0] AXI_0_ARADDR;
reg [2:0]  AXI_0_ARPROT;

wire AXI_0_RVALID;
wire AXI_0_AWREADY;
wire AXI_0_WREADY;
wire AXI_0_BVALID;
wire AXI_0_ARREADY;
wire [1:0]  AXI_0_BRESP;
wire [31:0] AXI_0_RDATA;
wire [1:0]  AXI_0_RRESP;

// AXI Target 1
reg AXI_1_NSYSRESET;
reg AXI_1_ACLK;
reg AXI_1_ARVALID;
reg AXI_1_WVALID;
reg AXI_1_AWVALID;
reg AXI_1_BREADY;
reg AXI_1_RREADY;
reg [31:0] AXI_1_AWADDR;
reg [31:0] AXI_1_WDATA;
reg [2:0]  AXI_1_AWPROT;
reg [3:0]  AXI_1_WSTRB;
reg [31:0] AXI_1_ARADDR;
reg [2:0]  AXI_1_ARPROT;

wire AXI_1_RVALID;
wire AXI_1_AWREADY;
wire AXI_1_WREADY;
wire AXI_1_BVALID;
wire AXI_1_ARREADY;
wire [1:0]  AXI_1_BRESP;
wire [31:0] AXI_1_RDATA;
wire [1:0]  AXI_1_RRESP;

// AXI Target 2
reg AXI_2_NSYSRESET;
reg AXI_2_ACLK;
reg AXI_2_ARVALID;
reg AXI_2_WVALID;
reg AXI_2_AWVALID;
reg AXI_2_BREADY;
reg AXI_2_RREADY;
reg [31:0] AXI_2_AWADDR;
reg [31:0] AXI_2_WDATA;
reg [2:0]  AXI_2_AWPROT;
reg [3:0]  AXI_2_WSTRB;
reg [31:0] AXI_2_ARADDR;
reg [2:0]  AXI_2_ARPROT;

wire AXI_2_RVALID;
wire AXI_2_AWREADY;
wire AXI_2_WREADY;
wire AXI_2_BVALID;
wire AXI_2_ARREADY;
wire [1:0]  AXI_2_BRESP;
wire [31:0] AXI_2_RDATA;
wire [1:0]  AXI_2_RRESP;

//--------------------------------------------------------------------
// IRQ Signals
//--------------------------------------------------------------------
wire MON_IRQ_H1;
wire MON_IRQ_H2;
wire MON_IRQ_H3;
wire MON_IRQ_H4;
wire MON_IRQ_H5;
wire APP_IRQ_H0;
wire APP_IRQ_H1;
wire APP_IRQ_H2;
wire APP_IRQ_H3;
wire APP_IRQ_H4;
wire APP_IRQ_H5;

// Store Individual interrupt signals that are output from MIV_IHC in arrays for testing purposes
wire [5:0]  APP_IRQ = {APP_IRQ_H5, APP_IRQ_H4, APP_IRQ_H3, APP_IRQ_H2, APP_IRQ_H1, APP_IRQ_H0};
wire [5:0]  MON_IRQ = {MON_IRQ_H5, MON_IRQ_H4, MON_IRQ_H3, MON_IRQ_H2, MON_IRQ_H1, 1'b0};

reg CORE_CLK;
reg CORE_RESETN;

//--------------------------------------------------------------------
// Testbench for-loop signals
//--------------------------------------------------------------------
reg  [11:0] H0_TO_Hi_BASE_ADDR = 'b0;
reg  [11:0] Hi_TO_H0_BASE_ADDR = 'b0;
reg  [11:0] BASE_ADDR_H        = 'b0;

//--------------------------------------------------------------------
// Other Signals
//--------------------------------------------------------------------
reg [31:0]  write_data;
reg [31:0]  read_data;
reg valid_perm = 'b0;

//--------------------------------------------------------------------
// Main Code - Initial Block
//--------------------------------------------------------------------
initial
begin    
    // ****** Start of Test ******

    // This test will demonstrate how to:
    //    1.) enable interrupts for a hart via its associated Interrupt Modules
    //    2.) raise interrupts from one hart to another via the Inter-Hart Communication Channels (IHCC)
    //    3.) write and read messages from one hart to another via the Inter-Hart Communication Channels (IHCC)
    // The testbench will self check both types of interrupts to and from all harts to ensure that each is functioning correctly

    init_amba_buses();  // initialize all AMBA buses to all 0's for both used and unused buses.
    reset_routine();   // reset cycle the DUT

    for (t=0; t<num_targets; t=t+1) begin     // find an enabled interface to run the test
      if (enabled_targets[t] == 1'b1) break;  // use the first interface found that is enabled for this test
    end

    // Enabling all IRQs for all harts via the Interrupt Modules
    $display ("Enabling all IRQs for all Harts by writing to the Interrupt Modules");
    for (h=0; h<num_harts; h=h+1) begin  // loop through all harts h
      BASE_ADDR_H = BASE_ADDR_IRQ_CTRL[12*h +: 12];  // get the base address of the IHCIM for hart h
      target_write(t, {12'h000, BASE_ADDR_H, IRQ_MASK_ADDR}, 32'h0000_0FFF);  // Enabling IRQs for hart h by setting bits in the Message Available Status Register
      repeat(20) @(posedge CORE_CLK);

      target_read(t, {12'h000, BASE_ADDR_H, IRQ_MASK_ADDR}, read_data);  // read back the 
      repeat(20) @(posedge CORE_CLK);

      // we can only expect to read the control bits 32'h0000_0FFF from interrupt module if we have write and read permissions to that register
      valid_perm = verify_write_permissions(t, h) && verify_read_permissions(t, h);
      if(read_data != 32'h0000_0FFF && enabled_interrupt_modules[h] && valid_perm) begin  // Ensure the control bits were successfully written to and can be read back if the given interrupt module is enabled
        $display ("FAILED : read_data=%h, expected=%h", read_data, 32'h0000_0FFF);
        #10
        $stop;
      end
    end

    // Part 1: Writing from channel A over to channel B
    // 1.) Receiving hart on channel b has to enable their message present irq (b_mp), by setting b_mp_ie
    // 2.) The transmitting hart will write to a mailbox_a.
    // 3.) Transmitting hart enables a_ack interrupt. It will then write to b_mp to set it high to signal there is a message for the receiving hart that's connected to channel b
    // 4.) The receiving hart reads the message from mailbox_a
    // 5.) The message will be checked to ensure it's the same as what was sent
    // 6.) Receiving hart sets the channel A ack flag (a_ack) high and clears the message for channel b present flag (b_mp)
    // 7.) The transmitting hart clears the channel A acknowledgement flag (a_ack)

    // Hart 0 writes to all other harts and raises relevant interrupts. All receiving harts read the message and raise an acknowledge interrupt. Written and read messages compared.
    h = 0;  // transmitting hart h=0 i.e. H0 is writing to all other harts
    
    $display ("------ Hart %0d writes to all other harts w/ hart number higher than it ------", h);
    for (i=1+h; i<num_harts; i=i+1) begin  // hart h writes to all other harts i with **a higher hart number than it**
      $display ("--- H0 sending message to H%0d ---", i);
      H0_TO_Hi_BASE_ADDR = H0_TO_HX_BASE_ADDR[12*(i-1) +: 12];
      Hi_TO_H0_BASE_ADDR = HX_TO_H0_BASE_ADDR[12*(i-1) +: 12];

      // receiving hart on channel b has to enable their mp irq
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, CONTROL_ADDR}, 32'b000100);  // b_ack_ie=0, b_mp_ack=0, a_mp_ack=0, b_mp_ie=1, b_mp=0, a_mp=0

      // transmitting hart on channel a writes a message to mailbox_a
      write_data = $urandom_range(1, 2**32-1); // ensure write data is not the same as the initialized value of 0x0
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, MESSAGE_BASE_ADDR_OUT}, write_data);  // Hart h writes into first location of mailbox_a the message for hart i

      // transmitting hart enables a_ack interrupt and tells receiving hart on channel b that there's a message for it by setting b_mp=1
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, CONTROL_ADDR}, 32'b100001);  // a_ack_ie=1, a_mp_ack=0, b_mp_ack=0, a_mp_ie=0, a_mp=0, b_mp=1
      repeat(20) @(posedge CORE_CLK);
      
      // hart h writing to hart i should result in the relevant interrupt being raised
      // we can only expect an interrupt to be raised if we have permissions to set the interrupt bit in transmitting hart *and* the interrupt enable of the receiving hart
      valid_perm = verify_write_permissions(t, h) && verify_write_permissions(t, i);

      if (h==0 && H0_MONITOR_EN==1) begin  // MON_IRQ goes HIGH whenever a hart has a message from Hart0 pending
        if ( (MON_IRQ[i] != 1'b1 || !($onehot(MON_IRQ)) || (|APP_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[i] && valid_perm) begin  // ith bit should be high. all other bits should be low. all interrupts from Hart0 should be local interrupts only.
          $display ("FAILED : Hart %0d wrote to Hart %0d, so MON_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & all APP_IRQ's=0 ! Actual MON_IRQ_H%0d=%b", h, i, i, i, MON_IRQ[i]);
          #10 $stop;
        end else begin
          $display ("PASS : Hart %0d wrote to Hart %0d, so MON_IRQ_H%0d=1 (if Interrupt Module enabled & MPU allows it). Actual MON_IRQ_H%0d=%b", h, i, i, i, MON_IRQ[i]);
        end
      end else begin
        if ( (APP_IRQ[i] != 1'b1 || !($onehot(APP_IRQ)) || (|MON_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[i] && valid_perm) begin // Relevant APP_IRQ bit should be high if message is not for hart 0, all other bits should be low
          $display ("FAILED : Hart %0d wrote to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & all MON_IRQ's = 0 !  Actual APP_IRQ_H%0d=%b", h, i, i, i, APP_IRQ[i]);
          #10 $stop;
        end else begin 
          $display ("PASS : Hart %0d wrote to Hart %0d, so APP_IRQ_H%0d=1 (if Interrupt Module enabled & MPU allows it) Actual APP_IRQ_H%0d=%b", h, i, i, i, APP_IRQ[i]);
        end
      end
      
      target_read(t, {12'h000, Hi_TO_H0_BASE_ADDR, MESSAGE_BASE_ADDR_IN}, read_data);  // the receiving hart i reads from mailbox_a the message from Hart h
      repeat(20) @(posedge CORE_CLK);
      verify_mb_ch_rdwr_data(t, h, t, i, hart_en_vector[i], write_data, read_data);  // verify if the message read back was the same written (if the channel is enabled and MPU permissions allow)

      // receiving hart sets channel a ack flag high (a_mp_ack) and clears the message present flag.
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, CONTROL_ADDR}, 32'b001000 | 32'b000100);  // b_ack_ie=0, b_mp_ack=0, a_mp_ack=1, b_mp_ie=1, b_mp=0, a_mp=0
      repeat(20) @(posedge CORE_CLK);

      // hart i raises an ack flag for hart h. should result in the relevant interrupt being raised
      if (i==0 && H0_MONITOR_EN==1) begin  // MON_IRQ goes HIGH whenever a hart has a message or acknowledgement from Hart0 pending
        if ( (MON_IRQ[h] != 1'b1 || !($onehot(MON_IRQ)) || (|APP_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[h] && valid_perm) begin  // ith bit should be high, all other bits should be low
          $display ("FAILED : Hart %0d sent ack to Hart %0d, so MON_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & all APP_IRQ's = 0 !  Actual MON_IRQ_H%0d=%b", i, h, h, h, MON_IRQ[h]);
          #10 $stop;
        end else begin
          $display ("PASS : Hart %0d sent ack to Hart %0d, so MON_IRQ_H%0d=1 (if Interrupt Module enabled & MPU allows it). Actual MON_IRQ_H%0d=%b", i, h, h, h, MON_IRQ[h]);
        end
      end else begin
        if ( (APP_IRQ[h] != 1'b1 || !($onehot(APP_IRQ)) || (|MON_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[h] && valid_perm) begin // Relevant APP_IRQ bit should be high if message is not for hart 0, all other bits should be low
          $display ("FAILED : Hart %0d sent ack to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & MON_IRQ='0!  Actual APP_IRQ_H%0d=%b", i, h, h, h, APP_IRQ[h]);
          #10 $stop;
        end else begin 
          $display ("PASS : Hart %0d sent ack to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it). Actual APP_IRQ_H%0d=%b", i, h, h, h, APP_IRQ[h]);
        end
      end

      // transmitting hart h clears the channel A acknowledgement flag (a_ack) (and disables channel side A acknowledgements)
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, CONTROL_ADDR}, 32'b000000);  // a_ack_ie=0, a_mp_ack=0, b_mp_ack=0, a_mp_ie=0, a_mp=0, b_mp=0

      // receiving hart on channel b clears all flags in anticipation for next iteration
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, CONTROL_ADDR}, 32'b000000);  // b_ack_ie=0, b_mp_ack=0, a_mp_ack=0, b_mp_ie=0, b_mp=0, a_mp=0
    end

    repeat(100) @(posedge CORE_CLK);

    // Part 2: Writing from channel B over to channel A
    // 1.) Receiving hart on channel A enables their message present irq (a_mp)
    // 2.) The trasmitting hart will write to a mailbox_b location
    // 3.) Transmitting hart enables b_ack interrupt. It will then write to a_mp to set it high to signal there is a message for the receiving hart on the channel A side
    // 4.) The receiving hart reads the message from mailbox_b
    // 5.) The message will be checked to ensure it's the same as what was sent
    // 6.) Receiving hart sets the channel B ack flag (b_ack) high and clears the message present flag for channel A (a_mp)
    // 7.) The transmitting hart clears the channel B acknowledgement flag (b_ack)

    // All harts write to H0 and raise relevant. H0 reads the message and raises acknowledge interrupt. Written and read messages compared.
    h = 0;  // receiving hart h=0 i.e. H1-H5 are writing to H0
    $display ("------ All harts with hart number higher than 0 write to H0 ------");
    for (i=1; i<num_harts; i=i+1) begin  // loop through all transmitting harts i from 1 to 5
      $display ("--- H0 receiving message from H%0d ---", i);
      H0_TO_Hi_BASE_ADDR = H0_TO_HX_BASE_ADDR[12*(i-1) +: 12];
      Hi_TO_H0_BASE_ADDR = HX_TO_H0_BASE_ADDR[12*(i-1) +: 12];

      // receiving hart on channel a has to enable their mp irq
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, CONTROL_ADDR}, 32'b000100);  // a_ack_ie=0, a_mp_ack=0, b_mp_ack=0, a_mp_ie=1, a_mp=0, b_mp=0

      // transmitting hart on channel b writes a message to mailbox_b
      write_data = $urandom_range(1, 2**32-1); // ensure write data is not the same as the initialized value of 0x0
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, MESSAGE_BASE_ADDR_OUT}, write_data);  // Hart i writes into the first mailbox_b location a message for the Hart0 
      repeat(20) @(posedge CORE_CLK);

      // transmitting hart on channel B enables b_ack interrupt and tells receiving hart on channel A that there's a message for it by setting a_mp=1
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, CONTROL_ADDR}, 32'b100001);  // b_ack_ie=1, b_mp_ack=0, a_mp_ack=0, b_mp_ie=0, b_mp=0, a_mp=1
      repeat(20) @(posedge CORE_CLK);

      // we can only expect an interrupt to be raised if we have permissions to set the interrupt bit in transmitting hart *and* the interrupt enable of the receiving hart
      valid_perm = verify_write_permissions(t, h) && verify_write_permissions(t, i);
      
      // hart i writing to hart h should result in the relevant interrupt being raised
      if (i==0 && H0_MONITOR_EN==1) begin  // MON_IRQ goes HIGH whenever a hart has a message from Hart0 pending
        if ( (MON_IRQ[h] != 1'b1 || !($onehot(MON_IRQ)) || (|APP_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[h] && valid_perm) begin  // bit h should be high, all other bits should be low
          $display ("FAILED : Hart %0d sent ack to Hart %0d, so MON_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & all APP_IRQ's = 0 !  Actual MON_IRQ_H%0d=%b", i, h, h, h, MON_IRQ[h]);
          #10 $stop;
        end else begin
          $display ("PASS : Hart %0d sent ack to Hart %0d, so MON_IRQ_H%0d=1 (if Interrupt Module enabled & MPU allows it). Actual MON_IRQ_H%0d=%b", i, h, h, h, MON_IRQ[h]);
        end
      end else begin
        if ( (APP_IRQ[h] != 1'b1 || !($onehot(APP_IRQ)) || (|MON_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[h] && valid_perm) begin // Relevant APP_IRQ bit should be high if message is not for hart 0, all other bits should be low
          $display ("FAILED : Hart %0d wrote to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & MON_IRQ='0!  Actual APP_IRQ_H%0d=%b", i, h, h, h, APP_IRQ[h]);
          #10 $stop;
        end else begin 
          $display ("PASS : Hart %0d wrote to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it). Actual APP_IRQ_H%0d=%b", i, h, h, h, APP_IRQ[h]);
        end
      end

      target_read(t, {12'h000, H0_TO_Hi_BASE_ADDR, MESSAGE_BASE_ADDR_IN}, read_data);  // the receiving hart i reads from mailbox_b the message from Hart h
      repeat(20) @(posedge CORE_CLK);
      verify_mb_ch_rdwr_data(t, i, t, h, hart_en_vector[i], write_data, read_data);  // verify if the message read back was the same written (if the channel is enabled and MPU permissions allow)

      // receiving hart sets channel B ack flag high (b_mp_ack) and clears the message present flag.
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, CONTROL_ADDR}, 32'b001000 | 32'b000100);  // a_ack_ie=0, a_mp_ack=0, b_mp_ack=1, a_mp_ie=1, a_mp=0, b_mp=0
      repeat(20) @(posedge CORE_CLK);

      // hart h raises an ack flag for hart i. should result in the relevant interrupt being raised
      if (h==0 && H0_MONITOR_EN==1) begin  // MON_IRQ goes HIGH whenever a hart has a message or acknowledgement from Hart0 pending
        if ( (MON_IRQ[i] != 1'b1 || !($onehot(MON_IRQ)) || (|APP_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[i] && valid_perm) begin  // ith bit should be high, all other bits should be low
          $display ("FAILED : Hart %0d wrote to Hart %0d, so MON_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & all APP_IRQ's=0 ! Actual MON_IRQ_H%0d=%b", h, i, i, i, MON_IRQ[i]);
          #10 $stop;
        end else begin
          $display ("PASS : Hart %0d wrote to Hart %0d, so MON_IRQ_H%0d=1 (if Interrupt Module enabled & MPU allows it). Actual MON_IRQ_H%0d=%b", h, i, i, i, MON_IRQ[i]);
        end
      end else begin
        if ( (APP_IRQ[i] != 1'b1 || !($onehot(APP_IRQ)) || (|MON_IRQ)) && hart_en_vector[i] && enabled_interrupt_modules[i] && valid_perm) begin // Relevant APP_IRQ bit should be high if message is not for hart 0, all other bits should be low
          $display ("FAILED : Hart %0d sent ack to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it) & MON_IRQ='0!  Actual APP_IRQ_H%0d=%b", h, i, i, i, APP_IRQ[i]);
          #10 $stop;
        end else begin 
          $display ("PASS : Hart %0d sent ack to Hart %0d, so APP_IRQ_H%0d should be 1 (if Interrupt Module enabled & MPU allows it). Actual APP_IRQ_H%0d=%b", h, i, i, i, APP_IRQ[i]);
        end
      end

      // transmitting hart h clears the channel A acknowledgement flag (b_ack) (and disables channel side A acknowledgements)
      target_write(t, {12'h000, Hi_TO_H0_BASE_ADDR, CONTROL_ADDR}, 32'b000000);  // b_ack_ie=0, b_mp_ack=0, a_mp_ack=0, b_mp_ie=0, b_mp=0, a_mp=0

      // receiving hart on channel b clears all flags in anticipation for next iteration
      target_write(t, {12'h000, H0_TO_Hi_BASE_ADDR, CONTROL_ADDR}, 32'b000000);  // b_ack_ie=0, b_mp_ack=0, a_mp_ack=0, b_mp_ie=0, b_mp=0, a_mp=0
    end

    repeat(100) @(posedge CORE_CLK);

    // ****** End of Test ******

// stop simulation when test has finished
$stop;
$finish;

end

//////////////////////////////////////////////////////////////////////
// Clock Drivers
//////////////////////////////////////////////////////////////////////
generate
  if (AXI_INTERFACE_0) begin: axi0_clk  // only drive AXI Target 0 clock when the target has been selected by user in GUI
    always @(AXI_0_ACLK)
      #(TARGET_0_PERIOD / 2.0) AXI_0_ACLK <= !AXI_0_ACLK;
  end
  else if (APB_INTERFACE_0) begin: apb0_clk  // only drive APB Target 0 clock when the target has been selected by user in GUI
    always @(APB_0_PCLK)
      #(TARGET_0_PERIOD / 2.0) APB_0_PCLK <= !APB_0_PCLK;
  end

	if (AXI_INTERFACE_1) begin: axi1_clk  // only drive AXI Target 1 clock when the target has been selected by user in GUI
    always @(AXI_1_ACLK)
      #(TARGET_1_PERIOD / 2.0) AXI_1_ACLK <= !AXI_1_ACLK;
  end
  else if (APB_INTERFACE_1) begin: apb1_clk  // only drive APB Target 1 clock when the target has been selected by user in GUI
    always @(APB_1_PCLK)
      #(TARGET_1_PERIOD / 2.0) APB_1_PCLK <= !APB_1_PCLK;
  end

  if (AXI_INTERFACE_2) begin: axi2_clk  // only drive AXI Target 2 clock when the target has been selected by user in GUI
    always @(AXI_2_ACLK)
      #(TARGET_2_PERIOD / 2.0) AXI_2_ACLK <= !AXI_2_ACLK;
  end
  else if (APB_INTERFACE_2) begin: apb2_clk  // only drive APB Target 2 clock when the target has been selected by user in GUI
    always @(APB_2_PCLK)
      #(TARGET_2_PERIOD / 2.0) APB_2_PCLK <= !APB_2_PCLK;
  end
endgenerate

// always drive the MIV_IHC core clock
always @(CORE_CLK)
  #(CORE_PERIOD / 2.0) CORE_CLK <= !CORE_CLK;

//////////////////////////////////////////////////////////////////////
// MIV_IHC Instantiation
//////////////////////////////////////////////////////////////////////
MIV_IHC_C0_MIV_IHC_C0_0_MIV_IHC #(
	  .FAMILY				      (FAMILY),
    .H0_MONITOR_EN      ( H0_MONITOR_EN  ),
    .H0_TO_H1_CH_EN     ( H0_TO_H1_CH_EN ),
    .H0_TO_H2_CH_EN     ( H0_TO_H2_CH_EN ),
    .H0_TO_H3_CH_EN     ( H0_TO_H3_CH_EN ),
    .H0_TO_H4_CH_EN     ( H0_TO_H4_CH_EN ),
    .H0_TO_H5_CH_EN     ( H0_TO_H5_CH_EN ),
    .H1_TO_H2_CH_EN     ( H1_TO_H2_CH_EN ),
    .H1_TO_H3_CH_EN     ( H1_TO_H3_CH_EN ),
    .H1_TO_H4_CH_EN     ( H1_TO_H4_CH_EN ),
    .H1_TO_H5_CH_EN     ( H1_TO_H5_CH_EN ),
    .H2_TO_H3_CH_EN     ( H2_TO_H3_CH_EN ),
    .H2_TO_H4_CH_EN     ( H2_TO_H4_CH_EN ),
    .H2_TO_H5_CH_EN     ( H2_TO_H5_CH_EN ),
    .H3_TO_H4_CH_EN     ( H3_TO_H4_CH_EN ),
    .H3_TO_H5_CH_EN     ( H3_TO_H5_CH_EN ),
    .H4_TO_H5_CH_EN     ( H4_TO_H5_CH_EN ),
    .H0_IHCIM_EN        ( H0_IHCIM_EN ),
    .H1_IHCIM_EN        ( H1_IHCIM_EN ),
    .H2_IHCIM_EN        ( H2_IHCIM_EN ),
    .H3_IHCIM_EN        ( H3_IHCIM_EN ),
    .H4_IHCIM_EN        ( H4_IHCIM_EN ),
    .H5_IHCIM_EN        ( H5_IHCIM_EN ),
    .INF_0_TYPE         ( INF_0_TYPE ),
    .INF_0_TYPE_MIRROR  ( INF_0_TYPE_MIRROR),
    .INF_1_TYPE         ( INF_1_TYPE ),
    .INF_1_TYPE_MIRROR  ( INF_1_TYPE_MIRROR),
    .INF_2_TYPE         ( INF_2_TYPE ),
    .INF_2_TYPE_MIRROR  ( INF_2_TYPE_MIRROR),
    .INF_0_CDC_EN       ( INF_0_CDC_EN),
    .INF_1_CDC_EN       ( INF_1_CDC_EN),
    .INF_2_CDC_EN       ( INF_2_CDC_EN),
    .MPU_EN             ( MPU_EN  ),
    .INF_0_H0_ACCESS    (INF_0_H0_ACCESS),
    .INF_0_H1_ACCESS    (INF_0_H1_ACCESS),
    .INF_0_H2_ACCESS    (INF_0_H2_ACCESS),
    .INF_0_H3_ACCESS    (INF_0_H3_ACCESS),
    .INF_0_H4_ACCESS    (INF_0_H4_ACCESS),
    .INF_0_H5_ACCESS    (INF_0_H5_ACCESS),
    .INF_1_H0_ACCESS    (INF_1_H0_ACCESS),
    .INF_1_H1_ACCESS    (INF_1_H1_ACCESS),
    .INF_1_H2_ACCESS    (INF_1_H2_ACCESS),
    .INF_1_H3_ACCESS    (INF_1_H3_ACCESS),
    .INF_1_H4_ACCESS    (INF_1_H4_ACCESS),
    .INF_1_H5_ACCESS    (INF_1_H5_ACCESS),
    .INF_2_H0_ACCESS    (INF_2_H0_ACCESS),
    .INF_2_H1_ACCESS    (INF_2_H1_ACCESS),
    .INF_2_H2_ACCESS    (INF_2_H2_ACCESS),
    .INF_2_H3_ACCESS    (INF_2_H3_ACCESS),
    .INF_2_H4_ACCESS    (INF_2_H4_ACCESS),
    .INF_2_H5_ACCESS    (INF_2_H5_ACCESS)
    )
DUT (
    // Inputs
    .APB_0_PADDR    ( APB_0_PADDR ),
    .APB_0_PCLK     ( APB_0_PCLK ),
    .APB_0_PENABLE  ( APB_0_PENABLE ),
    .APB_0_PRESETn  ( APB_0_NSYSRESET ),
    .APB_0_PSEL     ( APB_0_PSEL ),
    .APB_0_PWDATA   ( APB_0_PWDATA ),
    .APB_0_PWRITE   ( APB_0_PWRITE ),
    .AXI_0_ACLK     ( AXI_0_ACLK ), 
    .AXI_0_ARADDR   ( AXI_0_ARADDR ), 
    .AXI_0_ARESETn  ( AXI_0_NSYSRESET ), 
    .AXI_0_ARPROT   ( AXI_0_ARPROT ), 
    .AXI_0_ARVALID  ( AXI_0_ARVALID ), 
    .AXI_0_AWADDR   ( AXI_0_AWADDR ), 
    .AXI_0_AWPROT   ( AXI_0_AWPROT ), 
    .AXI_0_AWVALID  ( AXI_0_AWVALID ), 
    .AXI_0_BREADY   ( AXI_0_BREADY ), 
    .AXI_0_RREADY   ( AXI_0_RREADY ), 
    .AXI_0_WDATA    ( AXI_0_WDATA ), 
    .AXI_0_WSTRB    ( AXI_0_WSTRB ), 
    .AXI_0_WVALID   ( AXI_0_WVALID ), 
    .APB_1_PADDR    ( APB_1_PADDR ),
    .APB_1_PCLK     ( APB_1_PCLK ),
    .APB_1_PENABLE  ( APB_1_PENABLE ),
    .APB_1_PRESETn  ( APB_1_NSYSRESET ),
    .APB_1_PSEL     ( APB_1_PSEL ),
    .APB_1_PWDATA   ( APB_1_PWDATA ),
    .APB_1_PWRITE   ( APB_1_PWRITE ),
    .AXI_1_ACLK     ( AXI_1_ACLK ), 
    .AXI_1_ARADDR   ( AXI_1_ARADDR ), 
    .AXI_1_ARESETn  ( AXI_1_NSYSRESET ), 
    .AXI_1_ARPROT   ( AXI_1_ARPROT ), 
    .AXI_1_ARVALID  ( AXI_1_ARVALID ), 
    .AXI_1_AWADDR   ( AXI_1_AWADDR ), 
    .AXI_1_AWPROT   ( AXI_1_AWPROT ), 
    .AXI_1_AWVALID  ( AXI_1_AWVALID ), 
    .AXI_1_BREADY   ( AXI_1_BREADY ), 
    .AXI_1_RREADY   ( AXI_1_RREADY ), 
    .AXI_1_WDATA    ( AXI_1_WDATA ), 
    .AXI_1_WSTRB    ( AXI_1_WSTRB ), 
    .AXI_1_WVALID   ( AXI_1_WVALID ),
    .APB_2_PADDR    ( APB_2_PADDR ),
    .APB_2_PCLK     ( APB_2_PCLK ),
    .APB_2_PENABLE  ( APB_2_PENABLE ),
    .APB_2_PRESETn  ( APB_2_NSYSRESET ),
    .APB_2_PSEL     ( APB_2_PSEL ),
    .APB_2_PWDATA   ( APB_2_PWDATA ),
    .APB_2_PWRITE   ( APB_2_PWRITE ),
    .AXI_2_ACLK     ( AXI_2_ACLK ), 
    .AXI_2_ARADDR   ( AXI_2_ARADDR ), 
    .AXI_2_ARESETn  ( AXI_2_NSYSRESET ), 
    .AXI_2_ARPROT   ( AXI_2_ARPROT ), 
    .AXI_2_ARVALID  ( AXI_2_ARVALID ), 
    .AXI_2_AWADDR   ( AXI_2_AWADDR ), 
    .AXI_2_AWPROT   ( AXI_2_AWPROT ), 
    .AXI_2_AWVALID  ( AXI_2_AWVALID ), 
    .AXI_2_BREADY   ( AXI_2_BREADY ), 
    .AXI_2_RREADY   ( AXI_2_RREADY ), 
    .AXI_2_WDATA    ( AXI_2_WDATA ), 
    .AXI_2_WSTRB    ( AXI_2_WSTRB ), 
    .AXI_2_WVALID   ( AXI_2_WVALID ), 
    .CORE_CLK       ( CORE_CLK ),
    .CORE_RESETN    ( CORE_RESETN ),

    // Outputs
    .APB_0_PRDATA   ( APB_0_PRDATA ),
    .APB_0_PREADY   ( APB_0_PREADY ),
    .APB_0_PSLVERR  ( APB_0_PSLVERR ),
    .AXI_0_ARREADY  ( AXI_0_ARREADY ),
    .AXI_0_AWREADY  ( AXI_0_AWREADY ),
    .AXI_0_BRESP    ( AXI_0_BRESP ),
    .AXI_0_BVALID   ( AXI_0_BVALID ),
    .AXI_0_RDATA    ( AXI_0_RDATA ),
    .AXI_0_RRESP    ( AXI_0_RRESP ),
    .AXI_0_RVALID   ( AXI_0_RVALID ),
    .AXI_0_WREADY   ( AXI_0_WREADY ),
    .APB_1_PRDATA   ( APB_1_PRDATA ),
    .APB_1_PREADY   ( APB_1_PREADY ),
    .APB_1_PSLVERR  ( APB_1_PSLVERR ),
    .AXI_1_ARREADY  ( AXI_1_ARREADY ),
    .AXI_1_AWREADY  ( AXI_1_AWREADY ),
    .AXI_1_BRESP    ( AXI_1_BRESP ),
    .AXI_1_BVALID   ( AXI_1_BVALID ),
    .AXI_1_RDATA    ( AXI_1_RDATA ),
    .AXI_1_RRESP    ( AXI_1_RRESP ),
    .AXI_1_RVALID   ( AXI_1_RVALID ),
    .AXI_1_WREADY   ( AXI_1_WREADY ),
    .APB_2_PRDATA   ( APB_2_PRDATA ),
    .APB_2_PREADY   ( APB_2_PREADY ),
    .APB_2_PSLVERR  ( APB_2_PSLVERR ),
    .AXI_2_ARREADY  ( AXI_2_ARREADY ),
    .AXI_2_AWREADY  ( AXI_2_AWREADY ),
    .AXI_2_BRESP    ( AXI_2_BRESP ),
    .AXI_2_BVALID   ( AXI_2_BVALID ),
    .AXI_2_RDATA    ( AXI_2_RDATA ),
    .AXI_2_RRESP    ( AXI_2_RRESP ),
    .AXI_2_RVALID   ( AXI_2_RVALID ),
    .AXI_2_WREADY   ( AXI_2_WREADY ),
    .MON_IRQ_H1     ( MON_IRQ_H1 ),
    .MON_IRQ_H2     ( MON_IRQ_H2 ),
    .MON_IRQ_H3     ( MON_IRQ_H3 ),
    .MON_IRQ_H4     ( MON_IRQ_H4 ),
    .MON_IRQ_H5     ( MON_IRQ_H5 ),
    .APP_IRQ_H0     ( APP_IRQ_H0 ),
    .APP_IRQ_H1     ( APP_IRQ_H1 ),
    .APP_IRQ_H2     ( APP_IRQ_H2 ),
    .APP_IRQ_H3     ( APP_IRQ_H3 ),
    .APP_IRQ_H4     ( APP_IRQ_H4 ),
    .APP_IRQ_H5     ( APP_IRQ_H5 )
    );

/************************************************************************/
// Supporting Tasks

// This task does an APB or AXI Target Write
// The interface used is determined by Target number
task target_write;
input integer target_num;
input [31:0] address;
input [31:0] data;
begin
  if (target_num == 0) begin
    target_0_write(address, data);
  end else if (target_num == 1) begin
    target_1_write(address, data);  
  end else if (target_num == 2) begin
    target_2_write(address, data);  
  end
end
endtask

// This task does an APB or AXI Target Read
// The interface used is determined by 1.) Hart number 2.) Which interface the MSS is on
task target_read;
input integer target_num;
input [31:0] address;
output [31:0] data;
reg [31:0] data;
begin
  if (target_num == 0) begin
    target_0_read(address, data);
  end else if (target_num == 1) begin
    target_1_read(address, data);
  end else if (target_num == 2) begin
    target_2_read(address, data);  
  end
end
endtask

// This task does an APB or AXI Target 0 Write
task target_0_write;
input [31:0] address;
input [31:0] data;
begin
  if (APB_INTERFACE_0) begin
    $display("APB TARGET 0 Write %h = %04x", address, data);
    @(posedge APB_0_PCLK);  
    APB_0_PWRITE   = 1'b0;
    @(posedge APB_0_PCLK);  
    APB_0_PENABLE  = 1'b0;
    APB_0_PSEL     = 1'b1;
    APB_0_PADDR    = address;
    APB_0_PWDATA   = data;  
    APB_0_PWRITE   = 1'b1;
    @(posedge APB_0_PCLK);  
    APB_0_PENABLE  = 1'b1;
    @(posedge APB_0_PCLK);  
    while (APB_0_PREADY==1'b0) @(posedge APB_0_PCLK);
    APB_0_PWRITE   = 1'b0;
    APB_0_PENABLE  = 1'b0;
    APB_0_PSEL     = 1'b0;
  end else if (AXI_INTERFACE_0) begin
    $display("AXI TARGET 0 Write %04x = %04x", address, data);
    @(posedge AXI_0_ACLK);
    AXI_0_AWVALID = 1'b1;
    AXI_0_AWADDR = address; //4'b0000;
    AXI_0_AWPROT = 3'b0;
    wait(AXI_0_AWREADY);  // wait until target is ready to accept the write address
    @(posedge AXI_0_ACLK);
    AXI_0_AWVALID = 1'b0;
    AXI_0_AWADDR = 32'b0;

    @(posedge AXI_0_ACLK);
    AXI_0_WVALID = 1'b1;
    AXI_0_WDATA  = data;
    AXI_0_WSTRB  = 4'b1111;
    //AXI_0_WLAST  = 1'b1;
    wait(AXI_0_WREADY);  // wait until target is ready to accept the write data
    @(posedge AXI_0_ACLK);
    AXI_0_WVALID = 1'b0;
    AXI_0_WDATA  = 32'b0;
    AXI_0_WSTRB  = 4'b0;
    //AXI_0_WLAST  = 1'b0;

    @(posedge AXI_0_ACLK);
    AXI_0_BREADY = 1'b1;  // indicate to target that we are ready to do the B channel handshake
    wait(AXI_0_BVALID);  // wait for B channel handshake to finish (BVALID=1 && BREADY=1)
    @(posedge AXI_0_ACLK);
    AXI_0_BREADY = 1'b0;
    @(posedge AXI_0_ACLK);
  end else begin  
    $display ("Error: a target 0 write was attempted but the target 0 interface is disabled");
    #10
    $stop;
  end
end
endtask

// This task does an APB or AXI Target 0 Read
task target_0_read;
input [31:0] address;
output [31:0] data;
reg [31:0] data;
begin
  if (APB_INTERFACE_0) begin
    @(posedge APB_0_PCLK);  
    APB_0_PWRITE   = 1'b1;
    @(posedge APB_0_PCLK);  
    APB_0_PENABLE  = 1'b0;
    APB_0_PSEL     = 1'b1;
    APB_0_PADDR    = address;
    APB_0_PWRITE   = 1'b0;
    @(posedge APB_0_PCLK);  
    APB_0_PENABLE  = 1'b1;
    @(APB_0_PCLK);
    while (APB_0_PREADY==1'b0) @(posedge APB_0_PCLK);
    data = APB_0_PRDATA;
    APB_0_PWRITE   = 1'b1;
    APB_0_PENABLE  = 1'b0;
    APB_0_PSEL     = 1'b0;
    $display("APB TARGET 0 Read %h = %04x", address, data);
  end else if (AXI_INTERFACE_0) begin
    @(posedge AXI_0_ACLK);
    // AR Channel handshake
    AXI_0_ARVALID = 1'b1;
    AXI_0_ARADDR = address;
    wait(AXI_0_ARREADY);
    @(posedge AXI_0_ACLK);
    AXI_0_ARVALID = 1'b0;
    AXI_0_ARADDR = 32'b0;
    
    // R Channel handshake
    @(posedge AXI_0_ACLK);
    AXI_0_RREADY = 1'b1;
    wait(AXI_0_RVALID);  // wait until the read data is valid
    #1 data = AXI_0_RDATA;
    @(posedge AXI_0_ACLK);
    AXI_0_RREADY = 1'b0;
    @(posedge AXI_0_ACLK);
    $display("AXI TARGET 0 Read %04x = %04x", address, data);
  end else begin  
    $display ("Error: a target 0 read was attempted but the target 0 interface is disabled");
    #10
    $stop;
  end
end
endtask

// This task does an APB or AXI Target 1 Write
task target_1_write;
input [31:0] address;
input [31:0] data;
begin
  if (APB_INTERFACE_1) begin
    $display("APB TARGET 1 Write %h = %04x", address, data);
    @(posedge APB_1_PCLK);  
    APB_1_PWRITE   = 1'b0;
    @(posedge APB_1_PCLK);  
    APB_1_PENABLE  = 1'b0;
    APB_1_PSEL     = 1'b1;
    APB_1_PADDR    = address;
    APB_1_PWDATA   = data;  
    APB_1_PWRITE   = 1'b1;
    @(posedge APB_1_PCLK);  
    APB_1_PENABLE  = 1'b1;
    @(posedge APB_1_PCLK);  
    while (APB_1_PREADY==1'b0) @(posedge APB_1_PCLK);
    APB_1_PWRITE   = 1'b0;
    APB_1_PENABLE  = 1'b0;
    APB_1_PSEL     = 1'b0;
  end else if (AXI_INTERFACE_1) begin
    $display("AXI TARGET 1 Write %04x = %04x", address, data);
    @(posedge AXI_1_ACLK);
    AXI_1_AWVALID = 1'b1;
    AXI_1_AWADDR = address;
    AXI_1_AWPROT = 3'b0;
    wait(AXI_1_AWREADY);  // wait until target is ready to accept the write addr
    @(posedge AXI_1_ACLK);
    AXI_1_AWVALID = 1'b0;
    AXI_1_AWADDR = 32'b0;
    
    @(posedge AXI_1_ACLK);
    AXI_1_WVALID = 1'b1;
    AXI_1_WDATA  = data;
    AXI_1_WSTRB  = 4'b1111;
    //AXI_1_WLAST  = 1'b1;
    wait(AXI_1_WREADY);  // wait until target is ready to accept the write data
    @(posedge AXI_1_ACLK);
    AXI_1_WVALID = 1'b0;
    AXI_1_WDATA  = 32'b0;
    AXI_1_WSTRB  = 4'b0;
    //AXI_1_WLAST  = 1'b0;
    
    @(posedge AXI_1_ACLK);
    AXI_1_BREADY = 1'b1;  // indicate to target that we are ready to do the B channel handshake
    wait(AXI_1_BVALID);  // wait for B channel handshake to finish (BVALID=1 && BREADY=1)
    @(posedge AXI_1_ACLK);
    AXI_1_BREADY = 1'b0;
    @(posedge AXI_1_ACLK);
  end else begin  
    $display ("Error: a target 1 write was attempted but the target 1 interface is disabled");
    #10
    $stop;
  end
end
endtask

// This task does an APB or AXI Target 1 Read
task target_1_read;
input [31:0] address;
output [31:0] data;
reg [31:0] data;
begin
  if (APB_INTERFACE_1) begin
    @(posedge APB_1_PCLK);  
    APB_1_PWRITE   = 1'b1;
    @(posedge APB_1_PCLK);  
    APB_1_PENABLE  = 1'b0;
    APB_1_PSEL     = 1'b1;
    APB_1_PADDR    = address;
    APB_1_PWRITE   = 1'b0;
    @(posedge APB_1_PCLK);  
    APB_1_PENABLE  = 1'b1;
    @(APB_1_PCLK);
    while (APB_1_PREADY==1'b0) @(posedge APB_1_PCLK);
    data = APB_1_PRDATA;
    APB_1_PWRITE   = 1'b1;
    APB_1_PENABLE  = 1'b0;
    APB_1_PSEL     = 1'b0;
    $display("APB TARGET 1 Read %h = %04x",address,data);
  end else if (AXI_INTERFACE_1) begin
    @(posedge AXI_1_ACLK);
    // AR Channel handshake
    AXI_1_ARVALID = 1'b1;
    AXI_1_ARADDR = address;
    wait(AXI_1_ARREADY);
    @(posedge AXI_1_ACLK);
    AXI_1_ARVALID = 1'b0;
    AXI_1_ARADDR = 32'b0;
    
    // R Channel handshake
    @(posedge AXI_1_ACLK);
    AXI_1_RREADY = 1'b1;
    wait(AXI_1_RVALID);  // wait until the read data is valid
    #1 data = AXI_1_RDATA;
    @(posedge AXI_1_ACLK);
    AXI_1_RREADY = 1'b0;
    @(posedge AXI_1_ACLK);
    $display("AXI TARGET 1 Read %04x = %04x",address,data);
  end else begin  
    $display ("Error: a target 1 read was attempted but the target 1 interface is disabled");
    #10
    $stop;
  end
end
endtask

// This task does an APB or AXI Target 2 Write
task target_2_write;
input [31:0] address;
input [31:0] data;
begin
  if (APB_INTERFACE_2) begin
    $display("APB TARGET 2 Write %h = %04x", address, data);
    @(posedge APB_2_PCLK);  
    APB_2_PWRITE   = 1'b0;
    @(posedge APB_2_PCLK);  
    APB_2_PENABLE  = 1'b0;
    APB_2_PSEL     = 1'b1;
    APB_2_PADDR    = address;
    APB_2_PWDATA   = data;  
    APB_2_PWRITE   = 1'b1;
    @(posedge APB_2_PCLK);  
    APB_2_PENABLE  = 1'b1;
    @(posedge APB_2_PCLK);  
    while (APB_2_PREADY==1'b0) @(posedge APB_2_PCLK);
    APB_2_PWRITE   = 1'b0;
    APB_2_PENABLE  = 1'b0;
    APB_2_PSEL     = 1'b0;
  end else if (AXI_INTERFACE_2) begin
    $display("AXI TARGET 2 Write %04x = %04x", address, data);
    @(posedge AXI_2_ACLK);
    AXI_2_AWVALID = 1'b1;
    AXI_2_AWADDR = address; //4'b0000;
    AXI_2_AWPROT = 3'b0;
    wait(AXI_2_AWREADY);  // wait until target is ready to accept the write address
    @(posedge AXI_2_ACLK);
    AXI_2_AWVALID = 1'b0;
    AXI_2_AWADDR = 32'b0;

    @(posedge AXI_2_ACLK);
    AXI_2_WVALID = 1'b1;
    AXI_2_WDATA  = data;
    AXI_2_WSTRB  = 4'b1111;
    //AXI_0_WLAST  = 1'b1;
    wait(AXI_2_WREADY);  // wait until target is ready to accept the write data
    @(posedge AXI_2_ACLK);
    AXI_2_WVALID = 1'b0;
    AXI_2_WDATA  = 32'b0;
    AXI_2_WSTRB  = 4'b0;
    //AXI_0_WLAST  = 1'b0;

    @(posedge AXI_2_ACLK);
    AXI_2_BREADY = 1'b1;  // indicate to target that we are ready to do the B channel handshake
    wait(AXI_2_BVALID);  // wait for B channel handshake to finish (BVALID=1 && BREADY=1)
    @(posedge AXI_2_ACLK);
    AXI_2_BREADY = 1'b0;
    @(posedge AXI_2_ACLK);
  end else begin  
    $display ("Error: a target 2 write was attempted but the target 2 interface is disabled");
    #10
    $stop;
  end
end
endtask

// This task does an APB or AXI Target 2 Read
task target_2_read;
input [31:0] address;
output [31:0] data;
reg [31:0] data;
begin
  if (APB_INTERFACE_2) begin
    @(posedge APB_2_PCLK);  
    APB_2_PWRITE   = 1'b1;
    @(posedge APB_2_PCLK);  
    APB_2_PENABLE  = 1'b0;
    APB_2_PSEL     = 1'b1;
    APB_2_PADDR    = address;
    APB_2_PWRITE   = 1'b0;
    @(posedge APB_2_PCLK);  
    APB_2_PENABLE  = 1'b1;
    @(APB_2_PCLK);
    while (APB_2_PREADY==1'b0) @(posedge APB_2_PCLK);
    data = APB_2_PRDATA;
    APB_2_PWRITE   = 1'b1;
    APB_2_PENABLE  = 1'b0;
    APB_2_PSEL     = 1'b0;
    $display("APB TARGET 2 Read %h = %04x", address, data);
  end else if (AXI_INTERFACE_2) begin
    @(posedge AXI_2_ACLK);
    // AR Channel handshake
    AXI_2_ARVALID = 1'b1;
    AXI_2_ARADDR = address;
    wait(AXI_2_ARREADY);
    @(posedge AXI_2_ACLK);
    AXI_2_ARVALID = 1'b0;
    AXI_2_ARADDR = 32'b0;
    
    // R Channel handshake
    @(posedge AXI_2_ACLK);
    AXI_2_RREADY = 1'b1;
    wait(AXI_2_RVALID);  // wait until the read data is valid
    #1 data = AXI_2_RDATA;
    @(posedge AXI_2_ACLK);
    AXI_2_RREADY = 1'b0;
    @(posedge AXI_2_ACLK);
    $display("AXI TARGET 2 Read %04x = %04x", address, data);
  end else begin  
    $display ("Error: a target 2 read was attempted but the target 2 interface is disabled");
    #10
    $stop;
  end
end
endtask

task reset_routine;
begin
  fork
    write_data = 32'b0;
    read_data  = 32'hdeadbeef;

    if (APB_INTERFACE_0) begin
      begin
        APB_0_PWRITE  = 1'b0;
        APB_0_PADDR   = 32'b0;
        APB_0_PENABLE = 1'b0;
        APB_0_PSEL    = 1'b0;
        APB_0_PWDATA  = 32'b0;

        APB_0_PCLK = 1'b0;
        
        APB_0_NSYSRESET = 1'b0;
        #(TARGET_0_PERIOD * 10 )
            APB_0_NSYSRESET = 1'b1;
        #50;
      end
    end

    if (APB_INTERFACE_1) begin
      begin
        APB_1_PWRITE  = 1'b0;
        APB_1_PADDR   = 32'b0;
        APB_1_PENABLE = 1'b0;
        APB_1_PSEL    = 1'b0;
        APB_1_PWDATA  = 32'b0;

        #CLOCK_TYPE APB_1_PCLK = (CLOCK_TYPE == 0) ? 1'b0 : 1'b1; // #0 is for syncheonous, the rest are asynchronous
        
        APB_1_NSYSRESET = 1'b0;
        #(TARGET_1_PERIOD * 10 )
            APB_1_NSYSRESET = 1'b1;
        #50;
      end
    end

    if (APB_INTERFACE_2) begin
      begin
        APB_2_PWRITE  = 1'b0;
        APB_2_PADDR   = 32'b0;
        APB_2_PENABLE = 1'b0;
        APB_2_PSEL    = 1'b0;
        APB_2_PWDATA  = 32'b0;

        #CLOCK_TYPE;
        #CLOCK_TYPE APB_2_PCLK = (CLOCK_TYPE == 0) ? 1'b0 : 1'b1; // #0 is for syncheonous, the rest are asynchronous
        
        APB_2_NSYSRESET = 1'b0;
        #(TARGET_2_PERIOD * 10 )
            APB_2_NSYSRESET = 1'b1;
        #50;
      end
    end

    if (AXI_INTERFACE_0) begin
      axi_target_0_reset();
    end

    if (AXI_INTERFACE_1) begin
      axi_target_1_reset();
    end

    if (AXI_INTERFACE_2) begin
      axi_target_2_reset();
    end
    
    begin
      CORE_CLK = 1'b0;
      CORE_RESETN = 1'b0;
      #(CORE_PERIOD * 10 )
          CORE_RESETN = 1'b1;
      #50;
    end

  join
end
endtask

// AXI reset tasks
task axi_target_0_reset;
begin
  AXI_0_ACLK = 1'b0;
  AXI_0_ARVALID = 1'b0;
  AXI_0_WVALID = 1'b0;
  AXI_0_AWVALID = 1'b0;
  AXI_0_BREADY = 1'b0;
  AXI_0_RREADY = 1'b0;
  AXI_0_AWADDR = 32'b0;
  AXI_0_WDATA = 32'b0;
  AXI_0_AWPROT = 3'b0;
  AXI_0_WSTRB = 4'b0;
  AXI_0_ARADDR = 32'b0;
  AXI_0_ARPROT = 3'b0;

  AXI_0_NSYSRESET = 1'b0;
  #(TARGET_0_PERIOD * 10 )
    AXI_0_NSYSRESET = 1'b1;
  #50;
end
endtask

task axi_target_1_reset;
begin
  AXI_1_ACLK = 1'b0;
  AXI_1_ARVALID = 1'b0;
  AXI_1_WVALID = 1'b0;
  AXI_1_AWVALID = 1'b0;
  AXI_1_BREADY = 1'b0;
  AXI_1_RREADY = 1'b0;
  AXI_1_AWADDR = 32'b0;
  AXI_1_WDATA = 32'b0;
  AXI_1_AWPROT = 3'b0;
  AXI_1_WSTRB = 4'b0;
  AXI_1_ARADDR = 32'b0;
  AXI_1_ARPROT = 3'b0;

  #CLOCK_TYPE AXI_1_ACLK = (CLOCK_TYPE == 0) ? 1'b0 : 1'b1; // #0 is for syncheonous, the rest are asynchronous

  AXI_1_NSYSRESET = 1'b0;
  #(TARGET_1_PERIOD * 10 )
    AXI_1_NSYSRESET = 1'b1;
  #50;
end
endtask

task axi_target_2_reset;
begin
  AXI_2_ACLK = 1'b0;
  AXI_2_ARVALID = 1'b0;
  AXI_2_WVALID = 1'b0;
  AXI_2_AWVALID = 1'b0;
  AXI_2_BREADY = 1'b0;
  AXI_2_RREADY = 1'b0;
  AXI_2_AWADDR = 32'b0;
  AXI_2_WDATA = 32'b0;
  AXI_2_AWPROT = 3'b0;
  AXI_2_WSTRB = 4'b0;
  AXI_2_ARADDR = 32'b0;
  AXI_2_ARPROT = 3'b0;

  #CLOCK_TYPE;
  #CLOCK_TYPE AXI_2_ACLK = (CLOCK_TYPE == 0) ? 1'b0 : 1'b1; // #0 is for syncheonous, the rest are asynchronous

  AXI_2_NSYSRESET = 1'b0;
  #(TARGET_2_PERIOD * 10 )
    AXI_2_NSYSRESET = 1'b1;
  #50;
end
endtask

task init_amba_buses;
begin
// Initialize APB Target 0 Input ports
APB_0_NSYSRESET  = 'b0;
APB_0_PWRITE     = 'b0;
APB_0_PADDR      = 'b0;
APB_0_PCLK       = 'b0;
APB_0_PENABLE    = 'b0;
APB_0_PSEL       = 'b0;
APB_0_PWDATA     = 'b0;

// Initialize APB Target 1 Input ports
APB_1_NSYSRESET  = 'b0;
APB_1_PADDR      = 'b0;
APB_1_PCLK       = 'b0;
APB_1_PENABLE    = 'b0;
APB_1_PSEL       = 'b0;
APB_1_PWDATA     = 'b0;
APB_1_PWRITE     = 'b0;

// Initialize APB Target 2 Input ports
APB_2_NSYSRESET  = 'b0;
APB_2_PADDR      = 'b0;
APB_2_PCLK       = 'b0;
APB_2_PENABLE    = 'b0;
APB_2_PSEL       = 'b0;
APB_2_PWDATA     = 'b0;
APB_2_PWRITE     = 'b0;

// Initialize AXI Target 0 Input ports
AXI_0_NSYSRESET   = 'b0;
AXI_0_ACLK        = 'b0;
AXI_0_ARVALID     = 'b0;
AXI_0_WVALID      = 'b0;
AXI_0_AWVALID     = 'b0;
AXI_0_BREADY      = 'b0;
AXI_0_RREADY      = 'b0;
AXI_0_AWADDR      = 'b0;
AXI_0_WDATA       = 'b0;
AXI_0_AWPROT      = 'b0;
AXI_0_WSTRB       = 'b0;
AXI_0_ARADDR      = 'b0;
AXI_0_ARPROT      = 'b0;

// Initialize AXI Target 1 Input ports
AXI_1_NSYSRESET   = 'b0;
AXI_1_ACLK        = 'b0;
AXI_1_ARVALID     = 'b0;
AXI_1_WVALID      = 'b0;
AXI_1_AWVALID     = 'b0;
AXI_1_BREADY      = 'b0;
AXI_1_RREADY      = 'b0;
AXI_1_AWADDR      = 'b0;
AXI_1_WDATA       = 'b0;
AXI_1_AWPROT      = 'b0;
AXI_1_WSTRB       = 'b0;
AXI_1_ARADDR      = 'b0;
AXI_1_ARPROT      = 'b0;

// Initialize AXI Target 2 Input ports
AXI_2_NSYSRESET   = 'b0;
AXI_2_ACLK        = 'b0;
AXI_2_ARVALID     = 'b0;
AXI_2_WVALID      = 'b0;
AXI_2_AWVALID     = 'b0;
AXI_2_BREADY      = 'b0;
AXI_2_RREADY      = 'b0;
AXI_2_AWADDR      = 'b0;
AXI_2_WDATA       = 'b0;
AXI_2_AWPROT      = 'b0;
AXI_2_WSTRB       = 'b0;
AXI_2_ARADDR      = 'b0;
AXI_2_ARPROT      = 'b0;
end
endtask

// task to verify whether the written data is equal to the data read when the channel is enabled
// if channel is not enabled it should NOT match & all attempted reads should read back all 0's
// to be used to verify normal read-write behaviour without MPU violations
task verify_normal_wr_rd;
input ch_en;
input reg [31:0] wr_data;
input reg [31:0] rd_data;
begin
  if (ch_en) begin  // if the channel for Hart i and Hart j communication is enabled
    // should match if the corresponding hart channel is enabled and no memory protection or mpu allows reads/writes
    if (rd_data != wr_data) begin  // Write message compared with read message.
      $display ("FAILED : rd_data=%h, wr_data=%h", rd_data, wr_data);
      #10
      $stop;
    end
  end else begin
    // should NOT match if the hart channel is not enabled and all attempted reads should read back all 0's
    if ( ((rd_data == wr_data) && (rd_data != '0 && wr_data != '0)) || (rd_data != 'b0) ) begin  // Write message compared with read message.
      $display ("T0.0.0 FAILED : rd_data=%h, wr_data=%h", rd_data, wr_data);
      #10
      $stop;
    end
  end
end
endtask

// task to verify correct mailbox/channel register read-write behaviour under various conditions
// *If the MPU is not enabled*:
//    - If the IHCC channel between the transmitting hart and receiving hart is enabled, then write data should equal to read data
//    - If the IHCC channel is not enabled, write data and read data should be different

// *If the MPU is enabled*:
//    - If we don't have read permissions, write data shouldn't equal read data and read data should be 0xBAD
//    - If we do have read permissions:
//          - If we also have write permissions then MPU should allow read/writes and write data should equal read data
//          - If we don't have write permissions then the read data shouldn't equal the written data as MPU should block the write
task verify_mb_ch_rdwr_data;
input integer tx_target;  // target interface that is being used to transmit the message
input integer tx_hart;    // the hart that is transmitting the message
input integer rx_target;  // target interface that the receiving hart is using to read the message
input integer rx_hart;    // the hart that is receiving the message
input ch_en;              // a true value indicates that the channel between the transmitting and receiving hart is enabled in hardware
input reg [31:0] wr_data;
input reg [31:0] rd_data;
begin
  if (!MPU_EN) begin  // If the MPU is not enabled
    // If the IHCC channel between the transmitting hart and receiving hart is enabled, then write data should equal to read data
    // If the IHCC channel is not enabled, write data and read data should be different
    verify_normal_wr_rd(ch_en, wr_data, rd_data);
  end else begin  // If the MPU is enabled
    automatic reg [5:0] rx_target_perm = target_perm_matrix[6*rx_target +: 6];
    if (rx_target_perm[rx_hart]) begin  // If reading target has read permissions for receiving hart
      automatic reg [5:0] tx_target_perm = target_perm_matrix[6*tx_target +: 6];
      if (tx_target_perm[tx_hart]) begin  // If transmitting target has write permissions for sending har  
        // MPU should allow both the reads & writes and thus write data should equal read data (if the IHCC is enabled)
        verify_normal_wr_rd(ch_en, wr_data, rd_data);
      end else begin
        // If we don't have write permissions then the read data shouldn't equal the written data as MPU should block the write
        if ((rd_data == wr_data) && (rd_data != '0 && wr_data != '0)) begin  // rd_data == wr_data could be true when we don't have permissions if wr_data = initial reset value of register
        $display ("FAILED : rd_data=%h, wr_data=%h (We don't have write permissions)", rd_data, wr_data);
        #10
        $stop;
        end
      end
      
    end else begin  // If we don't have read permissions
      // write data shouldn't equal read data and read data should be 0xBAD  
      if ( (rd_data == wr_data) || (rd_data != 32'hBAD00000) ) begin  // should NOT match if we have no read permissions. All attempted reads should read back 0xBAD
        $display ("FAILED : rd_data=%h, wr_data=%h (We don't have read permissions)", rd_data, wr_data);
        #10
        $stop;
      end
    end
  end
end
endtask

// task to verify if the transmitting hart on the given target has valid write permissions
// *If the MPU is not enabled*:
//    - The target-hart pair will always have write permissions
//
// *If the MPU is enabled*:
//    - if the target that is being used is allowed to use the transmitting hart address space it's attempting to access the
//      write will be successful. Otherwise, it will fail
// Return value: trans_wr_perm if 'true' indicates that the write transaction is permitted
function reg verify_write_permissions;
input integer tx_target;  // target interface that is being used to transmit the message
input integer tx_hart;    // the hart that is transmitting the message
begin
  if (!MPU_EN) begin  // If the MPU is not enabled
    verify_write_permissions = 1'b1;  // if MPU is not enabled then the transaction always has permissions
  end else begin  // If the MPU is enabled
    automatic reg [5:0] tx_target_perm = target_perm_matrix[6*tx_target +: 6];

    if (tx_target_perm[tx_hart]) begin  // If transmitting target has write permissions for sending hart and 
      verify_write_permissions = 1'b1;  // then the transaction has permissions
    end else begin
      verify_write_permissions = 1'b0;
    end
  end
end
endfunction

// task to verify if the receiving hart on the given target has valid read permissions
// *If the MPU is not enabled*:
//    - The target-hart pair will always have read permissions
//
// *If the MPU is enabled*:
//    - if the target that is being used is allowed to read from the receiving hart hart address space it's attempting to access the
//      read will be successful. Otherwise, it will fail
function reg verify_read_permissions;
input integer rx_target;  // target interface that is being used to receive the message
input integer rx_hart;    // the hart that is receiving the message
begin
  if (!MPU_EN) begin  // If the MPU is not enabled
    verify_read_permissions = 1'b1;  // if MPU is not enabled then the transaction always has permissions
  end else begin  // If the MPU is enabled
    automatic reg [5:0] rx_target_perm = target_perm_matrix[6*rx_target +: 6];

    if (rx_target_perm[rx_hart]) begin  // If transmitting target has write permissions for sending hart and 
      verify_read_permissions = 1'b1;  // then the transaction has permissions
    end else begin
      verify_read_permissions = 1'b0;
    end
  end
end
endfunction

endmodule
