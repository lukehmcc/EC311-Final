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
    reg gs_in, up, frame;
    wire gs_out, reset;
    
    reset_controller rc0(.gs_in(gs_in), .up(up), .frame(frame), .gs_out(gs_out), .reset(reset));

    initial begin 
        gs_in = 0;
        up = 0;
        frame = 0;
    end
    always #1 frame = ~frame;
    initial begin
        gs_in = 0;
        up = 0; 
        #10;
        gs_in = 0;
        up = 1; 
        #10;
        gs_in = 1;
        up = 0; 
        #10;
        gs_in = 1;
        up = 1; 
    end
endmodule
