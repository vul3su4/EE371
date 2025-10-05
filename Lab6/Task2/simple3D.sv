/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- simple3D
//  File Name: simple3D.sv                                                  
/*====================================================================*/ 
module simple3D (CLK, RST, clear_reg, Car_in, Car_out, Entrance, Exit, count, full, empty);
    input logic CLK, RST;
	 input logic clear_reg;
	 input logic Car_in, Car_out;
    output logic Entrance, Exit;
	 output logic [1:0] count;
	 output logic full, empty;

    logic Car_out_QD, Car_out_eff;
	 logic P1, P2;
	 logic reset;
	 logic Car_in_eff;
	
    assign Entrance = Car_in_eff & (count < 3);  //<----
    assign Exit = Car_out;
	 assign full  = (count == 2'b11) ? 1'b1 : 1'b0;
	 assign empty = (count == 2'b00) ? 1'b1 : 1'b0;
	 assign reset = RST | clear_reg;
	
    counter      m2 (.clk(CLK), .reset(reset), .inc(Entrance), .dec(Car_out_eff), .count(count));
    twoDFF       m3 (.CLK(CLK), .RST(reset), .D(Car_out), .Q(Car_out_QD));
    userInput    m4 (.CLK(CLK), .RST(reset), .Qin(Car_out_QD), .Qeff(Car_out_eff));	
	 
	 twoDFF       m5 (.CLK(CLK), .RST(reset), .D(Car_in), .Q(Car_in_QD));
    userInput    m6 (.CLK(CLK), .RST(reset), .Qin(Car_in_QD), .Qeff(Car_in_eff));	
endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 
module simple3D_testbench();
    
	 logic CLK, RST, Car_in, Car_out, Entrance, Exit;
	 logic clear_reg;
	 logic [1:0] count;

    simple3D dut (.CLK, .RST, .clear_reg, .Car_in, .Car_out, .Entrance, .Exit, .count);
    
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
	
        repeat(2)             
		  @(posedge CLK);
	     {Car_in, Car_out} = 2'b10;		
		
		  repeat(2)             
		  @(posedge CLK);
	     {Car_in, Car_out} = 2'b10;		
		
	     repeat(2)             
		  @(posedge CLK);
	     {Car_in, Car_out} = 2'b10;		
		
        repeat(8)             
		  @(posedge CLK);	
		  $stop;
     end
endmodule