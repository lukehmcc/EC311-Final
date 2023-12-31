`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 12:34:04 PM
// Design Name: 
// Module Name: game_controller
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


module game_controller(
    input in_clk,
    input PS2_CLK,
    input PS2_DATA,
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS,
    output up, down, idle
    );
    
    // randomness, wizard & fireball x & y offsets
    wire [7:0] wyo;
    wire [15:0] rand, BCD_score;
    wire [11:0] score;
    wire [9:0] fxo1, fyo1, fxo2, fyo2;
    wire collision, reset;
    wire frame;

    // create a frame clock
    frame_clock_divier fcd0(.clk(in_clk), .fclk(frame));
     
    // gets rng
    rng rng(.clk(in_clk),.frame(frame),.click(up),.rand(rand));
    
    // controlls fireball
    fireball_controller fc0(.frame(frame), .rand(rand[10:8]), .reset(reset),
    .collision(collision),.score(score),.fxo1(fxo1),.fyo1(fyo1), 
    .fxo2(fxo2), .fyo2(fyo2));
    
    // takes keyboard input and defines jump
    jump_controller jc0(.y_offset(wyo), .up(up), .reset(reset),
    .frame(frame), .collision(collision), .jumping(jumping));
    
    //Score counter
    score_count_forVGA sc0(.frame(frame),.reset(reset),.collision(collision),
    .BCD_score(BCD_score),.score(score));
    
    // outputs to the display
    vga_controller vc0(.in_clk(in_clk), .wyo(wyo), .crouch(down), .jump(jumping), .collision(collision),
    .fxo1(fxo1), .fyo1(fyo1),
    .fxo2(fxo2), .fyo2(fyo2),
    .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS),
    .thous(BCD_score[15:12]),.hunds(BCD_score[11:8]),.tens(BCD_score[7:4]),.ones(BCD_score[3:0]));
    
    // cleans keyboard inputs into up and down presses
    keyboard_top kt0(.clk(in_clk), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), 
    .idle(idle), .up(up), .down(down));

    // detects collisions
    collision_controller cc0(.wyo(wyo), .fxo1(fxo1), .fyo1(fyo1), .fxo2(fxo2), 
    .fyo2(fyo2), .reset(reset), .frame(frame), .collision(collision), .crouch(down));

    // defines reset pulse
    reset_controller rc0(.collision(collision), .up(up), .frame(frame), .reset(reset));
    
endmodule
