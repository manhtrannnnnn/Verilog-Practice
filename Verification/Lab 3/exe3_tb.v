//------------------------------------------- Testbench for PIPO Shift Register -------------------------------------------//
module tb_pipo_shiftregister;

    reg clk, rst_n, shift_en, load;
    reg [1:0] opcode;
    reg [15:0] data_in;
    wire [15:0] data_out;

    // Instantiate the module
    pipo_shiftregister uut (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_en),
        .load(load),
        .opcode(opcode),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        // Initialize signals
        clk = 0; rst_n = 0; shift_en = 0; load = 0; opcode = 2'b00; data_in = 16'b0; #10;

        // Reset the system
        rst_n = 1;

        // Test Load
        $display("----------Test Load----------");
        data_in = 16'b1001101110011010; load = 1'b1; #10;
        load = 1'b0; 

        // Test Left Shift
        $display("----------Test Left Shift----------");
        shift_en = 1'b1; opcode = 2'b00; #50;

        // Test Right Shift
        $display("----------Test Right Shift----------");
        shift_en = 1'b1; opcode = 2'b01; #50;

        // Test Rotational Left Shift
        $display("----------Test Rotational Left Shift----------");
        shift_en = 1'b1; opcode = 2'b10; #50;

        // Test Rotational Right Shift
        $display("----------Test Rotational Right Shift----------");
        shift_en = 1'b1; opcode = 2'b11; #50;

        // Test Shift Enable
        $display("----------Test Inactive Shift Enable----------");
        shift_en = 1'b0; opcode = 2'b00; #50;
        shift_en = 1'b1; #50;

        // Test Shift Enable
        $display("----------Test Load Data----------");
        load = 1'b1; data_in = 16'b1100111011001010; #20;
        load = 1'b0; #20;
        
        $finish;
    end

    // Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor
    initial begin
        // Monitor signals
        $monitor("Time: %0t | rst_n: %b | load: %b | shift_en: %b | opcode: %b | data_in: %b | data_out: %b", $time, rst_n, load, shift_en, opcode, data_in, data_out);
    end

    // Generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
