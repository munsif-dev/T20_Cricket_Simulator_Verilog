`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:36:54 PM
// Design Name: 
// Module Name: cricket_game_sim
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


module cricket_game_sim(
input clk, rst, ball_sw, team_sw,
output inning_over, game_over, winner,
output [3:0] lfsr_out,
output [7:0] runs,
output [3:0] wickets);


    wire [11:0] t1_data;
    wire [11:0] t2_data;
    wire [7:0] t1_balls;
    wire [7:0] t2_balls;
    wire [7:0] ball_count;

    
    //Generating random numbers from 1 to 8 using lfsr module
    lfsr l1 (clk,rst, ball_sw, game_over, lfsr_out);
    //Generating individual team data consisting of runs and wickets
    score_and_wickets sc1 (clk,rst,ball_sw,team_sw,inning_over, lfsr_out, game_over,winner,runs, wickets, t1_data, t2_data); 
    //Deciding whether inning is over, if game is over and which team is the winner
    score_comparator sc2 (clk, rst, t1_data, t2_data, t1_balls, t2_balls, ball_count, inning_over, game_over, winner);
    //Countng the number of deliveries that are bowled (excluding no balls and wides)
    ball_counter bc1 (clk, rst, ball_sw, team_sw, lfsr_out,inning_over,game_over,winner,ball_count,t1_balls,t2_balls);
    //Controller of seven-segment display
    bcd_control disp1 (clk,rst,ball_sw,team_sw,inning_over,game_over,winner,runs,wickets,ball_count,seg,AN,dp);
    //Scrolling leds for celebration after game is over
    scroll_leds sl1 (clk, game_over, LED);
    //Producing rainbow effect with tri-state leds for celebration after game is over 
    rainbow_leds rl1 (clk,game_over,red,grn,blu);
endmodule
