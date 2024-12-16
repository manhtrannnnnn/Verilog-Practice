//-------------------------------D Latch using gate leve------------------------------------//
module sr_latch(
    input in1, in2,
    output q
);
    wire not_q;
    nand u1(q, in1, not_q);
    nand u2(not_q, q, in2);
endmodule

module d_latch(
    input d, en,
    output out
);
    wire not_d;
    wire out1, out2;
    nand n1(out1, d, en);
    nand n2(out2,not_d, en);

    sr_latch sr(
        .in1(out1),
        .in2(out2),
        .q(out)
    );

endmodule


