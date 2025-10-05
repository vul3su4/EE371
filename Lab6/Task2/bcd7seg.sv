/*====================================================================*/
//  LAB1b -- 
//  Device under Test (dut)                                                   
//  File Name: bcd7seg.sv                                                   
/*====================================================================*/
module bcd7seg(bcd, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
input logic [1:0] bcd;
output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

parameter [6:0] Blank = 7'b111_1111; // 7'h7f
parameter [6:0] A = 7'b000_1000; // 7'h08
parameter [6:0] C = 7'b100_0110; // 7'h46
parameter [6:0] E = 7'b000_0110; // 7'h06
parameter [6:0] F = 7'b000_1110; // 7'h0e
parameter [6:0] L = 7'b100_0111; // 7'h47
parameter [6:0] r = 7'b000_1111; // 7'h0f
parameter [6:0] U = 7'b100_0001; // 7'h41
parameter [6:0] Chr_0 = 7'b100_0000;  // 7'h40
parameter [6:0] Chr_1 = 7'b111_1001;  // 7'h79
parameter [6:0] Chr_2 = 7'b010_0100;  // 7'h24
parameter [6:0] Chr_3 = 7'b011_0000;  // 7'h30
  
always_comb begin
case(bcd)
    3'b000:  {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {C, L, E, A, r, Chr_0};
    3'b001:  {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {Blank, Blank, Blank, Blank, Blank, Chr_1};
    3'b010:  {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {Blank, Blank, Blank, Blank, Blank, Chr_2};
    3'b011:  {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {F, U, L, L, Blank, Chr_3};
	default: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {Blank, Blank, Blank, Blank, Blank, Blank};
endcase
end

endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 

module bcd7seg_testbench();
    
	logic [1:0] bcd;
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	integer i;

    bcd7seg dut (.bcd, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0); 
	
	initial begin 
        for (i = 0; i < 4; i++) begin
		    bcd = i;
			#10;
        end		
		$stop;
    end
endmodule