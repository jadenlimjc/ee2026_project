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


module Top_Student (
    input clk, btnC, btnU, sw4,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden
);

    
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [15:0] oled_data;
    wire reset;
    wire clk6p25m;
    
    
    flexible_clock clk6p25 (clk, 31'd7, clk6p25m);
    
    assign reset = sw4;
    
    Oled_Display OLED (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden);
      
    taskC taskc(clk, btnC, btnU, pixel_index, oled_data);
    
    


endmodule