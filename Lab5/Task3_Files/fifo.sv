/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing  (Task 3)
//  Device under Test (dut) --- fifo
//  File Name: fifo.sv
//  This is form Homework 3.                                                  
/*====================================================================*/ 
/* FIFO buffer FWFT implementation for specified data and address
 * bus widths based on internal register file and FIFO controller.
 * Inputs: 1-bit rd removes head of buffer and 1-bit wr writes
 * w_data to the tail of the buffer.
 * Outputs: 1-bit empty and full indicate the status of the buffer
 * and r_data holds the value of the head of the buffer (unless empty).
 */
module fifo #(parameter DATA_WIDTH=24, ADDR_WIDTH=3)
            (clk, reset, rd, wr, empty, full, w_data, r_data);

	input  logic clk, reset, rd, wr;
	output logic empty, full;
	input  logic [DATA_WIDTH-1:0] w_data;
	output logic [DATA_WIDTH-1:0] r_data;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic w_en;
	
	// enable write only when FIFO is not full
	// or if reading and writing simultaneously
	assign w_en = wr & (~full | rd);
	
	// instantiate FIFO controller and register file
	fifo_ctrl #(ADDR_WIDTH) c_unit (.*);
	reg_file #(DATA_WIDTH, ADDR_WIDTH) r_unit (.*);
	
endmodule  // fifo

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/
module fifo_testbench();
	
parameter DATA_WIDTH = 24, ADDR_WIDTH = 3;
	
logic clk, reset, rd, wr, empty, full;
logic [DATA_WIDTH-1:0] w_data;
logic [DATA_WIDTH-1:0]r_data;
	
integer i;

fifo #(DATA_WIDTH, ADDR_WIDTH) dut (.*);
	
parameter CLK_Period = 100;
	
initial begin
    clk <= 1'b0;
	 forever #(CLK_Period/2) clk <= ~clk;
end
	
initial begin 
    reset <= 1;
       
    repeat(1)     
    @(posedge clk);
    
	 reset <= 0;
end
   
initial begin
        @(negedge clk);	
		
		  {rd, wr} <= 2'b01;
		  w_data <= 24'h9090ab;        
		  repeat(2**(ADDR_WIDTH-1))			 
		  @(negedge clk);	
		  
		  w_data <= 24'h9012cd;
		  repeat(2**(ADDR_WIDTH-1))			 
		  @(negedge clk);		  

          {rd, wr} <= 2'b00;         
		  repeat(2)			 
		  @(negedge clk);	            
	  
          {rd, wr} <= 2'b10;
		  repeat(2**(ADDR_WIDTH))				 
		  @(negedge clk);	   
		  
          {rd, wr} <= 2'b01;
		  w_data <= 24'h9034ef;
		  repeat(2**(ADDR_WIDTH-1))				 
		  @(negedge clk);	   

          {rd, wr} <= 2'b00;
		  repeat(2)					 
		  @(negedge clk);	            
  
          {rd, wr} <= 2'b10;
		  repeat(2**(ADDR_WIDTH-1))				 
		  @(negedge clk);	   
		  
          {rd, wr} <= 2'b01;
		  w_data <= 24'h9056ca;         
		  repeat(2**(ADDR_WIDTH-1))				 
		  @(negedge clk);	   
			  
          {rd, wr} <= 2'b10;
		  repeat(2**(ADDR_WIDTH-1))				 
		  @(negedge clk);

          {rd, wr} <= 2'b11;
		  w_data <= 24'h9078db; 
		  repeat(2**(ADDR_WIDTH))				 
		  @(negedge clk);         

          {rd, wr} <= 2'b10;
		  repeat(2**(ADDR_WIDTH)+3)				 
		  @(negedge clk);	 
    $stop;
end
	
endmodule 