module taskC(
    input clk, btnC, btnU,
    input [12:0] pixel_index,
    output reg [15:0] colour
    );

    // Define colors and parameters
    parameter GREEN = 16'b00000_111111_00000;
    parameter RED = 16'b11111_000000_00000;
    parameter BLACK = 16'b00000_000000_00000;
    parameter SQUARE_SIZE = 15;

    // Define movement boundaries
    parameter MAX_X = 90;
    parameter MIN_X = 6;
    parameter MAX_Y = 60;
    parameter MIN_Y = 4;
    
    // Screen dimensions
    parameter SCREEN_WIDTH = 96;
    parameter SCREEN_HEIGHT = 64;

    wire [6:0] col; 
    wire [6:0] row;
    assign col = pixel_index % SCREEN_WIDTH;
    assign row = pixel_index / SCREEN_WIDTH;

    // Clock signal to control movement
    localparam GREEN_DELAY = 31'd1666667;   // Movement speed for green square
    localparam RED_DELAY = 31'd1000000;

    // State definitions for movement directions
    localparam [3:0] INIT        = 4'b0000,
                     MOVE_RIGHT  = 4'b0001,
                     WAIT_RIGHT  = 4'b0010,
                     MOVE_DOWN   = 4'b0011,
                     WAIT_DOWN   = 4'b0100,
                     MOVE_LEFT   = 4'b0101,
                     WAIT_LEFT   = 4'b0110,
                     INIT_RED    = 4'b0111,
                     RED_RIGHT   = 4'b1000,
                     RED_UP      = 4'b1001,
                     RED_LEFT    = 4'b1010;
                     

    reg [3:0] current_state;
    

    // Position of the green square
    reg [6:0] green_x, green_y;
    reg [6:0] red_x, red_y;

    // Clock for movement
    wire green_clk, red_clk;


    // Movement clock module
    flexible_clock green_clock(
        .clk(clk),
        .cycle_delay(GREEN_DELAY),
        .clk_signal(green_clk)
    );
    
    flexible_clock red_clock(
        .clk(clk),
        .cycle_delay(RED_DELAY),
        .clk_signal(red_clk)
    );

    // Initialize state and pixel trail array
    reg [6:0] i, j; 
    
    reg [31:0] wait_counter;
    
    initial begin
        current_state = INIT;
        green_x = MIN_X;
        green_y = MIN_Y;
        red_x = MIN_X;
        red_y = MAX_Y - SQUARE_SIZE;
    end

    // State machine for movement and transitions
    always @(posedge green_clk) begin
        case (current_state)
            INIT: begin
                green_x = MIN_X;
                green_y = MIN_Y;
                red_x = MIN_X;
                red_y = MAX_Y - SQUARE_SIZE;
                if (btnC) begin
                    current_state <= MOVE_RIGHT;
                end
            end

            MOVE_RIGHT: begin
                if (green_x < MAX_X - SQUARE_SIZE) begin
                    green_x <= green_x + 1;
                end else begin
                    current_state <= WAIT_RIGHT;
                end
            end
            
            WAIT_RIGHT: begin 
                wait_counter <= wait_counter + 1;
                if (wait_counter >= 45) begin
                    current_state <= MOVE_DOWN;
                    wait_counter <= 0;
                end
            end

            MOVE_DOWN: begin
                if (green_y < MAX_Y - SQUARE_SIZE) begin
                    green_y <= green_y + 1;
                end else begin
                    current_state <= WAIT_DOWN;
                end
            end
            
            WAIT_DOWN: begin
                wait_counter <= wait_counter + 1;
                if (wait_counter >= 45) begin
                    current_state <= MOVE_LEFT;
                    wait_counter <= 0;
                end
            end

            MOVE_LEFT: begin
                if (green_x > MIN_X) begin
                    green_x <= green_x - 1;
                end else begin
                    current_state <= WAIT_LEFT;
                end
            end
            
            WAIT_LEFT: begin
                wait_counter <= wait_counter + 1;
                if (wait_counter >= 45) begin
                    current_state <= INIT_RED;
                    wait_counter <= 0;
                end
            end
            
            INIT_RED: begin
                if (btnU) begin
                    current_state <= RED_RIGHT;
                end
            end
            
            RED_RIGHT: begin
                if (red_x < MAX_X - SQUARE_SIZE) begin
                        red_x <= red_x + 2;
                end else begin
                    current_state <= RED_UP;
                end
            end
            
            RED_UP: begin
                if (red_y > MIN_Y) begin
                    red_y <= red_y - 2;
                end else begin
                    current_state <= RED_LEFT;
                end
            end
            
            RED_LEFT: begin
                if (red_x > MIN_X) begin
                    red_x <= red_x - 2;
                end else begin
                    current_state = INIT;
                end
            end
        endcase
    end


    // Pixel drawing logic
    always @(posedge clk) begin
        case (current_state)
            INIT: begin
                if (col >= 6 && col < 6 + SQUARE_SIZE &&
                    row >= 4 && row < 4 + SQUARE_SIZE) begin
                    colour <= GREEN;  // Draw the square
                end
                else begin
                    colour <= BLACK;  // Background color
                end
            end
            MOVE_RIGHT: begin
                if (col >= MIN_X && col < green_x + SQUARE_SIZE &&
                    row >= MIN_Y && row < green_y + SQUARE_SIZE) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            WAIT_RIGHT: begin
                if (col >= MIN_X && col < green_x + SQUARE_SIZE &&
                    row >= MIN_Y && row < green_y + SQUARE_SIZE) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            
            MOVE_DOWN: begin
                if ((col >= 6 && col < 90 && 
                    row >= 4 && row < 19) || 
                    (col >= 75 && col < 90 &&
                    row >= MIN_Y && row < green_y + SQUARE_SIZE)) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            
            WAIT_DOWN: begin
                if ((col >= 6 && col < 90 && 
                    row >= 4 && row < 19) || 
                    (col >= 75 && col < 90 &&
                    row >= MIN_Y && row < green_y + SQUARE_SIZE)) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            MOVE_LEFT: begin
                if ((col >= 6 && col < 90 && 
                    row >= 4 && row < 19) ||
                    (col >= 75 && col < 90 &&
                    row >= 4 && row < 60) ||
                    (col >= green_x && col < 90 &&
                    row >= 45 && row < 60)) begin
                    colour<= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            WAIT_LEFT: begin
                if ((col >= 6 && col < 90 && 
                    row >= 4 && row < 19) ||
                    (col >= 75 && col < 90 &&
                    row >= 4 && row < 60) ||
                    (col >= green_x && col < 90 &&
                    row >= 45 && row < 60)) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            INIT_RED: begin
                if ((col >= 6 && col < 90 && 
                    row >= 4 && row < 19) || //top line
                    (col >= 75 && col < 90 &&
                    row >= 4 && row < 60) || //right line
                    (col >= 22 && col < 90 &&
                    row >= 45 && row < 60)) begin //bottom line
                    colour <= GREEN;
                end
                // initialise red square
                else if (col >= 6 && col <= 6 + SQUARE_SIZE &&
                        row >= 45 && row < 45 + SQUARE_SIZE) begin
                    colour <= RED;
                end
                else begin
                    colour <= BLACK;
                end
            end
            
            RED_RIGHT: begin
                if (col >= 6 && col <= red_x + SQUARE_SIZE &&
                    row >= 45 && row < red_y + SQUARE_SIZE) begin
                    colour <= RED;
                end
                else if ((col >= 6 && col < 90 && 
                        row >= 4 && row < 19) || //top line
                        (col >= 75 && col < 90 &&
                        row >= 4 && row < 60) || //right line
                        (col >= 22 && col < 90 &&
                        row >= 45 && row < 60)) begin //bottom line
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            
            RED_UP: begin
                if ((col >= 6 && col < 90 &&
                    row >= 45 && row < 60) ||    //bottom line red 
                    (col >= 75 && col < 90 &&
                    row >= red_y && row < 60)) begin //right line turning red
                    colour <= RED;
                end
                else if ((col >= 6 && col < 90 && 
                        row >= 4 && row < 19) || //top line
                        (col >= 75 && col < 90 &&
                        row >= 4 && row < 60)) begin //right line
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end
            end
            RED_LEFT: begin
                if ((col >= 6 && col < 90 &&
                    row >= 45 && row < 60) ||    //bottom line red 
                    (col >= 75 && col < 90 &&
                    row >= 4 && row < 60) || //right line red
                    (col >= red_x && col < 90 &&
                    row >= 4 && row < 19)) begin //top line turning red
                    colour <= RED;
                end
                else if (col >= 6 && col < 90 && 
                        row >= 4 && row < 19) begin
                    colour <= GREEN;
                end
                else begin
                    colour <= BLACK;
                end                  
            end                        
        endcase  
    end

endmodule
