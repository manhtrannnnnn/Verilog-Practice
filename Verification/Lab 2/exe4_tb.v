//--------------------------------Verify exercise 4 Lab 2--------------------------------//
module exe4_tb;
  reg A, B, C, D, E;
  wire Y;

  // Instantiate the module
  exe4 dut(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .Y(Y)
  );

  // Test stimulus
  initial begin
    // Test normal data
    $display("----------Test normal data----------");
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0; #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b1; #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b0; #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b1; #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0; #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b1; #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b0; #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b1; #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0; #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b1; #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0; #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b1; #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b0; #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b1; #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0; #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1; E = 1'b1; #10;

    // Test with x,y data
    $display("----------Test x, y value----------");
    A = 1'bx; B = 1'b0; C = 1'bz; D = 1'b1; E = 1'b0; #10;
    A = 1'bx; B = 1'bx; C = 1'bz; D = 1'b1; E = 1'b0; #10;
    A = 1'bx; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b1; #10;
    A = 1'bz; B = 1'b0; C = 1'b1; D = 1'b1; E = 1'b1; #10;
    A = 1'b0; B = 1'bx; C = 1'bx; D = 1'b1; E = 1'b1; #10;
    A = 1'b0; B = 1'bx; C = 1'bz; D = 1'b1; E = 1'b1; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | A: %b, B: %b, C: %b, D: %b, E: %b || Y: %b", $time, A, B, C, D, E, Y);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule