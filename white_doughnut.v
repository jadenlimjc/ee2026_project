`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 23:13:29
// Design Name: 
// Module Name: white_doughnut
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


module white_doughnut(
input clk25,[12:0]  pixel_index, output reg [15:0]color

    );
    reg [15:0] white =16'hFFFF ;
    always @ (posedge clk25)begin 
    if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 144 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 196 )begin
        color <= white;
        end
         else color<=0;
         end
endmodule
