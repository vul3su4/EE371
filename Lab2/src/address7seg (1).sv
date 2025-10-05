/*====================================================================*/
// Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks 
//  Device under Test (dut) --- address7seg                                                  
//  File Name: address7seg.sv                                                  
/*====================================================================*/ 
module address7seg(address, seg1, seg0);

input logic [4:0] address;// 5-bit input for the address
output logic [6:0] seg1, seg0;// 7-bit output for 7-segment display encoding

parameter [6:0] Blank = 7'b111_1111;  // 7'h7f
parameter [6:0] Chr_0 = 7'b100_0000;  // 7'h40
parameter [6:0] Chr_1 = 7'b111_1001;  // 7'h79
parameter [6:0] Chr_2 = 7'b010_0100;  // 7'h24
parameter [6:0] Chr_3 = 7'b011_0000;  // 7'h30
parameter [6:0] Chr_4 = 7'b001_1001;  // 7'h19					
parameter [6:0] Chr_5 = 7'b001_0010;  // 7'h12
parameter [6:0] Chr_6 =	7'b000_0010;  // 7'h02
parameter [6:0] Chr_7 = 7'b101_1000;  // 7'h58
parameter [6:0] Chr_8 = 7'b000_0000;  // 7'h00
parameter [6:0] Chr_9 = 7'b001_0000;  // 7'h10
parameter [6:0] Chr_A = 7'b000_1000;  // 7'h08
parameter [6:0] Chr_b = 7'b000_0011;  // 7'h03
parameter [6:0] Chr_C = 7'b100_0110;  // 7'h46
parameter [6:0] Chr_d = 7'b010_0001;  // 7'h21
parameter [6:0] Chr_E = 7'b000_0110;  // 7'h06
parameter [6:0] Chr_F = 7'b000_1110;  // 7'h0e
  
  
    // Always block to assign the correct segment pattern based on the input data

always_comb begin
case(address)
     0:  {seg1, seg0} = {Chr_0, Chr_0};
     1:  {seg1, seg0} = {Chr_0, Chr_1};
     2:  {seg1, seg0} = {Chr_0, Chr_2};
     3:  {seg1, seg0} = {Chr_0, Chr_3};
	
     4:  {seg1, seg0} = {Chr_0, Chr_4};
     5:  {seg1, seg0} = {Chr_0, Chr_5};
     6:  {seg1, seg0} = {Chr_0, Chr_6};
     7:  {seg1, seg0} = {Chr_0, Chr_7};
	
     8:  {seg1, seg0} = {Chr_0, Chr_8};
     9:  {seg1, seg0} = {Chr_0, Chr_9};
    10:  {seg1, seg0} = {Chr_0, Chr_A};
    11:  {seg1, seg0} = {Chr_0, Chr_b};
	
    12:  {seg1, seg0} = {Chr_0, Chr_C};
    13:  {seg1, seg0} = {Chr_0, Chr_d};
    14:  {seg1, seg0} = {Chr_0, Chr_E};
    15:  {seg1, seg0} = {Chr_0, Chr_F};

    16:  {seg1, seg0} = {Chr_1, Chr_0};
    17:  {seg1, seg0} = {Chr_1, Chr_1};
    18:  {seg1, seg0} = {Chr_1, Chr_2};
    19:  {seg1, seg0} = {Chr_1, Chr_3};
	
    20:  {seg1, seg0} = {Chr_1, Chr_4};
    21:  {seg1, seg0} = {Chr_1, Chr_5};
    22:  {seg1, seg0} = {Chr_1, Chr_6};
    23:  {seg1, seg0} = {Chr_1, Chr_7};
	
    24:  {seg1, seg0} = {Chr_1, Chr_8};
    25:  {seg1, seg0} = {Chr_1, Chr_9};
    26:  {seg1, seg0} = {Chr_1, Chr_A};
    27:  {seg1, seg0} = {Chr_1, Chr_b};
	
    28:  {seg1, seg0} = {Chr_1, Chr_C};
    29:  {seg1, seg0} = {Chr_1, Chr_d};
    30:  {seg1, seg0} = {Chr_1, Chr_E};
    31:  {seg1, seg0} = {Chr_1, Chr_F};	 
	default: {seg1, seg0} = {Blank, Blank};
endcase
end

endmodule


module address7seg_testbench();

    // Testbench signals
    logic [4:0] address;         // 5-bit input for the address (hexadecimal value)
    logic [6:0] seg1, seg0;      // 7-bit outputs for the two 7-segment encodings

    // Instantiate the address7seg module (DUT - Device Under Test)
    address7seg uut (
        .address(address),  // Connect the testbench 'address' to the DUT 'address'
        .seg1(seg1),        // Connect the testbench 'seg1' to the DUT 'seg1'
        .seg0(seg0)         // Connect the testbench 'seg0' to the DUT 'seg0'
    );

    // Stimulus generation (apply different test cases to 'address' and observe the result)
    initial begin
        // Display headers for the testbench output
        $display("Time\tAddress\tSeg1\t\tSeg0");

        // Test cases for all address values (0 to 31)
        // Apply each value of address (0 to 31) and monitor the seg1 and seg0 outputs
        for (int i = 0; i < 32; i++) begin
            address = i;             // Assign value to 'address'
            #10;                     // Wait for 10 time units to simulate behavior
            $display("%0t\t%0d\t\t%b\t%b", $time, address, seg1, seg0);  // Display the time, address, seg1, and seg0
        end

        // End the simulation
        $finish;
    end

endmodule

