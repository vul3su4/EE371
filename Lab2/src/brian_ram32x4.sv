/*====================================================================*/
//  Brian Chen
//  01/28/2025
//  LAB2 -- Memory Blocks (Task 1)
//  Device under Test (dut) --- brain_ram32x4                               
//  File Name: brian_ram32x4.sv                                            
/*====================================================================*/
module brian_ram32x4 (clock, reset, write, address, data_in, data_out);

input logic clock, reset, write;
input logic [3:0] data_in;
input logic [4:0] address;
output logic [3:0] data_out; 

logic [4:0] address_q;
logic [3:0] data_in_q;
logic write_q; 

logic [3:0] memory_array [31:0];

always_ff @  (posedge clock or posedge reset) 
    if (reset) begin
	     address_q <= 5'b0_0000;
		  data_in_q <= 4'b0000;
		  write_q   <= 1'b0;
	 end
    else begin
 	     address_q <= address;
		  data_in_q <= data_in;
		  write_q   <= write;   	 
    end

always_ff @ (posedge clock) // write operation performed @ posedge clock
    if (write_q)	
        memory_array [address_q] <= data_in_q; 	 
	 
assign data_out = memory_array[address_q]; 
	 
endmodule

/*====================================================================*/
//  Testbench                                        
/*====================================================================*/
module brian_ram32x4_testbench();

logic clock, reset, write;
logic [3:0] data_in;
logic [4:0] address;
logic [3:0] data_out; 

integer i;

brian_ram32x4 dut (.clock, .reset, .write, .address, .data_in, .data_out);

parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD/2) clock <= ~clock;
end

initial begin
    reset <= 1'b1;
	 
	 repeat(3)
	 @ (posedge clock);
	 reset <= 1'b0;
end

initial begin
    data_in <= 4'b1000;
	   write <= 1'b1;     // write operation
	 address <= 5'b0_0000;
	 
	 for (i = 0; i < 32; i = i + 1) begin
	     @(negedge clock)   // <---- update data_in @ negedge clock
		  if (data_in == 4'b1000)
		      data_in <= 4'b0001;
		  else
		      data_in <= (data_in << 1);
			
	     address <= address + 1;  // <-- update address @ negedge clock
	 end

    data_in <= 4'b1000;
	   write <= 1'b0;   // set this for read operation
	 address <= 5'b0_0000;
	 
	 for (i = 32; i < 65; i = i + 1) begin
	     @(negedge clock)		
	     address <= address + 1;
	 end
 
	 $stop;
end

endmodule