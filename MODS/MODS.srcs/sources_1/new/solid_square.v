`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:21:09
// Design Name: 
// Module Name: solid_square
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


module solid_square(
    input clk25,
    [12:0] pixel_index,
    [15:0]color_in,
    output reg [15:0]color
);
    
    always @(posedge clk25)begin 
        if((pixel_index%96 >= 48-6) && (pixel_index%96 <= 48+6) && (pixel_index/96 >= 32-6) && (pixel_index/96 <=32+6) )begin
        color <= color_in;
        end else color<=0;
    end
    
endmodule
