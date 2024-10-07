`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Royce Wong
//  STUDENT B NAME: Nicholas
//  STUDENT C NAME: Jaden
//  STUDENT D NAME: Irwin Teo
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk,
    input [4:0] btn,
    input [3:0] sw,
    output [7:0] JC,
    inout PS2Clk, PS2Data
);

    wire [15:0] pixel_data;
    wire [12:0] pixel_index;
    wire sending_pixels;
    wire sample_pixel;
    wire clock_signal;
    wire frame_begin;
            
    wire clksig6p25m;
    wire clksig20;
    custom_clock clk6p25m (
        .clk(clk),
        .cycle_delay(7),
        .clock_signal(clksig6p25m)
    );
    custom_clock clk20 (
        .clk(clk),
        .cycle_delay(2_499_999),
        .clock_signal(clksig20)
    );
        
    wire clksig25m;
    wire clksig12p5m;
    wire clksig10;
    wire clksig1k;
    custom_clock clk25m (
        .clk(clk),
        .cycle_delay(1),
        .clock_signal(clksig25m)
    );
    custom_clock clk12p5m (
        .clk(clk),
        .cycle_delay(3),
        .clock_signal(clksig12p5m)
    );
    custom_clock clk10 (
        .clk(clk),
        .cycle_delay(4_999_999),
        .clock_signal(clksig10)
    );
    custom_clock clk1k (
        .clk(clk),
        .cycle_delay(49_999),
        .clock_signal(clksig1k)
    );
    
    Oled_Display oled (
        .clk(clksig6p25m),
        .reset(0),
        .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel), 
        .pixel_index(pixel_index), 
        .pixel_data(pixel_data), 
        .cs(JC[0]), 
        .sdin(JC[1]), 
        .sclk(JC[3]), 
        .d_cn(JC[4]), 
        .resn(JC[5]), 
        .vccen(JC[6]),
        .pmoden(JC[7])
    );
    
    wire [15:0] pixel_data_d;
    task_d task_d (
        .clksig(clksig20),
        .btn(btn),
        .pixel_index(pixel_index),
        .pixel_data(pixel_data_d)
    );
    
    wire [15:0] pixel_data_a;
    task_a task_a (
        .clk(clk),
        .clk25(clksig25m),
        .clk6p25(clksig6p25m),
        .clk1k(clksig1k),
        .btnU(btn[1]),
        .pixel_index(pixel_index),
        .selected_color(pixel_data_a)
    );
    
    wire [15:0] pixel_data_b;
    task_b task_b (
        .CLOCK(clk),
        .btnU(btn[1]),
        .btnC(btn[0]),
        .btnD(btn[4]),
        .pixel_index(pixel_index),
        .color(pixel_data_b)
    );
    
    wire [15:0] pixel_data_c;
    task_c2 task_c (
        .clk(clk),
        .btnC(btn[0]),
        .btnU(btn[1]),
        .pixel_index(pixel_index),
        .colour(pixel_data_c)
    );
    
    assign pixel_data = (sw[0]) ? pixel_data_a : ((sw[1]) ? pixel_data_b : ((sw[2]) ? pixel_data_c : pixel_data_d));
/*
task_c task_c (
    .clk(clksig20),
    .reset(0),
    .btn(btn), // Assuming 5 buttons for up, down, left, right, and stop
    .pixel_index(pixel_index),
    .pixel_data(pixel_data)
);
*/

endmodule