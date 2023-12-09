`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 08:02:27 PM
// Design Name: 
// Module Name: fireball_controller_tb
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


module fireball_controller_tb(

    );
    reg frame,click, reset;
    wire [9:0] fxo1, fyo1,fxo2,fyo2;
    wire [7:0] rand;
    wire collision;
    reg [7:0] wyo; 
    
    rng rng(.click(click),.frame(frame),.clk(frame),.rand(rand));
    fireball_controller fbc(.frame(frame),.rand(rand),.fxo1(fxo1),.fyo1(fyo1),.fxo2(fxo2),.fyo2(fyo2),.collision(collision),.reset(reset));
    collision_controller cc0(.fxo1(fxo1), .fyo1(fyo1), .fxo2(fxo2), .fyo2(fyo2), .wyo(wyo), .reset(reset), .frame(frame), .collision(collision));


    initial begin 
        wyo = 0;
        frame = 0;
        click = 0;
        reset = 0;
    end
    always #1 frame = ~frame;
endmodule
