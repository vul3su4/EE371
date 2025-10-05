/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- data7seg
//  File Name: data7seg.sv                                     
/*====================================================================*/ 
module data7seg(data, seg);

    input logic [3:0] data;
    output logic [6:0] seg;

    parameter [6:0] Blank = 7'b111_1111;  // 7'h7f
    parameter [6:0] Chr_0 = 7'b100_0000;  // 7'h40
    parameter [6:0] Chr_1 = 7'b111_1001;  // 7'h79  
    parameter [6:0] Chr_2 = 7'b010_0100;  // 7'h24
    parameter [6:0] Chr_3 = 7'b011_0000;  // 7'h30
    parameter [6:0] Chr_4 = 7'b001_1001;  // 7'h19					
    parameter [6:0] Chr_5 = 7'b001_0010;  // 7'h12
    parameter [6:0] Chr_6 = 7'b000_0010;  // 7'h02
    parameter [6:0] Chr_7 = 7'b101_1000;  // 7'h58
    parameter [6:0] Chr_8 = 7'b000_0000;  // 7'h00
    parameter [6:0] Chr_9 = 7'b001_0000;  // 7'h10
    parameter [6:0] Chr_A = 7'b000_1000;  // 7'h08
    parameter [6:0] Chr_b = 7'b000_0011;  // 7'h03
    parameter [6:0] Chr_C = 7'b100_0110;  // 7'h46
    parameter [6:0] Chr_d = 7'b010_0001;  // 7'h21
    parameter [6:0] Chr_E = 7'b000_0110;  // 7'h06
    parameter [6:0] Chr_F = 7'b000_1110;  // 7'h0e
  
    always_comb begin
        case(data)
            0:  seg = Chr_0;
            1:  seg = Chr_1;
	         2:  seg = Chr_2;
            3:  seg = Chr_3;
	
            4:  seg = Chr_4;
            5:  seg = Chr_5;
	         6:  seg = Chr_6;
            7:  seg = Chr_7;
	 
            8:  seg = Chr_8;
            9:  seg = Chr_9;
	        10:  seg = Chr_A;
           11:  seg = Chr_b;
	 
           12:  seg = Chr_C;
           13:  seg = Chr_d;
	        14:  seg = Chr_E;
           15:  seg = Chr_F;
	        default: seg = Blank;
       endcase
    end
endmodule