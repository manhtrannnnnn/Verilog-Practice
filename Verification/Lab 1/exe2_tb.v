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
        in1 = 0; in2 = 0; in3 = 0; in4 = 0; sel = 2'b00; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 0; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 1; in3 = 0; in4 = 0; sel = 2'b01; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 0; in3 = 1; in4 = 0; sel = 2'b10; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 0; in3 = 0; in4 = 1; sel = 2'b11; #10; // Expect out = 1
        result(expected_out);

        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b01; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b10; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b11; #10; // Expect out = 1
        result(expected_out);

        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b01; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b10; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b11; #10; // Expect out = 1
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
        if(expected_out == out) begin
            $display("[TEST PASSED] for in1: %b, in2: %b, in3: %b, in4: %b sel: %b", in1, in2, in3, in4, sel);
            passed = passed + 1;
        end
        else begin
            $display("[TEST FAILED!!!] for in1: %b, in2: %b, in3: %b, in4: %b, sel: %b || out: %b", in1, in2, in3, in4, sel, out);
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
        in1 = 0; in2 = 0; in3 = 0; in4 = 0; sel = 2'b00; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 0; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 1; in3 = 0; in4 = 0; sel = 2'b01; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 0; in3 = 1; in4 = 0; sel = 2'b10; #10; // Expect out = 1
        result(expected_out);
        in1 = 0; in2 = 0; in3 = 0; in4 = 1; sel = 2'b11; #10; // Expect out = 1
        result(expected_out);

        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b01; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b10; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 1; in3 = 1; in4 = 1; sel = 2'b11; #10; // Expect out = 1
        result(expected_out);

        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b00; #10; // Expect out = 1
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b01; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b10; #10; // Expect out = 0
        result(expected_out);
        in1 = 1; in2 = 0; in3 = 0; in4 = 1; sel = 2'b11; #10; // Expect out = 1
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
        if(expected_out == out) begin
            $display("[TEST PASSED] for in1: %b, in2: %b, in3: %b, in4: %b sel: %b", in1, in2, in3, in4, sel);
            passed = passed + 1;
        end
        else begin
            $display("[TEST FAILED!!!] for in1: %b, in2: %b, in3: %b, in4: %b, sel: %b || out: %b", in1, in2, in3, in4, sel, out);
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
  
    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
