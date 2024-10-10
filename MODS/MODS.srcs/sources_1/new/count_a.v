`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 01:31:27
// Design Name: 
// Module Name: count_a
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


module count_a(input [15:0] sw, clk,btnC_pressed,btnU_pressed,output reg start_called = 0, reg[2:0] count);
parameter taskAPw = 16'b 0001000110000101;
always @(posedge clk) begin
     if(sw != taskAPw)begin
             start_called <= 0;
             
             
     end
     else if(btnU_pressed) start_called<=1;
     end    
     
always @(posedge btnC_pressed or negedge start_called) begin
if (start_called == 0) count <=0;
     else if (start_called) begin
          
          if (count == 6)begin
            count <= 1;
          end
         
           
             else count <= count + 1; // Increment count on each valid press
     
     end
     
     end
endmodule
