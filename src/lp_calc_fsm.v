`timescale 1ns / 1ps

module lp_calc_fsm (
    input  wire clk,
    input  wire reset,
    input  wire event_detected,

    output reg  clk_en,
    output reg  compute_en
);

    // States
    localparam SLEEP  = 2'b00;
    localparam ACTIVE = 2'b01;
    localparam IDLE   = 2'b10;

    reg [1:0] state, next_state;

    // Idle timeout counter
    reg [3:0] idle_cnt;          
    localparam IDLE_TIMEOUT = 4'd8;

     always @(posedge clk) begin
        if (reset)
            state <= SLEEP;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset || state != IDLE)
            idle_cnt <= 4'd0;
        else
            idle_cnt <= idle_cnt + 1'b1;
    end

    // Next-state 
    always @(*) begin
        next_state = state;

        case (state)
            SLEEP: begin
                if (event_detected)
                    next_state = ACTIVE;
            end

            ACTIVE: begin
                next_state = IDLE;   
            end

            IDLE: begin
                if (event_detected)
                    next_state = ACTIVE;
                else if (idle_cnt >= IDLE_TIMEOUT)
                    next_state = SLEEP;
            end

            default: next_state = SLEEP;
        endcase
    end

    always @(*) begin
        // default values
        clk_en     = 1'b0;
        compute_en = 1'b0;

        case (state)
            SLEEP: begin
                clk_en     = 1'b0;
                compute_en = 1'b0;
            end

            ACTIVE: begin
                clk_en     = 1'b1;
                compute_en = 1'b1;
            end

            IDLE: begin
                clk_en     = 1'b1;
                compute_en = 1'b0;
            end
        endcase
    end

endmodule

