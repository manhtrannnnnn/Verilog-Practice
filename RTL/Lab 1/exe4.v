//--------------------------------T flipflop using Latches--------------------------------------//
module sr_latch(
    input in1, in2,
    output q
);
    wire not_q;
    nand u1(q, in1, not_q); // q = ~(in1 & (q'))
    nand u2(not_q, q, in2); // q' = ~(in2 & (q))
endmodule

module t_flip_flop(
    input T, clk, async_set, async_clear,
    output Q
);
    wire s, r;

    // Asynchronous Set and Clear Logic
    assign s = async_set ? 1 : T & ~Q;
    assign r = async_clear ? 1 : ~T & Q;

    // Instantiate SR Latch
    sr_latch sr (
        .in1(s),
        .in2(r),
        .q(Q)
    );

endmodule
