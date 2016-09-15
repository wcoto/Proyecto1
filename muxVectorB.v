module muxVectorB

#(
	// Parameter Declarations
	parameter BITS_SIZE = 64
)

(
	// Input Ports
	input [BITS_SIZE-1:0] inputRegister,
	input [BITS_SIZE-1:0] vOperand,
	input aluOpSel,
	// Output Ports
	output reg [BITS_SIZE-1:0] aluVectorB
);

	always@(*)
		begin
			if(aluOpSel)
				aluVectorB = inputRegister;
			else
				aluVectorB = vOperand;
		end	

endmodule
