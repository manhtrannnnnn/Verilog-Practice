//--------------------------------Data Flow single Adder----------------------------------//

module dataflow_adder(
    input a, b, cin,
    output cout, sum
);
    assign cout = (a & b) | (b & cin) | (cin & a);
    assign sum = a ^ b ^ cin;
endmodule

//--------------------------------n-bit full adder---------------------------------------//

module fulladder_nbit #(
    parameter N = 4
)( 
    input [N-1:0] a, b, 
    output [N-1:0] sum,
    output overflow
);
    wire[N-1:0] cout;
    generate 
        genvar i;
        for(i = 0;i < N; i++) begin
            if(i == 0) begin
                dataflow_adder adder(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(1'b0),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
            else begin
                dataflow_adder adder(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
        end
    endgenerate
    
    assign overflow = cout[N-1];
    
endmodule

//--------------------------------Gate Level single bit Adder-------------------------------//

module gate_adder (
    input a, b, cin,
    output cout, sum
);
    // Sum = a ^ b ^ cin
    xor x1(sum, a, b, cin);

    // cout = (a & b) | (b & cin) | (cin & a) 
    wire out1, out2, out3;

    and a1(out1, a, b); // out1 = a & b
    and a2(out2, b, cin);// out2 = b & cin
    and a3(out3, a, cin);
    or  o1(cout, out1, out2, out3);

    
endmodule






