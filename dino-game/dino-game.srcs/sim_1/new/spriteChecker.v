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
    
    reg [11:0] fireball [0:255];
    integer i;

    initial begin
        // Load the image data into the gameOver register
        $readmemh("fireball.hex", fireball);  

        // Print the contents of the gameOver register
        for (i = 0; i < 256; i = i + 1) begin
            $display("fireball[%0d] = %0h", i, fireball[i]);
        end
    end
endmodule