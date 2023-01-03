`timescale 1ns/1ns
module colparity_same_matrix #(parameter WIDTH = 25) (
    input clk, 
    input rst, 
    input[4:0] index,
	input [WIDTH-1:0] xreg_out,
    output reg [WIDTH-1:0] parity1_out
);
   
    wire curr_page;
    wire [4:0] i;
	assign i = ((index%5) == 0) ? 5'd4 : (index - 1) % 5;
	
    assign curr_page = xreg_out[24-(5'd20+i)] ^ xreg_out[24-(5'd15+i)]
     ^ xreg_out[24-(5'd10+i)] ^ xreg_out[24-(5'd5+i)] ^ xreg_out[24-(i)];

   always @(posedge clk, posedge rst) begin 
        if(rst)
            parity1_out <= 0;
        else
            parity1_out[index] <= curr_page ^ xreg_out[24-index];
    end
endmodule