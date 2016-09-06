module vectorRegister (
input [63:0] dataIn,
output reg [63:0] dataOut
    );
	 
	 always @(dataIn)
		begin
			dataOut = dataIn;
		end

		
endmodule
