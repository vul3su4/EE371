module top_cell (CLK, RST, Prs, Car_in, Car_out, Entrance, Exit, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input logic CLK, RST;
	input logic [3:1] Prs;
	input logic Car_in, Car_out;
    output logic Entrance, Exit;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	logic [1:0] count;
	
    passcode_all_counter K1 (.CLK, .RST, .Prs, .Car_in, .Car_out, .Entrance, .Exit, .count);
    bcd7seg              K2 (.bcd(count), .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);    	
		
endmodule
/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 
module top_cell_testbench();
    
	logic CLK, RST, Car_in, Car_out, Entrance, Exit;
	logic [3:1] Prs;
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    top_cell dut (.CLK, .RST, .Prs, .Car_in, .Car_out, .Entrance, .Exit, 
	              .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
    
	parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        CLK <= 0;
        forever #(CLOCK_PERIOD/2) CLK <= ~CLK;
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
		
        repeat(10)             
		@(posedge CLK);
		Prs = 3'b000;

		$stop;
    end
endmodule