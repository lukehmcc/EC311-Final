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
    output VGA_VS
    );
    
    // randomness, wizard & fireball x & y offsets
    wire [7:0] rand, wyo;
    wire [9:0] fxo1, fyo1, fxo2, fyo2;
    wire idle, up, down, game_state, reset;
    wire frame;
    reg [20:0] c1;
    
    // create a frame clock
    frame_clock_divier fcd0(.clk(in_clk), .fclk(frame));
     
    // mod calls
    rng rng(.clk(in_clk),.frame(frame),.click(up),.rand(rand));
    
    fireball_controller fc0(.frame(frame),.rand(rand), 
    .fxo1(fxo1), .fyo1(fxo1), 
    .fxo2(fxo2), .fyo2(fyo2));
    
    jump_controller jc0(.y_offset(wyo), .in_clk(in_clk), .up(up));
   
    vga_controller vc0(.in_clk(in_clk), .wyo(wyo), 
    .fxo1(fxo1), .fyo1(fxo1),
    .fxo2(fxo2), .fyo2(fyo2),
    .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS));
    
    keyboard_top kt0(.clk(in_clk), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .idle(idle), .up(up), .down(down));
endmodule
