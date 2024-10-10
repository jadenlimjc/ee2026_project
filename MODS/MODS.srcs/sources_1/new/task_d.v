`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2024 09:41:29
// Design Name: 
// Module Name: task_d
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


module task_d
    #(
    parameter X_SIZE = 96,
    parameter Y_SIZE = 64,
    parameter COLOUR_RED = 16'hF800,
    parameter COLOUR_GREEN = 16'h07E0,
    parameter COLOUR_BLUE = 16'h001F,
    parameter COLOUR_ORANGE = 16'hFBE0
)
    (
    input en,
    input clksig,
    input [4:0] btn,
    input [12:0] pixel_index,
    output reg [15:0] pixel_data
);
    
    reg [7:0] ptr_x = 8'd4;
    reg [7:0] ptr_y = 8'd4;
    reg [7:0] ptr_hitbox_offset = 8'd6;

    reg [3:0] dir;
    reg is_enabled = 0;

    always @ (pixel_index)
    begin
        if (pixel_index % 96 >= ptr_x && pixel_index % 96 <= ptr_x + ptr_hitbox_offset && pixel_index / 96 >= ptr_y && pixel_index / 96 <= ptr_y + ptr_hitbox_offset)
            pixel_data <= COLOUR_GREEN;
        else if (pixel_index % 96 >= 35 && pixel_index % 96 <= 60 && pixel_index / 96 >= 20 && pixel_index / 96 <= 45)
            pixel_data <= (dir == 4'd0) ? COLOUR_RED : COLOUR_ORANGE;
        else
            pixel_data <= 16'h0;
    end
    
    always @ (posedge clksig)
    begin
    
        if (is_enabled == 1 && en == 1) begin
        
            if (btn[1] || btn[2] || btn[3] || btn[4])
                dir <= {btn[1], btn[4], btn[2], btn[3]};
            else if (btn[0])
                dir <= 4'd0;
            
            if (dir == 4'b0010) // left
            begin
                if (ptr_x > 0 && ~(ptr_x == 61 && (ptr_y <= 45 && ptr_y + ptr_hitbox_offset >= 20)))
                    ptr_x <= ptr_x - 1;
                else
                    dir <= 4'd0;
            end
            else if (dir == 4'b0001) // right
            begin
                if (ptr_x + ptr_hitbox_offset < 95 && ~(ptr_x + ptr_hitbox_offset == 34 && (ptr_y <= 45 && ptr_y + ptr_hitbox_offset >= 20)))
                    ptr_x <= ptr_x + 1;
                else
                    dir <= 4'd0;
            end
            else if (dir == 4'b1000) // up
            begin
                if (ptr_y > 0 && ~(ptr_y == 46 && (ptr_x <= 60 && ptr_x + ptr_hitbox_offset >= 35)))
                    ptr_y <= ptr_y - 1;
                else
                    dir <= 4'd0;
            end
            else if (dir == 4'b0100) // down
            begin
                if (ptr_y + ptr_hitbox_offset < 63 && ~(ptr_y + ptr_hitbox_offset == 19 && (ptr_x <= 60 && ptr_x + ptr_hitbox_offset >= 35)))
                    ptr_y <= ptr_y + 1;
                else
                    dir <= 4'd0;
            end
            
        end
        else if (en == 1)
        begin
            is_enabled <= 1;
            dir <= 4'd0;
            ptr_x <= 8'd4;
            ptr_y <= 8'd4;
        end else
            is_enabled = 0;
        
    end
endmodule
