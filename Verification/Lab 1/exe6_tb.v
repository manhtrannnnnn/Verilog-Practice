//-----------------------Verify NAND Gate-----------------------//
module nand_gate_tb;
  reg in1, in2;
  wire out;

  // Instantiate the module
  nand_gate uut (
    .in1(in1),
    .in2(in2),
    .out(out)
  );

  // Test stimulus
  initial begin
    $display("---- NAND Gate Test ----");
    in1 = 0; in2 = 0; #10;
    in1 = 0; in2 = 1; #10;
    in1 = 1; in2 = 0; #10;
    in1 = 1; in2 = 1; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | in1: %b, in2: %b | out: %b", $time, in1, in2, out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//-----------------------Verify Xor gate-----------------------//
module xor_gate_tb;
  reg in1, in2;
  wire out;

  // Instantiate the module
  xor_gate uut (
    .in1(in1),
    .in2(in2),
    .out(out)
  );

  // Test stimulus
  initial begin
    $display("---- XOR Gate Test ----");
    in1 = 0; in2 = 0; #10;
    in1 = 0; in2 = 1; #10;
    in1 = 1; in2 = 0; #10;
    in1 = 1; in2 = 1; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | in1: %b, in2: %b | out: %b", $time, in1, in2, out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule

//-----------------------------Verify mux4to1-----------------------------//
module mux4to1_tb;
  reg in0, in1, in2, in3;
  reg [1:0] sel;
  wire out;

  // Instantiate the module
  mux4to1 uut (
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .sel(sel),
    .out(out)
  );

  // Test stimulus
  initial begin
    $display("---- 4:1 Multiplexer Test ----");
    in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b00; #10;
    in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b01; #10;
    in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b10; #10;
    in0 = 0; in1 = 1; in2 = 0; in3 = 1; sel = 2'b11; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | sel: %b | out: %b", $time, sel, out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule


//-----------------------------------comparator2bit-----------------------------------//
module comparator2bit_tb;
  reg [1:0] in1, in2;
  wire in1_greater_in2, in1_equal_in2, in1_less_in2;

  // Instantiate the module
  comparator2bit uut (
    .in1(in1),
    .in2(in2),
    .in1_greater_in2(in1_greater_in2),
    .in1_equal_in2(in1_equal_in2),
    .in1_less_in2(in1_less_in2)
  );

  // Test stimulus
  initial begin
    $display("---- 2-Bit Magnitude Comparator Test ----");
    in1 = 2'b00; in2 = 2'b00; #10;
    in1 = 2'b01; in2 = 2'b00; #10;
    in1 = 2'b10; in2 = 2'b10; #10;
    in1 = 2'b11; in2 = 2'b01; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | in1: %b, in2: %b | greater: %b, equal: %b, less: %b", 
             $time, in1, in2, in1_greater_in2, in1_equal_in2, in1_less_in2);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//--------------------------------Verify decoder 2 to 4--------------------------------//
module decoder2to4_tb;
  reg in1, in2, en;
  wire [3:0] data_out;

  // Instantiate the module
  decoder2to4 uut (
    .in1(in1),
    .in2(in2),
    .en(en),
    .data_out(data_out)
  );

  // Test stimulus
  initial begin
    $display("---- 2:4 Decoder with Enable Test ----");
    in1 = 0; in2 = 0; en = 1; #10;
    in1 = 0; in2 = 1; en = 1; #10;
    in1 = 1; in2 = 0; en = 1; #10;
    in1 = 1; in2 = 1; en = 1; #10;
    in1 = 0; in2 = 0; en = 0; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | in1: %b, in2: %b, en: %b | data_out: %b", $time, in1, in2, en, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule


//--------------------------------------Verify Tristate Buffer--------------------------------------//
module tristateBuffer_tb;
  reg data_in, en;
  wire data_out;

  // Instantiate the module
  tristateBuffer uut (
    .data_in(data_in),
    .en(en),
    .data_out(data_out)
  );

  // Test stimulus
  initial begin
    $display("---- Tri-State Buffer Test ----");
    data_in = 0; en = 1; #10;
    data_in = 1; en = 1; #10;
    data_in = 0; en = 0; #10;
    data_in = 1; en = 0; #10;
    $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time: %0t | data_in: %b, en: %b | data_out: %b", $time, data_in, en, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule



