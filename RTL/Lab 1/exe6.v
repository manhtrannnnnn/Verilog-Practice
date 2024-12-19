//-------------------------------NAND Gate-------------------------------//
module nand_gate(
    input in1, in2,
    output out
);
    assign out = (in1 && in2) ? 0 : 1; // in1 == 1 and in2 == 1 => out = 0
endmodule

//-------------------------------Xor gate-------------------------------//
module xor_gate(
    input in1, in2,
    output out
);
    assign out = (in1 != in2) ? 1 : 0;
endmodule

//-------------------------------4:1 multiplexer-------------------------------//
module mux4to1(
    input in0, in1, in2, in3,
    input sel[1:0],
    output out
);
    assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0);
endmodule

//-------------------------------2 bit Magnitude Comparator-------------------------------//
module comparator2bit (
    input [1:0] in1, in2,
    output in1_greater_in2,
    output in1_equal_in2,
    output in1_less_in2
);
    assign in1_greater_in2 = (in1 > in2) ? 1 : 0;
    assign in1_less_in2 = (in1 < in2) ? 1 : 0;
    assign in1_equal_in2 = (in1 == in2) ? 1 : 0;

endmodule

//-------------------------------2:4 Decoder with enable-------------------------------//
module decoder2to4 (
    input in1, in2,
    input en,
    output [3:0] data_out
);
    wire [1:0] tmp;


    assign tmp = {in1, in2};
    assign data_out = (~en) ? 4'b0000 : 
                      (tmp == 2'b00) ? 4'b0001 :
                      (tmp == 2'b01) ? 4'b0010 :
                      (tmp == 2'b10) ? 4'b0100 : 4'b1000;
endmodule

//-------------------------------1 bit full adder-------------------------------//
module fullader1bit(
    input in1, in2, cin
    output sum,
    output overflow
);
    assign overflow = (a ^ b & cin) | (a & b);
    assign sum = a ^ b ^ cin;
endmodule

//-------------------------------Tri-State buffer-------------------------------//
module tristateBuffer(
    input data_in,
    input en,
    output data_out
);
    assign data_out = (en) ? data_in : 'bz;
endmodule
