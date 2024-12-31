module bidirectional_memory_tb;
    // Testbench signals
    reg clk;
    reg wr_en, rd_en;
    reg [3:0] addr;
    reg [15:0] data_in;
    wire [15:0] bus;

    // Bidirectional bus connection
    assign bus = wr_en ? data_in : 16'hZZZZ;

    // Instantiate the bidirectional memory
    bidirectional_memory uut (
        .clk(clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(addr),
        .bus(bus)
    );
    
    // Test stimulus 
    initial begin
        // Initialize signals
        wr_en = 0;
        rd_en = 0;
        addr = 0;
        data_in = 16'h0000;
        bus_driver_en = 0;

        // Test write 
        #10 wr_en = 1; addr = 4'h0; data_in = 16'hAAAA; #10 wr_en = 0; bus_driver_en = 0;
        #10 wr_en = 1; addr = 4'h1; data_in = 16'h5555; #10 wr_en = 0; bus_driver_en = 0;
        #10 wr_en = 1; addr = 4'h2; data_in = 16'h1234; #10 wr_en = 0; bus_driver_en = 0;

        // Test read 
        #10 rd_en = 1; addr = 4'h0; #10 rd_en = 0; // Read address 0
        #10 rd_en = 1; addr = 4'h1; #10 rd_en = 0; // Read address 1
        #10 rd_en = 1; addr = 4'h2; #10 rd_en = 0; // Read address 2

        // Invalid read operation (undefined address)
        #10 rd_en = 1; addr = 4'hF; #10 rd_en = 0; // Read uninitialized address

        $finish;
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
  
    // Monitor changes
    initial begin
        $monitor("Time=%0t | Addr=%h | Wr_en=%b | Rd_en=%b | Data_in=%h | Data_out=%h",
                 $time, addr, wr_en, rd_en, data_in, bus);
    end
  
    // Generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
