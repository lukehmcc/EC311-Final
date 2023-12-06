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
    reg frame,click;
    wire [9:0] fxo1, fyo1,fxo2,fyo2;
    wire [7:0] rand;
    
    rng rng(.click(click),.frame(frame),.clk(frame),.rand(rand));
    fireball_controller fbc(.frame(frame),.rand(rand),.fxo1(fxo1),.fyo1(fyo1),.fxo2(fxo2),.fyo2(fyo2));

    initial begin 
    frame = 0;
    click = 0;
    end
    always #1 frame = ~frame;
    
   
    
    
    

    
    
endmodule
