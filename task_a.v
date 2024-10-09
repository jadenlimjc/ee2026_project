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


module task_a(
    input clk,
    input clk25,
    input clk6p25,
    input clk1k,
    input btnU,
    input [12:0] pixel_index,
    output reg [15:0] selected_color
);
   wire [15:0] color_border;
   wire [15:0] greenCircle;
   wire [15:0] orangeCircle;
   wire [15:0] redCircle;
   wire [15:0] greenSquare;
   wire [15:0] orangeSquare;
   wire [15:0] redSquare;
   wire [15:0] orangeDoughnut;
   wire [15:0] whiteDoughnut;
   reg [31:0] debounce_count;
   reg ready;     
   
   reg btn_state = 0;
   reg btn_pressed = 0;
   reg [15:0] orange = 16'hFC00;
   reg [15:0] green =16'h07E0;
   reg [15:0] red = 16'hF800;
   reg [15:0] white = 16'hFFFF;

    
   
   reg [2:0]count;
   
    solid_circle greenC(clk25,pixel_index,green,greenCircle);
    solid_circle orangeC(clk25,pixel_index,orange,orangeCircle);
    solid_circle redC(clk25,pixel_index,red,redCircle);
    solid_square greenS(clk25,pixel_index,green,greenSquare);
    solid_square orangeS(clk25,pixel_index,orange,orangeSquare);
    solid_square redS(clk25,pixel_index,red,redSquare);
    red_border border(clk25,pixel_index,color_border);
    create_doughnut orangeD(clk25,pixel_index,orange,orangeDoughnut);
    create_doughnut whiteD(clk25,pixel_index,white,whiteDoughnut);


     always @(posedge clk1k) begin
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
                    selected_color <= orangeDoughnut; // orange doughnut
                end
                 else selected_color <= whiteDoughnut;// white doughnut
           
                
               if (pixel_index % 96 < 57 && pixel_index % 96 > 39 &&   // Left and right limit of changing small shape
                  pixel_index / 96 < 41 && pixel_index / 96 > 23) begin
         
               case (count)
                   3'b001: selected_color <= greenCircle; // Green Circle
                   3'b010: selected_color <= orangeCircle; // Orange Circle
                   3'b011: selected_color <= redCircle; // Red Circle
                   3'b100: selected_color <= greenSquare; // Green Square
                   3'b101: selected_color <= orangeSquare; // Orange Square
                   3'b110: selected_color <= redSquare; // Red Square
                   default: begin selected_color <= 16'h0000;
                   
                   end // Default to black if out of range
               endcase
               end
              
               
             
       
               // Apply red border to all counts
               if (pixel_index % 96 < 7 || pixel_index % 96 > 89 ||   // Left and right edges
                   pixel_index / 96 < 7 || pixel_index / 96 > 57) begin  // Top and bottom edges
                   selected_color <= color_border; // Override with red border
               end
           end


//    else if(((pixel_index%96 -48)*(pixel_index%96-48)+ (pixel_index/96 -32)*(pixel_index/96 -32)) >= 100 && ((pixel_index%96-48)*(pixel_index%96-48) + (pixel_index/96 -32)*(pixel_index/96 -32)) <= 144 )begin
//    color <= 16'b1111111111100000;
//    end

endmodule