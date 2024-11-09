`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:45:42 PM
// Design Name: 
// Module Name: three_bit_counter
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


module three_bit_counter(
	 input clk,         // input clock 
	 output reg [2:0] Q // 3-bit register
    );
    
	 //On each positive edge of the input clock, count up from 0 to 7, and wrap around from 7 back to 0
	 always @ (posedge clk)	begin
	 Q <= Q + 1'b1; 
	 end 
endmodule
