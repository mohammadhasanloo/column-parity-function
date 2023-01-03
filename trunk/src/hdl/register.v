`timescale 1ns/1ns
module register #(parameter WIDTH = 25) (
    input clk,
    input rst,
    input ld,
    input [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
);

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            out <= 0;
        end

        else if(ld) begin
            out <= in;
        end
        
    end

endmodule