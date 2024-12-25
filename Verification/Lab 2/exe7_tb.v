//------------------- Verify 8:3 Priority Encoder using Casez Statements ----------------------//
module encoder_tb;

    // Test Inputs and Outputs
    reg [7:0] data_in;
    wire [2:0] data_out;
    reg [2:0] expected_data_out;

    // Checker variables
    integer passed, failed;

    // Instantiate the DUT (Device Under Test)
    encoder dut(
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        passed = 0;
        failed = 0;

        $display("\n---------- Testing 8:3 Priority Encoder ----------");

        // Apply test cases
        data_in = 8'b10000000; #10;
        data_in = 8'b01000000; #10;
        data_in = 8'b00100000; #10;
        data_in = 8'b00010000; #10;
        data_in = 8'b00001000; #10;
        data_in = 8'b00000100; #10;
        data_in = 8'b00000010; #10;
        data_in = 8'b00000001; #10;
        data_in = 8'b00000000; #10;

        // Mixed priority cases
        $display("\n---------- Testing Mixed Priority Inputs ----------");
        data_in = 8'b11000000; #10; // data_in[7] takes priority
        data_in = 8'b00110000; #10; // data_in[5] takes priority
        data_in = 8'b00001111; #10; // data_in[3] takes priority

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

        $finish; // End simulation
    end

    // Expected data_out logic using if statements
    task result(input [2:0] expected_data_out);
        begin
            // Compare data_out with expected_data_out
            if (data_out === expected_data_out) begin
                passed = passed + 1;
                $display("[PASSED] data_in=%b | data_out=%b", data_in, data_out);
            end else begin
                failed = failed + 1;
                $display("[FAILED] data_in=%b | Expected=%b | Got=%b", data_in, expected_data_out, data_out);
            end
        end
    endtask

    always @(*) begin
        if (data_in[7]) 
            expected_data_out = 3'b111;
        else if (data_in[6]) 
            expected_data_out = 3'b110;
        else if (data_in[5]) 
            expected_data_out = 3'b101;
        else if (data_in[4]) 
            expected_data_out = 3'b100;
        else if (data_in[3]) 
            expected_data_out = 3'b011;
        else if (data_in[2]) 
            expected_data_out = 3'b010;
        else if (data_in[1]) 
            expected_data_out = 3'b001;
        else if (data_in[0]) 
            expected_data_out = 3'b000;
        else 
            expected_data_out = 3'bxxx; // Default for invalid input
        
        #1ns;
        result(expected_data_out);
    end


    // Generate waveform for debugging
    initial begin
        $dumpfile("encoder_tb.vcd");
        $dumpvars(0, encoder_tb);
    end

endmodule
