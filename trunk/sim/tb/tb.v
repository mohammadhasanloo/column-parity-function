
`timescale 1ns/1ns
module TB #(parameter WIDTH = 25)();
    reg [24:0] Mem [0:63];
    reg clk = 0;
    reg rst = 0;
    reg start = 0;
    reg [WIDTH-1:0] curr_input;
	reg [WIDTH-1:0] pre_input;
    wire ready, co_c64;
    wire [WIDTH-1:0] data_out;
	
    reg [8*18:0]input_file_name = "./file/input_i.txt";
    reg [8*19:0]output_file_name = "./file/output_i.txt";

    colParity_top UUT(.clk(clk), .rst(rst), .start(start), .curr_input(curr_input),
	.pre_input(pre_input), .ready(ready), .co_c64(co_c64) ,.out(data_out));

    integer input_file, output_file, i, j, testscounts=3, k;

    always #(5) clk = ~clk;

    initial begin
		for(i=0;i<testscounts;i=i+1) begin
		    $sformat(input_file_name, "./file/input_%0d.txt", i);
            $sformat(output_file_name, "./file/output_%0d.txt", i);
			$readmemb(input_file_name,Mem);
			
			rst = 1;
			#15
			rst = 0;
			start = 1;
			#15
			start = 0;
        
			input_file = $fopen(input_file_name, "r");
			output_file = $fopen(output_file_name, "w");
			for(k = 0; k < 64; k= k+1)  begin
                curr_input = Mem[k];
				if(k==0) begin
					pre_input = Mem[63];
				end else begin
				    pre_input = Mem[k-1];
				end
				#540
				$fwrite(output_file, "%b\n", data_out);
				$display("----\n%b\n%b\n----\n", curr_input, data_out);
			end
			$fclose(input_file);
			$fclose(output_file);
		end
        #30
        $stop;
    end
endmodule