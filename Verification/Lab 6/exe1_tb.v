//-------------------------------Verify Parity Generator-------------------------------//
module parity_generator_tb;
	// Test Inputs and Ouputs
  	reg clk, asyn_rst;
  	reg valid_in;
  	reg data_in;
  	wire [8:0] data_out;
    wire valid_out;

    // Instantiate the module
    parity_generator dut (
        .clk(clk),
        .asyn_rst(asyn_rst),
        .valid_in(valid_in),
        .data_in(data_in),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    // Test stimulus
    initial begin
        $display("--------Test Parity Generator--------");
        asyn_rst = 1'b0; valid_in = 1'b0; data_in = 1'b0; #20;

      	asyn_rst = 1'b1; valid_in = 1'b1; 
        // Send serial stream: 11001100 => parity: 0
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
      
        // Send Serial stream: 11010101 => parity: 1
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;

        // Send Serial stream: 10101101 => parity: 1
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;

        // Test Reset
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        asyn_rst = 0; #30;
        asyn_rst = 1;

        // Test Inactive valid
        // Send Serial stream: 10010[01]110 => parity: 0
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; valid_in = 0; #10;
        data_in = 1; valid_in = 0; #10;
        data_in = 1; valid_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;

      	#50; $finish;
    end

    // Generate Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor
    initial begin
      $monitor("[TIME: %0t] Asyn Reset: %b, Data In: %b, Valid In: %b || Data Out: %b, Valid Out: %b", $time, asyn_rst, data_in, valid_in, data_out, valid_out);
    end
  	
    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule