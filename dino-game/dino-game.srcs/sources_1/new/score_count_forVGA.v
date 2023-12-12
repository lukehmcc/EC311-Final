`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 06:06:19 PM
// Design Name: 
// Module Name: score_count_forVGA
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


module score_count_forVGA(
input frame,
input reset,
input collision,
output reg [15:0] BCD_score,
output reg [11:0] score
    );
    
    reg count;
    initial count = 1;
    integer  W = 12;
//   reg [W+(W-4)/3:0] BCD_score // bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(score) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) BCD_score[i] = 0;     // initialize with zeros
    BCD_score[12-1:0] = score;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (BCD_score[W-i+4*j -: 4] > 4)                      // if > 4
          BCD_score[W-i+4*j -: 4] = BCD_score[W-i+4*j -: 4] + 4'd3; // add 3
  end

     
   
always @ (posedge frame)
	begin
	  
	   if(!collision)begin
	    count =  !count;
	    
	   if(count == 1) score = score + 1;
	   end
	    
	    else if(reset && collision)
	    score = 0;
	    
    end
endmodule
