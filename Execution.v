module Execution

#(
	// Parameter Declarations
	parameter BITS_ALUOP = 4,
	parameter BITS_ARRAY  = 64,
	parameter BITS_DATA   = 8
)(
	// Input Ports
	input [BITS_ALUOP-1:0] opCode,
	input [BITS_ARRAY-1:0]  arrayA,
	input [BITS_ARRAY-1:0]  arrayB,
	input [BITS_DATA-1:0]   auxCarry,

	// Output Ports>,
	output [BITS_DATA-1:0]  carryTotal,
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
	wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8;

	// ALU Instantiation
	ALU inst_ALU1(
		.aluFunction(opCode),
		.vectorA(arrayA[7:0]),
		.vectorB(arrayB[7:0]),
		.inputCarry(auxCarry[7]),
		.outputCarry(carry1),
		.aluResult(alu1));

	ALU inst_ALU2(
		.aluFunction(opCode),
		.vectorA(arrayA[15:8]),
		.vectorB(arrayB[15:8]),
		.inputCarry(auxCarry[6]),
		.outputCarry(carry2),
		.aluResult(alu2));
		
		ALU inst_ALU4(
		.aluFunction(opCode),
		.vectorA(arrayA[23:16]),
		.vectorB(arrayB[23:16]),
		.inputCarry(auxCarry[5]),
		.outputCarry(carry3),
		.aluResult(alu3));

	ALU inst_ALU3(
		.aluFunction(opCode),
		.vectorA(arrayA[31:24]),
		.vectorB(arrayB[31:24]),
		.inputCarry(auxCarry[4]),
		.outputCarry(carry4),
		.aluResult(alu4));

	ALU inst_ALU5(
		.aluFunction(opCode),
		.vectorA(arrayA[39:32]),
		.vectorB(arrayB[39:32]),
		.inputCarry(auxCarry[3]),
		.outputCarry(carry5),
		.aluResult(alu5));

	ALU inst_ALU6(
		.aluFunction(opCode),
		.vectorA(arrayA[47:40]),
		.vectorB(arrayB[47:40]),
		.inputCarry(auxCarry[2]),
		.outputCarry(carry6),
		.aluResult(alu6));

	ALU inst_ALU7(
		.aluFunction(opCode),
		.vectorA(arrayA[55:48]),
		.vectorB(arrayB[55:48]),
		.inputCarry(auxCarry[1]),
		.outputCarry(carry7),
		.aluResult(alu7));

	ALU inst_ALU8(
		.aluFunction(opCode),
		.vectorA(arrayA[63:56]),
		.vectorB(arrayB[63:56]),
		.inputCarry(auxCarry[0]),
		.outputCarry(carry8),
		.aluResult(alu8));

		assign executionResult = {alu8, alu7, alu6, alu5, alu4, alu3, alu2, alu1};
		assign carryTotal      = {carry8, carry7, carry6, carry5, carry4, carry3, carry2, carry1};
endmodule
