/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-19-2025
//  EE/CSE371 LAB4--- Implementing Algorithm in Hardware (Task 2)
//  Device under Test (dut) --- binsearch_datapath
//  File Name: binsearch_datapath.sv                                                  
/*====================================================================*/ 
module binsearch_datapath 
    #(parameter BIT_WIDTH = 8, parameter ADDR_WIDTH = 5)(
	 input logic clock, reset,
	 output logic A_EQ_B,        // A == B
	 output logic A_GT_B,        // A > B
	 output logic A_LT_B,	     // A < B
	 output logic terminate,     // terminate searching
	 input logic Ld_A,           // Load data to be sought
	 input logic Ld_UpAddr,      // Set the initial address (0) of the top word.
	 input logic Ld_LowAddr,     // Set the initial address (31) of the bottom word.
	 input logic get_Addr_sum,	  // Calculate the sum of the top and bottom addresses.
	 input logic get_Addr_m,     // Calculate the mean of the top and bottom addresses.      
	 input logic compare,        // Compare data_A and data_B.
	 input logic Found,          // Indicate data_A was found in ram32x8.
	 input logic NotFound,       // Indicate data_A was not found in ram32x9
    input logic New_UpAddr,     // Update the address of the NEW top word.
	 input logic New_LowAddr,    // Update the address of the NEW bottom word.
	 input logic [BIT_WIDTH-1:0] data_A,
	 input logic [BIT_WIDTH-1:0] data_B,
	 output logic [ADDR_WIDTH-1:0] m,          // mean of the top and bottom addresses.
	 output logic [ADDR_WIDTH-1:0] Addr_Found, // The address of the word that is the same as data_A. 
    output logic Found2LEDR,      // Turn on LEDR[9] when data_A was found in ram32x8.
    output logic NotFound2LEDR);	 // Turn on LEDR[8] when data_A was not found in ram32x8.

    logic [BIT_WIDTH:0] A;
	 logic [ADDR_WIDTH-1:0] UpAddr, LowAddr; // The addresses of the top/bottom words.
	 logic [BIT_WIDTH:0] sum;
	 	 
	 assign Found2LEDR = Found;       // Send "Found" from Controller to Datapth to turn on LEDR[9].
	 assign NotFound2LEDR = NotFound; // Send "NotFound" from Controller to Datapth to turn on LEDR[8].
	
/*		Data Path	*/
    always_ff @(posedge clock) begin
        if (reset) begin
            UpAddr <= 5'b0_0000;     // Set initial address of the top word to be 0.
		      LowAddr <= 5'b1_1111;    // Set initial address of the bottom word to be 31.
			   m <= 5'b0_1111;          // Set initial m to 15.
			   Addr_Found <= 5'bz_zzzz; // Set initial Addr_Found to be high impedance. 
	     end	   		   
        else begin
	         if (Ld_A) A <= data_A;    
			   if (Ld_UpAddr)  UpAddr <= 5'b0_0000;
			   if (Ld_LowAddr) LowAddr <= 5'b1_1111;
	         if (get_Addr_sum)  sum <= (UpAddr + LowAddr);  // Calculate sum
		      if (get_Addr_m)  m <= sum >> 1;     // Divide by 2 by means of shift right 1 bit.
		      if (compare) begin
		          if (A == data_B) begin
				        {A_EQ_B, A_GT_B, A_LT_B} <= 3'b100;
					     Addr_Found <= m;
				    end
			       if (A > data_B)  {A_EQ_B, A_GT_B, A_LT_B} <= 3'b010;
			       if (A < data_B)  {A_EQ_B, A_GT_B, A_LT_B} <= 3'b001;
		      end					
            if ((UpAddr == m) || (LowAddr == m))	 terminate <= 1'b1;  // Set terminated condition
            else terminate <= 1'b0;	
	   
            if (New_UpAddr) UpAddr <= m + 1'b1;         // Update the address of the NEW top word. 
            if (New_LowAddr) LowAddr <= m - 5'b0_0001;// Update the address of the NEW bottom word.   	   	   
        end
    end // always_ff   
endmodule
