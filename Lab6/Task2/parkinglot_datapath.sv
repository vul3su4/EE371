/*====================================================================*/
//  Name: Brian Chen
//  Date: 03-15-2025
//  EE/CSE371 LAB6--- System Verilog in the Real World (Task 2)
//  Device under Test (dut) --- parkinglot_datapath
//  File Name: parkinglot_datapath.sv                                     
/*====================================================================*/ 
module parkinglot_datapath (
	input logic clock, 
	input logic reset,
	input logic clear_reg,
   input logic hour_inc,
	input logic wr,
	input logic RH_start,
   input logic RH_end,	
	input logic RH_flag,
	input logic show,
	input logic [1:0] count,
	output logic full,
	output logic empty,
	output logic hour_7,
	output logic [2:0] hour,
	output logic [2:0] count_updw,
	input logic [15:0] hour_car,
   output logic [6:0] HEX5,
	output logic [6:0] HEX4,
   output logic [6:0] HEX3,
   output logic [6:0] HEX2,
   output logic [6:0] HEX1,
   output logic [6:0] HEX0);
	
	logic wren;
	logic [15:0] car_acc;
	logic [2:0] rush_hour_start;
	logic [2:0] rush_hour_end;
	logic rush_hour_flag_start;
	logic rush_hour_flag_end;	
	logic [2:0] remaining;
	logic [6:0] HEX5_mux, HEX4_mux, HEX3_mux, HEX2_mux, HEX1_mux, HEX0_mux;
	
	logic select;
	logic [6:0] out13, out14, out20, out21, out22, out23, out24;
	
	
   logic hour_inc_QD, hour_inc_eff;

	
	assign wren = wr;
	assign hour_7 = (hour == 7) ? 1'b1 : 1'b0;
	assign full  = (count == 2'b11) ? 1'b1 : 1'b0;
	assign empty = (count == 2'b00) ? 1'b1 : 1'b0;
	assign remaining = 3'b11 - count;

   always_ff @(posedge clock or posedge reset or posedge clear_reg)
       if (reset) begin
		     hour <= 3'b0;
			  car_acc <= 16'b0;
			  rush_hour_start <= 3'b0;
			  rush_hour_end <= 3'b0;
			  rush_hour_flag_start <= 1'b0;
			  rush_hour_flag_end <= 1'b0;			
		 end
		 else if (clear_reg) begin
		     hour <= 3'b0;
			  car_acc <= 16'b0;
			  rush_hour_start <= 3'b0;
			  rush_hour_end <= 3'b0;
			  rush_hour_flag_start <= 1'b0;
			  rush_hour_flag_end <= 1'b0;			
		 end		
		 else begin
		     if (hour_inc_eff) hour <= hour + 3'b1;
		     if (RH_start) rush_hour_start <= hour;
			  if (RH_flag)  rush_hour_flag_start <= 1'b1;
			  if (RH_end) begin
			      rush_hour_end <= hour;
				   rush_hour_flag_end <= 1'b1;
           end				 
		 end
	//===================	 
	 twoDFF       DFF2   (.CLK(clock), .RST(reset), .D(hour_inc), .Q(hour_inc_QD));
    userInput    userin (.CLK(clock), .RST(reset), .Qin(hour_inc_QD), .Qeff(hour_inc_eff));
	//===================	 
	
    assign sel_HEX34 = rush_hour_flag_start && rush_hour_flag_end;	
		 
    data7seg d5 (.data({1'b0, hour}),       .seg(HEX5_mux));
    data7seg d4 (.data(rush_hour_end),      .seg(HEX4_mux));
    data7seg d3 (.data(rush_hour_start),    .seg(HEX3_mux));
    data7seg d2 (.data({1'b0, count_updw}), .seg(HEX2_mux));
    data7seg d1 (.data(hour_car[3:0]),      .seg(HEX1_mux));
    data7seg d0 (.data(remaining),          .seg(HEX0_mux));
	
	 mux2_1 m14 (.s(sel_HEX34), .d1(HEX4_mux), .d0(7'h3f), .out(out14));
	 mux2_1 m13 (.s(sel_HEX34), .d1(HEX3_mux), .d0(7'h3f), .out(out13));
	
	 mux2_1 m24 (.s(~show), .d1(7'h7f),    .d0(out14),    .out(out24));
	 mux2_1 m23 (.s(~show), .d1(7'h7f),    .d0(out13),    .out(out23));
	 mux2_1 m22 (.s(~show), .d1(7'h7f),    .d0(HEX2_mux), .out(out22));
	 mux2_1 m21 (.s(~show), .d1(7'h7f),    .d0(HEX1_mux), .out(out21));
	 mux2_1 m20 (.s(~show), .d1(HEX0_mux), .d0(7'h7f),    .out(out20));
	
	 assign select = full && ~show;

	 mux2_1 m35 (.s(~show), .d1(HEX5_mux), .d0(7'h7f), .out(HEX5));		
	 mux2_1 m34 (.s(select), .d1(7'h7f),    .d0(out24), .out(HEX4));		
	 mux2_1 m33 (.s(select), .d1(7'h0e),    .d0(out23), .out(HEX3));		
	 mux2_1 m32 (.s(select), .d1(7'h41),    .d0(out22), .out(HEX2));		
	 mux2_1 m31 (.s(select), .d1(7'h47),    .d0(out21), .out(HEX1));		
	 mux2_1 m30 (.s(select), .d1(7'h47),    .d0(out20), .out(HEX0));	
	
	 count_updw c1 (.clk(clock), .reset(~show), .count_updw(count_updw));
	
endmodule	
/*====================================================================*/
//   mux2_1                                                
/*====================================================================*/
module mux2_1 (
    input logic s,
    input logic [6:0] d1,
    input logic [6:0] d0, 
	 output logic [6:0] out);
	
	 assign out = s ? d1 : d0;
	
endmodule
/*====================================================================*/
//   Testbench for parkinglot_datapath                                                
/*====================================================================*/
`timescale 1 ps / 1 ps
module parkinglot_datapath_testbench();
	 logic clock; 
	 logic reset;
	 logic clear_reg;
    logic hour_inc;
	 logic wr;
	 logic RH_start;
    logic RH_end;	
	 logic RH_flag;
	 logic show;
	 logic [1:0] count;
	 logic full;
	 logic empty;
	 logic hour_7;
    logic [2:0] hour;
    logic [2:0] count_updw;
    logic [15:0] hour_car;
    logic [6:0] HEX5;
	 logic [6:0] HEX4;
    logic [6:0] HEX3;
    logic [6:0] HEX2;
    logic [6:0] HEX1;
    logic [6:0] HEX0;
	
	 integer i;

    parkinglot_datapath dut (.*);

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
		
		  for (i = 0; i < 2**6; i++) begin
		      {show, hour_inc, wr, RH_start, RH_end, RH_flag} = i;
			   repeat(2)     
            @(posedge clock);
		  end	
		
        repeat(2)     
        @(posedge clock);

	    $stop;
    end

endmodule