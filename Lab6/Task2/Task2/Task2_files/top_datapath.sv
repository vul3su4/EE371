/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- top_datapath
//  File Name: top_datapath.sv                                                  
/*====================================================================*/ 
module top_datapath (
	input logic clock, 
	input logic reset,
	input logic [3:1] Prs,
	input logic Car_in,
	input logic Car_out,
    input logic hour_inc,
	input logic wr,
	input logic RH_start,
    input logic RH_end,	
	input logic RH_flag,
	input logic show,
    output logic Entrance, 
	output logic Exit,
	output logic [1:0] count,	
	output logic full,
	output logic empty,
	output logic hour_7,
    output logic [6:0] HEX5,
	output logic [6:0] HEX4,
    output logic [6:0] HEX3,
    output logic [6:0] HEX2,
    output logic [6:0] HEX1,
    output logic [6:0] HEX0);
	
	logic [15:0] car_acc;

    passcode_all_counter passcode 
	    (.CLK(clock), .RST(reset), .Prs, .Car_in, .Car_out, .Entrance, .Exit, .count);
	parkinglot_datapath  parkinglot
	    (.clock, .reset, .hour_inc, .wr, .RH_start, .RH_end, .RH_flag, 
	     .show, .full, .empty, .hour_7, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
		 
	assign full  = (count == 2'b11) ? 1'b1 : 1'b0;
	assign empty = (count == 2'b00) ? 1'b1 : 1'b0;
	
	always_ff @ (posedge clock or posedge reset)
	    if (reset)
		    car_acc <= 16'b0;
		else 
            car_acc <= car_acc + Entrance;	
	
endmodule
/*====================================================================*/
//   Testbench for parkinglot_datapath                                                
/*====================================================================*/
`timescale 1 ps / 1 ps
module top_datapath_testbench();
	logic clock; 
	logic reset;
	logic [3:1] Prs;
	logic Car_in;
	logic Car_out;
    logic hour_inc;
	logic wr;
	logic RH_start;
    logic RH_end;	
	logic RH_flag;
	logic show;
    logic Entrance; 
	logic Exit;
	logic [1:0] count;	
	logic full;
	logic empty;
	logic hour_7;
    logic [6:0] HEX5;
	logic [6:0] HEX4;
    logic [6:0] HEX3;
    logic [6:0] HEX2;
    logic [6:0] HEX1;
    logic [6:0] HEX0;
	logic CLK, RST;
	
	integer i;

    top_datapath dut (.*);

    parameter CLK_Period = 100;

    initial begin
        clock <= 1'b0;
	    forever #(CLK_Period/2) clock <= ~clock;
    end
	
	assign CLK = clock;
    assign reset = RST;	
	
    initial begin 
        RST <= 1;
       
        repeat(1)     
        @(posedge clock);
        RST <= 0;
		
        repeat(1)     
        @(posedge clock);
		
		for (i = 0; i < 2**6; i++)
        begin
		    {show, hour_inc, wr, RH_start, RH_end, RH_flag} = i;
			repeat(2)     
            @(posedge clock);
		end	
		
        repeat(2)     
        @(posedge clock);

    end
	
	initial begin 
	    RST = 1;
        repeat(2)             
		@(posedge CLK);
	    RST = 0;	

        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;

        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
		        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	

		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	

		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;			

        repeat(5)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b01;	

        repeat(5)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b00;	
	
        repeat(5)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b01;	

        repeat(5)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b00;			

        repeat(5)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b01;	
		
        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;

        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
		        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	

		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	
		
		

		$stop;
    end
endmodule