module xy_convert(input [12:0] pixel_index, output [7:0] x, output [6:0] y);
assign x = pixel_index % 96;
assign y = pixel_index / 96;
endmodule
