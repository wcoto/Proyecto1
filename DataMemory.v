//module DataMemory #(
//parameter  ADDR_WIDTH=32,
//		     VECTOR_SIZE=64
//)(
//input clk,
//input write_enable,
//input [ADDR_WIDTH-1:0] address,
//input [VECTOR_SIZE-1:0] data_in,
//output reg [VECTOR_SIZE-1:0] data_out
//);
//
//reg [VECTOR_SIZE-1:0] DataMemory [2**ADDR_WIDTH-1:0];
// 
//always @(posedge clk)
//	if (enable)
//		begin
//			if (write_enable)
//				begin
//					DataMemory[address] <= data_in;
//					data_out <= data_in;
//				end
//		end
//	else
//		begin
//			data_out <= DataMemory[address];
//		 end
//
//endmodule 

module DataMemory 
#(parameter DATA_WIDTH=64, parameter ADDR_WIDTH=32)
(
	input [(DATA_WIDTH-1):0] data_in,
	input [(ADDR_WIDTH-1):0] addr, addr_2,
	input we, clk,
	output [(DATA_WIDTH-1):0] data_out, data_out2
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variables to hold the registered read addresses
	reg [ADDR_WIDTH-1:0] addr_reg;
	reg [ADDR_WIDTH-1:0] vga_reg;

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data_in;

		addr_reg <= addr;
		vga_reg <= addr_2;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign data_out = ram[addr_reg];
	assign data_out2 = ram[vga_reg];
 
endmodule