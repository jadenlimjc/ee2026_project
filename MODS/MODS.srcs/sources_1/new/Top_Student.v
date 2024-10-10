`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Royce Wong
//  STUDENT B NAME: Nicholas
//  STUDENT C NAME: Jaden Lim
//  STUDENT D NAME: Irwin Teo
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk,
    input [4:0] btn,
    input [15:0] sw,
    output [7:0] JC,
    [15:0]led
);
parameter taskAPw = 16'b 0001000110000101; // sw 0,2,7,8,12
parameter taskBPw = 16'b 0010000100110101; // sw 0,2,4,5,8,13
parameter taskCPw = 16'b 0100000100001111; // sw 0,1,2,3,8,14
parameter taskDPw = 16'b 1000000010010111; // sw 0,1,2,4,7,15


    reg [15:0] pixel_data;
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
    wire clksigAC, clksigB, clksigD;
    parameter freqAC = 5555554;
    parameter freqB = 49999999;
    parameter freqD = 24999999;
    wire ledFreq;
    reg [15:0] LEDS;
    
    custom_clock clockAC (clk,freqAC,clksigAC); // 9hz
    custom_clock clockB (clk,freqB,clksigB); // 1hz
    custom_clock clockD (clk,freqD,clksigD); // 2hz
    
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
        .en(sw == taskDPw),
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
        .btn(btn),
        .pixel_index(pixel_index),
        .sw(sw),
        .selected_color(pixel_data_a)
    );
    
    wire [15:0] pixel_data_b;
    task_b task_b (
        .CLOCK(clk),
        .btnU(btn[1]),
        .btnC(btn[0]),
        .btnD(btn[4]),
        .pixel_index(pixel_index),
        .sw(sw),
        .color(pixel_data_b)
    );
    
    wire [15:0] pixel_data_c;
    task_c2 task_c (
        .clk(clk),
        .btnC(btn[0]),
        .btnU(btn[1]),
        .sw(sw),
        .pixel_index(pixel_index),
        .colour(pixel_data_c)
    );
    wire [15:0] pixel_data_number_01;
    task_init task_i (
        .pixel_index(pixel_index),
        .colour(pixel_data_number_01)
    );
    
//    assign pixel_data = (sw[0]) ? pixel_data_a : ((sw[1]) ? pixel_data_b : ((sw[2]) ? pixel_data_c : pixel_data_d));
    always @(pixel_index) begin
         case (sw)
             taskAPw: begin
                 pixel_data <= pixel_data_a;
                 LEDS <= {7'b0000000, clksigAC, clksigAC, 4'b0000, clksigAC, 1'b0, clksigAC};
             end
             taskBPw: begin
                 pixel_data <= pixel_data_b;
                 LEDS <= {7'b0000000, clksigB, 2'b00, clksigB, clksigB, 1'b0, clksigB, 1'b0, clksigB};
             end
             taskCPw: begin
                 pixel_data <= pixel_data_c;
                 LEDS <= {7'b0000000, clksigAC, 4'b00, clksigAC, clksigAC, clksigAC, clksigAC};
             end
             taskDPw: begin
                 pixel_data <= pixel_data_d;
                 LEDS <= {8'b00000000, clksigD, 2'b000, clksigD, 1'b0, clksigD, clksigD, clksigD};
             end
             default: begin
                 // Optionally, include a default case if necessary
                  pixel_data <= pixel_data_number_01; 
                  LEDS <= sw;
             end
         endcase
     end
     assign led = LEDS;
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