//------------------------------------Design configurable full adder using parameter construct------------------------------------//
module dataflow_adder(
    input a, b, cin,
    output cout, sum
);
    assign cout = (a & b) | (b & cin) | (cin & a);
    assign sum = a ^ b ^ cin;
endmodule


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


module fulladder_tb;
    parameter N = 6;
    reg [N-1:0] a, b;
    wire [N-1:0] sum;
    wire overflow;

    fulladder_nbit #(
        .N(N)
    ) fulladder(
        .a(a),
        .b(b),
        .sum(sum),
        .overflow(overflow)
    );

    initial begin
        a <= 6'b001000;
        b <= 6'b010101;
        #10;
        a <= 6'b101001;
        b <= 6'b000010;
        #10;
        a <= 6'b010100;
        b <= 6'b101010;
        #10;
        a <= 6'b011111;
        b <= 6'b100000;
        #10;
        a <= 6'b000100;
        b <= 6'b110100;
        #10;
        a <= 6'b010011;
        b <= 6'b010101;
        #10;
        a <= 6'b010010;
        b <= 6'b011110;
        #10;
        a <= 6'b010101;
        b <= 6'b000101;
        #10;
        a <= 6'b001010;
        b <= 6'b111000;
        
        #50;
        $finish;
    end

    initial begin
        $monitor("[Time :%t] a = %b, b = %b | sum = %b, overflow = %b", $time, a, b, sum, overflow);
    end

    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule