module divRelojVGA
#(
	// Parameter Declarations
	parameter VALUE = 5 //416666   // Value = clk_in/clk_out
)

(
	// Input Ports
	input clk_in,
	input reset,

	// Output Ports
	output clk_out
);
	// CLK_OUT = CLK_IN/BITS_SIZE
	localparam BITS_SIZE = $clog2(VALUE); 

	reg [BITS_SIZE-1:0] divCounter = 0;
	
	always@(posedge clk_in or posedge reset)
		begin
			if(reset)
				divCounter <= 0;
			else if(divCounter == (VALUE - 1))
				divCounter <= 0;
			else
				divCounter <= divCounter + 1;
		end
	
	assign clk_out =  divCounter[BITS_SIZE-1];
	
endmodule