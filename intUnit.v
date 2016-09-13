module intUnit

#(
	// Parameter Declarations
	parameter BITSIMM = 19,
	parameter BITSOUT = 32,
	parameter INTUOP  = 2
)

(
	// Input Ports
	
	input [BITSIMM-1:0] immediate,
	input [BITSOUT-1:0] register,
	input [INTUOP-1:0]  intUOP,

	// Output Ports
	output reg [BITSOUT-1:0] outImmediate
);
	
		always@(*)
			begin
				case(intUOP)
					2'd0:
						begin
							outImmediate = 32'b0;
						end
					2'd1: 
						begin : inmediato_extendido
							outImmediate = {{13'b0},{immediate}};
						end
					2'd2:
						begin : inmediato_plus_registro
							outImmediate = register + {{13'b0},{immediate}};
						end
					default: 
						begin : other_operation
							outImmediate = 32'b0;
						end
				endcase
			end


endmodule
