//--------------------------------------- Verify T Flip Flop---------------------------------------//
module T_flipflop_tb;
  reg T, clk, async_set, async_clear;
  wire Q;

  // Instantiate the T Flip-Flop module
  T_flipflop dut (
    .T(T),
    .clk(clk),
    .async_set(async_set),
    .async_clear(async_clear),
    .Q(Q)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units clock period
  end

  // Test stimulus
  initial begin
    // Initial values
    T = 0; async_set = 0; async_clear = 0; #20;

    // Test asynchronous set
    async_set = 1; #10;
    async_set = 0; #10;

    // Test asynchronous clear
    async_clear = 1; #10;
    async_clear = 0; #10;

    // Test toggling behavior
    T = 1; #10; // Toggle on rising edge of clk
    T = 0; #10; // No toggle
    T = 1; #10; // Toggle again
    T = 1; #10; // Toggle again

    // Test behavior after asynchronous set
    async_set = 1; #10;
    async_set = 0; T = 0; #10;

    // Test behavior after asynchronous clear
    async_clear = 1; #10;
    async_clear = 0; T = 1; #10;

    $finish;
  end

  // Monitor the signals
  initial begin
    $monitor("Time: %0t | T: %b, clk: %b, async_set: %b, async_clear: %b | Q: %b", 
             $time, T, clk, async_set, async_clear, Q);
  end

  // Generate waveform
  initial begin
    $dumpfile("T_flipflop_tb.vcd");
    $dumpvars;
  end
endmodule
