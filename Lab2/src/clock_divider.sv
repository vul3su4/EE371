/*====================================================================*/
// Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks 
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


module clock_divider_testbench();

    // Testbench signals
    logic reset;           // Reset signal for the DUT (Device Under Test)
    logic clock;           // Clock signal for the DUT
    logic [31:0] divided_clocks;  // Output signal from the DUT

    // Instantiate the clock_divider module (DUT)
    clock_divider uut (
        .clock(clock),               // Connect the testbench clock to DUT's clock
        .reset(reset),               // Connect the testbench reset to DUT's reset
        .divided_clocks(divided_clocks)  // Connect the DUT output to the testbench signal
    );

    // Clock generation (period = 10 time units for a frequency of 50MHz)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;  // Toggle clock every 5 time units to get a 50MHz clock
    end

    // Stimulus generation (reset and monitoring the divided clocks)
    initial begin
        // Initialize signals
        reset = 0;
        
        // Display headers for simulation output
        $display("Time\tReset\tDivided Clocks");

        // Reset the DUT
        #5 reset = 1;   // Assert reset
        #10 reset = 0;  // Deassert reset

        // Monitor the divided clocks for some time after reset is deasserted
        #5;
        $display("%0t\t%b\t%h", $time, reset, divided_clocks);  // Display reset and divided clocks
        
        // Let the clock run and observe the incrementing divided_clocks
        #50;
        $display("%0t\t%b\t%h", $time, reset, divided_clocks);  // Display the value after 50 time units
        
        #50;
        $display("%0t\t%b\t%h", $time, reset, divided_clocks);  // Display the value after another 50 time units

        // Test longer simulation time to see clock divider behavior
        #100;
        $display("%0t\t%b\t%h", $time, reset, divided_clocks);  // Display the value after 100 time units

        // End the simulation
        $finish;
    end

endmodule
