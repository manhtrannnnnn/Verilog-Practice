    //-------------------------------------Verify D latch-------------------------------------//
    module d_latch_tb;

        // Test Inputs
        reg d, en;
        // Test Outputs
        wire out;

        // Test Checker
        reg expected_out;
        integer passed, failed;
    
        // Instantiate the D Latch module
        d_latch dut(
            .d(d),
            .en(en),
            .out(out)
        );
    
        // Test stimulus
        initial begin
            // Initial values
            passed = 0;
            failed = 0;
            
            // Test Inputs
            d = 1'b0; en = 1'b1; #10;  
            d = 1'b1; en = 1'b0; #10;  
            d = 1'b1; en = 1'b1; #10; 
            d = 1'b0; en = 1'b1; #10; 
            d = 1'b1; en = 1'b1; #10; 
            d = 1'b1; en = 1'b0; #10; 
            d = 1'b0; en = 1'b0; #10; 
            d = 1'b0; en = 1'b1; #10;  
            d = 1'bz; en = 1'b1; #10; 
            d = 1'b0; en = 1'b0; #10;
         	d = 1'b0; en = 1'b1; #10;  
            d = 1'b1; en = 1'b1; #10; 
            d = 1'b0; en = 1'b0; #10; 
          	d = 1'bx; en = 1'b1; #10;  
            d = 1'b1; en = 1'b1; #10; 
            d = 1'b0; en = 1'b0; #10; 
            
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
            
            $finish;  // End simulation
        end
    
        // Monitor the output signals
        initial begin
            passed = 0;
            failed = 0;
            $monitor("Time: %0t | D: %b, EN: %b | OUT: %b", $time, d, en, out);
        end

        // Checker
        task result(input expected_out);
            begin
            if(expected_out === out) begin
                passed = passed + 1;
            end
            else begin
                $display("[TEST FAILED!!!] D: %b, en: %b || out: %b || expected out: %b", d, en, out, expected_out);
                failed = failed + 1;
            end
            end
        endtask

        always @(*) begin
            if(en) expected_out = d;
          	if(expected_out === 1'bz) expected_out = 1'bx;
        end

        always @(*) begin
            result(expected_out);
        end

        // Generate waveform
        initial begin
            $dumpfile("dump.vcd");
            $dumpvars;
        end
    endmodule
