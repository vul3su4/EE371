/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware (Task 1)
//  Device under Test (dut) --- clock_divider
//  File Name: clock_divider.sv                                                  
/*====================================================================*/ 
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, reset, divided_clocks);

    input logic reset, clock;
    output logic [31:0] divided_clocks = 0;

    always_ff @(posedge clock) begin
        divided_clocks <= divided_clocks + 1;
    end

endmodule

/*====================================================================*/
//   Testbench                                                 
/*====================================================================*/
module clock_divider_testbench();

    logic clk, reset;
    logic [31:0] divided_clocks;

    // instance
    clock_divider dut (.clock(clk), .reset, .divided_clocks);

    parameter CLK_Period = 100;  // set clock period  

    // generate clock signal
    initial begin
        clk <= 1'b0;
	     forever #(CLK_Period/2) clk <= ~clk;
    end

    // reset and test this module	
    initial begin 
    reset <= 1;
       
    repeat(3)     
    @(posedge clk);
    reset <= 0;
	 
	 repeat(10000)     
    @(posedge clk); 
	 
	 $stop;	 
end

endmodule