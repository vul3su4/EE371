/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware (Task 2)
//  Device under Test (dut) --- binsearch_top
//  File Name: binsearch_top.sv                                                  
/*====================================================================*/ 
module binsearch_top 
    #(parameter BIT_WIDTH = 8, parameter ADDR_WIDTH = 5)(
	 input logic clock,
	 input logic reset,
    input logic LA,
	 input logic start,   
	 input logic [BIT_WIDTH-1:0] data_A,
    output logic Found2LEDR,
    output logic NotFound2LEDR,
	 output logic [6:0] HEX1,
	 output logic [6:0] HEX0);	
	 
	 // Declare the internal signals bewteen the Controller and the Datapath.   
    logic A_EQ_B, A_GT_B, A_LT_B, terminate, Ld_A, Ld_UpAddr, Ld_LowAddr;	
    logic get_Addr_sum, get_Addr_m, read_mem, compare, Found, NotFound;
	 logic New_UpAddr,New_LowAddr;
	
	 logic [BIT_WIDTH-1:0] data_B;
	 logic [ADDR_WIDTH-1:0] m, Addr_Found;
	
    logic [6:0] HEX1_mux, HEX0_mux;  // The bridge-signals between datapath and HEX1, HEX0. 
	 
	 // Instantiate binsearch_ctrl (Controller) module  
	 binsearch_ctrl m1 (
    .clock, 
    .reset,
    .LA, 	
    .start,
    .A_EQ_B,
    .A_GT_B,
    .A_LT_B,
    .terminate,	
    .Ld_A,
    .Ld_UpAddr,
    .Ld_LowAddr,
	 .get_Addr_sum, 
    .get_Addr_m,
    .compare,	
    .Found,
    .NotFound,
    .New_UpAddr,
    .New_LowAddr);

	 // Instantiate binsearch_datapath module  	 
    binsearch_datapath #(8,5) m2 (
	 .clock, 
	 .reset,	
    .A_EQ_B,
    .A_GT_B,
    .A_LT_B,	
    .terminate,
    .Ld_A,
    .Ld_UpAddr,
    .Ld_LowAddr,
	 .get_Addr_sum, 
    .get_Addr_m,
    .compare,
    .Found,
    .NotFound,
    .New_UpAddr,
    .New_LowAddr,   
    .data_A,
    .data_B,
    .m,
	 .Addr_Found,
	 .Found2LEDR,
    .NotFound2LEDR);		

	 // Instantiate ram32x8 module  	
    ram32x8 m3 (.clock, .data(8'b0), .rdaddress(m), .wraddress(5'b0), 
	             .wren(1'b0), .q(data_B));				   

	 // Instantiate data7seg module to display addresses on HEX1 and HEX0. 
    data7seg m4 (.data({3'b000,Addr_Found[4]}), .seg(HEX1_mux));
    data7seg m5 (.data(Addr_Found[3:0]), .seg(HEX0_mux)); 	

	 // Selecting the proper signal to HEX1 and HEX0 depends on Found or NotFound. 	 
	 assign HEX1 = (Found && ~NotFound) ? HEX1_mux : 7'h3f;
	 assign HEX0 = (Found && ~NotFound) ? HEX0_mux : 7'h3f;	 
	
endmodule

/*====================================================================*/
//   Testbench for binsearch_top                                                
/*====================================================================*/
`timescale 1 ps / 1 ps
module binsearch_top_testbench();

    parameter BIT_WIDTH = 8;
	 parameter ADDR_WIDTH = 5;
	
	 logic clock, reset;
	 logic LA;
	 logic start;   
	 logic [BIT_WIDTH-1:0] data_A;
    logic Found2LEDR;
    logic NotFound2LEDR;
	 logic [6:0] HEX1;
	 logic [6:0] HEX0;
	 
	 // Instantiate binsearch_top module 
    binsearch_top #(BIT_WIDTH, ADDR_WIDTH) dut (.*);

	 
	 // Generate clock signal
    parameter CLK_Period = 100;

    initial begin
        clock <= 1'b0;
	     forever #(CLK_Period/2) clock <= ~clock;
    end
	
    // Test the design.
    initial begin 
        reset <= 1;
        repeat(1)     
        @(posedge clock);
        
		  reset <= 0;
		  data_A <= 8'b0000_1100;  // Prepare the 1st data to be sought.
		  repeat(1)     
        @(posedge clock);
        
		  start <= 0;
		  LA <= 1;       	   // Load the 1st data to be sought.	
        repeat(2) 
		  @(posedge clock);
        
		  LA <= 0;		
        @(posedge clock);
		  
		  start <= 1;
        repeat(50)     
        @(posedge clock);
		  
		  start <= 0;
        reset <= 1;
        repeat(6)     
        @(posedge clock);
        
		  reset <= 0;
		  data_A <= 8'b011_1110;  // Prepare the 2nd data to be sought.
        repeat(1)     
        @(posedge clock);
        
		  start <= 0;
		  LA <= 1;       		// Load the 2nd data to be sought.
        repeat(2) 
		  @(posedge clock);
        
		  LA <= 0;		
        @(posedge clock);
		
		  start <= 1;		
        repeat(50)     
        @(posedge clock);
		  
		  
		  start <= 0; 
		  reset <= 1;
        repeat(6)     
        @(posedge clock);
		  
        reset <= 0;
		  data_A <= 8'b0010_0110;  // Prepare the 3rd data to be sought.
        repeat(1)     
        @(posedge clock);
        
		  start <= 0;
		  LA <= 1;       		// Load the 3rd data to be sought.
        repeat(2) 
		  @(posedge clock);
        
		  LA <= 0;		
        @(posedge clock);
		
		  start <= 1;
        repeat(50)     
        @(posedge clock);
		  
		  start <= 0;
	     reset <= 1;
        repeat(6)     
        @(posedge clock);
		  
        reset <= 0;
		  data_A <= 8'b0000_1110;  // Prepare the 4th data to be sought.
        repeat(1)     
        @(posedge clock);
		  
        start <= 0;
		  LA <= 1;       		// Load the 4th data to be sought.
        repeat(2) 
		  @(posedge clock);
		 
        LA <= 0;		
        @(posedge clock);		  
		  
		  start <= 1;
        repeat(50)     
        @(posedge clock);
		  
		  start <= 0;		  
	     $stop;
    end

endmodule