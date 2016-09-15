

module iMem(clk, address, instruction);

input		   	clk;
input[31:0]    address;
output[31:0]	instruction;


reg[31:0]	instruction;
reg[31:0]	memoryAddress;
reg[31:0]	iMem[0:1024];


initial
			$readmemb("iMem.mem", iMem);
			
			
always @(posedge clk) begin
		memoryAddress<=address;
		instruction<=iMem[memoryAddress];
end

endmodule