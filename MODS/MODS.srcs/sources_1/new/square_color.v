`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:30:21
// Design Name: 
// Module Name: square_color
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


module square_color (
    input CLOCK,
    input [2:0] step,
    output reg [15:0] color
);

always @(posedge CLOCK)
begin
case (step)
        3'b001: begin
            color <= 16'hFFFF; //white
            end
        3'b010: begin 
            color <= 16'hF800;//red
            end
        3'b011: begin
            color <= 16'h07E0;
            end
        3'b100: begin
             color <= 16'h001F;
             end
        default: begin
            color <= 16'h0000;
            end
    endcase
end

endmodule
