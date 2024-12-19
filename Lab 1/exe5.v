//------------------------------Design frequency divide by 8 circuit using T Flip Flop.---------------------------------------//
module DivideBy2 (
    input clk_in, rst_n,
    output reg clk_out
);
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) 
            clk_out <= 0;
        else 
            clk_out <= ~clk_out;
    end
endmodule

module DivideBy8 (
    input clk_in, rst_n,
    output clk_out
);
    wire clk_div2, clk_div4;

    // Instantiate three DivideBy2 modules
    DivideBy2 stage1 (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .clk_out(clk_div2)
    );

    DivideBy2 stage2 (
        .clk_in(clk_div2),
        .rst_n(rst_n),
        .clk_out(clk_div4)
    );

    DivideBy2 stage3 (
        .clk_in(clk_div4),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );
endmodule


//--------------------------------Verify--------------------------------//
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
