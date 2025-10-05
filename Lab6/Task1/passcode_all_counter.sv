module passcode_all_counter (CLK, RST, Prs, Car_in, Car_out, Entrance, Exit, count);
    input logic CLK, RST;
	input logic [3:1] Prs;
	input logic Car_in, Car_out;
    output logic Entrance, Exit;
	output logic [1:0] count;

    logic Car_out_QD, Car_out_eff;
	logic P1, P2;
	
	assign Entrance = Car_in & (P1 | P2) & (count < 3);
    assign Exit = Car_out;
	
    passcode_all m1 (.CLK(CLK), .RST(RST), .Prs(Prs), .P2(P2), .P1(P1));
    counter      m2 (.clk(CLK), .reset(RST), .inc(Entrance), .dec(Car_out_eff), .count(count));
    twoDFF       m3 (.CLK(CLK), .RST(RST), .D(Car_out), .Q(Car_out_QD));
    userInput    m4 (.CLK(CLK), .RST(RST), .Qin(Car_out_QD), .Qeff(Car_out_eff));	
endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 
module passcode_all__counter_testbench();
    
	logic CLK, RST, Car_in, Car_out, Entrance, Exit;
	logic [3:1] Prs;
	logic [1:0] count;

    passcode_all_counter dut (.CLK, .RST, .Prs, .Car_in, .Car_out, .Entrance, .Exit, .count);
    
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

        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;

        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
		        repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;
		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	

		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
        repeat(5)             
		@(posedge CLK);
		Prs = 3'b010;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b001;

        repeat(5)             
		@(posedge CLK);
		Prs = 3'b100;	

		
	    repeat(2)             
		@(posedge CLK);
	    {Car_in, Car_out} = 2'b10;		
		
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
	    {Car_in, Car_out} = 2'b01;	
		
		
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