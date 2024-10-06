`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 22:50:49
// Design Name: 
// Module Name: red_circle
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


module red_circle(input clk25,[12:0]  pixel_index, output reg [15:0]color

    );
    reg [15:0] red =16'hF800 ;
    always @(posedge clk25)begin 
        if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 0 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 64 )begin
        color <= red;
        end else color<=0;
        end


endmodule
