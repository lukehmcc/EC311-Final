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
        // this is a big conditional
        if (
        (
            (
                (
                    ((fxo1 >= 564) && (fxo1 <= 580)) // fireball 1 is in wizard x range
                    &&  // and
                    ((0+wyo <= 5+fyo1) && (5+fyo1 <= 16+wyo)) // fireball 1 is in wizard (standing) y range
                )
                || // or
                (
                    ((fxo2 >= 564) && (fxo2 <= 580)) // fireball 2 is within wizard x range
                    && // and
                    ((0+wyo <= 5+fyo2) && (5+fyo2 <= 16+wyo)) // fireball 2 is within wizard (standing) y range
                )
                && // and
                ~crouch // wizard is standing
            )
        ) 
        || 
        (
            (
                (
                    ((fxo1 >= 564) && (fxo1 <= 580)) // fireball 1 is in wizard x range
                    &&  // and
                    ((0+wyo <= 5+fyo1) && (5+fyo1 <= 8+wyo)) // fireball 1 is in wizard (crouching) y range
                )
                || // or
                (
                    ((fxo2 >= 564) && (fxo2 <= 580)) // fireball 2 is within wizard x range
                    && // and
                    ((0+wyo <= 5+fyo2) && (5+fyo2 <= 8+wyo)) // fireball 2 is within wizard (crouching) y range
                )
                && // and
                crouch // wizard is crouching
            )
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
