module passcode_all (CLK, RST, Prs, P2, P1);
    input logic CLK, RST;
	input logic [3:1] Prs;
    output logic P2, P1;	
	
	logic [3:1] QD, Peff;

    twoDFF     n3 (.CLK(CLK), .RST(RST), .D(Prs[3]), .Q(QD[3]));
	twoDFF     n2 (.CLK(CLK), .RST(RST), .D(Prs[2]), .Q(QD[2]));
    twoDFF     n1 (.CLK(CLK), .RST(RST), .D(Prs[1]), .Q(QD[1]));
    userInput nn3 (.CLK(CLK), .RST(RST), .Qin(QD[3]), .Qeff(Peff[3]));	
    userInput nn2 (.CLK(CLK), .RST(RST), .Qin(QD[2]), .Qeff(Peff[2]));	
    userInput nn1 (.CLK(CLK), .RST(RST), .Qin(QD[1]), .Qeff(Peff[1]));	
	
    passcode m4 (.CLK(CLK), .RST(RST), .B3(Peff[3]), .B2(Peff[2]), .B1(Peff[1]), .P2(P2), .P1(P1));	
	
endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 

module passcode_all_testbench();
    
	logic CLK, RST, P2, P1;
	logic [3:1] Prs;

    passcode_all dut (.CLK, .RST, .Prs, .P2, .P1);
    
	parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        CLK <= 0;
        forever #(CLOCK_PERIOD/2) CLK <= ~CLK;
    end
	
	initial begin 
	    RST = 1;
        repeat(2)             
		@(posedge CLK);
	    RST = 0;			
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b000;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b000;
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b000;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b011;
		
        repeat(8)             
		@(posedge CLK);	
		$stop;
    end
endmodule