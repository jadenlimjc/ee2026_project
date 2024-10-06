`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 22:50:49
// Design Name: 
// Module Name: green_square
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


module green_square(
input clk25, [12:0] pixel_index, output reg [15:0]color

    );
    reg [15:0] green =16'h07E0 ;
    always @(posedge clk25)begin 
        if((pixel_index%96 >= 48-6) && (pixel_index%96 <= 48+6) && (pixel_index/96 >= 32-6) && (pixel_index/96 <=32+6) )begin
        color <= green;
        end else color<=0;
        end
endmodule
