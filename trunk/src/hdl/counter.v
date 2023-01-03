`timescale 1ns/1ns
module counter #(parameter WIDTH = 6) (
    input clk, 
    input rst, 
    input inc,
    input init,
    input[WIDTH-1:0] PI,
    output reg[WIDTH-1:0] out,
    output co
);

    always @(posedge clk, posedge rst) begin
        if(rst) begin 
            out <= 0;
        end
        else if(init) begin
            out <= PI; 
        end
        else if(inc) begin
            out <= out + 1;
        end
    end

    assign co = &(out);
endmodule