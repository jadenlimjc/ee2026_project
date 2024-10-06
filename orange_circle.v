`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 22:43:55
// Design Name: 
// Module Name: orange_circle
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


module orange_circle(input clk25, [12:0] pixel_index, output reg [15:0]color

    );
    reg [15:0] orange =16'hFC00 ;
    
    always @(posedge clk25)begin 
        if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 0 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 64 )begin
        color <= orange;
        end
        else color<=0;
        end
endmodule
