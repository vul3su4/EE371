/*================================================================*/
//  EE/CSE371--LAB1b --Parking Lot 3D Simulation 
//  Device under Test (dut)---DE1_SoC
//  File Name: DE1_SoC.sv 
/*================================================================*/ 
module DE1_SoC (HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, KEY, SW, LEDR, V_GPIO, CLOCK_50);
// define ports
    output logic [6:0]  HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output logic [9:0]  LEDR;
    input  logic [3:1]  KEY;
    input  logic [9:0]  SW;
    input logic CLOCK_50;
	inout logic [35:23] V_GPIO;
	logic hold, hold2;

    top_cell top (.CLK(CLOCK_50), .RST(SW[9]), .Prs(~KEY), 
	              .Car_in(V_GPIO[23]), .Car_out(V_GPIO[24]), 
				  .Entrance(hold), .Exit(V_GPIO[33]), 
	              .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
    signal_extender top_ext(.in(hold), .out(hold2), .reset(SW[9]), .clk(CLOCK_50));	

assign V_GPIO[31] = hold2;
assign V_GPIO[26] = V_GPIO[28];  // specify the color of LED1.
assign V_GPIO[27] = V_GPIO[29];  // specify the color of LED2.
assign V_GPIO[32] = V_GPIO[30];  // specify the color of LED3.

// specify the color (0:green / 1:red) of the full indicaror LED.
assign V_GPIO[34] = V_GPIO[28] & V_GPIO[29] & V_GPIO[30];

endmodule // DE1_SoC

/*================================================================*/
//  Testbench                                                                       
/*================================================================*/ 
module DE1_SoC_testbench();
    logic [6:0]  HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    logic [9:0]  LEDR;
    logic [3:1]  KEY;
    logic [9:0]  SW;
    logic CLOCK_50;
    wire [35:23] V_GPIO;
	
	logic arrival, departure;

    // Set up a simulated clock: 50 MHz
    parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        CLOCK_50 <= 0;
        forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
    end		
	
    integer i;

    DE1_SoC dut (.HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0, .KEY, .SW, .LEDR, .V_GPIO, .CLOCK_50);
	
	assign V_GPIO[23] = arrival;
    assign V_GPIO[24] = departure;	
  
    initial begin 
	    SW[9] <= 1;
        repeat(3)             
		@(posedge CLOCK_50);
	    SW[9] <= 0;	

        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b011;

        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b111;
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b111;
		
        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b011;
		
        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b011;
	
        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b011;	

		
        repeat(2)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b10;		
		
        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b101;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b110;

        repeat(5)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b011;			

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b01;	

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b01;	
	
        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b00;		

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b01;				

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b00;	

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b01;				

        repeat(5)             
		@(posedge CLOCK_50);
	    {arrival, departure} = 2'b00;	
		
        repeat(10)             
		@(posedge CLOCK_50);
	    KEY[3:1] = 3'b111;

		$stop;
   end

endmodule // DE1_SoC_testbench