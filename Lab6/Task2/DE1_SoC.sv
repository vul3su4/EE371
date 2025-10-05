/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- DE1_SoC
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, V_GPIO);

	// define ports
	input  logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input  logic [3:0] KEY;
	input  logic [9:0] SW;
	output logic [9:0] LEDR;
	inout  logic [35:23] V_GPIO;

	
    // Initialize HEX
/*	 
    assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
*/
	
/*
	// FPGA output
	assign V_GPIO[26] = SW[0];	// LED parking 1
	assign V_GPIO[27] = SW[1];	// LED parking 2
	assign V_GPIO[32] = SW[2];	// LED parking 3
	assign V_GPIO[34] = SW[3];	// LED full
	assign V_GPIO[31] = SW[4];	// Open entrance
	assign V_GPIO[33] = SW[5];	// Open exit
*/

	// FPGA input
	assign LEDR[0] = V_GPIO[28];	// Presence parking 1: Felt by senor
	assign LEDR[1] = V_GPIO[29];	// Presence parking 2: Felt by senor
	assign LEDR[2] = V_GPIO[30];	// Presence parking 3: Felt by senor	
	assign LEDR[3] = V_GPIO[23];	// Presence entrance : Felt by senor
	assign LEDR[4] = V_GPIO[24];	// Presence exit     : Felt by senor
	
	// My connections
	assign V_GPIO[26] = V_GPIO[28];	// LED parking 1
	assign V_GPIO[27] = V_GPIO[29];	// LED parking 2
	assign V_GPIO[32] = V_GPIO[30];	// LED parking 3	
	assign V_GPIO[34] = V_GPIO[28] & V_GPIO[29] & V_GPIO[30];	// LED full
	
//	assign V_GPIO[31] = V_GPIO[23];	// Presence entrance and Open entrance
//	assign V_GPIO[33] = V_GPIO[24];	// Presence exit and Open exit	
	logic hold, hold2;
	
	
	top_ctrl_datapath top (
       .clock(CLOCK_50), 
       .reset(SW[9]),
       .start(SW[8]), 
		 .KEY0(KEY[0]), 
		 .Car_in(V_GPIO[23]), 
		 .Car_out(V_GPIO[24]),
       .Entrance(hold),   //<----- 
       .Exit(V_GPIO[33]),	
       .HEX5, 
		 .HEX4, 
		 .HEX3, 
		 .HEX2, 
		 .HEX1, 
		 .HEX0);
		 
	////
		
	signal_extender top_ext(.in(hold), .out(hold2), .reset(SW[9]), .clk(CLOCK_50));	
	assign V_GPIO[31] = hold2;
/*LAB1b codes	
	
    logic hold, hold2;

    top_cell top (.CLK(CLOCK_50), .RST(SW[9]), .Prs(~KEY), 
	              .Car_in(V_GPIO[23]), .Car_out(V_GPIO[24]), 
				  .Entrance(hold), .Exit(V_GPIO[33]), 
	              .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
    signal_extender top_ext(.in(hold), .out(hold2), .reset(SW[9]), .clk(CLOCK_50));	
*/	
		
/*  LAB1b codes
    assign V_GPIO[31] = hold2;
    assign V_GPIO[26] = V_GPIO[28];  // specify the color of LED1.
    assign V_GPIO[27] = V_GPIO[29];  // specify the color of LED2.
    assign V_GPIO[32] = V_GPIO[30];  // specify the color of LED3.
*/

endmodule  // DE1_SoC

/*================================================================*/
//  Testbench                                                                       
/*================================================================*/ 
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
    logic CLOCK_50;
	 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [3:0] KEY;
	 logic [9:0] SW;
	 logic [9:0] LEDR;
	 wire [35:23] V_GPIO;
	
	 logic Car_in, Car_out;
	 logic KEY0, clock, reset, start;

    // Set up a simulated clock: 50 MHz
	
    integer i, j, k;

    DE1_SoC dut (.*);
	
	 assign V_GPIO[23] = Car_in;
    assign V_GPIO[24] = Car_out;
	 assign KEY[0] = KEY0;
	 assign SW[9] = reset;
	 assign SW[8] = start;
	 assign CLOCK_50 = clock;
	 assign CLK = CLOCK_50;	 
  
    parameter CLK_Period = 100;

    initial begin
        clock <= 1'b0;
	    forever #(CLK_Period/2) clock <= ~clock;
    end
	 
	 initial begin
	     for (i = 0; i < 100; i++) begin
		      KEY0 <= 1;
				repeat(15)
				@(posedge clock);
				
				KEY0 <= 0;
				repeat(1)
				@(posedge clock);				
		  end
	 end
	 
	 initial begin 
        reset <= 1;
       
        repeat(2)     
        @(posedge clock);
        reset <= 0;	  
	 end
	 
	 
	 initial begin
	     for (j = 0; j < 30; j++) begin
		      start <= 0;
				repeat(5)
				@(posedge clock);
				
				start <= 1;
		      repeat(300)             
		      @(posedge CLK);			
		  end
	 end
	 
	 initial begin
	     for (k = 0; k < 12; k++) begin
            repeat(7)             
		      @(posedge CLK);	         
				{Car_in, Car_out} = 2'b10;		
		
            repeat(6)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;	
		
		      repeat(2)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b10;		
		
            repeat(7)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;			
								
				repeat(2)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b10;		
					 
				repeat(9)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;			
								
		      repeat(2)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b10;	
		
            repeat(6)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;	
					 
				repeat(5)                       
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b01;	

            repeat(5)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;		
			
	         repeat(3)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b01;	

            repeat(7)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;	
			
	         repeat(3)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b01;							 
					 
            repeat(2)             
		      @(posedge CLK);
	         {Car_in, Car_out} = 2'b00;						 
				repeat(50)
				@(posedge clock);				
		  end
		  $stop;
	 end

endmodule // DE1_SoC_testbench
