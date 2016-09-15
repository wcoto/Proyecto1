module demux

#(
	// Parameter Declarations
	parameter BITS_SIZE = 64
)

(
	// Input Ports
	input [BITS_SIZE-1:0] inputVector,
	input aluOpSel,
	// Output Ports
	output reg [BITS_SIZE-1:0] outputVector1,
	output reg [BITS_SIZE-1:0] outputVector2
);

	always@(*)
		begin
			if(aluOpSel)
				begin
					outputVector1 = inputVector;
					outputVector2 = 64'bz;
				end
			else
				begin
					outputVector1 = 64'bz;
					outputVector2 = inputVector;
				end
		end

endmodule
