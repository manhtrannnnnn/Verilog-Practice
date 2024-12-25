//--------------------------------------- Verify Parity Testbench ---------------------------------------//
module parity_tb;
    parameter Width = 16;
    reg [Width-1:0] data_in;          
    wire parity;           

    // Instantiate the parity calculator module
    parity uut (
        .data_in(data_in),
        .parity(parity)
    );

    initial begin
        // Test Normal Flow
        $display("----------Normal Flow----------");
        data_in = 16'b0000000000000000; #10;
        data_in = 16'b1111111111111111; #10;
        data_in = 16'b0000000000000001; #10;
        data_in = 16'b1010101010101010; #10;
        data_in = 16'b1011000011110000; #10;
        data_in = 16'b1100110011001100; #10;

        // Test x, y value
        $display("----------Test with x, y value----------");
        data_in = 16'b0010xz00000100100; #10;
        data_in = 16'b10011z1x11z11111; #10;
        data_in = 16'b0000000z00x00001; #10;
        data_in = 16'b101zzz101x101010; #10;

        $finish;
    end

    // Monitor
    initial begin
      $monitor("[TIME=%0t] Data In=%b -> Parity=%b", $time, data_in, parity);
    end

    // Generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
