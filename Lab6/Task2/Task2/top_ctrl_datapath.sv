/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- top_ctrl_datapath
//  File Name: top_ctrl_datapath.sv                                                  
/*====================================================================*/ 
module top_ctrl_datapath (
	 input logic clock, 
	 input logic reset,
    input logic start, 	
	 input logic KEY0,
	 input logic Car_in,
	 input logic Car_out,
    output logic Entrance, 
	 output logic Exit,	
    output logic [6:0] HEX5,
	 output logic [6:0] HEX4,
    output logic [6:0] HEX3,
    output logic [6:0] HEX2,
    output logic [6:0] HEX1,
    output logic [6:0] HEX0);
	 
	 logic full, empty, hour_7, hour_inc, wr, RH_start, RH_end, RH_flag,	show, clear_reg;		  
       
    parkinglot_ctrl ctrl (
	     .clock, 
		  .reset, 
		  .start, 
		  .KEY0, 
	     .full, 
		  .empty, 
		  .hour_7,	
		  .hour_inc, 
		  .wr, 
		  .RH_start, 
		  .RH_end, 
		  .RH_flag,	
		  .show,
		  .clear_reg);
	
    top_datapath datapath (
        .clock, 
        .reset,
		  .clear_reg,
        .Car_in,
        .Car_out,
        .hour_inc,
        .wr,
        .RH_start,
        .RH_end,	
        .RH_flag,
        .show,
        .Entrance, 
        .Exit,	
        .full,
        .empty,
        .hour_7,
        .HEX5,
        .HEX4,
        .HEX3,
        .HEX2,
        .HEX1,
        .HEX0);	
 
endmodule
/*====================================================================*/
//   Testbench for binsearch_top                                                
/*====================================================================*/
`timescale 1 ps / 1 ps
module top_ctrl_datapath_testbench();

	 logic clock, CLK; 
	 logic reset;
    logic start; 	
	 logic KEY0;
	 logic Car_in;
	 logic Car_out;
    logic Entrance; 
	 logic Exit;	
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	 
	 assign CLK = clock;
	
	 integer i, j, k;

    top_ctrl_datapath dut (.*);

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

endmodule