//--------------------------------------9.Design 3:8 Decoder with enable using 2:4 Decoder--------------------------------------//
module decoder2to4 (
    input in1, in2,
    input en,
    output [3:0] data_out
);
    wire [1:0] tmp;

    assign tmp = {in2, in1};

    // Use `en` to control the output
    assign data_out = ~en ? 4'b0000 : 
                      (tmp == 2'b00) ? 4'b0001 :
                      (tmp == 2'b01) ? 4'b0010 :
                      (tmp == 2'b10) ? 4'b0100 : 4'b1000;
endmodule


module decoder3to8(
    input [2:0] data_in,
    input en,
    output [7:0] data_out
);

    wire [3:0] tmp;

    decoder2to4 d1(
        .in1(data_in[0]),
        .in2(data_in[1]),
        .en(~data_in[2]),
        .data_out(data_out[3:0])
    );

    decoder2to4 d2(
        .in1(data_in[0]),
        .in2(data_in[1]),
        .en(data_in[2]),
        .data_out(data_out[7:4])
    );
endmodule