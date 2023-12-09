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
    wyo, fxo1, fyo1, fxo2, fyo2, reset, frame, collision, crouch
    );
    input reset, frame, crouch;
    input [7:0] wyo;
    input [9:0] fxo1, fyo1, fxo2, fyo2;

    output reg collision;

    always @ (posedge frame) begin
        // I'm sorry this is very cursed
        if (
        (
            ((((fxo1 >= 564) && (fxo1 <= 580)) && ((0+wyo <= fyo1) && (fyo1 <= 16+wyo))) // has the first fireball hit the upright wizard ?
            || (((fxo1 >= 564) && (fxo1 <= 580)) && ((0+wyo <= fyo2) && (fyo2 <= 16+wyo))) // has the second fireball hit the upright wizard ?
            && ~crouch)
        ) 
        || 
        (
            ((((fxo1 >= 564) && (fxo1 <= 580)) && ((0+wyo <= fyo1) && (fyo1 <= 8+wyo))) // has the first fireball hit the crouching wizard ?
            || (((fxo1 >= 564) && (fxo1 <= 580)) && ((0+wyo <= fyo2) && (fyo2 <= 8+wyo))) // has the second fireball hit the crouching wizard ?
            && crouch)
        )
        && 
        ~reset
        ) begin // has reset happened?
            collision = 1;
        end else begin
            collision = 0;
        end
    end
endmodule
