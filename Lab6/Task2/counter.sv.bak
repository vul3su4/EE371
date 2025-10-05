module counter(clk, reset, inc, dec, count);

	input logic clk, reset, inc ,dec;
	output logic [1:0] count;
	
	//counter logic
	
	always_ff @(posedge clk or posedge reset) begin
			if (reset)
				count <= 2'b00; // reset count to 0
			
			else begin
				if (inc && !dec && count < 2'b11)
					count <= count + 1; // Increment if below max
					
				else if (dec && !inc && count > 2'b00)
					count <= count - 1 ; // Decrement iff above 0
					
			end
	end
	
endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 
module counter_testbench();
    
	logic clk, reset, inc, dec;
	logic [1:0] count;

    counter dut (.clk, .reset, .inc, .dec, .count);
    
	parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end
	
	initial begin 
	    reset = 1;
        repeat(2)             
		@(posedge clk);
	    reset = 0;		
        repeat(8)             
		@(posedge clk);
		{inc, dec} = 2'b10;
		repeat(8)             
		@(posedge clk);
		{inc, dec} = 2'b01;
		repeat(8)             
		@(posedge clk);		
		$stop;
    end
endmodule


