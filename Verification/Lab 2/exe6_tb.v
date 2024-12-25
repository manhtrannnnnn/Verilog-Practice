//------------------- Verify 16:1 Mux using Case Statements ----------------------//
module mux16to1_tb;

    // Test Inputs and Outputs
    reg [15:0] data_in;
    reg [3:0] sel;
    wire data_out;
    integer passed, failed;

    // Instantiate the module
    mux16to1 dut(
        .data_in(data_in),
        .sel(sel),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        passed = 0;
        failed = 0;

        // Fixed data_in for all tests
        data_in = 16'b1010_0101_1100_0011; // Example input data

        // Test each sel value manually
        $display("\n---------- Testing normal Value ----------");

        sel = 4'b0000; #10; 
        sel = 4'b0001; #10; 
        sel = 4'b0010; #10; 
        sel = 4'b0011; #10; 
        sel = 4'b0100; #10; 
        sel = 4'b0101; #10; 
        sel = 4'b0110; #10; 
        sel = 4'b0111; #10; 
        sel = 4'b1000; #10; 
        sel = 4'b1001; #10; 
        sel = 4'b1010; #10; 
        sel = 4'b1011; #10; 
        sel = 4'b1100; #10; 
        sel = 4'b1101; #10; 
        sel = 4'b1110; #10; 
        sel = 4'b1111; #10; 

        // Test with x,y value for data in
        data_in = 16'b0110_00xz_0x0z_0x0z;
        $display("\n---------- Testing X, Y Value for Data In ----------");
        sel = 4'b0000; #10; 
        sel = 4'b0001; #10; 
        sel = 4'b0010; #10; 
        sel = 4'b0011; #10; 
        sel = 4'b0100; #10; 
        sel = 4'b0101; #10; 
        sel = 4'b0110; #10; 
        sel = 4'b0111; #10; 
        sel = 4'b1000; #10; 
        sel = 4'b1001; #10; 
        sel = 4'b1010; #10; 
        sel = 4'b1011; #10; 
        sel = 4'b1100; #10; 
        sel = 4'b1101; #10; 
        sel = 4'b1110; #10; 
        sel = 4'b1111; #10; 

        // Test with x, y value for enable
        data_in = 16'b0110_1101_0001_0101;
        $display("\n---------- Testing X, Y Value for Data In ----------");
        sel = 4'b0xz0; #10; 
        sel = 4'b00z1; #10; 
        sel = 4'b0xzz; #10; 


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

    // Task to check the result
    task result(input expected_out);
        begin
            if (data_out === expected_out) begin
                passed = passed + 1;
                $display("[PASSED] sel=%b | data_out=%b", sel, data_out);
            end else begin
                $display("[FAILED] sel=%b | Expected=%b | Got=%b", sel, expected_out, data_out);
                failed = failed + 1;
            end
        end
    endtask

    always @(*) begin
        #1ns;
        result(data_in[sel]);
    end

    // Generate waveform for debugging
    initial begin
      	$dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
