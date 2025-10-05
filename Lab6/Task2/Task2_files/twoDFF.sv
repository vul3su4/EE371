/*====================================================================*/
//  LAB6 -- Communicating Sequential Logic 
//  Device under Test (dut)---twoDFF                                                  
//  File Name: twoDFF.sv                                                  
/*====================================================================*/ 
module twoDFF (CLK, RST, D, Q);
input logic CLK, RST;
input logic D;
output logic Q;
logic Q1;  

    // DFFs
    always_ff @(posedge CLK or posedge RST) begin
        if (RST) begin
          Q  <= 0;
			Q1 <=0;
		end
        else begin
          Q  <= Q1;
			Q1 <= D;
	    end
    end

endmodule
