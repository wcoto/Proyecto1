


module decoder(clk, instruction, imm, aluOp, memOp, intUOp, vk_regDir, v_operand, rk_regDir, vw_regData,vz_regData, rw_regData, rz_regData, wbOp, aluOperand_sel);


input 			clk;
input[31:0] 	instruction;
output[31:0]   vw_regData;
output[31:0]   vz_regData;
output[31:0]   rw_regData;
output[31:0]   rz_regData;
output[18:0]   imm;				//immediate
output[3:0]	   aluOp;			//alu operation
output[2:0]		memOp;			//memory operation
output[1:0]		intUOp;			//int unit operation
output[3:0]		vk_regDir;		//vk register target dir
output[63:0]	v_operand;		//vector operand data
output[3:0]		rk_regDir;		//scalar register target dir
output[2:0]		wbOp;			//write back enable
output			aluOperand_sel;



wire[31:0]   vw_regData_w;
wire[31:0]   vz_regData_w;
wire[31:0]   rw_regData_w;
wire[31:0]   rz_regData_w;
wire[18:0]   imm_w;				//immediate
wire[3:0]	 aluOp_w;			//alu operation
wire[2:0]	 memOp_w;			//memory operation
wire[1:0]	 intUOp_w;			//int unit operation
wire[3:0]	 vk_regDir_w;		//vk register target dir
wire[63:0]	 v_operand_w;		//vector operand data
wire[3:0]	 rk_regDir_w;		//scalar register target dir
wire[2:0]	 wbOp_w;				//write back enable
wire			 aluOperand_sel_w;


decodeUnit decode(clk, instruction, imm_w, aluOp_w, memOp_w, intUOp_w, vk_regDir_w, v_operand_w, rk_regDir_w, wbOp_w);


registerFetch regFetchUnit(clk, instruction, vw_regData_w, vz_regData_w, rw_regData_w, rz_regData_w);



always @(posedge clk) begin


	vw_regData=vw_regData_w;
	vz_regData=vz_regData_w;
	rw_regData=rw_regData_w;
	rz_regData=rz_regData_w;
	imm=imm_w;
	aluOp=aluOp_w;
	memOp=memOp_w;
	intUOp=intUOp_w;
	vk_regDir=vk_regDir_w;
	v_operand=v_operand_w;
	rk_regDir=rk_regDir_w;
	wbOp=wbOp_w;
	aluOperand_sel=aluOperand_sel_w;

end


endmodule