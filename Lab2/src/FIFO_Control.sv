/*====================================================================*/
//Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks (Task 3)
//  Device under Test (dut) --- FIFO_Control                               
//  File Name: FIFO_Control_SoC.sv                                            
/*====================================================================*/
module FIFO_Control #(
							 parameter depth = 4
							 )(
								input logic clk, reset,
								input logic read, write,
							  output logic wr_en,
							  output logic empty, full,
							  output logic [depth-1:0] readAddr, writeAddr
							  );
	
/* 	Define_Variables_Here		*/
// State variables
typedef enum logic [3:0] {
    s0, s1, s2, s3, s4, s5, s6, s7, s10, s40, s50
	 } state_t;
	 state_t ps, ns;	
	
/*		Combinational_Logic_Here	*/
// Next State logic
always_comb begin
    ns = s0; // Default to avoid latches
    case (ps)
        s0: if ({read, write} == 2'b01) ns = s1;
                else ns = s0;
					 
        s1: if      (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s1;
				else if (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
				else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
				else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;				
            else    ns = s10;

        s2: if      ({read, write} == 2'b10) ns = s4;
				else    ns = s3;
                
        s3: if      ({read, write} == 2'b10) ns = s4;
            else    ns = s3;
					 
        s4: if      (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s5;
				else if (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
			   else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
				else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;
            else      ns = s40;
					 
		  s5: if      (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s5;
				else if (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
			   else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
			   else if (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;				 
            else    ns = s50;
					
		  s6: if      ({read, write} == 2'b01) ns = s5;
            else    ns = s7;
					 
		  s7: if      ({read, write} == 2'b01) ns = s5;			 
            else    ns = s7;
					 
		  s10: if       (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s1;
				 else if  (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
				 else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
				 else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;			 
             else      ns = s10;					 
				  
		  s40: if       (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s5;
				 else if  (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
		       else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
				 else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;	 
             else      ns = s40;
					  
		  s50: if       (({read, write} == 2'b01) && ((writeAddr + 4'b0001) != readAddr)) ns = s5;
				 else if  (({read, write} == 2'b01) && ((writeAddr + 4'b0001) == readAddr)) ns = s2;
			    else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) != writeAddr)) ns = s4;
				 else if  (({read, write} == 2'b10) && ((readAddr + 4'b0001) == writeAddr)) ns = s6;					 
             else      ns = s50;
				
	     default: ns = s0;
    endcase
end
   
   
always_comb begin
    case(ps)
        s0: {empty, full} = 2'b10;
        s1: {empty, full} = 2'b00;
        s2: {empty, full} = 2'b01;
        s3: {empty, full} = 2'b01;
            
        s4: {empty, full} = 2'b00;
        s5: {empty, full} = 2'b00;
        s6: {empty, full} = 2'b10;
        s7: {empty, full} = 2'b10;
            
        s10: {empty, full} = 2'b00;
        s40: {empty, full} = 2'b00;
        s50: {empty, full} = 2'b00;             
    endcase
end        
 
always_ff @(negedge clk) begin // use negedge for readAddr / writeAddr
    if(reset) begin
	     readAddr <= '0;
		  writeAddr <= '0;
	 end 
	 else begin
	     case (ps)
            s0: begin
				         readAddr <= 0;
						  writeAddr <= 0;
				    end
				  
            s1: begin
				         readAddr <= 0;
						  writeAddr <= writeAddr + 4'b0001;
				    end
				                
				s2: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr + 4'b0001;
				    end

				s3: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				    end	
				  
            s4: begin
				         readAddr <= readAddr + 4'b0001;
						  writeAddr <= writeAddr;
				    end	

            s5: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr + 4'b0001;
				    end	
				  
            s6: begin
				         readAddr <= readAddr + 4'b0001;
						  writeAddr <= writeAddr;
				    end
				  
            s7: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				    end
				  
           s10: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				    end
				  
           s40: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				    end

           s50: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				    end
              
			  default: begin
				         readAddr <= readAddr;
						  writeAddr <= writeAddr;
				        end
        endcase		
    end
end		
	

	    // DFFs
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        ps <= s0;
    else
        ps <= ns;
    end
	
assign wr_en = write & (~full);

endmodule 

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/

module FIFO_Control_testbench();
	
parameter depth = 4, width = 8;
logic clk, reset;
logic read, write;
logic empty, full;
logic wr_en;
logic [3:0] readAddr, writeAddr;	
	
integer i;

FIFO_Control #(depth) dut 
	          (.clk, .reset, .read, .write, .wr_en, .empty, .full, .readAddr, .writeAddr);
	
parameter CLK_Period = 100;
	
initial begin
    clk <= 1'b0;
	 forever #(CLK_Period/2) clk <= ~clk;
end
	
initial begin 
    reset <= 1;
       
    repeat(3)     
    @(posedge clk);
    
	 reset <= 0;
end
   
initial begin
    for (i = 0; i < 3; i++) begin	
	     @(negedge clk);		  
		  {read, write} <= 2'b01;
         
		  repeat(10)			 
		  @(negedge clk);	

        {read, write} <= 2'b00;
        repeat(2)			 
		  @(negedge clk);	            
     end  

     for (i = 3; i < 6; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b10;
         
			repeat(3)			 
		   @(negedge clk);	   
     end  
       
     for (i = 6; i < 9; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b01;
         
			repeat(3)			 
		   @(negedge clk);	   
     end
       
     for (i = 9; i < 12; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b01;
         
			repeat(10)			 
		   @(negedge clk);	

         {read, write} <= 2'b00;
         
			repeat(2)			 
		   @(negedge clk);	            
     end  

     for (i = 12; i < 15; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b10;
         
			repeat(20)			 
		   @(negedge clk);	   
     end  
       
     for (i = 15; i < 18; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b01;
         
			repeat(6)			 
		   @(negedge clk);	   
     end   
       
	  for (i = 12; i < 15; i++) begin	
		   @(negedge clk);		  
			{read, write} <= 2'b10;
         
			repeat(16)			 
		   @(negedge clk);

         {read, write} <= 2'b00;  
		   @(negedge clk);          
     end        
     
	  $stop;
end	
endmodule 




