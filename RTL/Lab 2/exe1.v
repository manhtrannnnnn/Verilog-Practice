//--------------------------------- 2:4 using gate level modeling----------------------------------------------//
module decoder2to4(
    input a, b,
    input en,
    output out0, out1, out2, out3 
);
    wire not_a, not_b, not_en;

    not n1(not_a, a);
    not n2(not_b, b);
    not n3(not_en, en);

    nand(out0, not_a, not_b, not_en);
    nand(out1, not_a, b, not_en);
    nand(out2, a, not_b, not_en);
    nand(out3, a, b, not_en);
endmodule