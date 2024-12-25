    //------------------------------- Verify Counter 4 bit -------------------------------//
    module counter4bit_tb;
        // Declare Inputs and Outputs
        reg clk, asyn_reset, syn_load, en;
        reg [3:0] data_in;
        wire [3:0] count;

        // Instantiate the module
        counter4bit dut(
            .clk(clk),
            .asyn_reset(asyn_reset),
            .syn_load(syn_load),
            .en(en),
            .data_in(data_in),
            .count(count)
        );

        // Clock Generate
        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end

        // Test stimulus
        initial begin 
            $display("----------Test Counter 4 bit----------");
            asyn_reset = 0;
            syn_load = 0;
            en = 1;
            data_in = 4'b0000; #20;

          	// Test normal flow - roll over
            $display("----------Test normal flow----------");
            asyn_reset = 1; #200;

          	// Test enable inactive
            $display("----------Test inactive enable----------");
          	en = 0; #50;

          	// Test enable active
            $display("----------Test active enable----------");
          	en = 1; #50;

          	// Test asynchronous reset
            $display("----------Test Asynchronous reset----------");
          	asyn_reset = 0; #30;

          	// Test synchronous load - valid value
            $display("----------Test synchronous Load and Valid Value----------");
          	asyn_reset = 1;
         	syn_load = 1;
          	data_in = 4'b0010; #10;
          	syn_load = 0; #40;

          	// Test synchronous reset - invalid value
            $display("----------Test synchronous Reset and Invalid Value----------");
          	syn_load = 1;
          	data_in = 4'b1010; #10;
          	syn_load = 0; #40;
            $finish;
        end

        // Monitor
        initial begin
            $monitor("[TIME: %0t] Reset: %b, Load: %b, Enable: %b, Data In: %b, Data out: %b", $time, asyn_reset, syn_load, en, data_in, count);
        end

        // Generate Waveform
        initial begin
            $dumpfile("dump.vcd");
            $dumpvars;
        end
    endmodule