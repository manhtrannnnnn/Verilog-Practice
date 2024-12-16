//-------------------------------NAND Gate-------------------------------//
module nand_gate(
    input in1, in2,
    output out
);
    nand n1(out, in1, in2);
endmodule

//-------------------------------Xor gate//-------------------------------//
module xor_gate(
    input in1, in2,
    output out
);
    xor(out, in1, in2);
endmodule

//-------------------------------4:1 multiplexer//-------------------------------//
module mux4to1(
    input in0, in1, in2, in3,
    input sel[1:0],
    output out
);
    assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0);
endmodule

//-------------------------------2 bit Magnitude Comparator-------------------------------//
module 2-bit_comparator(
    input 
);
endmodule