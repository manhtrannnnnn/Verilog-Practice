module chirpcounter_tb;
    
    // Declare Inputs and Outputs
    reg clk, asyn_rst;
    wire out;

    // Institiate the module 
    chirpcounter dut(
        .clk(clk),
        .asyn_rst(asyn_rst),
        .out(out)
    );

    // Test stimulus 
    initial begin
        // Initialize the data
        asyn_rst = 0; #10;
        // Test Normal Flow
        $display("---------Test Normal Flow---------");
        asyn_rst = 1; #2500;
        // Test Asynchronous reset
        $display("---------Test Asynchronous Reset---------");
        asyn_rst = 0; #30;
        asyn_rst = 1; #100;

        #1000;
        $finish;
    end

    // Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule