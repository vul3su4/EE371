/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware  (Task 2)
//  Device under Test (dut) --- DE1_SoC
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);

    input logic CLOCK_50;
    input logic [9:0] SW;
    input logic [3:0] KEY;
    output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output logic [9:0] LEDR;
    
	 // Turn OFF LEDR[7]~LEDR[0].
    assign LEDR[7:0] = 8'b0000_0000;
	 
	 // Set HEX5~HEX2 to display "BLANK".
    assign HEX5 = 7'h7f;
    assign HEX4 = 7'h7f;
    assign HEX3 = 7'h7f;
    assign HEX2 = 7'h7f;

    // Instantiate binsearch_top module	 
	 binsearch_top #(8, 5) m1 (
	 .clock (CLOCK_50), 
	 .reset (~KEY[0]),        
	 .LA (SW[8]), 
	 .start (SW[9]), 
	 .data_A (SW[7:0]), 
	 .Found2LEDR (LEDR[9]),         // Use LEDR[9] to indicate "Found".
	 .NotFound2LEDR (LEDR[8]),      // Use LEDR[8] to indicate "NotFound".
	 .HEX1 (HEX1),              // use HEX1, HEX0 to display the address.
	 .HEX0 (HEX0));

endmodule

/*====================================================================*/
//  Testbench for DE1_SoC                                                           
/*====================================================================*/
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();

    logic CLOCK_50;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    logic [3:0] KEY;
    logic [9:0] SW;
    logic [9:0] LEDR;
	
	 // Declare the following signal names for readability. 
    logic reset;
    logic [7:0] data_A;
    logic start;
    logic LA;
    logic clock;

    assign clock = CLOCK_50;
    assign KEY[0] = ~reset;
    assign SW[7:0] = data_A;
    assign SW[8] = LA;
    assign SW[9] = start;
	 
    // Instantiate DE1_SoC module
    DE1_SoC dut (.CLOCK_50, .SW, .KEY, 
                 .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0, .LEDR);

    // Set up a simulated clock: 50 MHz
    parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

    initial begin
        CLOCK_50 <= 0;
        forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
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