
`include "opcodes.h"
`include "aluOps.h"
`include "intUOps.h"
`include "memOps.h"
`include "wbOps.h"

//Instruction decode
module decodeUnit(clk, instruction, imm, aluOp, memOp, intUOp,
              vk_regDir, v_operand, rk_regDir, wbOp, aluOperand_sel);
 
input		      clk;				//clk signal
input [31:0]   instruction;	//instruction input
output[18:0]   imm;				//immediate
output[3:0]	   aluOp;			//alu operation
output[2:0]		memOp;			//memory operation
output[1:0]		intUOp;			//int unit operation
output[3:0]		vk_regDir;		//vk register target dir
output[63:0]	v_operand;		//vector operand data
output[3:0]		rk_regDir;		//scalar register target dir
output[1:0]		wbOp;			//write back enable
output			aluOperand_sel;



wire[18:0]  imm;
wire[3:0]	aluOp;
reg[2:0]		memOp;			//memory operation
reg[1:0]		intUOp;			//int unit operation
reg[3:0]		vk_regDir;		//vk register target dir
reg[63:0]	v_operand;		//vector operand data
reg[3:0]		rk_regDir;		//scalar register target dir
reg[1:0]		wbOp;		   	//write back enable
reg			aluOperand_sel;





always @(posedge clk) begin

	casez({instruction[14],instruction[31:27]})
	
	{1'b?,`NOOP}:
			begin
			aluOp<=`aluNoop;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbNoop;
			end
			
	{1'b?,`ADD}:
			begin
			aluOp<=`aluAdd;
			memOp<=`memNoop;
			wbOp<=`wbVk;
			intUOp<=`intUNoop;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b?,`SUB}: 
	      begin
			aluOp<=`aluSub;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b?,`XOR}:
			begin
			aluOp<=`aluXor;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
	
	{1'b?,`AND}:
			begin
			aluOp<=`aluAnd;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end

			
	{1'b?,`ORR}:
			begin
			aluOp<=`aluAdd;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b?,`LDV_I}:
			begin
			aluOp<=`aluNoop;
			memOp<=`ldv_i;
			intUOp<=`intUZext;
			wbOp<=`wbVk;
			vk_regDir<=instruction[26:23];
			imm<=instruction[18-0];
			end
			
	{1'b?,`LDV_R}:
			begin
			aluOp<=`aluNoop;
			memOp<=`ldv_r;
			intUOp<=`intUAdd;
			wbOp<=`wbVk;
			vk_regDir<=instruction[26:23];
			imm<=instruction[18-0];			
			end
	
	{1'b?,`STR_I}:
			begin
			aluOp<=`aluNoop;
			memOp<=`strv_i;
			intUOp<=`intUZext;
			wbOp<=`wbNoop;
			imm<=instruction[18-0];
			end
				
	{1'b?,`STR_R}:
			begin
			aluOp<=`aluNoop;
			memOp<=`strv_r;
			intUOp<=`intUAdd;
			wbOp<=`wbNoop;
			imm<=instruction[18-0];	
			end
			
	{1'b?,`MOVS_I}:
			begin
			aluOp<=`aluNoop;
			memOp<=`memNoop;
			intUOp<=`intUZext;
			wbOp<=`wbRk;
			rk_regDir<=instruction[26:23];
			imm<=instruction[18:0];
			end
			
	{1'b?,`MOVV_I}:
			begin
			aluOp<=`aluMov;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b1;
			vk_regDir<=instruction[26:23];
			v_operand<={8{instruction[7:0]}};
			end
	{1'b?,`MOVS_R}:
			begin
			aluOp<=`aluNoop;
			memOp<=`memNoop;
			intUOp<=`intUAdd;
			wbOp<=`wbRk;
			rk_regDir<=instruction[22:19];
			imm<=instruction[18:0];
			end
			
	{1'b?,`MOVV_R}:
			begin
			aluOp<=`aluMov;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b0,`SLV}:
			begin
			aluOp<=`aluSL;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
	
	{1'b1,`SLV}:
			begin
			aluOp<=`aluSL;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b1;
			vk_regDir<=instruction[26:23];
			v_operand<={8{instruction[7:0]}};
			end
			
	{1'b0,`SRV}:
			begin
			aluOp<=`aluSR;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b1,`SRV}:
			begin
			aluOp<=`aluSR;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b1;
			vk_regDir<=instruction[26:23];
			v_operand<={8{instruction[7:0]}};
			end
			
	{1'b0,`ROL}:
			begin
			aluOp<=`aluRotL;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b1,`ROL}:
			begin
			aluOp<=`aluRotL;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b1;
			vk_regDir<=instruction[26:23];
			v_operand<={8{instruction[7:0]}};
			end
	{1'b0,`ROR}:
			begin
			aluOp<=`aluRotR;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b0;
			vk_regDir<=instruction[26:23];
			end
			
	{1'b1,`ROR}:
			begin
			aluOp<=`aluRotR;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbVk;
			aluOperand_sel<=1'b1;
			vk_regDir<=instruction[26:23];
			v_operand<={8{instruction[7:0]}};
			end
	default:
			begin
			aluOp<=`aluNoop;
			memOp<=`memNoop;
			intUOp<=`intUNoop;
			wbOp<=`wbNoop;
			end
	

	endcase

end


endmodule