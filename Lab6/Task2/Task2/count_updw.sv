/*====================================================================*/
//   count_updw                                                
/*====================================================================*/
module count_updw(clk, reset, count_updw);
	input logic clk, reset;
	output logic [2:0] count_updw;
// State variables
    typedef enum logic [3:0] {s0, s1u, s2u, s3u, s4u, s5u, s6u, s7,
	                              s1d, s2d, s3d, s4d, s5d, s6d} state_t;
	state_t ps, ns;	
	
/*		Combinational_Logic_Here	*/
// Next State logic
    always_comb begin
        ns = s0; // Default to avoid latches
        case (ps)
            s0:  begin ns = s1u; count_updw = 3'b000; end				 
            s1u: begin ns = s2u; count_updw = 3'b001; end	
            s2u: begin ns = s3u; count_updw = 3'b010; end				 
            s3u: begin ns = s4u; count_updw = 3'b011; end
            s4u: begin ns = s5u; count_updw = 3'b100; end	
            s5u: begin ns = s6u; count_updw = 3'b101; end				 
            s6u: begin ns = s7;	 count_updw = 3'b110; end		
            s7:  begin ns = s6d; count_updw = 3'b111; end				
            s6d: begin ns = s5d; count_updw = 3'b110; end	
            s5d: begin ns = s4d; count_updw = 3'b101; end
            s4d: begin ns = s3d; count_updw = 3'b100; end
            s3d: begin ns = s2d; count_updw = 3'b011; end
            s2d: begin ns = s1d; count_updw = 3'b010; end
            s1d: begin ns = s0;	 count_updw = 3'b001; end		
		   default: ns = s0;
      endcase
   end

/*		State Transition at posedge clk	*/
   always_ff @(posedge clk or posedge reset) begin
        if (reset)
            ps <= s0;
        else
            ps <= ns;
   end 
	
endmodule
/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 
module count_updw_testbench();
    
	logic clk, reset;
	logic [2:0] count_updw;

    count_updw dut (.clk, .reset, .count_updw);
    
	parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end
	
	initial begin 
	    reset = 1;
        repeat(1) 		
		@(posedge clk);	
	
 	    reset = 0;
		repeat(30)             
		@(posedge clk);	
		$stop;
    end
endmodule