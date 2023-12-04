`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 01:51:27 PM
// Design Name: 
// Module Name: rng
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


module rng(
    input click, //jump
    input frame,
    input clk,
    output reg [7:0] rand
    );
    
    reg [7:0] seed;
    reg [7:0] hold;
    always @(posedge clk)
    seed = seed + 1;
    
    always @(posedge clk) begin
    if (click == 1)
    hold = seed;
    end
    
    always @(posedge frame)
    rand = seed^hold;
        
endmodule
