module ALU

#(parameter BITS=8,
  parameter FUNC=4)
(
	funcionALU,
	vectorA,
	vectorB,
	zero,
	overflow,
	resultado
);

input [FUNC-1:0] funcionALU;
input [BITS-1:0] vectorA;
input [BITS-1:0] vectorB;
output zero;
output overflow;
output reg [BITS-1:0] resultado;

	always @(*)
		begin
			case(funcionALU)
				0:  resultado = vectorA + vectorB;  // Add
				1:  resultado = vectorA - vectorB;  // Sub
				2:  resultado = vectorA ^ vectorB;  // Xor
				3:  resultado = vectorA & vectorB;  // And
				4:  resultado = vectorA | vectorB;  // Or
				11: resultado = vectorA << vectorB; // SHL
				12: resultado = vectorA >> vectorB; // SHR
			   default: resultado = 8'bx;
			endcase
		end

    assign overflow = ((vectorA[BITS-1] == 1'b1 & vectorB[BITS-1] == 1'b1 & resultado[BITS-1] == 1'b0)
								|(vectorA[BITS-1] == 1'b0 & vectorB[BITS-1] == 1'b0 & resultado[BITS-1] == 1'b1)) ? 1:0;
	 assign zero = (resultado == 0) ? 1: 0;

endmodule
