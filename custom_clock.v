`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 14:11:15
// Design Name: 
// Module Name: custom_clock
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


module custom_clock(input clk, [31:0] cycle_delay, output reg clock_signal = 0);

    reg [31:0] counter = 0;
    
    always @ (posedge clk)
    begin
        counter <= (counter >= cycle_delay) ? 0 : counter + 1;
        clock_signal <= (counter == 0) ? ~clock_signal : clock_signal;
    end
    
endmodule
