/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware (Task 1)
//  Device under Test (dut) --- bitcounting
//  File Name: bitcounting.sv                                                  
/*====================================================================*/ 
module bitcounting #(parameter WIDTH_A = 8, WIDTH_B = 4)
                    (clk, reset, LA, s, data, B, Done);
    input logic clk, reset;
    input logic LA; // Load signal of shfit register.	
	 input logic s;	
	 input logic [WIDTH_A-1:0]data; // input data of shift register
	 output logic [WIDTH_B-1:0]B; // output of counter
	 output logic Done;  
	
	 logic EA, LB, EB, Z;
	 logic [WIDTH_A-1:0] A;
       
    // State variables
    typedef enum logic [1:0] {S1, S2, S3} state_t;
	 state_t ps, ns;	
	
	
    /*		Combinational_Logic_Here	*/
    // Next State logic
    always_comb begin
        case (ps)
            S1: 
		        ns = s ? S2 : S1;
			
            S2: 
			     ns = (Z==1) ? S3 : S2;

            S3: 
			     ns = s ? S3 : S1;				
		  
		      default: ns = S1;
        endcase
    end

    /*		State Transition at posedge clk	*/
    always_ff @(posedge clk) begin
        if (reset)
            ps <= S1;
        else
            ps <= ns;
    end 
 
   
    /*	Outputs	 */
    assign LB = (ps == S1);
    assign EA = (ps == S2);	
	 assign EB = ((ps == S2) && (A[0] == 1'b1));
    assign Done = (ps == S3);	   

    /*		Data Path	*/
    always_ff @(posedge clk) begin
        if (reset) B <= 0;	     
        else if (LB) B <= 0;
        else if (EB) B <= B + 4'b0001;
    end

    // call shifter module
    shift #(8) sh (.clk, .reset, .data, .LA, .EA, .A);    

    assign Z = ~|A; // detect if A == 0.
   
endmodule
/*====================================================================*/
//   Testbench for bitcounting                                                
/*====================================================================*/
module bitcounting_testbench();

    parameter WIDTH_A = 8; // set bit-width of data to be counted
	 parameter WIDTH_B = 4; // set bit-width of counter
 
	 logic clk, reset;
    logic LA;	
	 logic s; 
	 logic [WIDTH_A-1:0]data; //data to be counted
	 logic [WIDTH_B-1:0]B;
	 logic Done;

    bitcounting #(WIDTH_A, WIDTH_B) dut (.*);

    parameter CLK_Period = 100;

    initial begin
        clk <= 1'b0;
	     forever #(CLK_Period/2) clk <= ~clk;
    end 
	
    initial begin 
        reset <= 1;
       
        repeat(1)     
        @(posedge clk);
        reset <= 0;
		  data <= 8'b1010_1110;
		
        repeat(1)     
        @(posedge clk);
        s <= 0;
		  LA <= 1;       		
        repeat(2) 
		  @(posedge clk);
        LA <= 0;		
        @(posedge clk);
		  s <= 1;
		
        repeat(12)     
        @(posedge clk);
		
	     $stop;
    end

endmodule