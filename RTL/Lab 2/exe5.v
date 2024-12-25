//-------------------parallel in parallel out 8-bit rotational right shift register Non-Blocking--------------------------//
module pipo_shiftregister_nonblocking #(
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

//-------------------parallel in parallel out 8-bit rotational right shift register Blocking--------------------------//
module pipo_shiftregister_blocking(
    input wire clk,
    input wire rst_n,
    input wire load,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // Using blocking assignment
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out = 8'b0;
        end
        else begin
            if (load) begin
                data_out = data_in;
            end
            else begin
                // Rotational right shift
                data_out = {data_out[0], data_out[7:1]};
            end
        end
    end

endmodule














