/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing (Task 3)
//  File Name: part1.v                                                  
/*====================================================================*/ 
module part1 #(parameter DATA_WIDTH=24, ADDR_WIDTH=3) 
            (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT, 
				  SW); //<--Add SW[8] to select filtered or unfiltered.

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	input [8:8] SW; //<--Add SW[8] to select filtered or unfiltered.
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
	wire [23:0] readdata_left_FIR, readdata_right_FIR;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
	// Instantiate FIR Filter for part1 (left-hand source).				  
   fir_filter #(DATA_WIDTH, ADDR_WIDTH) p3
             (.clk(CLOCK_50), 
				  .reset(~KEY[0]), 
				  .wr(1'b1), 
				  .data_in(readdata_left), 
				  .data_out(readdata_left_FIR)
				  );	   
	// Instantiate FIR Filter for part1 (right-hand source).					  
   fir_filter #(DATA_WIDTH, ADDR_WIDTH) p4
             (.clk(CLOCK_50), 
				  .reset(~KEY[0]), 
				  .wr(1'b1), 
				  .data_in(readdata_right), 
				  .data_out(readdata_right_FIR)
				  );	
				  
	// Send the data from mic to speakers.
	// Use SW[8] to select filtered or unfiltered.
	assign writedata_left  = SW[8] ? readdata_left_FIR  : readdata_left;
	assign writedata_right = SW[8] ? readdata_right_FIR : readdata_right;
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


