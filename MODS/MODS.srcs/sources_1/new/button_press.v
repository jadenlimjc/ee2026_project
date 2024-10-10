`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:30:21
// Design Name: 
// Module Name: button_press
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


module button_press(
    input CLOCK,
    input button,
    output reg pressed = 0
);

reg [31:0] count = 0;

always @ (posedge CLOCK)
begin
if (button == 1)
    begin
    count <= count + 1;
    if (count >= 2000000)
        begin
        pressed <= 1;
        end
    end
else if (button ==0)
    begin
    count <= 0;
    pressed <= 0;
    end
end

endmodule
