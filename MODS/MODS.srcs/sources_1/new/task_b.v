`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:30:21
// Design Name: 
// Module Name: task_b
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


module task_b (
    input CLOCK,
    input btnU,
    input btnC,
    input btnD,
    input [12:0] pixel_index,
    input [15:0] sw,
    output reg [15:0] color
);
    wire [7:0] x;
    wire [6:0] y;
    wire start;
    assign start = (sw == 16'b0010000100110101) ? 1 : 0;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    wire [2:0] stepU, stepC, stepD;
    wire [2:0] stepu, stepc, stepd;
    wire [15:0] top, middle, bottom;
    wire up, centre, down;
    button_press u7 (CLOCK,btnU,up );
    button_press u8 (CLOCK,btnC,centre);
    button_press u9 (CLOCK,btnD,down);
    count u1 (up,start,stepU);
    count u2 (centre,start, stepC);
    count u3 (down, start,stepD);
    square_color u4 (CLOCK, stepU, top);
    square_color u5 (CLOCK, stepC, middle);
    square_color u6 (CLOCK, stepD,bottom);
    always @ (posedge CLOCK)
    begin
    if (x >= 42 && x <= 51 && y>=5 && y <= 14)
        begin
        color <= top;
        end
    else if (x>=42 && x <= 51 && y >= 21 && y <= 30)
    begin
        color <=  middle;
    end
    else if (x >= 42 && x <= 51 && y >= 37 && y <= 46)
    begin
        color <= bottom;
    end
    else if (x >= 42 && x <= 51 && y >= 53 && y <= 62)
        begin
        if (stepU == 3 && stepC == 3 && stepD == 3)
            color <= 16'hF800;
        else
            color <= 16'hFFFF;
        end
    else
        begin
        color <= 16'h0000;
        end
    end
    
endmodule