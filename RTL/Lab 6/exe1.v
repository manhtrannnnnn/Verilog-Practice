//----------------------------------- Parity Generator -----------------------------------//
module parity_generator(
    input clk, asyn_rst,
    input valid_in,
    input data_in,
    output reg [7:0] data_out,
    output reg parity,
    output reg valid_out
);
    reg [7:0] shift_tmp;
    reg parity_tmp;
    reg [2:0] count;

    always @(posedge clk or negedge asyn_rst) begin
        if(!asyn_rst) begin
            data_out <= 7'b0;
            parity <= 1'b0;
            valid_out <= 1'b0;
            shift_tmp <= 7'b0;
            parity_tmp <= 1'b0;
            count <= 3'b000;
        end
        else if(valid_in) begin
          	// Convert serial to parallel
            shift_tmp <= {shift_tmp[6:0], data_in};
            count <= count + 1;
            parity_tmp = parity_tmp ^ data_in;
          
            if(count == 3'b111) begin
                data_out <= {shift_tmp[6:0], data_in};
                parity <= parity_tmp ^ data_in;
                valid_out <= 1'b1;
                // Reset count and parity_tmp
                count <= 3'b000;
                parity_tmp <= 1'b0;
            end
        end
        else begin
            valid_out <= 1'b0;
        end
    end
endmodule 