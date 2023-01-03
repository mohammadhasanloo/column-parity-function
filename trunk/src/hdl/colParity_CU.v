`timescale 1ns/1ns
module colParity_CU (
    input clk, rst, start, co_c64, co_c25,
    output reg ready, init_c64, inc_c64, init_c25,
     inc_c25, ld_x, pre_in_sel, curr_in_sel, ld_m, MemWrite, MemRead
);
    parameter[3:0] idle=0, init_counter64=1, load_curr_input=2, compute_first_parity=3, load_pre_input=4, compute_second_parity=5,
     write_in_memory=6, read_memory=7, done =8;
    reg[3:0] pstate, nstate;

    always@ (start, co_c64, co_c25, pstate) begin

        nstate = 4'b0;
        {ready, init_c64, inc_c64, init_c25, inc_c25, ld_x, pre_in_sel, curr_in_sel, ld_m, MemWrite, MemRead} = 11'b0;

        case(pstate)
            idle                 :begin nstate = start ? init_counter64 : idle; ready=1'b1; end
            init_counter64       :begin nstate = load_curr_input; init_c64=1'b1; end
            load_curr_input      :begin nstate = compute_first_parity; ld_x=1'b1; curr_in_sel=1'b1; init_c25=1'b1; end
            compute_first_parity :begin nstate = co_c25 ? load_pre_input : compute_first_parity; inc_c25=1'b1; end
	        load_pre_input       :begin nstate = compute_second_parity; ld_x=1'b1; ld_m=1'b1; init_c25=1'b1; pre_in_sel=1'b1; end
            compute_second_parity:begin nstate = co_c25 ? write_in_memory : compute_second_parity; inc_c25=1'b1; end
            write_in_memory      :begin nstate = read_memory; MemWrite=1'b1; end
			read_memory          :begin nstate = co_c64 ? done : load_curr_input; MemRead=1'b1; inc_c64=1'b1; end
			done                 :begin nstate = idle; end
            //read_memory          :begin nstate = idle; MemRead=1'b1; end
        endcase

    end

    always@ (posedge clk, posedge rst) begin
        if(rst)
            pstate <= idle;
        else
            pstate <= nstate;
    end        

endmodule