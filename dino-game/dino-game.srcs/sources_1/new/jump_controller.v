`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 12:48:33 PM
// Design Name: 
// Module Name: jump_controller
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


module jump_controller(
    input up, frame, collision, reset,
    output reg [7:0] y_offset
    );
    // first we gotta sync up the 100MHz clock to 60fps
    reg direction, jumping; // 0 going up, 1 going down
    reg [7:0] y_offset_prev;
    
    // init
    initial begin
        y_offset = 0;
        jumping = 0;
        direction = 0;
    end
    
    // jump logic.
    always @(posedge frame) begin
        if (up) begin 
            jumping = 1;
        end
        // jump animation
        if (jumping && ~collision) begin
            if (!direction) begin // going up 
                if (y_offset < 42) begin
                    y_offset = y_offset + 3;
                end else begin
                    direction = !direction;
                end
            end else begin // going down
                if (y_offset > 0) begin
                    y_offset = y_offset - 2;
                end else begin
                    direction = !direction;
                    jumping = 0;
                end
            end
        end
    end
endmodule
