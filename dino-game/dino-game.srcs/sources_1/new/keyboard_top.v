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
    output idle,
    output up,
    output down
    );
    
        
reg CLK50MHZ=0;    
reg [2:0] state;
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

wire [15:0] key = keycode[15:0];

//29 is space (jump), 12 is shift (crouch)

initial begin
state = 3'b001;
end

always @(key) begin
    if (key[7:0] == 8'h29 & key[15:8] != 8'hF0) 
    state = 4'b100; //up state when space is pressed
    if (key[7:0] == 8'h12 & key[15:8] != 8'hF0)
    state = 4'b010; //down state when shift is pressed
    if (key[15:8] == 8'hF0)
    state = 4'b001; //idle state when a key is released   
end

assign idle = state[0];
assign down = state[1];
assign up = state[2];

endmodule
