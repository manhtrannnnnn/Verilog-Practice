//-------------------parallel in parallel out 8-bit rotational right shift register Non-Blocking--------------------------//
module pipo_shiftregister #(
    parameter N = 8
)(
    input clk, rst_n, load,
    input [N-1:0] data_in,
    output reg [N-1:0] data_out
);
    always @(posedge clk or negedge rst_n ) begin
        if(!rst_n) begin            // Reset State
            data_out <= 0;
        end
        else if(load) begin
            data_out <= data_in;
        end
        else begin
            data_out <= {data_out[0], data_out[N-1:1]};
        end
    end
endmodule












