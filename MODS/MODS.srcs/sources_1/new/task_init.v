`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 13:29:56
// Design Name: 
// Module Name: task_init
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


module task_init(
    input [12:0] pixel_index,
    output reg [15:0] colour
);
    
    wire [7:0] x;
    wire [7:0] y;
    parameter WHITE = 16'hFFFF;
    parameter BLACK = 16'h0;
    assign x = pixel_index%96;
    assign y = pixel_index/96;
    
    always @(pixel_index) begin
    //draw 1
        if (x >= 70 && x <= 75 &&
            y >= 10 && y <= 54) begin
            colour <= WHITE;
        end
        //draw 0
        else if ((x >= 20 && x <= 50 &&
                ((y >= 10 && y <= 15) || //top line
                (y >= 49 && y <= 54))) || //bottom line
                ((y >= 10 && y <= 54) &&
                ((x >= 20 && x <= 25) || //left line
                (x >= 45 && x <= 50)))) begin // right line
            colour <= WHITE;
        end
        else begin
            colour <= BLACK;
        end
    end
    
endmodule
