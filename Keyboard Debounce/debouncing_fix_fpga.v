// keyboard switches are mechanical which result in weird signal
// to make only one clock cycle worth keypress, use the following circuit

/*
Modules: 
    main module
    d flip flop
    clock divider
*/

// consider main clock speed of 100MHz
// slowed down to one hertz so keyboard key will be available for one second before any other key press is there.


module top_level_debounce(clk, in, reset, key);

input clk, in, reset;
output key;

wire slow_clk;
wire q1;
wire q2;

clock_divider main_divider (clk, reset, slow_clk);
d_flip_flop first (slow_clk, reset, in, q1);
d_flip_flop second (slow_clk, reset, q1, q2);

assign key = q1 & ~q2;



endmodule


module clock_divider (in_clk, reset, out_clk);
    input in_clk, reset;
    output reg out_clk;

    reg [26:0] divisor;

    always @ (posedge in_clk) begin
        if (reset) begin
            divisor <= 0;
            out_clk <= 0;
        end
        else if (divisor < 100000000) begin
            out_clk <= 0;
        end
        else begin
           divisor <= 0;
           out_clk <= 1; 
        end
    end

endmodule


module d_flip_flop (clk, reset, d, q);
    input clk, reset, d;
    output reg q;
    always @ (posedge clk) begin
        if (reset) q <= 0;
        else q <= d;     
    end
endmodule