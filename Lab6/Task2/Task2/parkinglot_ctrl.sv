/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- parkinglot_ctrl
//  File Name: parkinglot_ctrl.sv                                                  
/*====================================================================*/ 
module parkinglot_ctrl (
	input logic clock, 
	input logic reset,
    input logic start, 	
	input logic KEY0,
	input logic full,
	input logic empty,
	input logic hour_7,	
	output logic hour_inc,
	output logic wr,
	output logic RH_start,
    output logic RH_end,
    output logic RH_flag,	
	output logic show,
	output logic clear_reg);
       
// State variables
    typedef enum logic [2:0] {s_idle, s_go, s_rush_start, s_rush_end, 
	                          s_wait1, s_wait2, 
	                          s_done, s_display} state_t;
	state_t ps, ns;	
	
/*		Combinational_Logic_Here	*/
// Next State logic
    always_comb begin
        ns = s_idle; // Default to avoid latches
        case (ps)
            s_idle: 
                ns = start ? s_go : s_idle;
				 
            s_go: 
				if (full)
			            ns = s_rush_start;
					else
						if (hour_7) 
						    ns = s_done;
						else
							ns = s_go;
			
            s_rush_start: 
			    ns = s_wait1;
			
			s_wait1:
				if (empty)
			            ns = s_rush_end;
					else
						if (hour_7) 
						    ns = s_done;
						else
							ns = s_wait1;
				
		    s_rush_end:
			    ns = s_wait2;

            s_wait2: 
                ns = hour_7 ? s_done : s_wait2;		       
            
		    s_done: 
				ns = KEY0 ? s_done : s_display;
						 
		    s_display: 
				ns = start ? s_display : s_idle;			          					
		  
		  default: ns = s_idle;
      endcase
   end

/*		State Transition at posedge clk	*/
   always_ff @(posedge clock) begin
        if (reset)
            ps <= s_idle;
        else
            ps <= ns;
   end 
   
/*	Outputs	 */ 
	 assign hour_inc = !KEY0 && ((ps != s_display) && (ps != s_idle));
    assign wr       = !KEY0 && ((ps != s_display) && (ps != s_idle));

    assign RH_start = (ps ==s_rush_start);
    assign RH_end = (ps == s_rush_end);	
    assign RH_flag = (ps == s_rush_start);	
    assign show = (ps == s_display);
	 assign clear_reg = (ps == s_idle);
 
endmodule
/*====================================================================*/
//   Testbench for binsearch_top                                                
/*====================================================================*/
`timescale 1 ps / 1 ps
module parkinglot_ctrl_testbench();
	logic clock; 
	logic reset;
    logic start; 	
	logic KEY0;
	logic full;
	logic empty;
	logic hour_7;	
	logic hour_inc;
	logic wr;
	logic RH_start;
    logic RH_end;
	 logic RH_flag;
	logic show;
	logic clear_reg;
	
	integer i;

    parkinglot_ctrl dut (.*);

    parameter CLK_Period = 100;

    initial begin
        clock <= 1'b0;
	    forever #(CLK_Period/2) clock <= ~clock;
    end
	
    initial begin 
        reset <= 1;
       
        repeat(1)     
        @(posedge clock);
        reset <= 0;
		
        repeat(1)     
        @(posedge clock);
        start <= 0;
		
        repeat(1) 	
        @(posedge clock);
		start <= 1;
		
		for (i = 0; i < 2**4; i++)
        begin
            {hour_7, empty, full, KEY0} = i;
			repeat(2)     
            @(posedge clock);
		end	
		
        repeat(2)     
        @(posedge clock);
		
		start <= 0;
		repeat(2)     
        @(posedge clock);

	    $stop;
    end

endmodule