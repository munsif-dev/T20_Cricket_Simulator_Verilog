`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:42:30 PM
// Design Name: 
// Module Name: score_comparator
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


module score_comparator(
    input clk_fpga,
    input reset,
	input [11:0] team1Data, 
	input [11:0] team2Data, 
	input [7:0] team1Balls, 
	input [7:0] team2Balls, 
	input [7:0] balls,
	output reg inningOver, 
	output reg gameOver, 
	output reg winnerLocked);
	 
	 
	 always @ (posedge clk_fpga)	
	 begin 
	     if (reset)
			inningOver <= 0;
		 else if((team1Data[3:0] >= 4'd5) || (team1Balls >= 7'd20))
			inningOver <= 1; //Inning is over and Team 2 will start playing
		 else 
			inningOver <= 0; //Team 1 is playing
	 end	 
	 
	 //If both teams have finished playing, end the game 
	 always @ (posedge clk_fpga)	
	 begin 
		 if (reset)
			gameOver <= 0; 
		 else if(inningOver && (((team2Data[11:4] > team1Data[11:4])) || ((team2Data[3:0] >= 4'd5) || (team2Balls >= 7'd20))))
			gameOver <= 1; 
		 else
			gameOver <= 0; 
	 end
	 
	 //On rising edge of gameOver, lock in the winner 
	 always @ (posedge gameOver)	
	 begin 
		 if (team1Data[11:4] > team2Data[11:4]) //The team with most runs on gameOver wins
			winnerLocked <= 0; //Team 1 wins 
		 else
			winnerLocked <= 1; //Team 2 wins
	 end	 
endmodule
