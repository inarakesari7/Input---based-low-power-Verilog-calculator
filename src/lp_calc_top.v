`timescale 1ns / 1ps

module lp_calc_top (
    input  wire        clk,
    input  wire        reset,
    input  wire [3:0]  a_in,
    input  wire [3:0]  b_in,
    input  wire [1:0]  op_in,
    output reg  [7:0]  result
);

    reg [3:0] a_reg, b_reg;
    reg [1:0] op_reg;
    wire clk_en;
    wire compute_en;
    wire [7:0] alu_result;

    // FSM module instanciated 
    lp_calc_fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .event_detected(event_detected),
        .clk_en(clk_en),
        .compute_en(compute_en)
    );

    //input change detection
    reg [3:0] a_prev, b_prev;
    reg [1:0] op_prev;
    wire event_detected;
    assign event_detected = (a_in != a_prev) ||
                            (b_in != b_prev) ||
                            (op_in != op_prev);

    //previous inputs
    always @(posedge clk) begin
        if (reset) begin
            a_prev  <= 4'd0;
            b_prev  <= 4'd0;
            op_prev <= 2'd0;
        end else begin
            a_prev  <= a_in;
            b_prev  <= b_in;
            op_prev <= op_in;
        end
    end

    // Input registers (clock-enabled)
    always @(posedge clk) begin
        if (reset) begin
            a_reg  <= 4'd0;
            b_reg  <= 4'd0;
            op_reg <= 2'd0;
        end else if (clk_en) begin
            a_reg  <= a_in;
            b_reg  <= b_in;
            op_reg <= op_in;
        end
    end

    // Arithmetic module instantiated
    lp_calc_arith op_inst (
        .a(a_reg),
        .b(b_reg),
        .op(op_reg),
        .result(alu_result)
    );

   always @(posedge clk) begin
        if (reset) begin
            result <= 8'd0;
        end else if (compute_en) begin
            result <= alu_result;
        end
    end

endmodule

