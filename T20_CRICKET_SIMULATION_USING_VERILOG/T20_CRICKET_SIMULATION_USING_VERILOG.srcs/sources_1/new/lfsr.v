`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:38:57 PM
// Design Name: 
// Module Name: lfsr
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


module lfsr(
input clk, rst, ball_sw, game_over, 
output reg [3:0] lfsr_out);
reg [15:0] lfsr_new;  //Register to store the generated 16-bit random number
reg [3:0] lfsr_new_2; //Register to store 4 selected bits from lfsr_new
reg count;

//The numbers will keep generating on every positive internal clock edge irrespective of whether  is pressed or not
  always@(posedge clk||ball_sw)
  begin
    //Initialize registers and outputs
    if(rst || game_over) begin
    lfsr_new <= 16'hffff;
    lfsr_new_2 <= 4'h0000;
    lfsr_out <= 16'h0000;
    count<=0;
    end
    
    //Multiplexing and shifting bits to generate a new random number
    else begin
    lfsr_new <= {lfsr_new[12:1],(lfsr_new[13]^lfsr_new[9]^lfsr_new[1]),(lfsr_new[15]^lfsr_new[12]^lfsr_new[10]),lfsr_new[0]};
    count <= count+1;
    end
    
    //Re-initialize register after 20 and 40 numbers are generated to reduce repetition
    if (count==20) begin
    lfsr_new <= 16'h9263;
    end
    if (count==40) begin
    lfsr_new <= 16'h1374;
    count<=0;
    end
    
    //Selecting and multiplexing from 16-bit register to generate 4-bit number
    lfsr_new_2 <= lfsr_new[3:0]^lfsr_new[8:5];
    
  
    lfsr_out <= lfsr_new_2;
    end
  end
endmodule
