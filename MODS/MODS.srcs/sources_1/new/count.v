`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 00:30:21
// Design Name: 
// Module Name: count
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


module count (
    input button,
    input start,
    output reg [2:0] step = 1
);

always @ (posedge button or negedge start)
begin
    if (start == 0)
    begin
        step <= 1;
    end
    else if (start == 1)
    begin
        if (step < 4)
        begin
            step <= step + 1;
        end
        else
        begin
            step <= 1;
        end
    end
end

endmodule