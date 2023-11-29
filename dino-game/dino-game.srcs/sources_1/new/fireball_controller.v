`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 01:48:57 PM
// Design Name: 
// Module Name: fireball_controller
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


module fireball_controller(
    clk,
    fxo, fyo, // fireball x & y offsets
    );
    // I/O
    input clk;
    output reg [7:0] fxo, fyo;
    
    // Vars
    reg [20:0] c1;
    reg [9:0] c2;
    
    // Init
    initial begin 
        c1 = 0;
        c2 = 0;
        fxo = 0; 
        fyo = 0;
    end
    
    // Main logic
    always @(posedge clk) begin 
        if (c1 == 1666667) begin // this updates 60 times per second
            // for now lets send 1 fireball every (640pixels/120 pixels/s) ~5.5s
            if (c2 == 700) begin
                fxo = c2;
                c2 = 0;
            end
            c2 = c2 + 2;
            c1 = 0;
        end
        c1 = c1 + 1;
    end    
endmodule









