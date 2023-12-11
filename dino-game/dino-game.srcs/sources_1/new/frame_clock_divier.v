`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 05:54:59 PM
// Design Name: 
// Module Name: frame_clock_divier
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


module frame_clock_divier(
    clk, fclk
    );
    input clk;
    output reg fclk;

    reg [20:0] c1;

    initial begin
        c1 = 0;
        fclk = 0;
    end
    
    always @(posedge clk) begin
        c1 = c1 + 1;
        if (c1 == 1666667) begin
            fclk = ~fclk;
            c1 = 0;
        end
    end
endmodule
