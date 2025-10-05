/*====================================================================*/
//  Brian Chen
//  01/28/2025
//  LAB2 -- Memory Blocks (Task 1)
//  Device under Test (dut) --- DE1_SoC                                                  
//  File Name: DE1_SoC.sv                                                  
/*====================================================================*/ 
module DE1_SoC (SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

input logic [9:0] SW;
input logic [3:0] KEY;
output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
logic [3:0] data_out;

assign HEX1 = 7'h7f;
assign HEX3 = 7'h7f;

 // Instantiate RAM module
brian_ram32x4 m1       (.clock(~KEY[0]), 
                        .reset(~KEY[3]), 
                        .write(SW[9]), 
								.address(SW[8:4]), 
								.data_in(SW[3:0]), 
								.data_out);

data7seg      m2_data_out (.data(data_out),.seg(HEX0));								
data7seg      m3_data_in  (.data(SW[3:0]), .seg(HEX2));

data7seg      m4_addrH    (.data(SW[8]),   .seg(HEX5));
data7seg      m5_addrL    (.data(SW[7:4]), .seg(HEX4));

endmodule

/*====================================================================*/
/*====================================================================*/
//  Testbench------------------ DE1_SoC_testbench                                                                                                  
/*====================================================================*/
module DE1_SoC_testbench();

logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
logic [3:0] KEY;
logic [9:0] SW;
	
integer i;

DE1_SoC dut (.SW, .KEY, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
	
parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns

initial begin
    KEY[0] <= 0;
    forever #(CLOCK_PERIOD/2) KEY[0] <= ~KEY[0];
end
	
	
initial begin
    KEY[3] <= 1'b0;
	 #20
    KEY[3] <= 1'b1;	 
end

initial begin
    SW[3:0] <= 4'b1000;
	   SW[9] <= 1'b1;     // write operation
	 SW[8:4] <= 5'b0_0000;
	 
	 for (i = 0; i < 32; i = i + 1) begin
	     @(negedge KEY[0])   // <---- update data_in @ negedge clock
		  if (SW[3:0] == 4'b1000)
		      SW[3:0] <= 4'b0001;
		  else
		      SW[3:0] <= (SW[3:0] << 1);
			
	     SW[8:4] <= SW[8:4] + 1;  // <-- update address @ negedge clock
	 end

    SW[3:0] <= 4'b1000;
	   SW[9] <= 1'b0;     // read operation
	 SW[8:4] <= 5'b0_0000;
	 
	 for (i = 32; i < 80; i = i + 1) begin
	     @(negedge KEY[0]) 		
	     SW[8:4] <= SW[8:4] + 1;
	 end
 
	 $stop;
end
		
endmodule