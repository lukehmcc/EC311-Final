`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 08:44:01 PM
// Design Name: 
// Module Name: reset_controller
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


module reset_controller(
    up, frame, collision,
    reset
    );
    input collision, up, frame;
    output reg reset;

    initial begin
        reset = 0;
    end

    always @ (posedge frame) begin
        if (collision && up) begin 
            reset = 1;
        end else begin
            reset = 0;
        end
    end

endmodule
