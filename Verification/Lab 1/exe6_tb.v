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
    in1 = 1'b0; in2 = 1'b0; #10;
    in1 = 1'b0; in2 = 1'b1; #10;
    in1 = 1'b1; in2 = 1'b0; #10;
    in1 = 1'b1; in2 = 1'b1; #10;
    in1 = 1'bx; in2 = 1'b0; #10;
    in1 = 1'bz; in2 = 1'b0; #10;
    in1 = 1'bx; in2 = 1'b1; #10;
    in1 = 1'bz; in2 = 1'b1; #10;
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

//-----------------------Verify XOR gate-----------------------//
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
    in1 = 1'b0; in2 = 1'b0; #10;
    in1 = 1'b0; in2 = 1'b1; #10;
    in1 = 1'b1; in2 = 1'b0; #10;
    in1 = 1'b1; in2 = 1'b1; #10;
    in1 = 1'bx; in2 = 1'b0; #10;
    in1 = 1'bz; in2 = 1'b0; #10;
    in1 = 1'bx; in2 = 1'b1; #10;
    in1 = 1'bz; in2 = 1'b1; #10;
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
  reg in1, in2, in3, in4;
  reg [1:0] sel;
  wire out;

  // Instantiate the module
  mux4to1 uut (
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .in4(in4),
    .sel(sel),
    .out(out)
  );

  // Test stimulus
  initial begin
    $display("---- 4:1 Multiplexer Test ----");
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
        in1 = 1'bz; in2 = 1'b1; in3 = 1'bz; in4 = 1'b0; sel = 2'b01; #10; // Expect out = 1
        in1 = 1'b1; in2 = 1'b0; in3 = 1'bx; in4 = 1'b1; sel = 2'b10; #10; // Expect out = x
        in1 = 1'bx; in2 = 1'bz; in3 = 1'b0; in4 = 1'bz; sel = 2'b11; #10; // Expect out = z
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
    in1 = 2'b0x; in2 = 2'b11; #10;
    in1 = 2'b01; in2 = 2'b10; #10;
    in1 = 2'bz0; in2 = 2'b11; #10;
    in1 = 2'b11; in2 = 2'bx1; #10;
    
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
    in1 = 1'b0; in2 = 1'b0; en = 1'b1; #10;
    in1 = 1'b0; in2 = 1'b1; en = 1'b1; #10;
    in1 = 1'b1; in2 = 1'b0; en = 1'b1; #10;
    in1 = 1'b1; in2 = 1'b1; en = 1'b1; #10;
    in1 = 1'bx; in2 = 1'b1; en = 1'b1; #10;
    in1 = 1'bx; in2 = 1'bz; en = 1'b1; #10;
    in1 = 1'bx; in2 = 1'bx; en = 1'b1; #10;
    in1 = 1'bz; in2 = 1'bz; en = 1'b1; #10;
    in1 = 1'b0; in2 = 1'b1; en = 1'b0; #10;
    in1 = 1'b1; in2 = 1'b0; en = 1'b0; #10; // Test enable
    in1 = 1'b1; in2 = 1'b1; en = 1'b1; #10;
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
    data_in = 1'b0; en = 1'b1; #10;
    data_in = 1'b1; en = 1'b1; #10;
    data_in = 1'b0; en = 1'b0; #10;
    data_in = 1'b1; en = 1'b0; #10;
    data_in = 1'b0; en = 1'bx; #10;
    data_in = 1'b1; en = 1'bx; #10;
    data_in = 1'b0; en = 1'bz; #10;
    data_in = 1'b1; en = 1'bz; #10;
    data_in = 1'bx; en = 1'b0; #10;
    data_in = 1'bz; en = 1'b0; #10;
    data_in = 1'bx; en = 1'b1; #10;
    data_in = 1'bz; en = 1'b1; #10;
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



