//-------------------------------------Verify D Flip Flop-------------------------------------//
module dflipflop_tb;

    // Test Inputs
    reg clk;
    reg asyn_clear, asyn_preset;
    reg data_in;
    // Test Outputs
    wire data_out;
    // Checker
    integer passed, failed;
    reg expected_data_out;

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
        passed = 0;
        failed = 0;
        asyn_clear = 0; asyn_preset = 0; data_in = 1; #5; // Test clear
        asyn_clear = 1; data_in = 0; #10; // Testing change value
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
        asyn_preset = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;

        // Display the result of the module
        if (failed == 0) begin
            $display("============");
            $display("ALL TESTS PASSED");
            $display("============");
        end else begin
            $display("===============");
            $display("TEST FAILED");
            $display("Total Passed: %d", passed);
            $display("Total Failed: %d", failed);
            $display("===============");
        end
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

    //Checker
    task result(input expected_data_out);
        if(((expected_data_out == 1'bX) && (data_out == 1'bX))) begin
            passed = passed + 1;
        end
        else if(expected_data_out == data_out) begin
            passed = passed + 1;
        end
        else begin
            failed = failed + 1;
            $display("[Time: %0t] TEST FAILED: asyn_clear: %b, asyn_preset: %b, data_in: %b || data_out: %b || expected data_out: %b", $time, asyn_clear, asyn_preset, data_in, data_out, expected_data_out);
        end
    endtask

    always @(posedge clk or negedge asyn_clear or posedge asyn_preset) begin
        if(!asyn_clear && asyn_preset) expected_data_out <= 1'bX;
        else if(!asyn_clear) expected_data_out <= 0;
        else if(asyn_preset) expected_data_out <= 1;
        else expected_data_out <= data_in;
    end 

    always@(*) begin
        #1ns;
        result(expected_data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule