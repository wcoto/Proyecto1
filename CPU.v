module CPU

#(
	parameter RGB_SIZE = 8
)

(
	// Input Ports
	input clk,

	// Output Ports
	output [RGB_SIZE-1:0] vgaRed,
	output [RGB_SIZE-1:0] vgaGreen,
	output [RGB_SIZE-1:0] vgaBlue,
	output hSync,
	output vSync,
	output sync,
	output blanck
);


	VGA_Controller vga(
		.iRed(),
		.iGreen(),
		.iBlue(),
		.oRequest(),
		.oVGA_R(vgaRed),
		.oVGA_G(vgaGreen),
		.oVGA_B(vgaBlue),
		.oVGA_H_SYNC(hSync),
		.oVGA_V_SYNC(vSync),
		.oVGA_SYNC(sync),
		.oVGA_BLANK(blanck),
		.iCLK(),
		.iRST_N(),
		.iZOOM_MODE_SW());

endmodule
