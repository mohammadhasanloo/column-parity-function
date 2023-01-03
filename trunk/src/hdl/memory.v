`timescale 1ns/1ns
module memory #(parameter WIDTH = 6) (
	input clk,
	input rst,
	input mem_write,
    input mem_read,
	input [WIDTH-1:0] addr_in,
	input[24:0] data_in,
	output [24:0] data_out
);
    reg[24:0] mem;

	always@ (posedge clk, posedge rst) begin
	if(mem_write)
		mem <= data_in;
	end
         
        assign data_out = (mem_read==1'b1) ? mem : 25'b0;
endmodule
