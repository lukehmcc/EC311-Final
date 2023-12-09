`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 08:44:01 PM
// Design Name: 
// Module Name: collision_controller
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


module collision_controller(
    wyo, fxo1, fyo1, fxo2, fyo2, reset, frame, collision
    );
    input reset, frame;
    input [7:0] wyo;
    input [9:0] fxo1, fyo1, fxo2, fyo2;

    output collision;

    // god damned multi-driven net errors have driven me to this
    assign collision = ((fxo1 >= 584 && ((0+wyo <= fyo1) && (fyo1 <= 16+wyo))) || (fxo2 >= 584 && ((0+wyo <= fyo2) && (fyo2 <= 16+wyo)))) ? 1 : 0;
endmodule
