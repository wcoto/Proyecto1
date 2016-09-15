
`include "opcodes.h"

module registerFetch(clk, instruction, vw_regData,vz_regData, rw_regData, rz_regData);

input 			clk;
input[31:0] 	instruction;
output[63:0]   vw_regData;
output[63:0]   vz_regData;
output[31:0]   rw_regData;
output[31:0]   rz_regData;

wire [4:0] vw_regDir;
wire [4:0] vz_regDir;
wire [4:0] rw_regDir;
wire [4:0] rz_regDir;

reg[63:0]   vw_regData;
reg[63:0]   vz_regData;
reg[31:0]   rw_regData;
reg[31:0]   rz_regData;

always @(posedge clk) begin

casez({instruction[14],instruction[31:27]})
	
	{1'b?,`NOOP}:
			begin
			vw_regData<=32'd0;
			vz_regData<=32'd0;
			rw_regData<=32'd0;
			rz_regData<=32'd0;
			end
			
	{1'b?,`ADD}:
			begin
			vw_regData<=32'd0;
			vz_regData<=32'd0;
			rw_regData<=32'd0;
			rz_regData<=32'd0;
			end
			
	{1'b?,`SUB}: 
	      begin

			end
			
	{1'b?,`XOR}:
			begin
		
			end
	
	{1'b?,`AND}:
			begin

			end

			
	{1'b?,`ORR}:
			begin
			
			end
			
	{1'b?,`LDV_I}:
			begin

			end
			
	{1'b?,`LDV_R}:
			begin
	
			end
	
	{1'b?,`STR_I}:
			begin

			end
				
	{1'b?,`STR_R}:
			begin
			end
			
	{1'b?,`MOVS_I}:
			begin

			end
			
	{1'b?,`MOVV_I}:
			begin

			end
	{1'b?,`MOVS_R}:
			begin

			end
			
	{1'b?,`MOVV_R}:
			begin

			end
			
	{1'b0,`SLV}:
			begin

			end
	
	{1'b1,`SLV}:
			begin

			end
			
	{1'b0,`SRV}:
			begin

			end
			
	{1'b1,`SRV}:
			begin

			end
			
	{1'b0,`ROL}:
			begin

			end
			
	{1'b1,`ROL}:
			begin

			end
	{1'b0,`ROR}:
			begin

			end
			
	{1'b1,`ROR}:
			begin
			
			end
	default:
			begin
			vw_regData<=32'd0;
			vz_regData<=32'd0;
			rw_regData<=32'd0;
			rz_regData<=32'd0;
			end
	

	endcase

end



endmodule