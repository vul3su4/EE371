/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing  (Task 3)
//  Device under Test (dut) --- fifo_ctrl
//  File Name: fifo_ctrl.sv
//  This is form Homework 3.                                                  
/*====================================================================*/ 
/* FIFO controller to manage a register file as a circular queue.
 * Manipulates output read and write addresses based on 1-bit
 * read (rd) and write (wr) requests and current buffer status
 * signals empty and full.
 */
module fifo_ctrl #(parameter ADDR_WIDTH=3)
                 (clk, reset, rd, wr, empty, full, w_addr, r_addr);
	
	input  logic clk, reset, rd, wr;
	output logic empty, full;
	output logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] rd_ptr, rd_ptr_next;
	logic [ADDR_WIDTH-1:0] wr_ptr, wr_ptr_next;
	logic empty_next, full_next;
	
	// output assignments
	assign w_addr = wr_ptr;
	assign r_addr = rd_ptr;
	
	// fifo controller logic
	always_ff @(posedge clk) begin
		if (reset)
			begin
				wr_ptr <= 0;
				rd_ptr <= 0;
				full   <= 0;
				empty  <= 1;
			end
		else
			begin
				wr_ptr <= wr_ptr_next;
				rd_ptr <= rd_ptr_next;
				full   <= full_next;
				empty  <= empty_next;
			end
	end  // always_ff
	
	// next state logic
	always_comb begin
		// default to keeping the current values
		rd_ptr_next = rd_ptr;
		wr_ptr_next = wr_ptr;
		empty_next = empty;
		full_next = full;
		case ({rd, wr})
			2'b11:  // read and write
				begin
					rd_ptr_next = rd_ptr + 1'b1;
					wr_ptr_next = wr_ptr + 1'b1;
				end
			2'b10:  // read
				if (~empty)
					begin
						rd_ptr_next = rd_ptr + 1'b1;
						if (rd_ptr_next == wr_ptr)
							empty_next = 1;
						full_next = 0;
					end
			2'b01:  // write
				if (~full)
					begin
						wr_ptr_next = wr_ptr + 1'b1;
						empty_next = 0;
						if (wr_ptr_next == rd_ptr)
							full_next = 1;
					end
			2'b00: ; // no change
		endcase
	end  // always_comb
	
endmodule  // fifo_ctrl
