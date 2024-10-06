`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 23:13:29
// Design Name: 
// Module Name: red_border
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


module red_border(input clk25, [12:0] pixel_index, output reg [15:0]color

    );
    reg [15:0] red =16'hF800 ;
    reg black;
    always @(posedge clk25)begin 
   if(pixel_index/96 >= 0 && pixel_index/96 < 4  || pixel_index/96 > 60 && pixel_index/96  <= 64 )begin
        color <= black;
        end
        else if(pixel_index%96 >= 0 && pixel_index%96 < 4  || pixel_index%96 >92  && pixel_index%96  <= 96 )begin
        color <=black;
        end
        else if(pixel_index/96 >= 4 && pixel_index/96  < 7 || pixel_index/96 > 57 && pixel_index/96  <= 60 )begin
        color <= red;
        end
        else if(pixel_index%96 >= 4 && pixel_index%96  < 7 || pixel_index%96 > 89 && pixel_index%96  <= 92 )begin
        color <= red;
        end else color<=0;
        end
endmodule
