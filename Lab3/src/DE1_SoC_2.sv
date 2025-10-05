/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-07-2025
//  EE/CSE371 LAB3-- Display Interface (Task2)
//  Device under Test (dut) --- DE1_SoC    
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	logic [9:0] x0, x1, x;
	logic [8:0] y0, y1, y;
	logic frame_start;
	logic pixel_color;
	
	
	logic [15:0] count;
	logic reset;      ///<--------Task2, for counter
	logic reset_line; ///<--------Task2, only for line_drawer
	
	assign reset = SW[9]; // do reset by sliding SW[9]
	
	
	    // Generate clk off of CLOCK_50, whichClock picks rate    .
   logic [31:0] div_clk;

   parameter whichClock = 16; // 2 for simulation, 16 for DE1_SoC board
/*====================================================================*/
//     clock_divider (File Name: clock_divider.sv)
/*====================================================================*/    
    clock_divider cdiv (.clock(CLOCK_50), .reset(SW[9]), .divided_clocks(div_clk));
/*--------------------------------------------------------------------*/
//     Clock selection; 
/*--------------------------------------------------------------------*/
   logic clkSelect;    
//***************************************************************
   assign clkSelect = div_clk[whichClock]; // for DE1_SoC  board
//***************************************************************
	
	
	//////// DOUBLE_FRAME_BUFFER ////////
	logic dfb_en;
	assign dfb_en = 1'b0; //****************
	/////////////////////////////////////
	
	VGA_framebuffer fb (.clk(CLOCK_50), .rst(1'b0), .x, .y,
				.pixel_color, .pixel_write(1'b1), .dfb_en, .frame_start,
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_N, .VGA_SYNC_N);
	
	// draw lines between (x0, y0) and (x1, y1)
	line_drawer lines (.clk(CLOCK_50),
	                   .reset(reset_line),  //////<---reset, only in Task 2
				          .x0, .y0, .x1, .y1, .x, .y);
	

	// counter for drawing lines cyclically 
	always_ff @(posedge clkSelect or posedge reset) begin
	    if (reset)
		     count <= 16'b0;
       else
	        count <= count + 1;	 
	end

   // specify different lines	
   always_latch begin
	    case (count)
           // draw 1st line		 
			  16'h0000: {reset_line, pixel_color} = 2'b10;	// reset line_drawer		  
		     16'h0010: begin
			                reset_line = 0;
                         x0 = 0;
                         y0 = 200;
                         x1 = 50;
                         y1 = 0; 
                         pixel_color = 1;	 // white	     
			            end
			  
			  // draw 2nd line			
			  16'h0190: {reset_line, pixel_color} = 2'b10;	// reset line_drawer		  
		     16'h0191: begin
			                reset_line = 0;						  
                         x0 = 50;
                         y0 = 0;
                         x1 = 120;
                         y1 = 194;
                         pixel_color = 1'b1; // white
			            end
							
							
           // draw 3rd line								
			  16'h0310: {reset_line, pixel_color} = 2'b10;	// reset line_drawer						  
		     16'h0312: begin
			                reset_line = 0;
                         x0 = 120;
                         y0 = 194;
                         x1 = 170;
                         y1 = 194;
                         pixel_color = 1'b1;	 // white		     
			            end
							
			  // draw 4th line								
			  16'h0490: {reset_line, pixel_color} = 2'b10;	// reset line_drawer				  
		     16'h0492: begin
			                reset_line = 0;			  
                         x0 = 170;
                         y0 = 194;
                         x1 = 220;
                         y1 = 9;
                         pixel_color = 1'b1;    // white
                     end
							
		     // draw 5th line	
			  16'h0610: {reset_line, pixel_color} = 2'b10;  // reset line_drawer
			  16'h0612: begin
			                reset_line = 0;			  
                         x0 = 220;
                         y0 = 0;
                         x1 = 250;
                         y1 = 194;
                         pixel_color = 1'b1;	   // white		     
			            end
							
           
			 				
			  // ******clear 3rd line	
			  16'h0790: {reset_line, pixel_color} = 2'b10; // reset line_drawer
		     16'h0792: begin
			                reset_line = 0;				  
                         x0 = 120;
                         y0 = 194;
                         x1 = 170;
                         y1 = 194;
                         pixel_color = 1'b0;	  // black					  
			            end
							
		     // ****** clear 1st line
		     16'h0910: {reset_line, pixel_color} = 2'b10;	// reset line_drawer		  
		     16'h0912: begin
			                reset_line = 0;
                         x0 = 0;
                         y0 = 200;
                         x1 = 50;
                         y1 = 0; 
                         pixel_color = 1'b0;		// black	     
			            end
		     
		     // ****** clear 2nd line
		     16'h0A90: {reset_line, pixel_color} = 2'b10; // reset line_drawer
		     16'h0A92: begin
			                reset_line = 0;						  
                         x0 = 50;
                         y0 = 0;
                         x1 = 120;
                         y1 = 194;
                         pixel_color = 1'b0;    // black	
			            end
			            
		     // ****** clear 4th line		    
		     16'h0C10: {reset_line, pixel_color} = 2'b10; // reset line_drawer
		     16'h0C12: begin
			                reset_line = 0;			  
                         x0 = 170;
                         y0 = 194;
                         x1 = 220;
                         y1 = 9;
                         pixel_color = 1'b0;     // black	
                     end
		    
			  // ****** clear 5th line
			  16'h0D90: {reset_line, pixel_color} = 2'b10; // reset line_drawer
			  16'h0D92: begin
			                reset_line = 0;			  
                         x0 = 220;
                         y0 = 0;
                         x1 = 250;
                         y1 = 194;
                         pixel_color = 1'b0;		  // black		     
			            end	

			  default:	;		  
		 endcase
	end	
	
endmodule

/*====================================================================*/
//  Testbench------------------ DE1_SoC_testbench                                                                                                  
/*====================================================================*/
module DE1_SoC_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	logic CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;

	// instant
    DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5,
                 .KEY, .LEDR, .SW, .CLOCK_50, 
	             .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, 
                 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

// Set up a simulated clock: 50 MHz
parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
end

// Test the design.
initial begin
    SW[9] <= 1;  // reset <= 1;
	 repeat(10) 
	 @(posedge CLOCK_50);
	 SW[9] <= 0;  // reset <= 0;
	 
    repeat(20000000) 
	@(posedge CLOCK_50);
	 $stop; // End the simulation.
end
		
endmodule
