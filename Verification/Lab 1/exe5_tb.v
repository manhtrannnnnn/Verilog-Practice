`timescale 1ns/1ps

module DivideBy8_tb;
    reg clk_in;        // Input clock
    reg rst_n;         // Active-low reset
    wire clk_out;      // Output clock (divided by 8)

    // Instantiate the DivideBy8 module
    DivideBy8 uut (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );

    // Test stimulus
    initial begin
        // Apply reset
        rst_n = 0; #50;    
        rst_n = 1; #500; // Inactive reset
      	rst_n = 0; #50;  // Test asynchronous Reset
      	rst_n = 1;

        // Run simulation for 2000ns
        #1000;

        // End simulation
        $finish;
    end

    // Monitor the output signals
    initial begin
        $monitor($time, " clk_in = %b, rst_n = %b, clk_out = %b", clk_in, rst_n, clk_out);
    end
  
    // Generate the clock
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in; // Toggle clock every 10ns
    end
  
  	//Generate waveform
	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule
