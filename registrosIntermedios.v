module registrosIntermedios

#(
	// Parameter Declarations
	parameter SIZE = 64
)

(
	// Input Ports
	input [SIZE-1:0] inputData,
	input clk,

	// Output Ports
	output reg [SIZE-1:0] outputData
);

	// Module Item(s)
	
	always@(posedge clk)
		begin
			outputData <= inputData;
		end
	

endmodule
