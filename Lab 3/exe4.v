//-----------------Design a circuit which accepts two 3-bit inputs (A and B) and produces 5 1-bit outputs (gray, Excess-3, More, Less, no_relation)------------------//

module comparator (
    input [2:0] A,
    input [2:0] B,
    output gray,
    output excess_3,
    output more,
    output less,
    output no_relation
);
    wire [2:0] tmp;
    assign tmp = A ^ B;
    // Gray code
    assign gray = (tmp == 3'b100 || tmp == 3'b010 || tmp == 3'b001) ? 1 : 0;
    // Excess by 3
    assign excess_3 = ((A - B) == 3) || ((B - A) == 3);
    // More condition
    assign more = (A > B);
    // Less Condition
    assign less = (B > A);
    // No Relation
    assign no_relation = ~(gray | excess_3 | more | less);

endmodule



//---------------------------------------------Verify--------------------------------------------------//
module comparator_tb();

    // Declare Input and output
    reg [2:0] A, B;
    wire gray, excess_3, more, less, no_relation;

    // DUT 
    comparator dut(
        .A(A),
        .B(B),
        .gray(gray),
        .excess_3(excess_3),
        .more(more),
        .less(less),
        .no_relation(no_relation)
    );

    initial begin
        A <= 3'b001;
        B <= 3'b101;
        #5;
        A <= 3'b101;
        B <= 3'b011;
        #5;
        A <= 3'b111;
        B <= 3'b000;
        #5;
        A <= 3'b100;
        B <= 3'b001;
        #5;
        A <= 3'b100;
        B <= 3'b011;
        #5;
        A <= 3'b000;
        B <= 3'b001;
        #5;
        A <= 3'b111;
        B <= 3'b010;
        #5;
        A <= 3'b111;
        B <= 3'b011;
        #5;
      	A <= 3'b111;
      	B <= 3'b111;
      	#5;

        $finish;
    
    end

    //Monitor signal
    initial begin
        $monitor("Time: %0t || A: %b, B: %b || gray: %b, excess by 3: %b, more: %b, less: %b, no_relation: %b", 
                 $time, A, B, gray, excess_3, more, less, no_relation);
    end


    //Generate the waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule

