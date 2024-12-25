//---------------------------------------16:4 Priority Encoder using if-else Statement---------------------------------------//
module encoder(
    input [15:0] data_in,
    output reg [3:0] data_out
);
    always @(*) begin
        if(data_in[15]) begin
            data_out = 4'b1111;
        end
        else if(data_in[14]) begin
            data_out = 4'b1110;
        end
        else if(data_in[13]) begin
            data_out = 4'b1101;
        end
        else if(data_in[12]) begin
            data_out = 4'b1100;
        end
        else if(data_in[11]) begin
            data_out = 4'b1011;
        end
        else if(data_in[10]) begin
            data_out = 4'b1010;
        end
        else if(data_in[9]) begin
            data_out = 4'b1001;
        end
        else if(data_in[8]) begin
            data_out = 4'b1000;
        end
        else if(data_in[7]) begin
            data_out = 4'b0111;
        end
        else if(data_in[6]) begin
            data_out = 4'b0110;
        end
        else if(data_in[5]) begin
            data_out = 4'b0101;
        end
        else if(data_in[4]) begin
            data_out = 4'b0100;
        end
        else if(data_in[3]) begin
            data_out = 4'b0011;
        end
        else if(data_in[2]) begin
            data_out = 4'b0010;
        end
        else if(data_in[1]) begin
            data_out = 4'b0001;
        end
        else if(data_in[0]) begin
            data_out = 4'b0000;
        end
        else begin
            data_out = 4'bx;
        end
    end
endmodule


