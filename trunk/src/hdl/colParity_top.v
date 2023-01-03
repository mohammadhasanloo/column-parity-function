`timescale  1ns/1ns
module colParity_top #(parameter WIDTH = 25) (
    input clk, rst, start,
    input[WIDTH-1:0] curr_input,
	input[WIDTH-1:0] pre_input,
    output ready,
    output co_c64,
    output[WIDTH-1:0] out
);
    wire init_c64, inc_c64, init_c25, inc_c25, ld_x, pre_in_sel, curr_in_sel, ld_m, MemWrite, MemRead, co_c25;

    colParity_DP dp(.clk(clk), .rst(rst), .init_c64(init_c64), .inc_c64(inc_c64),
     .init_c25(init_c25), .inc_c25(inc_c25), .ld_x(ld_x), .pre_in_sel(pre_in_sel),
      .curr_in_sel(curr_in_sel), .ld_m(ld_m), .MemWrite(MemWrite), .MemRead(MemRead),
       .curr_input(curr_input), .pre_input(pre_input), .res_output(out),
        .co_c25(co_c25), .co_c64(co_c64));

    colParity_CU cu(.clk(clk), .rst(rst), .start(start), .co_c64(co_c64), .co_c25(co_c25),
     .ready(ready), .init_c64(init_c64), .inc_c64(inc_c64), .init_c25(init_c25),
      .inc_c25(inc_c25), .ld_x(ld_x), .pre_in_sel(pre_in_sel), .curr_in_sel(curr_in_sel),
       .ld_m(ld_m), .MemWrite(MemWrite), .MemRead(MemRead));

endmodule