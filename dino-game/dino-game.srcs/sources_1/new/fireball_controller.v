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
    input frame,
    output reg [7:0] fxo, fyo // fireball x & y offsets
    );    
    // Vars
    reg [9:0] c1;
    
    // Init
    initial begin 
        c1 = 0;
        fxo = 0; 
        fyo = 0;
    end
    
    // Main logic
    always @(posedge frame) begin 
            if (c1 == 700) begin
                fxo = c1;
                c1 = 0;
            end
            c1 = c1 + 2;
        end    
endmodule









