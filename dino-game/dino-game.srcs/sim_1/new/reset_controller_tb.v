`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 08:51:01 PM
// Design Name: 
// Module Name: reset_controller_tb
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


module reset_controller_tb();
    reg collision, up, frame;
    wire reset;
    
    reset_controller rc0(.collision(collision), .up(up), .frame(frame), .reset(reset));

    initial begin 
        up = 0;
        frame = 0;
    end
    always #1 frame = ~frame;
    initial begin
        collision = 0;
        up = 0; 
        #10;
        collision = 0;
        up = 1; 
        #10;
        collision = 1;
        up = 0; 
        #10;
        collision = 1;
        up = 1; 
    end
endmodule
