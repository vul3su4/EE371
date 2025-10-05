/*====================================================================*/
// Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks 
//  Device under Test (dut)---                                                   
//  File Name: counter5b.sv                                                  
/*====================================================================*/ 
module counter5b (clock, reset, count);

input logic clock, reset;  //Input clock , reset signal

output logic [4:0] count; //5-bit counter output

 // Always block that triggers on the rising edge of the clock or reset

always_ff @(posedge clock or posedge reset) begin
    if (reset)
	     count <= 0; // If reset is active (high), set the counter to 0
    else
        count <= count + 1; // Otherwise, increment the counter on every clock cycle
    end
	 
endmodule
/*====================================================================*/
//   Testbench                                                 
/*====================================================================*/
module counter5b_testbench();

logic clk, rst;
logic [4:0] count;

 // Instantiate the counter5b module (Device Under Test - DUT)

counter5b dut (.clock(clk), .reset(rst), .count);

parameter CLK_Period = 100;

initial begin
    clk <= 1'b0;
	 forever #(CLK_Period/2) clk <= ~clk;
end
	
initial begin 
    rst <= 1;
       
    repeat(3)     
    @(posedge clk);
    rst <= 0;
end
	
initial begin 
    repeat(80)     
    @(posedge clk);
	 
	 $stop;
end

endmodule