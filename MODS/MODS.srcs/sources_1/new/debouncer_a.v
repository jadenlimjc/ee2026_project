`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 01:16:38
// Design Name: 
// Module Name: debouncer_a
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


module debouncer_a(input clk1k,
    input button,
    output reg pressed = 0
);

reg [31:0] count = 0;

always @ (posedge clk1k)
begin

if (button == 1)
    begin
    count <= count + 1;
    if (count >= 200)
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
