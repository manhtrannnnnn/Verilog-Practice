//------------------------------Verify bidirectional Memory------------------------------//
module bidirectional_memory_tb();

    // Test Inputs
    reg clk, wr_en, rd_en;
    reg [3:0] addr;
    reg [15:0] data_in;
    // Test Output
    wire [15:0] data_out;
    integer passed, failed;
    reg [15:0] expected_data_out;
    reg [15:0] mem [0:15];

    // Instantiate the module
    bidirectional_memory dut(
        .clk(clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Test stimulus
    initial begin
        $display("----------Test Bidirectional Memory----------");
        passed = 0;
        failed = 0;
        // Initialize
        wr_en = 0; rd_en = 0; addr = 0; data_in = 16'h0000;

        // Write data to memory
        #10 wr_en = 1; addr = 4'h0; data_in = 16'hAAAA; #10 wr_en = 0;
        #10 wr_en = 1; addr = 4'h1; data_in = 16'h5555; #10 wr_en = 0;
        #10 wr_en = 1; addr = 4'h2; data_in = 16'h1234; #10 wr_en = 0;

        // Read data from memory
        #10 rd_en = 1; addr = 4'h0; #10;
        #10 addr = 4'h1; #10;
        #10 addr = 4'h2; #10 rd_en = 0;

        // Check tri-state behavior
        #10 addr = 4'h3; #10;
      
        //Display the result of module
        if(failed == 0) begin
          $display("============");
          $display("TEST PASSED");
          $display("============");
        end
        else begin
          $display("===============");
          $display("TEST FAILED | Case: %d", failed);
          $display("===============");
        end

        $finish;
    end

    // Generate Clk
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Checker
    always @(posedge clk) begin
            if (wr_en) mem[addr] <= data_in;
            if (rd_en) result(mem[addr]);
        end 
    
  task result(input [15:0] expected_data_out);
    	begin
            if (expected_data_out == data_out) begin
                passed = passed + 1;
            end
            else begin
                $display("Test Failed || Read addr: %b from memory || Expected data out: %b || Data out: %b", addr, expected_data_out, data_out);
                failed = failed + 1;
            end
        end
    endtask
    
    // Monitor 
    initial begin
        $monitor("Time=%0t | Addr=%d, Wr_en=%b, Rd_en=%b, Data_in=%h, Data_out=%h", 
                 $time, addr, wr_en, rd_en, data_in, data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule