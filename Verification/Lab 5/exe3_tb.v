//-------------------------------Verify Sequential Multiplier-------------------------------//
module sequential_multiplier_tb;
    reg clk;
    reg reset;
    reg load;
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] product;
    wire valid;

    // Instantiate the module
    sequential_multiplier uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .a(a),
        .b(b),
        .product(product),
        .valid(valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units period
    end

    // Testbench logic
    initial begin
        integer i, j;
        $monitor("Time: %0t | Reset: %b | Load: %b | A: %d | B: %d | Product: %d | Valid: %b",
                 $time, reset, load, a, b, product, valid);

        // Test stimulus
        reset = 1; load = 0; a = 0; b = 0;
        #10 reset = 0;

        // Test multiple cases
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                // Apply inputs
                load = 1;
                a = i;
                b = j;
                #10 load = 0;

                // Wait for multiplication to complete
                wait(valid);
                #10;

                // Verify result
                if (product !== (a * b)) begin
                    $display("ERROR: A=%d, B=%d, Expected=%d, Got=%d", a, b, (a * b), product);
                end else begin
                    $display("SUCCESS: A=%d, B=%d, Product=%d", a, b, product);
                end
            end
        end

        $finish;
    end

    // Generate waveform
    initial begin
      $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
