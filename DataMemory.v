module DataMemory #(
parameter  MEM_SIZE=262144,
			  BIT_NUMBER=32,
		     VECTOR_SIZE=64
)(
input clk,
input enable,
input write_enable,
input [BIT_NUMBER-1:0] address,
input [VECTOR_SIZE-1:0] data_in,
output reg [VECTOR_SIZE-1:0] data_out
);

reg [VECTOR-SIZE:0] DataMemory [0:MEM_SIZE-1];
integer i;
 
always @(posedge clk)
	begin
	if (reset)
			begin
				for(i=0; i < MEM_SIZE; i = i + 1)
					begin
						DataMemory[i]<= 64'bx;
					end
			end
	else if (enable)
		begin
		if (write_enable)
			begin
				DataMemory[address] <= data_in;
			end
		else
		 begin
		 data_out <= DataMemory[address];
		 end
			end






endmodule 