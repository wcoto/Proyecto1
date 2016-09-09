module Execution

#(
	// Parameter Declarations
	parameter BITS_ALUOP = 4,
	parameter BITS_ARRAY = 64,
	parameter BITS_PIXEL = 8
)(
	// Input Ports
	input [BITS_ALUOP-1:0]  aluOP,
	input [BITS_ARRAY-1:0]  arrayA,
	input [BITS_ARRAY-1:0]  arrayB,

	// Output Ports
	output [BITS_ARRAY-1:0] executionResult
);

	// Conectors
	wire [BITS_PIXEL-1:0] alu1, alu2, alu3, alu4, alu5, alu6, alu7, alu8;

	// ALU Instantiation
	// Instancia ALU 1
	ALU inst_ALU1(
		.aluFunction(aluOP),
		.vectorA(arrayA[7:0]),
		.vectorB(arrayB[7:0]),
		.aluResult(alu1));

// Instancia ALU 2
	ALU inst_ALU2(
		.aluFunction(aluOP),
		.vectorA(arrayA[15:8]),
		.vectorB(arrayB[15:8]),
		.aluResult(alu2));

// Instancia ALU 3
	ALU inst_ALU3(
	.aluFunction(aluOP),
	.vectorA(arrayA[23:16]),
	.vectorB(arrayB[23:16]),
	.aluResult(alu3));

// Instancia ALU 4
	ALU inst_ALU4(
		.aluFunction(aluOP),
		.vectorA(arrayA[31:24]),
		.vectorB(arrayB[31:24]),
		.aluResult(alu4));

// Instancia ALU 5
	ALU inst_ALU5(
		.aluFunction(aluOP),
		.vectorA(arrayA[39:32]),
		.vectorB(arrayB[39:32]),
		.aluResult(alu5));

// Instancia ALU 6
	ALU inst_ALU6(
		.aluFunction(aluOP),
		.vectorA(arrayA[47:40]),
		.vectorB(arrayB[47:40]),
		.aluResult(alu6));

// Instancia ALU 7
	ALU inst_ALU7(
		.aluFunction(aluOP),
		.vectorA(arrayA[55:48]),
		.vectorB(arrayB[55:48]),
		.aluResult(alu7));

// Instancia ALU 8
	ALU inst_ALU8(
		.aluFunction(aluOP),
		.vectorA(arrayA[63:56]),
		.vectorB(arrayB[63:56]),
		.aluResult(alu8));

		assign executionResult = {alu8, alu7, alu6, alu5, alu4, alu3, alu2, alu1};
endmodule
