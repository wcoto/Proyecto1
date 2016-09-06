module Execution

#(
	// Parameter Declarations
	parameter BITS_OPCODE = 4,
	parameter BITS_ARRAY  = 64,
	parameter BITS_DATA   = 8
)(
	// Input Ports
	input [BITS_OPCODE-1:0] opCode,
	input [BITS_ARRAY-1:0]  arrayA,
	input [BITS_ARRAY-1:0]  arrayB,

	// Output Ports>,
	output [BITS_ARRAY-1:0] executionResult
);

	// Conectors
	wire [BITS_DATA-1:0] alu1;
	wire [BITS_DATA-1:0] alu2;
	wire [BITS_DATA-1:0] alu3;
	wire [BITS_DATA-1:0] alu4;
	wire [BITS_DATA-1:0] alu5;
	wire [BITS_DATA-1:0] alu6;
	wire [BITS_DATA-1:0] alu7;
	wire [BITS_DATA-1:0] alu8;

	// ALU Instantiation
	ALU inst_ALU1(
		.aluFunction(opCode),
		.vectorA(arrayA[7:0]),
		.vectorB(arrayB[7:0]),
		.aluResult(alu1));

	ALU inst_ALU2(
		.aluFunction(opCode),
		.vectorA(arrayA[15:8]),
		.vectorB(arrayB[15:8]),
		.aluResult(alu2));
		
		ALU inst_ALU4(
		.aluFunction(opCode),
		.vectorA(arrayA[23:16]),
		.vectorB(arrayB[23:16]),
		.aluResult(alu3));

	ALU inst_ALU3(
		.aluFunction(opCode),
		.vectorA(arrayA[31:24]),
		.vectorB(arrayB[31:24]),
		.aluResult(alu4));

	ALU inst_ALU5(
		.aluFunction(opCode),
		.vectorA(arrayA[39:32]),
		.vectorB(arrayB[39:32]),
		.aluResult(alu5));

	ALU inst_ALU6(
		.aluFunction(opCode),
		.vectorA(arrayA[47:40]),
		.vectorB(arrayB[47:40]),
		.aluResult(alu6));

	ALU inst_ALU7(
		.aluFunction(opCode),
		.vectorA(arrayA[55:48]),
		.vectorB(arrayB[55:48]),
		.aluResult(alu7));

	ALU inst_ALU8(
		.aluFunction(opCode),
		.vectorA(arrayA[63:56]),
		.vectorB(arrayB[63:56]),
		.aluResult(alu8));

		assign executionResult = {alu8, alu7, alu6, alu5, alu4, alu3, alu2, alu1};
endmodule
