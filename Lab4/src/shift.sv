/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware (Task 1)
//  Device under Test (dut) --- shift
//  File Name: shift.sv                                                  
/*====================================================================*/ 
module shift #(parameter BIT_WIDTH = 8) (clk, reset, data, LA, EA, A);
    input logic clk, reset;
	 input LA; // load input data parallely
	 input EA; // 1-bit shift right
	 input logic [BIT_WIDTH-1:0] data; // input data of shift regiter
	 output logic [BIT_WIDTH-1:0] A; // output data of shift register
	
	 always_ff @(posedge clk)
	     if (reset)
		      A <= 0;
		  else if (LA)
            A <= data;	   // load data parallely
        else if (EA)
            A <= (A >> 1); // 1-bit shift right per clock cycle
		   
    endmodule

/*====================================================================*/
//   Testbench for shift                                                
/*====================================================================*/
module shift_testbench();

    parameter BIT_WIDTH = 8; // set bit-width of shift register

    logic clk, reset, LA, EA;
	 logic [BIT_WIDTH-1:0] data;
	 logic [BIT_WIDTH-1:0] A;

    shift #(BIT_WIDTH) dut (.*);
	 
	 // set clock signal
    parameter CLK_Period = 100;

    initial begin
        clk <= 1'b0;
	     forever #(CLK_Period/2) clk <= ~clk;
    end
	 
	 // set test patterns
	
    initial begin 
        reset <= 1;     // reset
        repeat(1)     
        @(posedge clk);
		  
        reset <= 0;
		  data <= 8'b1010_1110;
		  repeat(1)     
        @(posedge clk);
		  
		  LA <= 1;       // load dada pararllely   		
        repeat(2) 
		  @(posedge clk);
        
		  LA <= 0;		  
        @(posedge clk);
		  
		  EA <= 1;       // 1-bit shift right per clock cycle
		  repeat(10)     
        @(posedge clk);
		
	     $stop;
    end

endmodule