`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 11:16:35 AM
// Design Name: 
// Module Name: keyvboard_top
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


module keyboard_top(
    input clk,
    input PS2_CLK,
    input PS2_DATA,
    output reg [2:0] keyout
    );
    
        
reg CLK50MHZ=0;    
reg [3:0] state;
wire [31:0]keycode;

always @(posedge(clk))begin
    CLK50MHZ<=~CLK50MHZ;
end

PS2Receiver keyboard (
.clk(CLK50MHZ),
.kclk(PS2_CLK),
.kdata(PS2_DATA),
.keycodeout(keycode[31:0])
);

wire [7:0] key = keycode[7:0];
//29 is space (jump), 12 is shift (crouch)

initial begin
state = 4'b0001;
end

always @(posedge clk) begin
    if (key == 8'h29 & state[4] == 0) 
    state = 4'b0100;
    if (key == 8'h12 & state[4] == 0)
    state = 4'b0010;
    if (key == 8'hF0 & state [4] == 0)
    state = 4'b1001;
    if (state[4] == 1)
    state = 4'b0001;    
    keyout = state[2:0];
end

endmodule
