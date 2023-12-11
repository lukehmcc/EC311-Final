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
    input in_clk, crouch,
    input [7:0] wyo, 
    input [9:0] fxo1, fyo1,fxo2, fyo2, // wizard y offset, fireball x & y offset
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

    
    reg [11:0] color; 
    reg[11:0] color_fireball;
    reg [11:0] wizard [0:255];
    reg [11:0] fireball [0:255];
    initial begin
        // Wizard art
        //Change to directory where you're storing these files 
         $readmemh("X:\\Desktop\\WizardStationary.hex", wizard);
        
        //Fireball art 
        $readmemh("X:\\Desktop\\fireball.hex", fireball);        
        
        
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
                    if (vertical_blank == 0)
                    begin
                        // wizard definition

                        if (hp < 16 && vp >= (278-wyo) && vp < (294-wyo)) begin
                            index = (vp - (278-wyo)) * 16 + hp; // Adjusted the index calculation
                            color = wizard[index]; // Access the wizard color data
                            VGA_R <= color[11:8]; // Extract the red component
                            VGA_G <= color[7:4];  // Extract the green component
                            VGA_B <= color[3:0];  // Extract the blue component
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
                        // black everything else    
                        end else begin
                            VGA_R <= 0;
                            VGA_G <= 0;
                            VGA_B <= 0;
                        end
                    end
                    else
                    begin
                        VGA_R <= 0;
                        VGA_G <= 0;
                        VGA_B<= 0;
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
