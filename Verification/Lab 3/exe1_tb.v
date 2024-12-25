//----------------------------------------- Verify Encoder -----------------------------------------//

module encoder_tb;

    reg [15:0] data_in;
    wire [3:0] data_out;

    // Instantiate the encoder module
    encoder uut (
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test sequence
    initial begin
        data_in = 16'b0000000000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0001001100000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b1100001000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0010000000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000001000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000000000011000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000000100001000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000100000100010; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0010000100100000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0011000110000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b1000011100000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000110000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0100100100000010; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000000111000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0011000000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000010010000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0100000000010000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000110000000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b0000000110000000; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        data_in = 16'b1111111111111111; #10;
        $write("Time=%0t | data_in= %b | data_out=%b\n", $time, data_in, data_out);
        
        // Finish the test
        #50;
        $finish;
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
