// Takes in a short pulse signal, extends the length of the pulse
// by 50,000,000 clock cycles for use with 3D simulator gates.

//in: 1-bit original input pulse
//out: 1-bit extended output pulse
//reset: 1-bit reset signal that sets counter to 0
//clk: 1-bit input clock controlling system
module signal_extender (in, out, reset, clk);
	
	input logic in, reset, clk;
	output logic out;
	logic [31:0] count = 32'b0;
	assign out = (count > 0);
	
	always_ff @(posedge clk) begin
	    if (reset) begin
	        count <= 0;
	    end
	    else begin
    	    if (in) count <= 50000000;
    	    else if (count > 0) count <= count - 1;
	    end
	end
endmodule
