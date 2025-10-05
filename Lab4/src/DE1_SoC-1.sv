/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware  (Task 1)
//  Device under Test (dut) --- DE1_SoC
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);

    input logic CLOCK_50;
    input logic [9:0] SW;
    input logic [3:0] KEY;
    output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output logic [9:0] LEDR;
    logic [3:0] B;
    
	 // Turn OFF LEDR[8]~LEDR9.
    assign LEDR[8:0] = 9'b0_0000_0000;
	 
	 // Set HEX5~HEX1 to display "BLANK".
    assign HEX5 = 7'h7f;
    assign HEX4 = 7'h7f;
    assign HEX3 = 7'h7f;
    assign HEX2 = 7'h7f;
    assign HEX1 = 7'h7f;
	 
	 
	 /*=================================================================*/
    //     clock_divider (File Name: clock_divider.sv)
    /*=================================================================*/  
     logic [31:0] div_clk;
     parameter whichClock = 6; // 0.75 Hz clock  (50 MHz / 2^26 = 0.75 Hz)   
 
     clock_divider cdiv (.clock(CLOCK_50), .reset(~KEY[0]), .divided_clocks(div_clk));
    /*---------------------------------------------------------------*/
    //     Clock selection; 
    //     allows for easy switching between simulation and board clocks
    /*---------------------------------------------------------------*/
     logic clkSelect;    
    
    //Uncomment ONE of the following two lines depending on intention
    //***************************************************************
       //assign clkSelect = CLOCK_50;           // for simulation
         assign clkSelect = div_clk[whichClock]; // for DE1_SoC  board
    //***************************************************************	
    /*=================================================================*/ 	 

    // Instantiate bitcounting module
    bitcounting #(8, 4)  m1 
	        (.clk(clkSelect), 
			   .reset(~KEY[0]), 
	         .LA(SW[8]),      // SW[8]: load data to shift register
				.s(SW[9]),       // SW[9]: start to count bit 1.
				.data(SW[7:0]),  // SW[7:0]: data to be loaded
				.B(B),           // output of counter
				.Done(LEDR[9])); // to indicate if process is finished. 

    // Instantiate data7seg module					  
    data7seg m2 (.data(B), .seg(HEX0));

endmodule

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/
module DE1_SoC_testbench();

    logic CLOCK_50;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    logic [3:0] KEY;
    logic [9:0] SW;
    logic [9:0] LEDR;
    logic reset;
    logic [7:0] data;
    logic s;
    logic LA;
    logic clk;

    assign clk = CLOCK_50;
    assign KEY[0] = ~reset;
    assign SW[7:0] = data;
    assign SW[8] = LA;
    assign SW[9] = s;

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
        @(posedge clk);
		  
        reset <= 0;
		  data <= 8'b1010_1110;		
        repeat(200)     
        @(posedge clk);
		  
        s <= 0;
		  LA <= 1;       		
        repeat(500) 
		  @(posedge clk);
		  
        LA <= 0;		
        @(posedge clk);
		  
		  s <= 1;		
        repeat(1500)     
        @(posedge clk);
		
	     s <= 0;		
        repeat(300)     
        @(posedge clk);
	     $stop;
    end
		
endmodule 