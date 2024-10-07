`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2024 17:04:56
// Design Name: 
// Module Name: flexible_clock
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


module flexible_clock(
    input clk, [31:0] cycle_delay,
    output reg clk_signal = 0

    );
    reg [31:0] counter = 0;
    always @(posedge clk)
    begin
        counter <= (counter >= cycle_delay) ? 0 : counter + 1;
        clk_signal <= (counter == 0) ? ~clk_signal : clk_signal;
    end
endmodule
