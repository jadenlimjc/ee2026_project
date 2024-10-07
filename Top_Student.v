`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input clk,[4:0]btn,[15:0]sw,output [7:0]JB,[15:0]led,[6:0]seg, inout PS2Clk,inout PS2Data
);
wire clk25,clk12p5,clk6p25,slowclk,clk_1k;
reg [15:0] oled_data;
wire [15:0] taskAdata,taskBdata,taskDdata;
reg [15:0] red = 16'hf800;
reg [15:0] green = 16'h07e0;
reg [15:0] blue =16'b0000010101011010;
reg black =0;
wire frame_begin;
wire sending_pixels;
wire [12:0] pixel_index;
wire sample_pixel;
//mouse
wire [11:0] value;
wire [11:0] xpos;
wire [11:0] ypos;
wire [3:0] zpos;
wire left;
wire middle;
wire right;
wire new_event;
wire setx;
wire sety;
wire setmax_x;
wire setmax_y;
wire enable;
assign enable =1;
wire  [7:0]x;
wire [6:0] y;


custom_clock clock0(clk,7,clk6p25);
custom_clock clock1(clk,1,clk25);
custom_clock clock2(clk,3,clk12p5);
custom_clock clock3(clk,4999999,slowclk);
custom_clock clock4(clk,49999,clk_1k);
assign led = sw;




 Oled_Display oleddisplay(clk6p25, btn[0], frame_begin, sending_pixels,
  sample_pixel, pixel_index, oled_data, JB[0], JB[1], JB[3], JB[4], JB[5], JB[6],
JB[7]);
//  MouseCtl mousectl(clk,btnC,xpos,ypos,zpos,left,middle,right,new_event,value,setx,sety,setmax_x,setmax_y,PS2Clk,PS2Data);
  
//  paint p(clk,clk25,clk12p5,clk6p25,slowclk,left,right,enable,xpos,ypos,pixel_index,led,seg,oled_data);
     task_a taska(clk,clk25,clk6p25,clk_1k,btn[1], pixel_index, taskAdata);
     task_d taskd(slowclk,btn,pixel_index,taskDdata);
     xy_convert u5 (pixel_index, x,y);
     oled_data u6 (clk,btn[1],btn[0],btn[4],x,y,taskBdata);
  
      always @(posedge clk25) begin
      if (sw[0])begin
      oled_data <= taskAdata;
      end
      else if(sw[1])begin
      oled_data <= taskBdata;
      end
      else if(sw[2])begin
      oled_data <= taskDdata;
      end
      end
     
  

//assign led[15] = left;
//assign led[14] = middle;
//assign led[13] =right;




endmodule