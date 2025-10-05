/*====================================================================*/
//Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks (Task 3)
//  Device under Test (dut) --- DE1_SoC                               
//  File Name: DE1_SoC.sv                                            
/*====================================================================*/ 
module DE1_SoC (CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);

input logic CLOCK_50;
input logic [9:0] SW;
input logic [3:0] KEY;
output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
output logic [9:0] LEDR;
logic [7:0] outputBus;
logic r_eff, w_eff;

assign LEDR[7:0] = 8'b0000_0000;
//assign HEX3 = 7'h7f;
//assign HEX2 = 7'h7f;

// Generate clk off of CLOCK_50, whichClock picks rate.
logic [31:0] div_clk;

parameter whichClock = 25; // 0.75 Hz clock  (50 MHz / 2^26 = 0.745 Hz)   
/*====================================================================*/
//     clock_divider (File Name: clock_divider.sv)
/*====================================================================*/    
    clock_divider cdiv (.clock(CLOCK_50), .reset(SW[9]), .divided_clocks(div_clk));
/*--------------------------------------------------------------------*/
//     Clock selection; 
//     allows for easy switching between simulation and board clocks
/*--------------------------------------------------------------------*/
logic clkSelect;    
    
    //Uncomment ONE of the following two lines depending on intention
//***************************************************************
    assign clkSelect = CLOCK_50;           // for simulation
    //assign clkSelect = div_clk[whichClock]; // for DE1_SoC  board
//***************************************************************
logic [3:0] wrAddr, rdAddr;


// Instantiate RAM module
FIFO #(4, 8)      m1 (.clk(clkSelect), .reset(SW[9]), .read(r_eff), .write(w_eff), 
                      .inputBus(SW[7:0]), .empty(LEDR[8]), .full(LEDR[9]), .outputBus, 
							 .wrAddr, .rdAddr // monitor write/read address
							 );
					  
data7seg          m2 (.data(SW[7:4]), .seg(HEX5));
data7seg          m3 (.data(SW[3:0]), .seg(HEX4));

data7seg          m4 (.data(outputBus[7:4]), .seg(HEX1));
data7seg          m5 (.data(outputBus[3:0]), .seg(HEX0));

userInput         m6 (.clk(clkSelect), .rst(SW[9]), .Qin(~KEY[3]), .Qeff(w_eff));
userInput         m7 (.clk(clkSelect), .rst(SW[9]), .Qin(~KEY[0]), .Qeff(r_eff));


// display wrAddr and rdAddr

data7seg          m8 (.data(wrAddr), .seg(HEX3));  // monitor write address
data7seg          m9 (.data(rdAddr), .seg(HEX2));  // monitor read address

endmodule

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/
`timescale 1ps/ 1ps
module DE1_SoC_testbench();

logic CLOCK_50;
logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
logic [3:0] KEY;
logic [9:0] SW;
logic [9:0] LEDR;
	
integer i;

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
    repeat(1) 
	@(posedge CLOCK_50);
	 SW[9] <= 1; 
    repeat(2)		
	@(posedge CLOCK_50);
	 SW[9] <= 0;  		
end
	
initial begin
    for (i = 0; i < 20; i++) begin	
	     @(negedge CLOCK_50);		  
        {KEY[0], KEY[3]} <= 2'b10;
        
		  repeat(3)			 
		  @(negedge CLOCK_50);	

        {KEY[0], KEY[3]} <= 2'b11;
         
		  repeat(2)			 
		  @(negedge CLOCK_50);	            
    end  

    for (i = 23; i < 26; i++) begin	
	     @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b01;
        
		  repeat(3)			 
		  @(negedge CLOCK_50);	   
    end  
       
    for (i = 26; i < 29; i++) begin	
		  @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b10;
         
		  repeat(3)			 
		  @(negedge CLOCK_50);	   
    end
       
    for (i = 29; i < 32; i++) begin	
		  @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b10;
        
		  repeat(3)			 
		  @(negedge CLOCK_50);	

        {KEY[0], KEY[3]} <= 2'b11;
         
		  repeat(2)			 
		  @(negedge CLOCK_50);	            
    end  

    for (i = 32; i < 55; i++) begin	
	     @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b01;
         
		  repeat(3)			 
		  @(negedge CLOCK_50);	   
    end  
       
    for (i = 55; i < 78; i++) begin	
		  @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b10;
         
		  repeat(6)			 
		  @(negedge CLOCK_50);	   
    end
	 
    for (i = 78; i < 100; i++) begin	
		  @(negedge CLOCK_50);		  
		  {KEY[0], KEY[3]} <= 2'b01;
        
		  repeat(3)			 
		  @(negedge CLOCK_50);

        {KEY[0], KEY[3]} <= 2'b11;  
		   
		  @(negedge CLOCK_50);          
    end        
	        
	 $stop; // End the simulation.
end
		
endmodule