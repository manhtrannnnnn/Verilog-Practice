//------------------------------------Y= A|B|C + A.B.E + |B.C + C|D ------------------------------------//
module exe4(
    input A, B, C, D, E,
    output Y
);
    wire not_B, not_C, not_D;

    // Not gates
    not n1(not_B, B);
    not n2(not_C, C);
    not n3(not_D, D);  
    
    // A|B|C
    wire out1, tmp1;
    and and1(tmp1, A, not_B);
    and and2(out1, tmp1, not_C);

    // A.B.E
    wire out2, tmp2;
    and and3(tmp2, A, B);
    and and4(out2, tmp2, E);    

    // |B.C
    wire out3;
    and and5(out3, not_B, C);

    // C|D
    wire out4;
    and and6(out4, C, not_D);

    // Final output
    wire out5, out6;
    or or1(out5, out1, out2);
    or or2(out6, out3, out4);
    or or3(Y, out5, out6);
endmodule