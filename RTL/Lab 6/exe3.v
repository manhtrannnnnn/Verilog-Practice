//--------------------------------------Flow Control--------------------------------------//
module flowcontrol(
    input clk,
    input asyn_rst,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);
    reg [7:0] previous_data;
    always @(posedge clk or negedge asyn_rst) begin
        if(!asyn_rst) begin
            valid_out <= 0;
            data_out <= 16'b0;
            previous_data <= 8'b0;
        end
        else begin
            if(valid_in) begin
                data_out <= {previous_data, data_in};
                valid_out <= 1;
                previous_data <= data_in;
            end
            else begin
                valid_out <= 0;
            end
        end
    end
endmodule