/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing (Task 2)
//  Device Under Test (dut) -- counter
//  File Name: counter.sv                                                  
/*====================================================================*/ 
module counter (clock, reset, count);
parameter N = 17;

input logic clock, reset;
output logic [N-1:0] count;

always_ff @(posedge clock or posedge reset) begin
    if (reset)
	     count <= 0;
    else
        count <= count + 1;
    end
	 
endmodule
/*====================================================================*/
//   Testbench                                                 
/*====================================================================*/
module counter_testbench();

parameter N = 17;
logic clk, rst;
logic [N-1:0] count;

counter dut (.clock(clk), .reset(rst), .count);

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
    repeat(60000)     
    @(posedge clk);
	 
	 $stop;
end

endmodule