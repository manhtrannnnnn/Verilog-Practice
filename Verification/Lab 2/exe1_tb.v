//--------------------------------Verify decoder 2 to 4--------------------------------//
module decoder2to4_tb;
  reg a, b, en;
  wire [3:0] data_out;

  // Instantiate the module
  decoder2to4 uut (
    .a(a),
    .b(b),
    .en(en),
    .out0(data_out[0]),
    .out1(data_out[1]),
    .out2(data_out[2]),
    .out3(data_out[3])
  );

  // Test stimulus
  initial begin
    $display("---- 2:4 Decoder with Enable Test ----");
    a = 1'b0; b = 1'b0; en = 1'b1; #10;
    a = 1'b0; b = 1'b1; en = 1'b1; #10;
    a = 1'b1; b = 1'b0; en = 1'b1; #10;
    a = 1'b1; b = 1'b1; en = 1'b1; #10;
    a = 1'bx; b = 1'b1; en = 1'b1; #10;
    a = 1'bx; b = 1'bz; en = 1'b1; #10;
    a = 1'bx; b = 1'bx; en = 1'b1; #10;
    a = 1'bz; b = 1'bz; en = 1'b1; #10;
    a = 1'b0; b = 1'b1; en = 1'b0; #10;
    a = 1'b1; b = 1'b0; en = 1'b0; #10; // Test enable
    a = 1'b1; b = 1'b1; en = 1'b1; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | a: %b, b: %b, en: %b | data_out: %b", $time, a, b, en, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule