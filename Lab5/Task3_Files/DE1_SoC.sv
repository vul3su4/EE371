/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing  (Task 3)
//  Device under Test (dut) --- DE1_SoC
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, 
                FPGA_I2C_SDAT, AUD_XCK, 
		          AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, 
				    AUD_ADCDAT, AUD_DACDAT, 
				    SW);  //<-- Add SW[9:8] as an input port.
				                                                       
    parameter DATA_WIDTH=24, ADDR_WIDTH=3;
	 
	 input CLOCK_50, CLOCK2_50;
	 input [0:0] KEY;
	 // I2C Audio/Video config interface
	 output FPGA_I2C_SCLK;
	 inout FPGA_I2C_SDAT;
    
	 // Audio CODEC
	 output AUD_XCK;
	 input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	 input AUD_ADCDAT;
	 output AUD_DACDAT;
	 input [9:8] SW;  //<-- Add SW[8:9] as input ports.
	
    // Delare the output ports of part1 with new names.    
	 logic FPGA_I2C_SCLK1, AUD_XCK1, AUD_DACDAT1, AUD_DACDAT1_FIR;
	 
    // Delare the output ports of part2 with new names. 				  
	 logic FPGA_I2C_SCLK2, AUD_XCK2, AUD_DACDAT2, AUD_DACDAT2_FIR;
	 
    // Use SW[9] to select the output signals to DE1_SoC.    
    assign   FPGA_I2C_SCLK = SW[9] ? FPGA_I2C_SCLK2 : FPGA_I2C_SCLK1; 
    assign   AUD_XCK       = SW[9] ? AUD_XCK2 : AUD_XCK1;  
    assign   AUD_DACDAT    = SW[9] ? AUD_DACDAT2 : AUD_DACDAT1;
	 


	 // Instantiate part1
    part1 #(DATA_WIDTH, ADDR_WIDTH) p1 (.CLOCK_50, 
	           .CLOCK2_50, 
				  .KEY, 
				  
				   // Rename FPGA_I2C_SCLK as FPGA_I2C_SCLK1
	           .FPGA_I2C_SCLK(FPGA_I2C_SCLK1), //<---This line.			  
				  .FPGA_I2C_SDAT, 
				  
				   // Rename AUD_XCK as AUD_XCK1.
				  .AUD_XCK(AUD_XCK1), //<---This line.				  
		        .AUD_DACLRCK, 
				  .AUD_ADCLRCK, 
				  .AUD_BCLK, 
				  .AUD_ADCDAT, 
				  
				  	// Rename AUD_DACDAT as AUD_DACDAT1.
				  .AUD_DACDAT(AUD_DACDAT1), //<---This line.
				  .SW(SW[8]) // <--Add SW[8] to select filtered or unfiltered.
				  );
				  
	
     // Instantiate part2	 			  
	  part2 #(DATA_WIDTH, ADDR_WIDTH) p2 (.CLOCK_50, 
	           .CLOCK2_50, 
				  .KEY, 
				  
				   // Rename FPGA_I2C_SCLK as FPGA_I2C_SCLK2.
	           .FPGA_I2C_SCLK(FPGA_I2C_SCLK2),  //<---This line.	
				  .FPGA_I2C_SDAT, 
				  
				   // Rename AUD_XCK as AUD_XCK2.
				  .AUD_XCK(AUD_XCK2), //<---This line.	
		        .AUD_DACLRCK, 
				  .AUD_ADCLRCK, 
				  .AUD_BCLK, 
				  .AUD_ADCDAT, 
				  
				  	// Rename AUD_DACDAT as AUD_DACDAT2.
				  .AUD_DACDAT(AUD_DACDAT2),  //<---This line.	
				  .SW(SW[8]) // <--Add SW[8] to select filtered or unfiltered.
				  );

endmodule
/*====================================================================*/
//  Testbench for DE1_SoC                                                           
/*====================================================================*/
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();

    logic CLOCK_50, CLOCK2_50, FPGA_I2C_SCLK, 
          AUD_XCK, AUD_DACLRCK, 
			 AUD_ADCLRCK, AUD_BCLK, 
			 AUD_ADCDAT, AUD_DACDAT;
	 wire FPGA_I2C_SDAT;
	 logic [9:8] SW;
	 logic [0:0] KEY;
	 
    // Instantiate DE1_SoC module
    DE1_SoC dut (.*);

    // Set up a simulated clock: 50 MHz
    parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

    initial begin
        CLOCK_50 <= 0;
        forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
    end

    // Test the design.
    initial begin 
        KEY[0] <= 0;
        repeat(1)     
        @(posedge CLOCK_50);
        
		  KEY[0] <= 1;
		  SW[9:8] = 2'b10;  
		  repeat(500)     
        @(posedge CLOCK_50);
        
		  SW[9:8] = 2'b11;  
		  repeat(500)     
        @(posedge CLOCK_50);		  
	     $stop;
    end
		
endmodule 