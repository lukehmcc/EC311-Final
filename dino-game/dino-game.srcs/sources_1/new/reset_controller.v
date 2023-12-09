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
    gs_in, up, frame,
    gs_out, reset
    );
    // gs == game state, if gs == 1 then death has occured
    input gs_in, up, frame;
    output reg gs_out, reset;

    initial begin
        gs_out = 0;
        reset = 0;
    end

    always @ (posedge frame) begin
        if (gs_in == 1 && up) begin
            gs_out = 0;
            reset = 1;
        end else begin 
            gs_out = gs_in;
            reset = 0;
        end
    end

endmodule
