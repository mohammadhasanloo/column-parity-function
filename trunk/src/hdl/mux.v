`timescale 1ns/1ns
module mux #(parameter WIDTH = 25)(
    input curr_sel,
    input pre_sel,
    input[WIDTH-1:0] curr_input,
    input[WIDTH-1:0] pre_input,
    output[WIDTH-1:0] out
);

    assign out = curr_sel ? curr_input : pre_sel ? pre_input : 0;

endmodule