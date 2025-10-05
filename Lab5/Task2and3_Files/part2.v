/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing (Task 2)
//  File Name: part2.v                                                  
/*====================================================================*/ 
module part2 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

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
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
      wire [31:0] div_clk;
      parameter whichClock = 9; // 48.8 kHz clock  (50 MHz / 2^10 = 48.8 kHz)   
   /*====================================================================*/
   //     clock_divider (File Name: clock_divider.sv)
   /*====================================================================*/    
      clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
   /*--------------------------------------------------------------------*/
   //     Clock selection; 
   //     allows for easy switching between simulation and board clocks
   /*--------------------------------------------------------------------*/
      wire clkSelect;      
   //Uncomment ONE of the following two lines depending on intention
   //***************************************************************
     // assign clkSelect = CLOCK_50;           // for simulation
     assign clkSelect = div_clk[whichClock];  // for DE1_SoC  board
   //***************************************************************	
	wire [23:0] readdata;
	wire [15:0] address;
	
	// Instantiate rom_lab5.
	rom_lab5 m1     (.address(address), .clock(clkSelect), .q(readdata));
	
	// Instantiate counter to generate the addresses for memory read operations.	
   counter  m2     (.clock(clkSelect), .reset(reset), .count(address));

	// Send the data read from rom_lab5 to speakers.
	assign writedata_left = readdata;
	assign writedata_right = readdata;
	assign read = read_ready ? 1 : 0;
	assign write = write_ready ? 1 : 0;
	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule

/*====================================================================*/
//  Testbench------------------ part2_testbench                                                                                                  
/*====================================================================*/
`timescale 1 ps / 1 ps
module part2_testbench();

	reg CLOCK_50, CLOCK2_50;
	reg [0:0] KEY;
	// I2C Audio/Video config interface
	wire FPGA_I2C_SCLK;
	wire FPGA_I2C_SDAT;
	// Audio CODEC
	wire AUD_XCK;
	wire AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	wire AUD_ADCDAT;
	wire AUD_DACDAT;

   part2 dut (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

// Set up a simulated clock: 50 MHz
parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
end

// Test the design.
initial begin
   KEY[0] <= 0;
	@(posedge CLOCK_50);
   KEY[0] <= 1;	
	
    repeat(100000) 
	@(posedge CLOCK_50);
	 $stop; // End the simulation.
end
		
endmodule