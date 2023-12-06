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
    input [2:0] rand,
    output reg [9:0] fxo1, fyo1,fxo2, fyo2 // fireball x & y offsets
    );    
    // Vars
    
    // Init
    initial begin 
        fxo1 = 0; 
        fyo1 = 0;
        fxo2 = 0;
        fyo2 = 0;
    end
    
    reg ground = 316;
    
    // Main logic
    always @(posedge frame) begin 
    if (fxo1 == 700)begin 
    fxo1 = 0; fxo2 = 0;
    case (rand) 
    0:begin
    fyo1 = ground; //one at ground
    fyo2 = ground;
    fxo2 = -700;
    end 
    1:begin
    fyo1 = ground; // two at ground small gap
    fyo2 = ground;
    fxo2 = -30;
    end 
    2:begin
    fyo1 = ground + 15; //one elevated
    fyo2 = ground;
    fxo2 = -700;
    end 
    3:begin
    fyo1 = ground; //two, one elevated behind
    fyo2 = ground + 15;
    fxo2 = -20;
    end 
    4:begin
    fyo1 = ground; //two on ground close together 
    fyo2 = ground;
    fxo2 = -15;
    end 
    5:begin
    fyo1 = ground; // two on ground big gap
    fyo2 = ground;
    fxo2 = -45;
    end 
    6:begin
    fyo1 = ground; //two, one above far behind
    fyo2 = ground + 40;
    fxo2 = -40;
    end 
    7:begin
    fyo1 = ground + 15; // two, one above ahead
    fyo2 = ground;
    fxo2 = -30;
    end 
    
    endcase
    
    end

    fxo1 = fxo1 + 2;
    fxo2 = fxo2 + 2;
    end
     
endmodule









