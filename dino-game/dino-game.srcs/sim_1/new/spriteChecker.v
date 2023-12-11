`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 06:00:46 PM
// Design Name: 
// Module Name: spriteChecker
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


module spriteChecker(
    );
    
    reg [11:0] gameOver [0:76800];
    integer i;

    initial begin
        // Load the image data into the gameOver register
        $readmemh("X:\\Desktop\\game_over_screen.hex", gameOver);

        // Print the contents of the gameOver register
        for (i = 0; i < 32000; i = i + 1) begin
            $display("gameOver[%0d] = %0h", i, gameOver[i]);
        end
    end
endmodule