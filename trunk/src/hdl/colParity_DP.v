`timescale 1ns/1ns
module colParity_DP #(parameter WIDTH = 25)(
    input clk, rst, init_c64, inc_c64, init_c25,
     inc_c25, ld_x, pre_in_sel, curr_in_sel, ld_m, MemWrite, MemRead,
    input[WIDTH-1:0] curr_input,
	input[WIDTH-1:0] pre_input,
    output [WIDTH-1:0] res_output,
    output co_c25, co_c64
);
    wire[WIDTH-1:0] xreg_out, mreg_out;
    wire[5:0] out_c64;
	wire[4:0] out_c25;
    wire[WIDTH-1:0] mux_out;
    wire[WIDTH-1:0] parity1_out, parity2_out;

    mux mux2to1(.curr_sel(curr_in_sel), .pre_sel(pre_in_sel),
     .curr_input(curr_input), .pre_input(pre_input), .out(mux_out));
	 
    counter #(6) counter64(.clk(clk), .rst(rst), .inc(inc_c64),
	 .init(init_c64), .PI(6'b000000), .out(out_c64), .co(co_c64));
	
	counter #(5) counter25(.clk(clk), .rst(rst), .inc(inc_c25),
	 .init(init_c25), .PI(5'b00111), .out(out_c25), .co(co_c25));
	
    register xreg(.clk(clk), .rst(rst), .ld(ld_x), .in(mux_out), .out(xreg_out));
    register mreg(.clk(clk), .rst(rst), .ld(ld_m), .in(parity1_out), .out(mreg_out));
	  
    memory data_memory(.clk(clk), .rst(rst), .mem_write(MemWrite),
     .mem_read(MemRead), .addr_in(out_c64), .data_in(parity2_out), .data_out(res_output));

    colparity_same_matrix parity_fun1(.clk(clk), .rst(rst), .index(out_c25-5'b00111),
     .xreg_out(xreg_out), .parity1_out(parity1_out));

    colparity_different_matrix parity_fun2(.clk(clk), .rst(rst), .index(out_c25-5'b00111),
     .curr_parity(mreg_out), .prev_page(xreg_out), .parity2_out(parity2_out));
endmodule