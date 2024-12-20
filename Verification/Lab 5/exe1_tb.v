//-------------------------------------Verify-------------------------------------//
module dflipflop_tb;

    // Test Inputs
    reg clk;
    reg asyn_clear, asyn_preset;
    reg data_in;
    // Test Outputs
    wire data_out;

    // Instantiate the module
    dflipflop dut(
        .clk(clk),
        .asyn_clear(asyn_clear),
        .asyn_preset(asyn_preset),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        $display("------------Test D Flip Flop------------");
        asyn_clear = 0; asyn_preset = 0; data_in = 1; #5; // Test clear
        asyn_clear = 1; data_in = 0; #10; // Testing change value when clock rising
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;

        #2; asyn_preset = 1; // Testing asynchronous preset
        #20; asyn_preset = 0;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;

        #2 asyn_clear = 0; data_in = 1; // Testing asynchronous asynchronous clear
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        $finish;
    end

    // Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor the ouput
    initial begin
        $monitor("asyn_clear: %b, asyn_preset: %b, data_in: %b || data_out: %b", asyn_clear, asyn_preset, data_in, data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule