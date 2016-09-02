module ALU

#(
	// Parameter Declarations
	parameter BITS = 8,
	parameter OPCODE = 5
)(
	// Input Ports
	input [OPCODE-1:0] aluFunction,
	input [BITS-1:0]   vectorA,
	input [BITS-1:0]   vectorB,

	// Output Ports
	//output zero,
	//output overflow,
	output reg [BITS-1:0] aluResult
);

	reg [BITS-1:0] aux;
	integer i;

			always@(*)
				begin
					case(aluFunction)
						5'd0:
							begin : Add
								aluResult = vectorA + vectorB;
							end
						5'd1:
							begin : Subtract
								aluResult = vectorA - vectorB;
							end
						5'd2:
							begin : XOR
								aluResult = vectorA ^ vectorB;
							end
						5'd3:
							begin : And
								aluResult = vectorA && vectorB;
							end
						5'd4:
							begin : Or
								aluResult = vectorA || vectorB;
							end
						5'd11:
							begin : Shift_Left
								aluResult = vectorA << vectorB;
							end
						5'd12:
							begin : Shift_Right
								aluResult = vectorA >> vectorB;
							end
						default:
							begin : No_function
								aluResult = 8'hX;
							end
					endcase
				end

/*
			assign overflow = ((vectorA[BITS-1] == 1'b1 & vectorB[BITS-1] == 1'b1 & aluResult[BITS-1] == 1'b0)
								|(vectorA[BITS-1] == 1'b0 & vectorB[BITS-1] == 1'b0 & aluResult[BITS-1] == 1'b1)) ? 1:0;
			assign zero     = (aluResult == 0) ? 1: 0;
*/

endmodule
