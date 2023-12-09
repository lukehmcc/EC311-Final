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
    col_in, up, frame,
    col_out, reset
    );
    // gs == game state, if gs == 1 then death has occured
    input col_in, up, frame;
    output reg col_out, reset;

    initial begin
        col_out = col_in;
        reset = 0;
    end

    always @ (posedge frame) begin
        // if (col_in == 1 && up) begin
        //     col_out = 0;
        //     reset = 1;
        // end else begin 
        //     col_out = col_in;
        //     reset = 0;
        // end
    end

endmodule
