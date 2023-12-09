`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 08:51:01 PM
// Design Name: 
// Module Name: collision_controller_tb
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


module collision_controller_tb();
    reg [9:0] fxo1, fyo1, fxo2, fyo2;
    reg [7:0] wyo;
    reg reset, frame;
    wire collision;
    
    collision_controller cc0(.fxo1(fxo1), .fyo1(fyo1), .fxo2(fxo2), .fyo2(fyo2), .wyo(wyo), .reset(reset), .frame(frame), .collision(collision));

    initial begin 
        fxo1 = 0;
        fyo1 = 0;
        fxo2 = 0; 
        fyo2 = 0;
        wyo = 0;
        reset = 0;
        frame = 0;
    end
    always #1 frame = ~frame;
    initial begin
        #10;
        fxo1 = 590;
        fyo1 = 0;
        fxo2 = 0; 
        fyo2 = 0;
        wyo = 20;
        reset = 0;
        #10;
        fxo1 = 590;
        fyo1 = 0;
        fxo2 = 0; 
        fyo2 = 0;
        wyo = 0;
        reset = 0;
        #10;
        fxo1 = 590;
        fyo1 = 0;
        fxo2 = 0; 
        fyo2 = 0;
        wyo = 0;
        reset = 1;
        #10;
        fxo1 = 0;
        fyo1 = 0;
        fxo2 = 590; 
        fyo2 = 0;
        wyo = 0;
        reset = 0;
        #10;
        fxo1 = 0;
        fyo1 = 0;
        fxo2 = 200; 
        fyo2 = 0;
        wyo = 0;
        reset = 0;
        #10;
        fxo1 = 0;
        fyo1 = 0;
        fxo2 = 590; 
        fyo2 = 0;
        wyo = 20;
        reset = 0;
    end
endmodule
