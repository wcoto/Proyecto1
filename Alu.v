module ALU

#(
	// Parameter Declarations
	parameter BITS  = 8,
	parameter ALUOP = 4
)(
	// Input Ports
	input [ALUOP-1:0]     aluFunction,
	input [BITS -1:0]     vectorA,
	input [BITS -1:0]     vectorB,
	input                 inputCarry,

	// Output Ports
	output                overflow,
	output                zero,
	output                outputCarry,
	output reg [BITS-1:0] aluResult
);

	// Registro con una posición extra que verifica si hubo carry
	reg [BITS:0] auxCarry;

			always@(*)
				begin
					case(aluFunction)
						4'd1:
							begin : Add
								auxCarry = vectorA + vectorB;
								aluResult = vectorA + vectorB;
							end
						4'd2:
							begin : Subtract
								if(inputCarry)
									begin
										auxCarry = {{1'b1},{vectorA}};
									end
								else
									begin
										auxCarry = vectorA;
									end
								aluResult = auxCarry - vectorB;
							end
						4'd3:
							begin : XOR
								aluResult = vectorA ^ vectorB;
							end
						4'd4:
							begin : And
								aluResult = vectorA && vectorB;
							end
						4'd5:
							begin : Or
								aluResult = vectorA || vectorB;
							end
						4'd6:
							begin : Move_Scalar
								aluResult = 8'hFF;
							end
						4'd7:
							begin : Move_Scalar_to_Register
								aluResult = 8'hFF;
							end
						4'd8:
							begin : Shift_Left
								aluResult = vectorA << vectorB;
							end
						4'd9: 
							begin : Shift_Right
								aluResult = vectorA >> vectorB;
							end
						4'd10:
							begin : Rotate_Right
								case(vectorB)
									5'd1:
										begin : Rotacion_1Bit
											aluResult = {{vectorA[0]},{vectorA[7:1]}};
										end
									5'd2:
										begin : Rotacion_2Bit
											aluResult = {{vectorA[1:0]},{vectorA[7:2]}};
										end
									5'd3:
										begin : Rotacion_3Bit
											aluResult = {{vectorA[2:0]},{vectorA[7:3]}};
										end
									5'd4:
										begin : Rotacion_4Bit
											aluResult = {{vectorA[3:0]},{vectorA[7:4]}};
										end
									5'd5:
										begin : Rotacion_5Bit
											aluResult = {{vectorA[4:0]},{vectorA[7:5]}};
										end
									5'd6:
										begin : Rotacion_6Bit
											aluResult = {{vectorA[5:0]},{vectorA[7:6]}};
										end
									5'd7:
										begin : Rotacion_7Bit
											aluResult = {{vectorA[6:0]},{vectorA[7]}};
										end
									default :
										begin : Rotacion_0Bit
											aluResult = vectorA;
										end
								endcase  
							end
						4'd11:
							begin : Rotate_Left
								case(vectorB)
									5'd1:
										begin : Rotacion_1Bit
											aluResult = {{vectorA[7:1]},{vectorA[0]}};
										end
									5'd2:
										begin : Rotacion_2Bit
											aluResult = {{vectorA[7:2]},{vectorA[1:0]}};
										end
									5'd3:
										begin : Rotacion_3Bit
											aluResult = {{vectorA[7:3]},{vectorA[2:0]}};
										end
									5'd4:
										begin : Rotacion_4Bit
											aluResult = {{vectorA[7:4]},{vectorA[3:0]}};
										end
									5'd5:
										begin : Rotacion_5Bit
											aluResult = {{vectorA[7:5]},{vectorA[4:0]}};
										end
									5'd6:
										begin : Rotacion_6Bit
											aluResult = {{vectorA[7:6]},{vectorA[5:0]}};
										end
									5'd7:
										begin : Rotacion_7Bit
											aluResult = {{vectorA[7]},{vectorA[6:0]}};
										end
									default:
										begin : Rotacion_0Bit
											aluResult = vectorA;
										end
								endcase  
							end
						default:
							begin : No_function
								aluResult = 8'hX;
							end
					endcase
				end
				
			assign outputCarry = ((aluFunction == 4'd1) & (auxCarry[BITS] == 1'b1));		    
			
			assign overflow = ((vectorA[BITS-1] == 1'b1 & vectorB[BITS-1] == 1'b1 & aluResult[BITS-1] == 1'b0)
   								|(vectorA[BITS-1] == 1'b0 & vectorB[BITS-1] == 1'b0 & aluResult[BITS-1] == 1'b1)) ? 1:0;
			assign zero     = (aluResult == 0) ? 1: 0;


endmodule
