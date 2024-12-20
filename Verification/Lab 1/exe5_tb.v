//--------------------------------Verify Divide Frequency by 8--------------------------------//
`timescale 1ns/1ps

module DivideBy8_tb;
    reg clk_in;       
    reg rst_n;         
    wire clk_out;      

    // Instantiate the DivideBy8 module
    DivideBy8 uut (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );

    // Generate Clock
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in; 
    end

    initial begin
        rst_n = 0;
        #50;          
        rst_n = 1;   
        #2000;

        // End simulation
        $finish;
    end

    // Monitor the output signals
    initial begin
        $monitor($time, " clk_in = %b, rst_n = %b, clk_out = %b", clk_in, rst_n, clk_out);
    end
  
  	//Generate waveform
	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule