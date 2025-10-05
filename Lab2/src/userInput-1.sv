/*====================================================================*/
//Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks (Task 3)
//  Device under Test (dut) --- userInput                               
//  File Name: userInput.sv                                            
/*====================================================================*/
module userInput (clk, rst, Qin, Qeff);
input logic clk, rst;
input logic Qin; 
output logic Qeff; 

// State variables
    typedef enum logic [1:0] {
        start, s1, s2
    } state_t;
    state_t ps, ns;

    // Next State logic
always_comb begin
    ns = start; // Default to avoid latches
    case (ps)
        start: if (Qin == 1) ns = s1;
               else ns = start;

        s1:    if (Qin == 1) ns = s2;
               else ns = start;
			   
		  s2:    if (Qin == 1) ns = s2;
               else ns = start;
	     default: ns = start;
    endcase
end

    // Output logic
always_comb begin
    Qeff = 0;  // Default to avoid latches
    case (ps)
        start:   Qeff = 0;
           s1:   Qeff = 1;
           s2:   Qeff = 0;
        default: Qeff = 0;
    endcase
end

    // DFFs
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        ps <= start;
    else
        ps <= ns;
    end

endmodule



/*====================================================================*/
// Testbench for userInput module                                      
/*====================================================================*/
module userInput_testbench();

    // Declare signals
    logic clk, rst;              // Clock and reset signals
    logic Qin;                   // Input signal
    logic Qeff;                  // Output signal
    
    // Instantiate the Device Under Test (DUT)
    userInput dut (
        .clk(clk),   // Connect clock
        .rst(rst),   // Connect reset
        .Qin(Qin),   // Connect Qin input
        .Qeff(Qeff)  // Connect Qeff output
    );

    // Clock generation: Generate a clock signal with period 10 time units
    parameter CLK_PERIOD = 10;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;  // Toggle clock every half period
    end

    // Reset generation: Assert reset at the beginning, then de-assert it after 2 clock cycles
    initial begin
        rst = 1;               // Assert reset at the start
        #(CLK_PERIOD * 2);     // Wait for 2 clock cycles
        rst = 0;               // De-assert reset
    end

    // Test sequence: Stimulate the Qin input and observe the Qeff output
    initial begin
        // Initial state with reset, Qeff should be 0
        Qin = 0;               // Set Qin to 0
        #(CLK_PERIOD * 3);     // Wait for 3 clock cycles

        // Test 1: Transition from start -> s1 -> s2 -> start
        Qin = 1;               // Set Qin to 1, should transition to s1
        #(CLK_PERIOD);         // Wait 1 clock cycle
        Qin = 1;               // Qin still 1, should transition to s2
        #(CLK_PERIOD);         // Wait 1 clock cycle
        Qin = 0;               // Set Qin to 0, should transition to start
        #(CLK_PERIOD * 2);     // Wait for 2 clock cycles

        // Test 2: Transition back to s1 and stay in s2
        Qin = 1;               // Qin 1, should transition to s1
        #(CLK_PERIOD);         // Wait 1 clock cycle
        Qin = 1;               // Qin still 1, should transition to s2
        #(CLK_PERIOD * 2);     // Wait for 2 clock cycles

        // Test 3: Return to start state when Qin is 0
        Qin = 0;               // Set Qin to 0, should transition to start
        #(CLK_PERIOD);         // Wait 1 clock cycle

        // Stop the simulation after a few cycles
        $stop;                 // Stop simulation after the tests
    end

    // Monitor: Observe the signals during the simulation
    initial begin
        $monitor("Time = %0t | Qin = %b | Qeff = %b", $time, Qin, Qeff);
    end

endmodule
