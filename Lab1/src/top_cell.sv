module top_cell (CLK, RST, Prs, Car_in, Car_out, Entrance, Exit, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input logic CLK, RST;
	input logic [3:1] Prs;
	input logic Car_in, Car_out;
   output logic Entrance, Exit;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	logic [1:0] count;
	 

    passcode_all_counter K1 (.CLK, .RST, .Prs, .Car_in, .Car_out, .Entrance, .Exit, .count);
	 
    bcd7seg              K2 (.bcd(count), .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);    	
		
endmodule