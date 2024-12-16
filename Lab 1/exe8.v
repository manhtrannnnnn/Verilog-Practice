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