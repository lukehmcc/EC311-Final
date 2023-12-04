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
    
    // define vars
    wire [7:0] rand, wizard_y_offset, fireball_x_offset, fireball_y_offset;
    wire idle, up, down;
    reg frame;
    reg [20:0] c1;
    
    initial begin
    c1 = 0;
    frame = 0;
    end
    
    always @(posedge in_clk) begin
        c1 = c1 + 1;
        if (c1 == 1666667) begin
            frame = ~frame;
            c1 = 0;
        end
    end
    
    
    
    
    // mod calls
    rng rng(.clk(in_clk),.frame(frame),.click(up),.rand(rand));
    fireball_controller fc0(.frame(frame), .fxo(fireball_x_offset), .fyo(fireball_y_offset));
    jump_controller jc0(.y_offset(wizard_y_offset), .in_clk(in_clk), .up(up));
    vga_controller vc0(.in_clk(in_clk), .wyo(wizard_y_offset), 
    .fxo(fireball_x_offset), .fyo(fireball_y_offset),
    .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS));
    keyboard_top(.clk(in_clk), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .idle(idle), .up(up), .down(down));
    
endmodule
