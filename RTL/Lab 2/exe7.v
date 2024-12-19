//----------------------------- Design 8:3 priority encoder using casez statements------------------------------------//
module encoder(
    input [7:0] in,
    output [2:0] out
);
    always @(*) begin
        casez(in)
            8'b1zzzzzzz: out = 3'b111;
            8'b01zzzzzz: out = 3'b110;
            8'b001zzzzz: out = 3'b101;
            8'b0001zzzz: out = 3'b100;
            8'b00001zzz: out = 3'b011;
            8'b000001zz: out = 3'b010;
            8'b0000001z: out = 3'b001;
            8'b00000001: out = 3'b000;
            default: out = 3'bxxx;
        endcase
    end
endmodule