`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:37:56 PM
// Design Name: 
// Module Name: decoder3to8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder3to8(
	 input [2:0] en, 
	 output reg dp, 
	 output reg [7:0] an
    );
	 
	 //Cycle through the eight anodes using en (output of 3-bit counter) 
	 always@ (en)	begin 
		 case (en) 
		 0: begin
			 an = 8'b11111110; 
			 dp = 1'b1;
			 end 
		 1: begin
			 an = 8'b11111101; 
			 dp = 1'b0; //Turn on the active low decimal point after anode ANI
			 end 
		 2: begin
			 an = 8'b11111011; 
			 dp = 1'b1;
			 end 
		 3: begin
			 an = 8'b11110111; 
			 dp = 1'b1;
			 end 
         4: begin
			 an = 8'b11101111; 
			 dp = 1'b1;
			 end 
		 5: begin
			 an = 8'b11011111; 
			 dp = 1'b1; 
			 end 
		 6: begin
			 an = 8'b10111111; 
			 dp = 1'b0;
			 end 
		 7: begin
			 an = 8'b01111111; 
			 dp = 1'b1;
			 end	
		 endcase 
	 end
endmodule
