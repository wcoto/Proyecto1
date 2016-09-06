module ALU

#(
	// Parameter Declarations
	parameter BITS = 8,
	parameter ALUOP = 4
)(
	// Input Ports
	input [ALUOP-1:0] aluFunction,
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
						4'd1:
							begin : Add
								aluResult = vectorA + vectorB;
							end
						4'd2:
							begin : Subtract
								aluResult = vectorA - vectorB;
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
									5'd0:
										begin
											aluResult = vectorA;
										end
									5'd1:
										begin
											aluResult = {{vectorA[0]},{vectorA[7:1]}};
										end
									5'd2:
										begin
											aluResult = {{vectorA[1:0]},{vectorA[7:2]}};
										end
									5'd3:
										begin
											aluResult = {{vectorA[2:0]},{vectorA[7:3]}};
										end
									5'd4:
										begin
											aluResult = {{vectorA[3:0]},{vectorA[7:4]}};
										end
									5'd5:
										begin
											aluResult = {{vectorA[4:0]},{vectorA[7:5]}};
										end
									5'd6:
										begin
											aluResult = {{vectorA[5:0]},{vectorA[7:6]}};
										end
									5'd7:
										begin
											aluResult = {{vectorA[6:0]},{vectorA[7]}};
										end
									default:
										begin
											aluResult = 8'd0;
										end
								endcase  
							end
						4'd11:
							begin : Rotate_Left
								case(vectorB)
									5'd0:
										begin
											aluResult = vectorA;
										end
									5'd1:
										begin
											aluResult = {{vectorA[7:1]},{vectorA[0]}};
										end
									5'd2:
										begin
											aluResult = {{vectorA[7:2]},{vectorA[1:0]}};
										end
									5'd3:
										begin
											aluResult = {{vectorA[7:3]},{vectorA[2:0]}};
										end
									5'd4:
										begin
											aluResult = {{vectorA[7:4]},{vectorA[3:0]}};
										end
									5'd5:
										begin
											aluResult = {{vectorA[7:5]},{vectorA[4:0]}};
										end
									5'd6:
										begin
											aluResult = {{vectorA[7:6]},{vectorA[5:0]}};
										end
									5'd7:
										begin
											aluResult = {{vectorA[7]},{vectorA[6:0]}};
										end
									default:
										begin
											aluResult = 8'd0;
										end
								endcase  
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
