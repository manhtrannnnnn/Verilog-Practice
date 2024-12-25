//--------------------------------------------16 bit parallel in parallel out universal Shift Register------------------------------------------/
module pipo_shiftregister(
    input clk, rst_n, load, shift_en, 
    input [1:0] opcode,             // 00 -> Left Shift || 01 -> Right Shift || 10 -> Rotational Left Shift || 11 -> Rotational Right Shift
    input [15:0] data_in,
    output reg [15:0] data_out
);
    always @(posedge clk) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else if(load) begin
            data_out <= data_in;
        end
        else if(shift_en) begin
            case(opcode)
                2'b00: begin    // Left Shift
                    data_out <= (data_out << 1);
                end
                2'b01: begin    // Right Shift
                    data_out <= (data_out >> 1);
                end
                2'b10: begin    // Rotational Left Shift
                    data_out <= {data_out[14:0],data_out[15]};
                end
                2'b11: begin    // Rotational Right Shift
                    data_out <= {data_out[0],data_out[15:1]};
                end
                default: data_out <= 16'bx;
            endcase
        end
    end

endmodule 



