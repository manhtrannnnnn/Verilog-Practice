//-------------------------------Verify Sequential Multiplier-------------------------------//
module sequential_multiplier_tb;
    reg clk;
    reg asyn_rst;
    reg load;
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] product;
    wire valid;

    // Instantiate the module
    sequential_multiplier uut (
        .clk(clk),
        .asyn_rst(asyn_rst),
        .load(load),
        .a(a),
        .b(b),
        .product(product),
        .valid(valid)
    );

    // Test Stimulus
    initial begin
        integer i, j;
        // Initialize the data
        asyn_rst = 1'b0; load = 1'b0; a = 8'b0; b = 8'b0; #10;

        // Test Normal data
        $display("----------Test Normal Data----------");
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1011_0111; b = 8'b1100_0101; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1001_0101; b = 8'b0110_0111; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1101_0001; b = 8'b0111_0101; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1101_0111; b = 8'b1110_0001; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1111_0101; b = 8'b1110_1111; #10;
        load = 1'b0; #80;

        // Test x, y value
        $display("-----------Test x, y Value----------");
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1xz1_0x11; b = 8'b11zz_0101; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1xz1_0101; b = 8'b0zx0_01zx; #10;
        load = 1'b0; #80;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1101_0001; b = 8'b0111_0zx1; #10;
        load = 1'b0; #80;
        
        // Test Load data while executing
        $display("-----------Test Load Data----------");
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1011_0111; b = 8'b1100_0101; #10;
        load = 1'b0; #20;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1001_0101; b = 8'b0110_0111; #10;
        load = 1'b0; #80;

        // Test Asynchronous Reset
        $display("-----------Test Asynchronous Reset----------");
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1011_0111; b = 8'b1100_0101; #10;
        load = 1'b0; #10;
        asyn_rst = 1'b0; #50;
        asyn_rst = 1'b1; load = 1'b1; a = 8'b1001_0101; b = 8'b0110_0111; #10;
        load = 1'b0; #80;
        $finish;
    end

    // Display the result
    initial begin
        forever begin
            $display("Time: %0t | Reset: %b | Load: %b | A: %d | B: %d | Product: %d | Valid: %b", $time, reset, load, a, b, product, valid);
        end
    end
    
  
	// Generate Clock
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
