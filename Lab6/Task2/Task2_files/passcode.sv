module passcode (CLK, RST, B3, B2, B1, P2, P1);
    input logic CLK, RST, B3, B2, B1;
    output logic P2, P1;	
	
// State variables
    typedef enum logic [3:0] {
    s0, s1, s2, s3, s4, s5, s6, s7, s8, s9
    } state_t;
    state_t ps, ns;

    // assign ps_out = ps;

    // Next State logic
always_comb begin
    ns = s0; // Default to avoid latches
    case (ps)
        s0:    if (B1 == 1)
                   ns = s1;
               else if (B2 == 1)
			       ns = s4;
			   else if (B3 == 1)
			       ns = s7;
               else ns = s0;

        s1:    if (B1 == 1)
                   ns = s2;
               else if ((B2 == 1) || (B3 == 1))
			       ns = s8;
               else ns = s1;			   
			   
        s2:    if (B2 == 1)
                   ns = s3;
               else if ((B1 == 1) || (B3 == 1))
			       ns = s9;
               else ns = s2;

        s3:    ns = s0;
			   
        s4:    if (B1 == 1)
                   ns = s5;
               else if ((B2 == 1) || (B3 == 1))
			       ns = s8;
               else ns = s4;			   
			   
        s5:    if (B3 == 1)
                   ns = s6;
               else if ((B1 == 1) || (B2 == 1))
			       ns = s6;
               else ns = s5;

        s6:    ns = s0;
		
        s7:    if ((B1 == 0) && (B2 == 0) && (B3 == 0))
			       ns = s7;
			   else
				   ns = s8;
				   
        s8:    if ((B1 == 0) && (B2 == 0) && (B3 == 0))
			       ns = s8;
			   else
				   ns = s9;	
				   
        s9:    ns = s0;			
			   
	    default: ns = s0;
    endcase
end

    // Output logic
    always_comb begin
        {P2, P1} = 2'b00;  // Default to avoid latches
        case (ps)
            s0: {P2, P1} = 2'b00;
            s1: {P2, P1} = 2'b00;
            s2: {P2, P1} = 2'b00;
            s3: {P2, P1} = 2'b10;
            s4: {P2, P1} = 2'b00;
            s5: {P2, P1} = 2'b00;
            s6: {P2, P1} = 2'b01;
            s7: {P2, P1} = 2'b00;		
            s8: {P2, P1} = 2'b00;
            s9: {P2, P1} = 2'b00;			
            default: {P2, P1} = 2'b00;
        endcase
    end
    // DFFs
    
    always_ff @(posedge CLK or posedge RST) begin
        if (RST)
            ps <= s0;
        else
            ps <= ns;
    end

endmodule

/*====================================================================*/
// Testbench                                                
/*====================================================================*/ 

module passcode_testbench();
    
	logic CLK, RST, B3, B2, B1, P2, P1;

    passcode dut (.CLK, .RST, .B3, .B2, .B1, .P2, .P1);
    
	parameter CLOCK_PERIOD = 20; // default timescale 1ns/1ns
    initial begin
        CLK <= 0;
        forever #(CLOCK_PERIOD/2) CLK <= ~CLK;
    end
	
	initial begin 
	    RST = 1;
        repeat(2)             
		@(posedge CLK);
	    RST = 0;			
        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b010;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b001;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b100;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b000;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b001;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b001;

        repeat(8)             
		@(posedge CLK);
		{B3, B2, B1} = 3'b010;
	
		$stop;
    end
endmodule