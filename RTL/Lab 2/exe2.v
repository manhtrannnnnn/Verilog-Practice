//------------------------------------Design 8:3 priority encoder using dataflow modeling------------------------------------//\
module encoder(
    input [7:0] data_in,
    output [2:0] data_out
);
    assign data_out =   (data_in[7]) ? 3'b111 :
                        (data_in[6]) ? 3'b110 :
                        (data_in[5]) ? 3'b101 :
                        (data_in[4]) ? 3'b100 :
                        (data_in[3]) ? 3'b011 :
                        (data_in[2]) ? 3'b010 :
                        (data_in[1]) ? 3'b001 :
                        (data_in[0]) ? 3'b000 : 3'bxxx;
endmodule