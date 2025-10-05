/*====================================================================*/
//  Name: Brian Chen
//  Date: 02-07-2025
//  EE/CSE371 LAB3-- Display Interface (Task 1 & Task 2)
//  Device under Test (dut) --- line_drawer    
//  File Name: line_drawer.sv                                                  
/*====================================================================*/ 
module line_drawer(
	input logic clk, reset,
	
	// x and y coordinates for the start and end points of the line
	input logic [9:0] x0, x1, 
	input logic [8:0] y0, y1,

	//outputs cooresponding to the coordinate pair (x, y)
	output logic [9:0] x,
	output logic [8:0] y 
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
    logic signed [9:0] x0_in, x1_in, x_buf;  // buffer for I/O points
    logic signed [8:0] y0_in, y1_in, y_buf;  // buffer for I/O points
	 logic signed [9:0] error, error_initial;	// reg. for error etc. 
    logic signed [9:0] diff_x;               // reg. for difference of x
    logic signed [8:0] diff_y, diff_y_new;   // reg. for difference of y
    logic signed [9:0] abs_diff_x;    // reg. for absolute of diff_x
    logic signed [8:0] abs_diff_y;    // reg. for absolute of diff_y
    logic signed [9:0] delta_x;       // reg. for delta_x
    logic signed [8:0] delta_y;       // reg. for delta_y
    logic signed [8:0] y_step;        // reg. for y_step
    logic signed [9:0] x_new;         // reg. for x in new iteration
    logic signed [8:0] y_new;         // reg. for y in new iteration
    logic signed steep;               // reg. for steep

    // delcare output signals of ASM (control unit) 
    logic get_end_pt, get_abs, get_steep, swap_xy, swap_01;
    logic draw_pt_0, update_y_error, x_inc, draw_pt_i;      

/* 	Define_Variables_Here		*/
// State variables
    typedef enum logic [3:0] {
	         idle,
            end_pt_ready,   // end-points get ready
            abs_ready,      // absolute value get ready
            steep_ready,    // steep value get ready
            swap_xy_ready,  // swap(x,y) get ready
            swap_01_ready,  // swap(x0, x1), swap(y0,y1) get ready
            finished_pt,    // finished drawing a point 
            next_iteration, // get ready to enter next iteration 
            new_pt_ready    // (x, y) get ready
            } state_t;
	 state_t ps, ns;	
	
/*		Combinational_Logic_Here	*/
// Next State logic
    always_latch begin
        ns = idle; // Default to avoid latches
        case (ps)
            idle: 
                if (!reset) begin
                    ns = end_pt_ready;
                    get_end_pt     = 1'b1; // get end points
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;
                end
                else 
                    ns = idle;

            end_pt_ready: 
                begin
                    ns = abs_ready;
                    get_end_pt     = 1'b0;                    
                    get_abs        = 1'b1; // calculte absolute value
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;
                end
					 
            abs_ready: 
                begin
                    ns = steep_ready;
                    get_end_pt     = 1'b0;                 
                    get_abs        = 1'b0;
                    get_steep      = 1'b1; // get steep value
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;
                end

            steep_ready:
                if (steep) begin
                    ns = swap_xy_ready;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b1;  // do swap(x, y)
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;                   
                end
                else begin                 
                    ns = swap_xy_ready;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;
                end

            swap_xy_ready: 
                if (x0_in > x1_in) begin
                    ns = swap_01_ready;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b1;  //do swap(x0,x1), swap(y0,y1)
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;                
                end
                else begin
                    ns = swap_01_ready;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0; 
                end
                
            swap_01_ready: 
                begin
                    ns = finished_pt;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b1; //draw the 1st point
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;                    
                end
					 
            finished_pt: 
                if (error >= 0) begin
                    ns = next_iteration;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b1; // update y and error
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;                     
                end
                else begin              
                    ns = next_iteration;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;                     
                end
					 
		    next_iteration: 
                if (x_buf <= x1_in - 1) begin
                    ns = new_pt_ready;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b1; // increase x_new by 1
                    draw_pt_i      = 1'b0;
                end
                else begin                          
                    ns = idle;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;
                end
				
			new_pt_ready: 
                begin
                    ns = finished_pt;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b1; // draw the i-th point          
                end
		  
		  default:
		          begin
                    ns = finished_pt;
                    get_end_pt     = 1'b0;                     
                    get_abs        = 1'b0;
                    get_steep      = 1'b0;
                    swap_xy        = 1'b0;
                    swap_01        = 1'b0;
                    draw_pt_0      = 1'b0;
                    update_y_error = 1'b0;
                    x_inc          = 1'b0;
                    draw_pt_i      = 1'b0;           
               end
      endcase
   end

/*		State Transition at posedge clk	*/
   always_ff @(posedge clk or posedge reset) begin
        if (reset)
            ps <= idle;
        else
            ps <= ns;
   end 

/*		Data Path	*/
   always_ff @(posedge clk or posedge reset) begin
       if (reset) begin
		    // clear regiters related to x, y 
	        x <= 0;
		     y <= 0;
		     x_new <= 0;
		     y_new <= 0;
		     x_buf <= 0;
		     y_buf <= 0;
		 end
       else begin
        
            if (get_end_pt) begin				
		          // put end points into buffers 
					 // calculte the difference 
                x0_in <= x0;
                y0_in <= y0;
                x1_in <= x1;
                y1_in <= y1;
                diff_x <= x1 - x0;
                diff_y <= y1 - y0;                                  
            end
				
        
            if (get_abs) begin
					 // calculte the absolute values 
				    abs_diff_x = (diff_x[9] == 1) ? 
					              (~diff_x + 1'b1) : diff_x;
				    abs_diff_y = (diff_y[8] == 1) ? 
					              (~diff_y + 1'b1) : diff_y;						  
            end
				

            if (get_steep) 
				    // check if it is a steep line 
				    steep = (abs_diff_y > abs_diff_x) ? 1 : 0;
					 
				
            if (swap_xy) begin
					 // do swap 
                x0_in <= y0_in;
                y0_in <= x0_in;
                x1_in <= y1_in;
                y1_in <= x1_in;            
            end
            else if (swap_01) begin
					 // do swap 
                x0_in <= x1_in;
                x1_in <= x0_in;
                y0_in <= y1_in;
                y1_in <= y0_in;
            end
            else begin
                ;
            end
				
                                  
            if (draw_pt_0) begin  // set and caculate prarmeters
                delta_x = x1_in - x0_in;
                diff_y_new = y1_in - y0_in;
                delta_y = (diff_y_new[8] == 1) ? 
			                 (~diff_y_new + 1'b1) : diff_y_new;
                error_initial = -(delta_x >> 1);
                y_step = (y0_in < y1_in) ? 1 : -1;
					 
			       x_new <= x0_in;
				    y_new <= y0_in;
                x_buf <= x0_in;
                y_buf <= y0_in;
					 
                if (!steep) begin
				        x = x_buf;
				        y = y_buf;
                end 
                else begin
                    y = x_buf;
                    x = y_buf;
                end
					 error <= error_initial + delta_y;					 
            end			

            
				if (ps == finished_pt)  // update error & y_new
		          if (update_y_error) begin
                    y_new <= y_buf + y_step;
                    error <= error - delta_x;          
                end
                else
                    y_new <= y_buf;
						  
		
            if (x_inc) begin
                x_new <= x_buf + 1;          
            end  
				

		      if (draw_pt_i) begin // prepare (x,y) to be drawn
				    x_buf <= x_new;
                y_buf <= y_new;
		          if (!steep) begin
				        x = x_buf;
				        y = y_buf;
                end
                else begin
				        x = y_buf;
				        y = x_buf;
                end
                error <= error + delta_y;
            end 	
				
       
		 end               
   end 
   
endmodule

/*====================================================================*/
//   Testbench                                                 
/*====================================================================*/
module line_drawer_testbench();

logic clk, reset;
logic [9:0] x0, x1, x;
logic [8:0] y0, y1, y;

line_drawer dut (.clk, .reset, .x0, .x1, .y0, .y1, .x, .y);

parameter CLK_Period = 100;  // set clock period

// generate clock signal
initial begin
    clk <= 1'b0;
	 forever #(CLK_Period/2) clk <= ~clk;
end

// reset this module	
initial begin 
    reset <= 1;
       
    repeat(3)     
    @(posedge clk);
    reset <= 0;
end


// set values of end points of each line	
initial begin
    x0 <= 10'd10;
    y0 <=  9'd20;  
    x1 <= 10'd300;
    y1 <=  9'd200;      
    repeat(1000)     
    @(posedge clk);

    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;
	
	 x0 <= 10'd10;
    y0 <=  9'd20;  
    x1 <= 10'd100;
    y1 <=  9'd200;		
    repeat(1000)     
    @(posedge clk);	 
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;
	
	 x0 <= 10'd10;
    y0 <=  9'd20;  
    x1 <= 10'd10;
    y1 <=  9'd200;      		
    repeat(1000)     
    @(posedge clk);
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;

	 x0 <= 10'd300;
    y0 <=  9'd20;  
    x1 <= 10'd10;
    y1 <=  9'd200;      
    repeat(1000)     
    @(posedge clk);
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;;
		
	 x0 <= 10'd300;
    y0 <=  9'd20;  
    x1 <= 10'd100;
    y1 <=  9'd200;      
    repeat(1000)     
    @(posedge clk);
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;
		
	 x0 <= 10'd300;
    y0 <=  9'd200;  
    x1 <= 10'd10;
    y1 <=  9'd20;      
    repeat(1000)     
    @(posedge clk);
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;


	 x0 <= 10'd100;
    y0 <=  9'd200;  
    x1 <= 10'd10;
    y1 <=  9'd20;      
    repeat(1000)     
    @(posedge clk);
	
    reset <= 1;   
    repeat(3)     
    @(posedge clk);
	 reset <= 0;
	 
    x0 <= 10'd100;
    y0 <=  9'd200;  
    x1 <= 10'd200;
    y1 <=  9'd200;      
    repeat(1000)     
    @(posedge clk);
	
	 $stop;

	 end

endmodule
