//------------------------------------------7.Design XNOR Gate using 4:1 Multiplexer------------------------------------------//
module mux4to1(
    input in0, in1, in2, in3,
    input [1:0] sel,
    output out
);
    assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0);
endmodule


module xnor_logic(
    input in1, in2,
    output out
);
    
    // XNOR Truth table: 2'b00 -> 1 | 2'b01 -> 0 | 2'b10 -> 0 | 2'b11 -> 1 
    mux4to1 mux(
        .in0(1'b1),
        .in1(1'b0),
        .in2(1'b0),
        .in3(1'b1),
      	.sel({in1,in2}),
        .out(out)
    );
  
endmodule