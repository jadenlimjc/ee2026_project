`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 22:50:49
// Design Name: 
// Module Name: red_square
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


module red_square(input clk25,[12:0]  pixel_index, output reg [15:0]color

    );
    reg [15:0] red =16'hF800 ;
    always @(posedge clk25)begin 
        if((pixel_index%96 >= 48-6) && (pixel_index%96 <= 48+6) && (pixel_index/96 >= 32-6) && (pixel_index/96 <=32+6) )begin
        color <= red;
        end else color<=0;
        end
        
endmodule
