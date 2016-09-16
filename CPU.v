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
	output blanck,
	output led1,
	output led2
);

	reg [7:0] rojo = 8'hFF;
	reg [7:0] verd = 8'hFF;
	reg [7:0] azul = 8'hFF;
	
	wire clk_out_VGA;
	assign led2 = ~led1;
	
	// INSTANCIACIÓN EJECUCIÓN_ALUS
	
	
	// INSTANCIACIÓN DIVISOR RELOJ PARA VGA
	divRelojVGA reloj(
		.clk_in(clk),
		.reset(reset),
		.clk_out(led1)
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
		.iCLK(clk),
		.iRST_N(reset));

endmodule
