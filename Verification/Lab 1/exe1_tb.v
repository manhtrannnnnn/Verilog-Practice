//-------------------------Test adder gate level-------------------------//
module dataflow_adder_tb;
  
  reg a, b, cin; 	// Test Inputs
  wire cout, sum;	// Test Outputs
  reg expected_cout, expected_sum; 	// Checker
  integer passed, failed;
  
  //Instantiate the module
  dataflow_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(sum)
  );
  
  //Test stimulus
  initial begin
    failed = 0;
    passed = 0;
    a = 0; b = 0; cin = 0;  #10; 
    // Expect sum=0, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 0; cin = 1;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 1; cin = 0;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 1; cin = 1;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 0; cin = 0;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 1; b = 0; cin = 1;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 1; cin = 0;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 1; cin = 1;  #10; 
    // Expect sum=1, cout=1
    result(expected_sum, expected_cout);
    
    
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
  end
  
  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | A: %b, B: %b, Cin: %b | sum: %b, cout: %b", $time, a, b, cin, sum, cout);
    assign {expected_cout, expected_sum} = a + b + cin; // Checker function
  end
  
  task result(input expected_sum, expected_cout);
    begin
      if(expected_sum == sum && expected_cout == cout) begin
        $display("[TEST PASSED] for a: %b, b: %b, cin: %b", a, b, cin);
        passed = passed + 1;
      end
      else begin
        $display("[TEST FAILED!!!] for a: %b, b: %b, cin: %b", a, b, cin);
        failed = failed + 1;
      end
    end
  endtask
  
  
  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//---------------------Verify fulladder_nbit---------------------//
module fulladder_nbit_tb;
  parameter Width = 4;
  
  // Test Inputs
  reg [Width-1:0] a, b;
  // Test Outputs
  wire [Width-1:0] sum;		
  wire overflow;
  
  // Checker
  reg [Width-1:0] expected_sum;
  reg expected_overflow;
  integer passed, failed;
  
  // Instantiate the module
  fulladder_nbit #(.Width(Width)) dut (
    .a(a),
    .b(b),          // Corrected connection
    .sum(sum),
    .overflow(overflow)
  );
  
  // Test stimulus
  initial begin
    // Test various cases with binary values
    a = 4'b0101;  b = 4'b0010;  #10; // Expect sum=0111, overflow=0
    a = 4'b0100;  b = 4'b0111;  #10; // Expect sum=1011, overflow=0
    a = 4'b1011;  b = 4'b0111;  #10; // Expect sum=0010, overflow=1
    a = 4'b0110;  b = 4'b0011;  #10; // Expect sum=1001, overflow=0
    a = 4'b0011;  b = 4'b1100;  #10; // Expect sum=1111, overflow=0
    a = 4'b1101;  b = 4'b1001;  #10; // Expect sum=0110, overflow=1
    a = 4'b0010;  b = 4'b1000;  #10; // Expect sum=1010, overflow=0
    a = 4'b1111;  b = 4'b1111;  #10; // Expect sum=1110, overflow=1
    a = 4'b1100;  b = 4'b0111;  #10; // Expect sum=0011, overflow=1
    
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
  end
  
  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | A: %b, B: %b | sum: %b, overflow: %b", $time, a, b, sum, overflow);
    assign {expected_overflow, expected_sum} =	a + b; // Checker function
  end
  
  task result(input expected_sum, expected_overflow);
    begin
      if(expected_sum == sum && expected_overflow == overflow) begin
        $display("[TEST PASSED] for a: %b, b: %b", a, b, cin);
        passed = passed + 1;
      end
      else begin
        $display("[TEST FAILED!!!] a: %b, b: %b || expected sum: %b, expected overflow: %b || sum: %b, overflow: %b", a, b, expected_sum, expected_overflow, sum, overflow);
        failed = failed + 1;
      end
    end
  endtask
  
  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, fulladder_nbit_tb);
  end
endmodule


//-------------------------Test adder gate level-------------------------//
module gate_adder_tb;
  
  reg a, b, cin; 	// Test Inputs
  wire cout, sum;	// Test Outputs
  reg expected_cout, expected_sum; 	// Checker
  integer passed, failed;
  
  //Instantiate the module
  gate_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(sum)
  );
  
  //Test stimulus
  initial begin
    failed = 0;
    passed = 0;
    a = 0; b = 0; cin = 0;  #10; 
    // Expect sum=0, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 0; cin = 1;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 1; cin = 0;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 0; b = 1; cin = 1;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 0; cin = 0;  #10; 
    // Expect sum=1, cout=0
    result(expected_sum, expected_cout);
    a = 1; b = 0; cin = 1;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 1; cin = 0;  #10; 
    // Expect sum=0, cout=1
    result(expected_sum, expected_cout);
    a = 1; b = 1; cin = 1;  #10; 
    // Expect sum=1, cout=1
    result(expected_sum, expected_cout);
    
    
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
  end
  
  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | A: %b, B: %b, Cin: %b | sum: %b, cout: %b", $time, a, b, cin, sum, cout);
    assign {expected_cout, expected_sum} = a + b + cin; // Checker function
  end
  
  task result(input expected_sum, expected_cout);
    begin
      if(expected_sum == sum && expected_cout == cout) begin
        $display("[TEST PASSED] for a: %b, b: %b, cin: %b", a, b, cin);
        passed = passed + 1;
      end
      else begin
        $display("[TEST FAILED!!!] for a: %b, b: %b, cin: %b", a, b, cin);
        failed = failed + 1;
      end
    end
  endtask
  
  
  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule




