`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:41:36 PM
// Design Name: 
// Module Name: score_and_wickets
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


module score_and_wickets(
    input clk,reset,delivery, team_sw,inning_over,
    input [3:0] lfsr_out,
    input gameOver,
    input winner,
    output reg [7:0] runs,
    output reg [3:0] wickets,
    output reg [11:0] team1Data, //Stores and updates teaml's runs and wickets when inning_over is 0
    output reg [11:0] team2Data  //Stores and updates team2's runs and wickets when inning_over is 1 
    );
	 
	 localparam single = 16;
	 localparam double = 32;
	 localparam triple = 48;
	 localparam four = 64;
	 localparam six = 96;
	 
	 //Update score after each delivery(bowl) based on cricket rule.
	 always @ (posedge delivery)
	 begin
			   if(~inning_over && ~gameOver && ~team_sw && ~reset) //Increment score of both team 1 and team 2
					begin
					case (lfsr_out) //Pseudorandom number from linear feedback shift register
						0, 1, 2:        team1Data <= team1Data;             // Dot ball
                        3, 4, 5, 6:     team1Data <= team1Data + single;    // Single and wide ball
                        7, 8, 9:        team1Data <= team1Data + double;    // Two runs
                        10:              team1Data <= team1Data + triple;   // Three runs
                        11:              team1Data <= team1Data + four;     // Four runs
                        12:              team1Data <= team1Data + six;      // Six runs
                        13:              team1Data <= team1Data + 1;        // Wide ball
                        14:              team1Data <= team1Data + 1;        // No ball
                        15:              team1Data <= team1Data;
					endcase          
					runs <= team1Data[11:4];   //First 8-bits store information of runs
					wickets <= team1Data[3:0]; //Last 4-bits store information of wickets
				end-
				else if(inning_over && ~gameOver && ~team_sw && ~reset) //Increment score of team 2
						begin
						case (lfsr_out) //Pseudorandom number from linear feedback shift register
							0, 1, 2:        team1Data <= team1Data;             // Dot ball
							3, 4, 5, 6:     team1Data <= team1Data + single;    // Single and wide ball
							7, 8, 9:        team1Data <= team1Data + double;    // Two runs
							10:              team1Data <= team1Data + triple;   // Three runs
							11:              team1Data <= team1Data + four;     // Four runs
							12:              team1Data <= team1Data + six;      // Six runs
							13:              team1Data <= team1Data + 1;        // Wide ball
							14:              team1Data <= team1Data + 1;        // No ball
							15:              team1Data <= team1Data;	  //Wicket
						endcase
						runs <= team2Data[11:4];   //First 8-bits store information of runs
						wickets <= team2Data[3:0]; //Last 4-bits store information of wickets
					end

	        //Re-inititiallize scores if reset
	        if (reset)
			begin
			runs <= 0;
			wickets <= 0;
			team1Data <= 0;
			team2Data <= 0;
			end
	end
endmodule
