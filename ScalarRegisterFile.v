module ScalarRegisterFile #(
parameter  BIT_NUMBER=32,
			  ADDR_NUMBER=5,
		     REGISTER_NUMBER=16
)(
input clk,
input reset,
input enable,
input write_enable,
input [ADDR_NUMBER-1:0] src_addr_1,
input [ADDR_NUMBER-1:0] src_addr_2,
input [ADDR_NUMBER-1:0] dest_addr,
input [BIT_NUMBER-1:0]  write_data,

output reg [BIT_NUMBER-1:0] data_out_1,
output reg [BIT_NUMBER-1:0] data_out_2
);

reg [BIT_NUMBER-1:0] ScalarRegisterFile [0:REGISTER_NUMBER-1];
integer i;

//********* Reset RegisterFile or Write data at clock's negative edge *********************//


always @(negedge clk)
	begin
		if (reset)
			begin
				for(i=0; i < REGISTER_NUMBER; i = i + 1)
					begin
						ScalarRegisterFile[i]= 32'bx;
					end
			end
		else if (write_enable)
			  begin
					ScalarRegisterFile[dest_addr] = write_data;
			  end
	end
		
		
////*********** Reads data at clock's positive edge **************

always @(posedge clk)
	  begin
			data_out_1 = ScalarRegisterFile[src_addr_1];
			data_out_2 = ScalarRegisterFile[src_addr_2];
	  end
	  
endmodule