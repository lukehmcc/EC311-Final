`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 05:55:18 PM
// Design Name: 
// Module Name: frame_clock_divider_tb\
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


module frame_clock_divider_tb();
    reg clk; 
    wire fclk;
    
    frame_clock_divier fcd0(.clk(clk), .fclk(fclk));

    initial begin 
        clk = 0;
    end
    always #1 clk = ~clk;
endmodule
