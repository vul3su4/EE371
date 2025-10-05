/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing (Task 2)
//  Device Under Test (dut) -- clock_divider
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
