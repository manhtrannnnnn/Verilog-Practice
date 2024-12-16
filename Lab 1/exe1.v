//--------------------------------Data Flow single Adder----------------------------------//

module dataflow_adder(
    input a, b, cin
    output cout, sum
);
    assign cout = (a ^ b & cin) | (a & b);
    assign sum = a ^ b ^ cin;
endmodule

//--------------------------------n-bit full adder---------------------------------------//

module n-bit_adder #(
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
                    .b(a[i]),
                    .cin(cout[i-1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
        end
        assign overflow = cout[N-1];
    endgenerate

    
endmodule

//--------------------------------Gate Level single bit Adder-------------------------------//

module gate_adder (
    input a, b, cin,
    output cout, sum
);
    wire xor1;
    wire and1, and2;
    wire or1;

    xor out1(sum,a,b);
    xor out2(xor2,xor1,cin);
    and out3(and1,cin,xor1);
    and out4(and2,a,b);
    or out5(cout,and1,and2);
endmodule

//-----------------------------8-bit from 4-bit adder-----------------------------------------//

module 8-bit_adder(
    input [7:0] a, b, cin
    output cout,
    output [7:0] sum
);

endmodule




