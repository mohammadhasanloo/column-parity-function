`timescale 1ns/1ns
module colparity_different_matrix #(parameter WIDTH = 25) (
    input clk, 
    input rst, 
    input[4:0] index,
	input [WIDTH-1:0] curr_parity,
	input [WIDTH-1:0] prev_page,
    output reg [WIDTH-1:0] parity2_out
);
   
    wire colparity;
    wire [4:0] i = (index + 1) % 5;
	
    assign colparity = prev_page[24-(5'd20+i)] ^ prev_page[24-(5'd15+i)]
     ^ prev_page[24-(5'd10+i)] ^ prev_page[24-(5'd5+i)] ^ prev_page[24-(i)];

   always @(posedge clk, posedge rst) begin 
        if(rst)
            parity2_out <= 0;
        else 
            parity2_out[24-index] <= colparity ^ curr_parity[index];
    end
endmodule