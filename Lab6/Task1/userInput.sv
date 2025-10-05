/*====================================================================*/
//  LAB6 -- Communication Sequential Logic 
//  Device under Test (dut)---userInput                                                   
//  File Name: userInput.sv                                                  
/*====================================================================*/ 
module userInput (CLK, RST, Qin, Qeff);
input logic CLK, RST;
input logic Qin; 
output logic Qeff; 

// State variables
    typedef enum logic [1:0] {
        start, s1, s2
    } state_t;
    state_t ps, ns;

    // Next State logic
always_comb begin
    ns = start; // Default to avoid latches
    case (ps)
        start: if (Qin == 1) ns = s1;
               else ns = start;

        s1:    if (Qin == 1) ns = s2;
               else ns = start;
			   
		s2:    if (Qin == 1) ns = s2;
               else ns = start;
	    default: ns = start;
    endcase
end

    // Output logic
    always_comb begin
        Qeff = 0;  // Default to avoid latches
        case (ps)
            start: Qeff = 0;
            s1:    Qeff = 1;
            s2:    Qeff = 0;
            default: Qeff = 0;
        endcase
    end

    // DFFs
    always_ff @(posedge CLK or posedge RST) begin
        if (RST)
            ps <= start;
        else
            ps <= ns;
    end

endmodule
