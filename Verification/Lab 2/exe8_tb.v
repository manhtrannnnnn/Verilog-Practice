//-------------------------------------------- Verify D-flipflop --------------------------------------------//
module d_flipflop_tb;

    // Test Inputs and Outputs
    reg clk, rst_n;
    reg [3:0] data_in;
    wire [3:0] data_out;

    // Instantiate the module
    d_flipflop dut(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        $display("---- D Flip-Flop Normal Flow ----");
        rst_n = 0; data_in = 4'b0000; #10;
        rst_n = 1; data_in = 4'b0101; #10;
        data_in = 4'b0000; #10;
        data_in = 4'b1011; #10;
        data_in = 4'b0111; #10;
        data_in = 4'b1111; #10;
        data_in = 4'b0011; #10;
        data_in = 4'b1011; #10;
        data_in = 4'b0001; #10;
        data_in = 4'b0010; #10;
        data_in = 4'b0011; #10;
        data_in = 4'b1011; #10;

        // Test Reset
        $display("----------Test Reset----------");
        rst_n = 0; data_in = 4'b1100; #10;
        data_in = 4'b1111; #10;
        data_in = 4'b0101; #10;
        data_in = 4'b1011; #10;
        data_in = 4'b1111; #10;
        data_in = 4'b0000; #10;
        data_in = 4'b1111; rst_n = 1; #10;
        data_in = 4'b0101; #10;
        $finish;
    end

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor
    initial begin
        $monitor("[TIME: %0t] Reset: %b, Data In: %b || Data Out: %b", $time, rst_n, data_in, data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule

//-------------------------------------------- Verify D-flipflop with Asynchronous Reset --------------------------------------------//
module dflipflop_asynrst_tb;

    // Test Inputs and Outputs
    reg clk, asyn_rst;
    reg [5:0] data_in;
    wire [5:0] data_out;

    // Instantiate the module
    dflipflop_asynrst #(.Width(6)) dut (
        .clk(clk),
        .asyn_rst(asyn_rst),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        $display("---- D Flip-Flop with Asynchronous Reset Test ----");
        
        // Initial conditions
        asyn_rst = 0; data_in = 6'b000000; #10;
        asyn_rst = 1; data_in = 6'b010101; #10;
        data_in = 6'b000000; #10;
        data_in = 6'b111111; #10;
        data_in = 6'b110011; #10;
        data_in = 6'b101010; #10;
        data_in = 6'b001100; #10;
        
        // Test asynchronous reset behavior
        $display("---------- Test Asynchronous Reset ----------");
        data_in = 6'b110011; asyn_rst = 0; #10;  // Reset state
        data_in = 6'b101010; asyn_rst = 1; #10;
        data_in = 6'b111111; #10;
        data_in = 6'b000000; #10;
        
        // Test with asynchronous reset in between
        asyn_rst = 0; #10; 
        data_in = 6'b101010; #10; 
        asyn_rst = 1; #10;  
        data_in = 6'b010101; #10;

        $finish;
    end

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end
  
  	// Monitor
    initial begin
        $monitor("[TIME: %0t] Reset: %b, Data In: %b || Data Out: %b", $time, asyn_rst, data_in, data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
