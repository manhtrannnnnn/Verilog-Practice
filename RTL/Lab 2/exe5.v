//-------------------parallel in parallel out 8-bit rotational right shift register Non-Blocking--------------------------//
module pipo_shiftregister #(
    parameter Width = 8
)(
    input clk, rst_n, load,
    input [Width-1:0] data_in,
    output [Width-1:0] data_out
);
    always @(posedge clk or negedge rst_n ) begin
        if(!rst_n) begin            // Reset State
            data_out <= 0;
        end
        else if(load) begin
            data_out <= data_in;
        end
        else begin
            data_out <= {data_out[0], data_out[Width-1:1]};
        end
    end
endmodule












