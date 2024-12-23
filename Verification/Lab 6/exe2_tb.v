//-----------------------------------Verify Count Zero-----------------------------------//
module zero_count_tb;
    
    // Test Inputs and Outputs
    reg [31:0] data_in;
    wire [5:0] count;
    // Test checker
    reg [5:0] expected_count;
    integer passed, failed;

    // Instantiate the module 
    zero_count dut(
        .data_in(data_in),
        .count(count)
    );

    // Test stimulus
    initial begin
        passed = 0;
        failed = 0;
        // Test cases
        data_in = 32'h00000000; #10; 
        data_in = 32'hFFFFFFFF; #10;
        data_in = 32'hAAAAAAAA; #10; 
        data_in = 32'h55555555; #10; 
        data_in = 32'hF0F0F0F0; #10; 
        data_in = 32'h0F0F0F0F; #10; 
        data_in = 32'h12345678; #10; 
        data_in = 32'h87654321; #10; 
        data_in = 32'hABCDEF12; #10; 
        data_in = 32'h13579BDF; #10; 
        data_in = 32'h02468ACE; #10; 
        data_in = 32'h80000001; #10; 
        data_in = 32'h7FFFFFFE; #10; 
        data_in = 32'hAAAAAAAA; #10; 
        data_in = 32'h0000FFFF; #10; 
        data_in = 32'hFFFF0000; #10; 
        
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
    end

    //Checker
    task result(input [5:0] expected_count);
        if(expected_count == count) begin
            passed = passed + 1;
        end
        else begin
            failed = failed + 1;
            $display("[Time: %0t] TEST FAILED: Data In: %b || Zero Count: %d || Expected Zero Count: %d", $time, data_in, count, expected_count);
        end
    endtask

    integer i;
    
    always @(*) begin
        expected_count = 0;
        for(i = 0; i < 32; i = i +2) begin
            if(data_in[i] == 0) expected_count++;
        end
        #1ns;
        result(expected_count);
    end
    
    // Monitor
    initial begin
        $monitor("Data In: %b, Number of odd Zeros: %d", data_in, count);
    end
endmodule