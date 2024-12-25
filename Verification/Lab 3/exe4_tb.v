//--------------------------------------------- Verify Comparator Testbench ---------------------------------------------//
module comparator_tb();

    // Declare Input and output
    reg [2:0] A, B;
    wire gray, excess_3, more, less, no_relation;

    // DUT (Device Under Test)
    comparator dut (
        .A(A),
        .B(B),
        .gray(gray),
        .excess_3(excess_3),
        .more(more),
        .less(less),
        .no_relation(no_relation)
    );

    initial begin
        // Test with normal Data
        $display("----------Test normal flow----------");
        A = 3'b001; B = 3'b101; #10;
        A = 3'b101; B = 3'b011; #10;
        A = 3'b111; B = 3'b000; #10;
        A = 3'b100; B = 3'b001; #10;
        A = 3'b100; B = 3'b011; #10;
        A = 3'b000; B = 3'b001; #10;
        A = 3'b111; B = 3'b010; #10;
        A = 3'b111; B = 3'b011; #10;
        A = 3'b111; B = 3'b111; #10;
        
        $display("----------Test x, y value----------");
        A = 3'b0xz; B = 3'b101; #10;
        A = 3'b1x1; B = 3'bz11; #10;
        A = 3'b1x1; B = 3'bz0x; #10;
        A = 3'b10z; B = 3'b0z; #10;

        $finish;
    end

    // Monitor signal
    initial begin
        $monitor("Time: %0t || A: %b, B: %b || gray: %b, excess by 3: %b, more: %b, less: %b, no_relation: %b", 
                 $time, A, B, gray, excess_3, more, less, no_relation);
    end

    // Generate the waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
