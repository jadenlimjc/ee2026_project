`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:18:21
// Design Name: 
// Module Name: create_doughnut
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


module create_doughnut(
    input clk25,
    input [12:0] pixel_index,
    input [15:0] color_in,
    output reg [15:0]color
);

    always @ (posedge clk25)
    begin 
        if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 144 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 196 )
            color <= color_in;
        else color<=0;
    end
    
endmodule
