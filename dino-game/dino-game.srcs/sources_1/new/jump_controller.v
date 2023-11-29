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
    input in_clk,
    output reg [7:0] y_offset
    );
    // first we gotta sync up the 100MHz clock to 60fps
    reg [20:0] c;
    reg direction; // 0 going up, 1 going down
    
    // init
    initial begin
        c = 0;
        y_offset = 0;
    end
    
    // jump logic.
    always @(posedge in_clk) begin
        if (c == 1666667) begin // this updates 60 times per second
            c = 0;
            if (!direction) begin // going up 
                if (y_offset < 30) begin
                    y_offset = y_offset + 1;
                end else begin
                    direction = !direction;
                end
            end else begin // going down
                if (y_offset > 0) begin
                    y_offset = y_offset - 1;
                end else begin
                    direction = !direction;
                end
            end
        end
        c = c + 1;
    end
    
endmodule