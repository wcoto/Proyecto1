module divRelojVGA
#(
	// Parameter Declarations
	parameter VALUE = 416666
)

(
	// Input Ports
	input clk_in,

	// Output Ports
	output clk_out
);
	// CLK_OUT = CLK_IN/BITS_SIZE
	localparam BITS_SIZE = $clog2(VALUE); 

	reg [BITS_SIZE-1:0] divCounter = 0;
	
	always@(posedge clk_in)
		begin
			if(divCounter == (VALUE - 1))
				divCounter <= 0;
			else
				divCounter <= divCounter + 1;
		end
	
	assign clk_out =  divCounter[BITS_SIZE-1];
	
endmodule