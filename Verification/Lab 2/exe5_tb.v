//-------------------Verify PIPO 8-bit rotational right shift register Non-Blocking--------------------------//

module pipo_shiftregister_nonblocking_tb();
  // Test Inputs and Outputs
  parameter N = 8;
  reg clk, rst_n, load;
  reg [N-1:0] data_in;
  wire [N-1:0] data_out;

  // Instantiate the module
  pipo_shiftregister_nonblocking dut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test simulus 
  initial begin
    // Initialize the data
    rst_n = 1'b0; load = 1'b0; data_in = 8'b00000000; #10;

    // Test Normal Flow
    $display("----------Test Normal Flow----------");
    rst_n = 1'b1; load = 1'b1; data_in = 8'b10110101; #10;
    load = 1'b0; #100;

    // Test Load New Value 
    $display("----------Test Load New Value----------");
    load = 1'b1; data_in = 8'b10011101; #10;
    load = 1'b0; #50;
    load = 1'b1; data_in = 8'b11001101; #50;

    // Test Synchronous Reset
    $display("-----------Test synchronous Reset----------");
    rst_n = 1'b0; #50;
    rst_n = 1'b1; load = 1'b1; data_in = 8'b11011011; #10;
    load = 1'b0; #50;
    $finish;
  end

  // Generate Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Monitor 
  initial begin
    $monitor("[TIME: %0t] Reset: %b, Load: %b, Data In: %b || Data Out: %b", $time, rst_n, load, data_in, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//-------------------Verify PIPO 8-bit rotational right shift register Blocking--------------------------//

module pipo_shiftregister_blocking();
  // Test Inputs and Outputs
  parameter N = 8;
  reg clk, rst_n, load;
  reg [N-1:0] data_in;
  wire [N-1:0] data_out;

  // Instantiate the module
  pipo_shiftregister_blocking dut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test simulus 
  initial begin
    // Initialize the data
    rst_n = 1'b0; load = 1'b0; data_in = 8'b00000000; #10;

    // Test Normal Flow
    $display("----------Test Normal Flow----------");
    rst_n = 1'b1; load = 1'b1; data_in = 8'b10110101; #10;
    load = 1'b0; #100;

    // Test Load New Value 
    $display("----------Test Load New Value----------");
    load = 1'b1; data_in = 8'b10011101; #10;
    load = 1'b0; #50;
    load = 1'b1; data_in = 8'b11001101; #50;

    // Test Synchronous Reset
    $display("-----------Test synchronous Reset----------");
    rst_n = 1'b0; #50;
    rst_n = 1'b1; load = 1'b1; data_in = 8'b11011011; #10;
    load = 1'b0; #50;
    $finish;
  end

  // Generate Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Monitor 
  initial begin
    $monitor("[TIME: %0t] Reset: %b, Load: %b, Data In: %b || Data Out: %b", $time, rst_n, load, data_in, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule