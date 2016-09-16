module CPU

#(
	parameter RGB_SIZE = 8
)

(
	// Input Ports
	input clk,
	input reset,

	// Output Ports
	output [RGB_SIZE-1:0] vgaRed,
	output [RGB_SIZE-1:0] vgaGreen,
	output [RGB_SIZE-1:0] vgaBlue,
	output hSync,
	output vSync,
	output sync,
	output blanck
);

	localparam rojo = 8'hFF;
	localparam verd = 8'hFF;
	localparam azul = 8'hFF;
	
	wire clk_out_VGA;
	
	// INSTRANCIACIÓN EJECUCIÓN_ALUS
	Execution alus(
		.aluOp(),
		.arrayA(),
		.arrayB(),
		.executionResult()
	);

	// INSTANCIACIÓN DIVISOR RELOJ PARA VGA
	divRelojVGA reloj(
		.clk_in(clk),
		.reset(reset),
		.clk_out(clk_out_VGA)
	);


	// INSTANCIACIÓN CONTROLADOR VGA
	VGA_Controller vga(
		.iRed(rojo),
		.iGreen(verd),
		.iBlue(azul),
		.oRequest(),
		.oVGA_R(vgaRed),
		.oVGA_G(vgaGreen),
		.oVGA_B(vgaBlue),
		.oVGA_H_SYNC(hSync),
		.oVGA_V_SYNC(vSync),
		.oVGA_SYNC(sync),
		.oVGA_BLANK(blanck),
		.iCLK(clk_out_VGA),
		.iRST_N(reset),
		.iZOOM_MODE_SW());

endmodule
