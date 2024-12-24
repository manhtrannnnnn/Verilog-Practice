//--------------------------Verify mux 4 to 1---------------------//
module xnor_logic_tb;
    
    // Test Inputs and Outputs
    reg in1, in2;
    wire out;

    // Instantiate the module
    xnor_logic dut(
        .in1(in1),
        .in2(in2),
        .out(out)
    );

    // Test stimulus
    initial begin
        $display("---- 4:1 Multiplexer Test ----");
        in1 = 1'b0; in2 = 1'b0; #10;
        in1 = 1'b0; in2 = 1'b1; #10;
        in1 = 1'b1; in2 = 1'b0; #10;
        in1 = 1'b1; in2 = 1'b1; #10;
        in1 = 1'bx; in2 = 1'b0; #10;
        in1 = 1'bz; in2 = 1'b0; #10;
        in1 = 1'bx; in2 = 1'bx; #10;
        in1 = 1'bz; in2 = 1'bz; #10;
        in1 = 1'b1; in2 = 1'bx; #10;
        $finish;
    end

    // Monitor the output signals
    initial begin
        $monitor("Time: %0t | in1: %b, in2: %b | out: %b", $time, in1, in2, out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule

