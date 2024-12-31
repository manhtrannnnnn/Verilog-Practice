//--------------------------------- 2:4 using gate level modeling----------------------------------------------//
module decoder2to4(
    input a, b,
    input en,
    output out0, out1, out2, out3 
);
    wire not_a, not_b;

    not n1(not_a, a);
    not n2(not_b, b);

    and(out0, not_a, not_b, en);
    and(out1, not_a, b, en);
    and(out2, a, not_b, en);
    and(out3, a, b, en);
    
endmodule