/*====================================================================*/
// Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks 
//  Device under Test (dut) --- DE1_SoC                                                  
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
`timescale 1ps/ 1ps

module DE1_SoC (CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

input logic CLOCK_50;
input logic [9:0] SW;
input logic [3:0] KEY;
output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
logic [4:0] rdaddress;
logic [3:0] q;

    // Generate clk off of CLOCK_50, whichClock picks rate.
logic rst;
logic [31:0] div_clk;
logic [1:0] result;

parameter whichClock = 25; // 0.75 Hz clock  (50 MHz / 2^26 = 0.745 Hz)   
/*====================================================================*/
//     clock_divider (File Name: clock_divider.sv)
/*====================================================================*/    
    clock_divider cdiv (.clock(CLOCK_50), .reset(~KEY[0]), .divided_clocks(div_clk));
/*--------------------------------------------------------------------*/
//     Clock selection; 
//     allows for easy switching between simulation and board clocks
/*--------------------------------------------------------------------*/
logic clkSelect;    
    
    //Uncomment ONE of the following two lines depending on intention
//***************************************************************
   //assign clkSelect = CLOCK_50;           // for simulation
   assign clkSelect = div_clk[whichClock]; // for DE1_SoC  board
//***************************************************************

 // Instantiate RAM module
ram32x4           m1 (.clock(clkSelect), .data(SW[3:0]), .rdaddress(rdaddress), 
                      .wraddress(SW[8:4]), .wren(~KEY[3]), .q);
counter5b         m2 (.clock(~clkSelect), .reset(~KEY[0]), .count(rdaddress));
address7seg       m3 (.address(rdaddress), .seg1(HEX3), .seg0(HEX2));
address7seg       m4 (.address(SW[8:4]), .seg1(HEX5), .seg0(HEX4));
data7seg          m5 (.data(SW[3:0]), .seg(HEX1));
data7seg          m6 (.data(q), .seg(HEX0));

endmodule

/*====================================================================*/
/*====================================================================*/
//  Testbench------------------ DE1_SoC_testbench                                                                                                  
/*====================================================================*/
module DE1_SoC_testbench();

logic CLOCK_50;
logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
logic [3:0] KEY;
logic [9:0] SW;
logic wren, reset;
	
integer i;

DE1_SoC dut (.CLOCK_50, .SW, .KEY, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
assign KEY[3] = ~wren;
assign KEY[0] = ~reset;	

// Set up a simulated clock: 50 MHz
parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
end

// Test the design.
initial begin
    repeat(1) 
	 @(posedge CLOCK_50);
	 reset <= 1;
    wren  <= 0;  
    repeat(2)		
	 @(posedge CLOCK_50);
	 reset <= 0;  		
end
	
initial begin
    repeat(35)		
	 @(posedge CLOCK_50);
		
	 wren <= 1;
		
	 for (i = 0; i < 8; i++) begin
	     @(negedge CLOCK_50);
        SW[8:4] <= i;
        SW[3:0] <= 4'b1111;
    end		

    for (i = 8; i < 16; i++) begin
		  @(negedge CLOCK_50);
        SW[8:4] <= i;
        SW[3:0] <= 4'b1010;
    end	

	 for (i = 16; i < 24; i++) begin
		  @(negedge CLOCK_50);
        SW[8:4] <= i;
        SW[3:0] <= 4'b0100;
    end		

	 for (i = 24; i < 32; i++) begin
		  @(negedge CLOCK_50);
        SW[8:4] <= i;
        SW[3:0] <= 4'b1001;
    end
		    
    @(negedge CLOCK_50);		
    wren  <= 0;     
		
	 repeat(35)
    @(posedge CLOCK_50);        		
        
	 $stop; // End the simulation.
end
		
endmodule