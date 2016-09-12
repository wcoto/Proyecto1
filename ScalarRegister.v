module scalarRegister (
input [31:0] dataIn,
output reg [31:0] dataOut
    );
	 
	 always @(dataIn)
		begin
			dataOut = dataIn;
		end

		
endmodule
