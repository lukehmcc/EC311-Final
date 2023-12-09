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

    output reg collision;

    initial begin
        collision = 0;
    end

    always @ (posedge frame) begin
        // reset if there's a reset
        if (reset) begin
            collision = 0;
        end else if ((fxo1 >= 624 && 0+wyo <= fyo1 <= 16+wyo) || (fxo2 >= 624 && 0+wyo <= fyo2 <= 16+wyo)) begin
            collision = 1;
        end else begin
            collision = 0;
        end
    end

endmodule
