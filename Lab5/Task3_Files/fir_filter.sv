/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-28-2025
//  EE/CSE371 LAB5--- Digital Signal Processing  (Task 3)
//  Device under Test (dut) --- fir_filter
//  File Name: fir_filter.sv                                                  
/*====================================================================*/ 
module fir_filter #(parameter DATA_WIDTH=24, ADDR_WIDTH=3)
            (clk, reset, wr, data_in, data_out);

	input  logic clk, reset, wr;
	input  logic  [DATA_WIDTH-1:0] data_in; 
	output  logic [DATA_WIDTH-1:0] data_out;
	
	// signal declarations
	logic rd, empty, full, reset_acc;
	logic [DATA_WIDTH-1:0] r_data, divided, r_data_out, sum, acc_q;
	
	assign rd = full;  // Do not read FIFO until it becomes full.
	assign r_data_out = rd ? r_data : 24'b0;  // This is for getting correct moving average.
	assign divided = {{ADDR_WIDTH{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:ADDR_WIDTH]};
	//assign divided = {{3{data_in[23]}}, data_in[23:3]};	
	
	// instantiate FIFO
	fifo #(DATA_WIDTH, ADDR_WIDTH) m1
            (.clk, .reset, .rd, .wr, .empty, .full, .w_data(divided), .r_data(r_data));
    
	assign sum = divided - r_data_out;
	
	// Accumulator
	assign reset_acc = (empty == 0) ? 0 : 1;  // reset signal for accumulator.
	assign data_out = acc_q + sum;
	
	always_ff @ (posedge clk or posedge reset_acc)
	    if (reset_acc)
		     acc_q <= sum;
		 else 
           acc_q <= acc_q + sum;		

endmodule  // fir_filter

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/
module fir_filter_testbench();
	
    parameter DATA_WIDTH = 24, ADDR_WIDTH = 3;
	
    logic clk, reset, wr;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    integer i;
	 
	 // Instantiate fir_filter.
    fir_filter #(DATA_WIDTH, ADDR_WIDTH) dut (.*);

	 // clock generator 
    parameter CLK_Period = 100;
	
    initial begin
        clk <= 1'b0;
	     forever #(CLK_Period/2) clk <= ~clk;
    end
	
    // Reset stimulus
    initial begin
        reset = 1;  // Assert reset
        repeat(1) 
        @(posedge clk);        
        reset = 0;   // De-assert reset
    end

	 // Use for loop for test generation.
    initial begin
        repeat(2) 
        @(posedge clk);			
		  wr <= 1'b1;
		  for (i = 10; i < 200; i = i + 2) begin 
		      data_in <= i[23:0];        		 
		      @(posedge clk);
        end			  
        $stop;
    end
	
endmodule 