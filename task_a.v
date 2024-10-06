`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 22:37:27
// Design Name: 
// Module Name: task_a
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


module task_a(input clk,clk25,clk6p25,btnU, [12:0] pixel_index, output reg [15:0] selected_color

    );
   wire [15:0] color;
   wire [15:0] color1;
   wire [15:0] color2;
   wire [15:0] color3;
   wire [15:0] color4;
   wire [15:0] color5;
   wire [15:0] color6;
   wire [15:0] color7;
   wire [15:0] color8;
   reg [31:0] debounce_count;
   reg ready;     
   wire clk_1k;
   reg btn_state = 0;
   reg btn_pressed = 0;

    
   
   reg [2:0]count;
   custom_clock clock4(clk,49999,clk_1k);
    
    green_circle circle2(clk25,pixel_index,color1);
    orange_circle circle1(clk25,pixel_index,color2);
    red_circle circle13(clk25,pixel_index,color3);
    green_square square2(clk25,pixel_index,color4);
    orange_square square1(clk25,pixel_index,color5);
    red_square square3(clk25,pixel_index,color6);
    red_border border(clk25,pixel_index,color);
    orange_doughnut doughnut1(clk25,pixel_index,color7);
    white_doughnut doughnut2(clk25,pixel_index,color8);

     always @(posedge clk_1k) begin
     if (count > 6)begin
     count <= 0;
     end
       if (btnU == btn_state) begin
           
           debounce_count <= 0; // Reset counter when stable
       end 
       else begin
           // Button is changing state, count how long it has been unstable
           debounce_count <= debounce_count + 1;
           if (debounce_count >= 200) begin  // Wait for 200ms 
               btn_state <= btnU;  // Accept the new button state
               debounce_count <= 0; // Reset the counter
               if (btnU == 1) begin
                   btn_pressed <= 1; // Register button press
               end
           end
       end
   
       if (btn_pressed) begin
           btn_pressed <= 0;  // Reset press flag
           count <= count + 1; // Increment count on each valid press
       end
   end
    always @(posedge clk25) begin
    
                if(count <= 3 || count == 7)begin // logic for doughnut
                    selected_color <= color7; // orange doughnut
                end
                 else selected_color <=color8;// white doughnut
           
                
               if (pixel_index % 96 < 57 && pixel_index % 96 > 39 &&   // Left and right limit of changing small shape
                  pixel_index / 96 < 41 && pixel_index / 96 > 23) begin
         
               case (count)
                   3'b001: selected_color <= color1; // Green Circle
                   3'b010: selected_color <= color2; // Orange Circle
                   3'b011: selected_color <= color3; // Red Circle
                   3'b100: selected_color <= color4; // Green Square
                   3'b101: selected_color <= color5; // Orange Square
                   3'b110: selected_color <= color6; // Red Square
                   default: begin selected_color <= 16'h0000;
                   
                   end // Default to black if out of range
               endcase
               end
              
               
             
       
               // Apply red border to all counts
               if (pixel_index % 96 < 7 || pixel_index % 96 > 89 ||   // Left and right edges
                   pixel_index / 96 < 7 || pixel_index / 96 > 57) begin  // Top and bottom edges
                   selected_color <= color; // Override with red border
               end
           end


//    else if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 100 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 144 )begin
//    color <= 16'b1111111111100000;
//    end

endmodule
