//--------------------------Verify mux 4 to 1---------------------//
module mux4to1_tb;
    reg in0, in1, in2, in3;
    reg [1:0] sel;
    wire out;

    // Instantiate the module
    mux4to1 uut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel),
        .out(out)
    );

    // Test stimulus
    initial begin
        $display("---- 4:1 Multiplexer Test ----");
        in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b00; #10;
        in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b01; #10;
        in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b10; #10;
        in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b11; #10;
        $finish;
    end

    // Monitor the output signals
    initial begin
        $monitor("Time: %0t | in0: %b, in1: %b, in2: %b, in3: %b, sel: %b | out: %b", $time, in0, in1, in2, in3, sel, out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
