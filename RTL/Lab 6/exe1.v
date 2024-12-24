//----------------------------------- Parity Generator -----------------------------------//
module parity_generator(
    input clk, asyn_rst,
    input valid_in,
    input data_in,
  	output reg [8:0] data_out,
    output reg valid_out
);
  	reg [7:0] shift_tmp;
    reg parity;
    reg [2:0] count;

    always @(posedge clk or negedge asyn_rst) begin
        if(!asyn_rst) begin
            data_out <= 9'b0;
            valid_out <= 1'b0;
            shift_tmp <= 8'b0;
            parity <= 1'b0;
            count <= 0;
        end
        else if(valid_in) begin
            if(count == 3'b111) begin
                data_out <= {parity ^ data_in, shift_tmp[6:0],data_in};
                valid_out <= 1'b1;
                count <= 1'b0;
              	parity <= 1'b0;
            end
            else begin
                shift_tmp <= {shift_tmp[6:0], data_in};
                count <= count + 1;
                parity <= parity ^ data_in;
                valid <= 1'b0;
            end
        end
        else begin
            valid_out <= 0;
        end
    end
endmodule 