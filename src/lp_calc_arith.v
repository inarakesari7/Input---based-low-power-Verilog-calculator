`timescale 1ns / 1ps
module lp_calc_arith(
    input  wire [3:0] a,        
    input  wire [3:0] b,        
    input  wire [1:0] op,       
    output reg  [7:0] result    
);

always @(*) begin
    case (op)
        2'b00: result = a + b;          // Addition 
        2'b01: result = a - b;          // Subtraction 
        2'b10: result = a * b;          // Multiplication
        2'b11: begin                    // Division 
            if (b != 0)
                result = a / b;
            else
                result = 8'd0;           
        end
        default: result = 8'd0;
    endcase
end
endmodule
