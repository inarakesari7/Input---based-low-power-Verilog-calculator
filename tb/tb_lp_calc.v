`timescale 1ns/1ps
module tb_lp_calc;

    reg        clk;
    reg        reset;
    reg [3:0]  a_in;
    reg [3:0]  b_in;
    reg [1:0]  op_in;
    wire [7:0] result;

    lp_calc_top dut (
        .clk(clk),
        .reset(reset),
        .a_in(a_in),
        .b_in(b_in),
        .op_in(op_in),
        .result(result)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

initial begin
    clk   = 0;
    reset = 1;
    a_in  = 0;
    b_in  = 0;
    op_in = 0;

    repeat (2) @(posedge clk);
    reset = 0;

    @(negedge clk);
    a_in  = 4'd3;
    b_in  = 4'd2;
    op_in = 2'b00;

    repeat (5) @(posedge clk);

    @(negedge clk);
    a_in  = 4'd7;
    b_in  = 4'd4;
    op_in = 2'b01;

    repeat (5) @(posedge clk);

    @(negedge clk);
    a_in  = 4'd3;
    b_in  = 4'd5;
    op_in = 2'b10;

    repeat (5) @(posedge clk);

    @(negedge clk);
    a_in  = 4'd8;
    b_in  = 4'd2;
    op_in = 2'b11;

    repeat (10) @(posedge clk);
    $finish;
end

endmodule
