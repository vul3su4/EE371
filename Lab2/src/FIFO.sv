/*====================================================================*/
//Brian Chen
// 01/28/2025
//  LAB2 -- Memory Blocks (Task 3)
//  Device under Test (dut) --- FIFO                               
//  File Name: FIFO.sv                                            
/*====================================================================*/ 
module FIFO #(
				  parameter depth = 4,
				  parameter width = 8
				  )(
					 input logic clk, reset,
					 input logic read, write,
					 input logic [width-1:0] inputBus,
					output logic empty, full,
					output logic [width-1:0] outputBus,
					output logic [3:0] wrAddr,   // monitor write address
					output logic [3:0] rdAddr	   // monitor read address
				   );
					
	/* 	Define_Variables_Here		*/
	
//======================================	
     //logic [3:0] rdAddr, wrAddr;  <--comment for monitoring write/read address
//======================================		  
	  
logic wren;	
	
	/*			Instantiate_Your_Dual-Port_RAM_Here			*/
	
ram16x8 m1 (.clock(clk), .data(inputBus), .rdaddress(rdAddr), .wraddress(wrAddr), .wren(wren), .q(outputBus));
						  
	/*			FIFO-Control_Module			*/				
FIFO_Control #(depth) FC (.clk, .reset, 
								  .read, 
								  .write, 
								  .wr_en(wren),
								  .empty,
								  .full,
								  .readAddr(rdAddr), 
								  .writeAddr(wrAddr)
									 );	
endmodule 

/*====================================================================*/
//  Testbench                                                            
/*====================================================================*/
`timescale 1ps/1ps
module FIFO_testbench();
	
parameter depth = 4, width = 8;
	
logic clk, reset;
logic read, write;
logic [width-1:0] inputBus;
logic resetState;
logic empty, full;
logic [width-1:0] outputBus;

//monitor write/read address
logic [3:0] wrAddr, rdAddr; // monitor write/read address

	
integer i;
	
FIFO #(depth, width) dut (.*);
	
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