    //----------------------------Verify Decoder 3 to 8 ----------------------------//
    module decoder3to8_tb;

        // Test Inputs
        reg [2:0] data_in;
        // Test Outputs
        wire [7:0] data_out;

        // Test checker
        reg [7:0] expected_dataout;
        integer passed, failed;

        // Instantiate the module
        decoder3to8 dut(
            .data_in(data_in),
            .data_out(data_out)
        );

        // Test stimulus
        initial begin
            passed = 0;
            failed = 0;
            $display("----------Test Decoder 3 to 8----------");
           	data_in = 3'b000; #10;
            data_in = 3'b001; #10;
            data_in = 3'b010; #10;
            data_in = 3'b011; #10;
            data_in = 3'b100; #10;
            data_in = 3'b101; #10;
            data_in = 3'b100; #10;
            data_in = 3'b101; #10;
            data_in = 3'b000; #10;
            data_in = 3'b001; #10;
            data_in = 3'b100; #10;
            data_in = 3'b101; #10;
            data_in = 3'b101; #10;
            data_in = 3'b111; #10;

            //Display the result of module
            if(failed == 0) begin
                $display("============");
                $display("TEST PASSED");
                $display("============");
            end
            else begin
                $display("===============");
                $display("TEST FAILED!!!");
                $display("===============");
            end
        end

        // Compare the result
        task result(input [7:0] expected_dataout);
            begin
                if(expected_dataout == data_out) begin
                    $display("TEST PASSED");
                    passed = passed + 1;
                end
                else begin
                    $display("TEST FAILED | data_in: %b | Expected data_out: %b, data_out: %b", data_in, expected_dataout, data_out);
                    failed = failed + 1;
                end
            end
        endtask

        always @(*) begin
            if (data_in == 0) expected_dataout = 1;
            else if (data_in == 1) expected_dataout = 2;
            else if (data_in == 2) expected_dataout = 4;
            else if (data_in == 3) expected_dataout = 8;
            else if (data_in == 4) expected_dataout = 16;
            else if (data_in == 5) expected_dataout = 32;
            else if (data_in == 6) expected_dataout = 64;
            else if (data_in == 7) expected_dataout = 128;
            result(expected_dataout);
        end

        //Monitor the output signals
        initial begin
          $monitor("[Time: %0t] data_in: %b || data_out: %b || expected data_out: %b", data_in, data_out, expected_dataout);
        end

        // Generate Waveform
        initial begin
            $dumpfile("dump.vcd");
            $dumpvars;
        end
    endmodule