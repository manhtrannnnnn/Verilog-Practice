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
            d = 0; en = 1; #10;  
            result(expected_out);
            d = 1; en = 0; #10;  
            result(expected_out);
            d = 1; en = 1; #10; 
            result(expected_out);
            d = 0; en = 1; #10; 
            result(expected_out);
            d = 1; en = 1; #10; 
            result(expected_out);
            d = 1; en = 0; #10; 
            result(expected_out);
            d = 0; en = 0; #10; 
            result(expected_out);
            d = 0; en = 1; #10;  
            result(expected_out);
            d = 1; en = 1; #10; 
            result(expected_out);
            d = 0; en = 0; #10;  
            result(expected_out);
            
            //Display the result of module
            if(failed == 0) begin
            $display("============");
            $display("TEST PASSED");
            $display("============");
            end
            else begin
            $display("===============");
            $display("TEST FAILED!!!");
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
            if(expected_out == out) begin
                $display("[TEST PASSED]");
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
        end

        // Generate waveform
        initial begin
            $dumpfile("dump.vcd");
            $dumpvars;
        end
    endmodule
