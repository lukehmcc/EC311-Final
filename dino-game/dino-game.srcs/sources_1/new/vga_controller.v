`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 06:21:12 PM
// Design Name: 
// Module Name: vga
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


module vga_controller(
    input in_clk, crouch, jump, collision,
    input [7:0] wyo, 
    input [9:0] fxo1, fyo1,fxo2, fyo2, // wizard y offset, fireball x & y offset
    input [15:0] BCD_score,
    input [3:0] ones,tens,hunds,thous,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS
    );
    
    Clock_divider CD(in_clk, clock);
    
    reg [31:0] count, vertical_count;
    reg [31:0] vp, hp;
    reg [1:0] vertical_state, horizontal_state;
    reg vertical_trigger, vertical_blank; // triggers the vertical state machine
    // states: 0 means pre-blanking; 1 means wizard; 2 means post-blanking; 3 means synchronizing
    // pre-blanking: 48 cycles, HS high
    // wizard: 640 cycles, HS high
    // post-blanking: 16 cycles, HS high
    // synchronization: 96 cycles, HS low

    //Game over screen will be 320 x 240 (right now it is 640x480)
    reg [11:0] gameOver [0:76800];
    reg [11:0] color; 
    reg[11:0] color_fireball;
    reg [11:0] wizard [0:255];
    reg [11:0] wizardJump [0:255];
    reg [11:0] wizardCrouch [0:255];
    reg [11:0] fireball [0:255];
    initial begin
        // Wizard art
        //Change to directory where you're storing these files 
         $readmemh("X:\\Desktop\\WizardStationary.hex", wizard);
         $readmemh("X:\\Desktop\\wizard_jump.hex", wizardJump);
         $readmemh("X:\\Desktop\\crouch.hex", wizardCrouch);
        
        //Fireball art 
        $readmemh("X:\\Desktop\\fireball.hex", fireball);      
        
        //Gamveover
        $readmemh("X:\\Desktop\\game_over_screen.hex", gameOver);
        
        
        vp = 0; // vertical position
        count = 1;
        vertical_count = 1;
        hp = 0; // horizontal position
        vertical_state = 3;
        horizontal_state = 3;
        VGA_HS = 1;
        VGA_VS = 1;
        VGA_R = 0;
        VGA_G = 0;
        VGA_B = 0;
        vertical_trigger = 0;
        vertical_blank = 1; // one means blank line instead of display data
    end
    
    integer index,index_fireball;
    
    /////////// SCORE COUNTER SPRITES ////////////
    reg [0:3] pixels [15:0][6:0];

initial begin
// Value 0
pixels[0][0] = 4'b0110;
pixels[0][1] = 4'b1001;
pixels[0][2] = 4'b1001;
pixels[0][3] = 4'b0000;
pixels[0][4] = 4'b1001;
pixels[0][5] = 4'b1001;
pixels[0][6] = 4'b0110;

// Value 1
pixels[1][0] = 4'b0000;
pixels[1][1] = 4'b0001;
pixels[1][2] = 4'b0001;
pixels[1][3] = 4'b0000;
pixels[1][4] = 4'b0001;
pixels[1][5] = 4'b0001;
pixels[1][6] = 4'b0000;

// Value 2
pixels[2][0] = 4'b0110;
pixels[2][1] = 4'b0001;
pixels[2][2] = 4'b0001;
pixels[2][3] = 4'b0110;
pixels[2][4] = 4'b1000;
pixels[2][5] = 4'b1000;
pixels[2][6] = 4'b0110;

// Value 3
pixels[3][0] = 4'b0110;
pixels[3][1] = 4'b0001;
pixels[3][2] = 4'b0001;
pixels[3][3] = 4'b0110;
pixels[3][4] = 4'b0001;
pixels[3][5] = 4'b0001;
pixels[3][6] = 4'b0110;

// Value 4
pixels[4][0] = 4'b0000;
pixels[4][1] = 4'b1001;
pixels[4][2] = 4'b1001;
pixels[4][3] = 4'b0110;
pixels[4][4] = 4'b0001;
pixels[4][5] = 4'b0001;
pixels[4][6] = 4'b0000;

// Value 5
pixels[5][0] = 4'b0110;
pixels[5][1] = 4'b1000;
pixels[5][2] = 4'b1000;
pixels[5][3] = 4'b0110;
pixels[5][4] = 4'b0001;
pixels[5][5] = 4'b0001;
pixels[5][6] = 4'b0110;

// Value 6
pixels[6][0] = 4'b0110;
pixels[6][1] = 4'b1000;
pixels[6][2] = 4'b1000;
pixels[6][3] = 4'b0110;
pixels[6][4] = 4'b1001;
pixels[6][5] = 4'b1001;
pixels[6][6] = 4'b0110;

// Value 7
pixels[7][0] = 4'b0110;
pixels[7][1] = 4'b0001;
pixels[7][2] = 4'b0001;
pixels[7][3] = 4'b0000;
pixels[7][4] = 4'b0001;
pixels[7][5] = 4'b0001;
pixels[7][6] = 4'b0000;

// Value 8
pixels[8][0] = 4'b0110;
pixels[8][1] = 4'b1001;
pixels[8][2] = 4'b1001;
pixels[8][3] = 4'b0110;
pixels[8][4] = 4'b1001;
pixels[8][5] = 4'b1001;
pixels[8][6] = 4'b0110;

// Value 9
pixels[9][0] = 4'b0110;
pixels[9][1] = 4'b1001;
pixels[9][2] = 4'b1001;
pixels[9][3] = 4'b0110;
pixels[9][4] = 4'b0001;
pixels[9][5] = 4'b0001;
pixels[9][6] = 4'b0000;
end

    /////////// BEGIN HORIZONTAL STATE MACHINE //////////////
    always @(posedge clock)
    begin
        if (horizontal_state == 0) 
        begin
            // blank for 48 cycles
            if (count == 47) begin
                count <= 1;
                horizontal_state <= 1;
                // vertical_position <= vertical_position + 1;
                vertical_trigger <= 1; // to trigger the veritcal FSM on rising edge
            end
            else
            begin
                vertical_trigger <= 0;
                count <= count + 1;
            end
        end
        else if (horizontal_state == 1)
            begin
                // shift out 640 wizard
                if (hp == 640)
                begin
                    // reached end of line
                    VGA_R <= 0;
                    VGA_G <= 0;
                    VGA_B <= 0;
                    hp <= 0;
                    horizontal_state <= 2;
                end
                else
                begin
                    VGA_R <= 0;
                    VGA_G <= 0;
                    VGA_B <= 0;
                    if (vertical_blank == 0)
                    begin          
                        //Game over             
                        if (collision == 1) begin 
                            if (hp >= 160 && hp < 480 && vp >= 120 && vp < 360) begin
                                // Adjusted index calculation for centered display
                                index = (vp - 120) * 320 + (hp - 160);
                                color = gameOver[index];
                                VGA_R <= color[11:8];
                                VGA_G <= color[7:4];
                                VGA_B <= color[3:0];
                            end
                        end 
                        // score display
                        if (hp > 0 && hp < 5 && vp > 2 && vp < 10 && pixels[thous][vp-3][hp-1] == 1) begin

                            VGA_R <= 8;
                            VGA_G <= 8;
                            VGA_B <= 8;
                        end
                        else if (hp > 6 && hp < 11 && vp > 2 && vp < 10 && pixels[hunds][vp-3][hp-7] == 1) begin
                            VGA_R <= 8;
                            VGA_G <= 8;
                            VGA_B <= 8;
                        end
                        else if (hp > 12 && hp < 17 && vp > 2 && vp < 10 && pixels[tens][vp-3][hp-13] == 1) begin
                            VGA_R <= 8;
                            VGA_G <= 8;
                            VGA_B <= 8;
                        end
                        else if (hp > 18 && hp < 23 && vp > 2 && vp < 10 && pixels[ones][vp-3][hp-19] == 1) begin
                            VGA_R <= 8;
                            VGA_G <= 8;
                            VGA_B <= 8;
                        end
                        // wizard definition  
//                        end else if (collision == 0) begin                                  
                            if (hp <= 50 && hp >= 34 && vp >= (283-wyo) && vp < (299-wyo)) begin
                                if(jump) begin 
                                    index = ((vp - (283-wyo)) * 16) + (hp - 50);
                                    color = wizardJump[index];
                                    VGA_R <= color[11:8]; 
                                    VGA_G <= color[7:4];  
                                    VGA_B <= color[3:0];
                                end else if(crouch) begin 
                                    index = ((vp - (283-wyo)) * 16) + (hp - 50);
                                    color = wizardCrouch[index]; 
                                    VGA_R <= color[11:8]; 
                                    VGA_G <= color[7:4];  
                                    VGA_B <= color[3:0];
                                end else begin          
                                    index = ((vp - (283-wyo)) * 16) + (hp - 50); // Adjusted the index calculation to fit the collision hitbox 
                                    color = wizard[index]; // Access the wizard color data
                                    VGA_R <= color[11:8]; // Extract the red component
                                    VGA_G <= color[7:4];  // Extract the green component
                                    VGA_B <= color[3:0];  // Extract the blue component
                                end
                            // fireball 1 definition
                           end else if (hp >= (620-fxo1) && hp < (636-fxo1) && vp >= (278-fyo1) && vp < (294-fyo1) && fxo1 < 641) begin
                                index_fireball =  (vp - (278-fyo1)) * 16 + (hp - (620-fxo1));
                                color_fireball = fireball[index_fireball]; 
                                VGA_R <= color_fireball[11:8];
                                VGA_G <= color_fireball[7:4];
                                VGA_B <= color_fireball[3:0];
                            //fireball 2 definition
                            end else if (hp >= (620-fxo2) && hp < (636-fxo2) && vp >= (278-fyo2) && vp < (294-fyo2) && fxo2 < 641) begin
                                index_fireball =  (vp - (278-fyo2)) * 16 + (hp - (620-fxo2));
                                color_fireball = fireball[index_fireball]; 
                                VGA_R <= color_fireball[11:8];
                                VGA_G <= color_fireball[7:4];
                                VGA_B <= color_fireball[3:0];
                            // line for the ground
                            end else if (vp == 300 || (vp == 299 && (hp % 2 == 1 || hp % 3 == 1))) begin
                                VGA_R <= 8;
                                VGA_G <= 8;
                                VGA_B <= 8;
                            end
                        // black everything else
                        end
                    hp <= hp + 1;
                end
            end
        else if (horizontal_state == 2)
        begin
            // blank for 16 cycles
            if (count == 16) begin
                count <= 1;
                VGA_HS <= 0;
                horizontal_state <= 3;
            end
            else
            begin
                count <= count + 1;
            end
        end
        else // 3
        begin
            // sync for 96 cycles
            if (count == 96) begin
                VGA_HS <= 1;
                count <= 1;
                horizontal_state <= 0;
            end
            else
            begin
                count <= count + 1;
            end
        end
    end
    
    /////////// BEGIN VERTICAL STATE MACHINE //////////////
    always @(posedge vertical_trigger)
    begin
        if (vertical_state == 0) 
        begin
            // blank for 33 lines
            if (vertical_count == 32) begin
                vertical_count <= 1;
                vertical_state <= 1;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
        else if (vertical_state == 1)
        begin
            // shift out 480 lines
            if (vp == 480)
            begin
                // reached end of frame
                vp <= 0;
                vertical_state <= 2;
                vertical_blank <= 1;
            end
            else
            begin
                vertical_blank <= 0; // start displaying data instead of blanking
                vp <= vp + 1;
            end
        end
        else if (vertical_state == 2)
        begin
            // blank for 10 lines
            if (vertical_count == 10) begin
                vertical_count <= 1;
                VGA_VS <= 0;
                vertical_state <= 3;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
        else // 3
        begin
            // sync for 2 lines
            if (vertical_count == 2) begin
                VGA_VS <= 1;
                vertical_count <= 1;
                vertical_state <= 0;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
    end
endmodule
