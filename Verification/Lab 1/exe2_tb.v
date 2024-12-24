//-------------------------Verify Mux 4 to 1 using logic gate-------------------------//
module mux4to1_logicgate_tb;

    // Test Input
    reg in1, in2, in3, in4;
    reg [1:0] sel;
    // Test output
    wire out;

    // Test Checker
    reg expected_out;
    integer passed, failed;
  
    // Instantiate the module
    mux4to1_logicgate dut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );
  
    // Test stimulus
    initial begin
        // Test all combinations of inputs and select lines
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b0; in4 = 1'b0; sel = 2'b00; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b0; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b1; in3 = 1'b0; in4 = 1'b0; sel = 2'b01; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b1; in4 = 1'b0; sel = 2'b10; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b01; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b10; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b01; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b10; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'bx; in2 = 1'b1; in3 = 1'bz; in4 = 1'b0; sel = 2'b00; #10; // Expect out = x
        in1 = 1'bz; in2 = 1'b1; in3 = 1'bz; in4 = 1'b0; sel = 2'b01; #10; // Expect out = x
        in1 = 1'b1; in2 = 1'b0; in3 = 1'bx; in4 = 1'b1; sel = 2'b10; #10; // Expect out = x
        in1 = 1'bx; in2 = 1'bz; in3 = 1'b0; in4 = 1'bz; sel = 2'b11; #10; // Expect out = x

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
  
    // Monitor the output signals
    initial begin
        passed = 0;
        failed = 0;
        $monitor("Time: %0t | in1: %b, in2: %b, in3: %b, in4: %b, sel: %b | out: %b", 
                $time, in1, in2, in3, in4, sel, out);
    end

    // Checker
    task result(input expected_out);
        begin
        if(expected_out === out) begin
            passed = passed + 1;
        end
        else begin
            $display("[TEST FAILED!!!] for in1: %b, in2: %b, in3: %b, in4: %b, sel: %b || Out: %b || Expected Out: %b", in1, in2, in3, in4, sel, out, expected_out);
            failed = failed + 1;
        end
        end
    endtask

    always@(*) begin
        if(sel == 0) expected_out = in1;
        else if(sel == 1) expected_out = in2;
        else if(sel == 2) expected_out = in3;
        else expected_out = in4;
      	if(expected_out === 1'bz) expected_out = 1'bx;
    end

    always @(*) begin
        #1ns; result(expected_out);
    end
  
    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule




//-------------------------Verify Mux 4 to 1 using  assign-------------------------//
module mux4to1_ternary_tb;

    // Test Input
    reg in1, in2, in3, in4;
    reg [1:0] sel;
    // Test output
    wire out;

    // Test Checker
    reg expected_out;
    integer passed, failed;
  
    // Instantiate the module
    mux4to1_ternary dut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );
  
    // Test stimulus
    initial begin
        // Test all combinations of inputs and select lines
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b0; in4 = 1'b0; sel = 2'b00; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b0; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b1; in3 = 1'b0; in4 = 1'b0; sel = 2'b01; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b1; in4 = 1'b0; sel = 2'b10; #10; // Expect out = 1
        in1 = 1'b0; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b01; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b10; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b1; in3 = 1'b1; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b00; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b01; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b10; #10; // Expect out = 0
        in1 = 1'b1; in2 = 1'b0; in3 = 1'b0; in4 = 1'b1; sel = 2'b11; #10; // Expect out = 1

        in1 = 1'bx; in2 = 1'b1; in3 = 1'bz; in4 = 1'b0; sel = 2'b00; #10; // Expect out = x
        in1 = 1'bz; in2 = 1'b1; in3 = 1'bz; in4 = 1'b0; sel = 2'b01; #10; // Expect out = x
        in1 = 1'b1; in2 = 1'b0; in3 = 1'bx; in4 = 1'b1; sel = 2'b10; #10; // Expect out = x
        in1 = 1'bx; in2 = 1'bz; in3 = 1'b0; in4 = 1'bz; sel = 2'b11; #10; // Expect out = x

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
  
    // Monitor the output signals
    initial begin
        passed = 0;
        failed = 0;
        $monitor("Time: %0t | in1: %b, in2: %b, in3: %b, in4: %b, sel: %b | out: %b", 
                $time, in1, in2, in3, in4, sel, out);
    end

    // Checker
    task result(input expected_out);
        begin
        if(expected_out === out) begin
            passed = passed + 1;
        end
        else begin
            $display("[TEST FAILED!!!] for in1: %b, in2: %b, in3: %b, in4: %b, sel: %b || Out: %b || Expected Out: %b", in1, in2, in3, in4, sel, out, expected_out);
            failed = failed + 1;
        end
        end
    endtask

    always@(*) begin
        if(sel == 0) expected_out = in1;
        else if(sel == 1) expected_out = in2;
        else if(sel == 2) expected_out = in3;
        else expected_out = in4;
    end

    always @(*) begin
        #1ns; result(expected_out);
    end
  
    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule

// Using assign output can be z if input is z
// Using gate level output just x if input is x