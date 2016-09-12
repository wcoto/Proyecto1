
`include "opcodes.h"
`include "aluOps.h"
`include "intUOps.h"
`include "memOps.h"

//Instruction decode
module decode(clk, instruction, imm, aluOp, memOp, intUOp,
              vk_reg, v_operand, rk_reg, decoVOp_sel, ExRes_sel);
 
input		      clk;				//clk signal
input [31:0]   instruction;	//instruction input
output[18:0]   imm;				//immediate
output[3:0]	   aluOp;			//alu operation
output[2:0]		memOp;			//memory operation
output[1:0]		intUOp;			//int unit operation
output[3:0]		vk_reg;			//vk register target
output[63:0]	v_operand;		//vector operand A
output[3:0]		rk_reg;			//scalar register target
output			decoVOp_sel;	//mux select signal for'A' vector target  output
output	      ExRes_sel;		//mux select signal for excecution output between intUnit and ALU array



wire[18:0]   imm;
wire[3:0]	   aluOp;
reg[2:0]		memOp;
reg[1:0]		intUOp;
reg[3:0]		vk_reg;
reg[3:0]		rk_reg;
reg[63:0]	v_operand;
reg			decoVOp_sel;
reg			ExRes_sel;




always @(posedge clk) begin
	
	
	
	casez({instruction[14],instruction[31:27]})
	
	{1'b?,`NOOP}:
			begin
			aluOp=`aluNoop;
			memOp=`memNoop;
			intUOp=`intUNoop;
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b?,`ADD}:
			begin
			aluOp=`aluAdd;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b?,`SUB}: 
	      begin
			aluOp=`aluSub;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b?,`XOR}:
			begin
			aluOp=`aluXor;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
	
	{1'b?,`AND}:
			begin
			aluOp=`aluAnd;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end

			
	{1'b?,`ORR}:
			begin
			aluOp=`aluAdd;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b?,`LDV_I}:
			begin
			aluOp=`aluNoop;
			memOp=`ldv_i;
			intUOp=`intUAddExt;
			ExRes_sel=1'b1;
			vk_reg=instruction[26:23];
			imm=instruction[18-0];
			end
			
	{1'b?,`LDV_R}:
			begin
			aluOp=`aluNoop;
			memOp=`ldv_r;
			intUOp=`intUAdd;
			ExRes_sel=1'b1;
			vk_reg=instruction[26:23];
			rk_reg=instruction[22:19];
			imm=instruction[18-0];			
			end
	
	{1'b?,`STR_I}:
			begin
			aluOp=`aluNoop;
			memOp=`strv_i;
			intUOp=`intUAddExt;
			ExRes_sel=1'b1;
			vk_reg=instruction[26:23];
			imm=instruction[18-0];
			end
				
	{1'b?,`STR_R}:
			begin
			aluOp=`aluNoop;
			memOp=`strv_r;
			intUOp=`intUAdd;
			ExRes_sel=1'b1;
			vk_reg=instruction[26:23];
			rk_reg=instruction[22:19];
			imm=instruction[18-0];	
			end
			
	{1'b?,`MOVS}:
			begin
			aluOp=`aluNoop;
			memOp=`memNoop;
			intUOp=`intUMov;
			ExRes_sel=1'b1;
			rk_reg=instruction[22:19];
			imm=instruction[18:0];
			end
			
	{1'b?,`MOVV}:
			begin
			aluOp=`aluMov;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			ExRes_sel=1'b0;
			decoVOp_sel=1'b1;
			v_operand={8{instruction[7:0]}};
			end
			
	{1'b0,`SLV}:
			begin
			aluOp=`aluSL;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
	
	{1'b1,`SLV}:
			begin
			aluOp=`aluSL;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b1;
			ExRes_sel=1'b0;
			v_operand={8{instruction[7:0]}};
			end
			
	{1'b0,`SRV}:
			begin
			aluOp=`aluSR;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b1,`SRV}:
			begin
			aluOp=`aluSR;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b1;
			ExRes_sel=1'b0;
			v_operand={8{instruction[7:0]}};
			end
			
	{1'b0,`ROL}:
			begin
			aluOp=`aluRotL;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b1,`ROL}:
			begin
			aluOp=`aluRotL;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b1;
			ExRes_sel=1'b0;
			v_operand={8{instruction[7:0]}};
			end
	{1'b0,`ROR}:
			begin
			aluOp=`aluRotR;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
			
	{1'b1,`ROR}:
			begin
			aluOp=`aluRotR;
			memOp=`memNoop;
			intUOp=`intUNoop;
			vk_reg=instruction[26:23];
			decoVOp_sel=1'b1;
			ExRes_sel=1'b0;
			v_operand={8{instruction[7:0]}};
			end
	default:
			begin
			aluOp=`aluNoop;
			memOp=`memNoop;
			intUOp=`intUNoop;
			decoVOp_sel=1'b0;
			ExRes_sel=1'b0;
			end
	

	endcase

end


endmodule