//---------------------------------------Verify dlatch-------------------------------------------//
module dlatch_tb();
  
  // Test inputs and outputs
  reg en, data_in;
  wire data_out;

  // Instantiate the module
  dlatch dut(
    .en(en),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test stimulus
  initial begin
    // Initialize the data
    data_in = 1'b0; en = 1'b0; #10;
    // Test enable active
    en = 1'b1;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;

    // Test enable inactive
    en = 1'b0; 
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;

    // Test x, y value for enable
    en = 1'bx; // enable x value
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;
    
    en = 1'bz; // enable z value
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;

    $finish;
  end

  // Monitor
  initial begin
    $monitor("[TIME: %0t] Data In: %b, en: %b || Data Out: %b", $time, data_in, en, data_out);
  end
  
  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//---------------------------------------Verify D flipflop-------------------------------------------//
module dflipflop_tb();
  
  // Test Inputs and Outputs
  reg clk, rst_n, en;
  reg data_in;
  wire data_out;

  // Instantiate the module
  dflipflop dut(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test stimulus
  initial begin
    // Initialize the data
    rst_n = 1'b0; en = 1'b0; data_in = 1'b0; #10;
    
    // Test inactive reset and active enable
    rst_n = 1'b1; en = 1'b1;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'b1; #10;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'b0; #10;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;
    data_in = 1'bx; #10;
    data_in = 1'b1; #10;

    // Test synchronous reset
    rst_n = 1'b0; #50;
    rst_n = 1'b1;
    data_in = 1'b1; #10;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;

    // Test enable inactive
    en = 1'b0;
    data_in = 1'b0; #10;
    data_in = 1'b1; #10;
    data_in = 1'b1; #10;
    data_in = 1'b0; #10;
    data_in = 1'bx; #10;
    data_in = 1'bz; #10;

    // End simulation
    $finish;
  end

  // Monitor
  initial begin
    $monitor("[TIME: %0t] Data In: %b, en: %b, Reset: %b || Data Out: %b", $time, data_in, en, rst_n, data_out);
  end

  // Generate the clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule

//---------------------------------------Verify MOD-5 Counter-------------------------------------------//
module mod5counter_tb();
  // Test Inputs and Outputs 
  reg clk, rst_n, load;
  wire [2:0] count;

  // Instantiate the module
  mod5counter dut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .count(count)
  );

  // Test stimulus
  initial begin
    // Initialize the data
	rst_n = 1'b0; load = 1'b0; #10;

    // Test normal data
    rst_n = 1'b1; load = 1'b1; #100;

    // Test synchronous reset
    rst_n = 1'b0; #30;
    rst_n = 1'b1; #30;
    
    // Test load unactive
    load = 1'b0; #50;
    $finish; 
  end

  // Monitor
  initial begin
    $monitor("[TIME: %0t] Reset: %b, Load: %b || Count: %b", $time, rst_n, load, count);
  end

  // Generate clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//--------------------------------------- Verify 7-bit PIPO shift register with asynchronus reset and synchronous load-------------------------------------------//
module pipo_shiftregister7bit_tb();
  // Test Inputs and Outputs
  parameter N = 7;
  reg clk, rst_n, load;
  reg [N-1:0] data_in;
  wire [N-1:0] data_out;

  // Instantiate the module
  pipo_shiftregister7bit dut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test simulus 
  initial begin
    // Initialize the data
    rst_n = 1'b0; load = 1'b0; data_in = 7'b000000; #10;

    // Active load
    rst_n = 1'b1; load = 1'b1; 
    data_in = 7'b0000000; #10;
    data_in = 7'b0101011; #10;
    data_in = 7'b1001100; #10;
    data_in = 7'bx001111; #10;
    data_in = 7'b1100010; #10;
    data_in = 7'b11000x0; #10;
    data_in = 7'b0101111; #10;
    data_in = 7'b1000001; #10;
    data_in = 7'b010001z; #10;

    // Active Reset
    rst_n = 1'b0; load = 1'b1; 
    data_in = 7'b0001000; #10;
    data_in = 7'b0111101; #10;
    data_in = 7'b1001100; #10;
    data_in = 7'b0101001; #10;
    data_in = 7'b0100001; #10;
    data_in = 7'b0100000; #10;
    data_in = 7'b0xz0000; #10;
    rst_n = 1'b1;
    data_in = 7'b1001100; #10;
    data_in = 7'b0101001; #10;
    data_in = 7'b0100001; #10;

    // Test Load
    load = 1'b0;
    data_in = 7'b0001010; #10;
    data_in = 7'b0111101; #10;
    data_in = 7'b1001110; #10;
    data_in = 7'b0111001; #10;

    $finish;
  end

  // Generate Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Monitor 
  initial begin
    $monitor("[TIME: %0t] Reset: %b, Load: %b, Data In: %b || Data Out: %b", $time, rst_n, load, data_in, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//---------------------------------------Verify 6-bit PISO shift register with synchronous load and enable-------------------------------------------//
module piso_shiftregister_tb();
  // Test Inputs and Outputs
  parameter N = 6;
  reg clk, rst_n, load, en;
  reg [N-1:0] data_in;
  wire data_out;

  // Instantiate the module
  piso_shiftregister dut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .en(en),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Test simulus 
  initial begin
    // Initialize the data
    rst_n = 1'b0; load = 1'b0; en = 1'b0; data_in = 7'b000000; #10;
    // Active enable and load data
    $display("----------Test normal Flow----------");
    rst_n = 1'b1; load = 1'b1; en = 1'b1; data_in = 6'b100111; #10;
    load = 1'b0; #70;

    // Test asynchronous reset;
    $display("----------Test Asynchronous reset----------");
    rst_n = 1'b0; load = 1'b1; en = 1'b1; 
    data_in = 6'b011011; #10;
    data_in = 6'b011011; #10;
    data_in = 6'b111111; #10;
    data_in = 6'b001111; #10;
    

    // Test enable unactive
    $display("----------Test Enable unactive----------");
    rst_n = 1'b1; load = 1'b1; en = 1'b1; 
    data_in = 6'b011011; #10;
    rst_n = 1'b1; load = 1'b0; en = 1'b0;
    data_in = 6'b011011; #10;
    data_in = 6'b111111; #10;
    data_in = 6'b001111; #10;
    en = 1'b1;

    // Test x,y value
    $display("----------Test X, Y Value----------");
    rst_n = 1'b1; load = 1'b1; en = 1'b1; data_in = 6'b0x0110; #10;
    load = 1'b0; #50;
    $finish;
  end

  // Generate Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Monitor 
  initial begin
    $monitor("[TIME: %0t] Reset: %b, Load: %b, Enable: %b Data In: %b || Data Out: %b", $time, rst_n, load, en, data_in, data_out);
  end

  // Generate Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

//---------------------------------------Verify RAM-------------------------------------------//
module RAM_tb;

    // Parameters
    parameter Width = 4;
    parameter Depth = 16;

    // Signals
    reg clk;
    reg wr_en, rd_en;
    reg [3:0] wr_addr, rd_addr;
    reg [Width-1:0] data_in;
    wire [Width-1:0] data_out;

    // Instantiate the RAM module
    RAM #(
        .Width(Width),
        .Depth(Depth)
    ) uut (
        .clk(clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
      clk = 0;
      forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        wr_en = 1'b0; rd_en = 1'b0; wr_addr = 1'b0; rd_addr = 1'b0; data_in = 4'b0; #10; 
        // Test 1: Write data to memory
        $display("----------Test Write to memory");
        wr_en = 1; 
      	wr_addr = 4'h0; data_in = 4'b0001; #10; // Write to address 0
        wr_addr = 4'h1; data_in = 4'b1000; #10;	// Write to address 1          
        wr_addr = 4'h2; data_in = 4'b0100; #10;	// Write to address 2
      	wr_addr = 4'h3; data_in = 4'b1010; #10;	// Write to address 3          
        wr_addr = 4'h4; data_in = 4'b1101; #10;	// Write to address 4 
      	wr_addr = 4'h5; data_in = 4'b1110; #10;	// Write to address 5          
        wr_addr = 4'h6; data_in = 4'b0011; #10;	// Write to address 6 
      	wr_addr = 4'h7; data_in = 4'b1111; #10;	// Write to address 7          
        wr_addr = 4'h8; data_in = 4'b0110; #10;	// Write to address 8 
      	wr_addr = 4'h9; data_in = 4'b1101; #10;	// Write to address 9          
        wr_addr = 4'hA; data_in = 4'b0001; #10;	// Write to address 10 
      	wr_addr = 4'hB; data_in = 4'b1011; #10;	// Write to address 11          
        wr_addr = 4'hC; data_in = 4'b1110; #10;	// Write to address 12 
      	wr_addr = 4'h1; data_in = 4'b1001; #10;	// Overide to address 1
        

        // Test 2: Read data from memory
        $display("----------Test Read from memory");
        wr_en = 0; rd_en = 1; 
      	rd_addr = 4'h0; #10; 		        // Read from address 0
        rd_addr = 4'h1; #10;            // Read from address 1
        rd_addr = 4'h2; #10;            // Read from address 2
      	rd_addr = 4'h3; #10; 		        // Read from address 3
        rd_addr = 4'h4; #10;            // Read from address 4
        rd_addr = 4'h5; #10;            // Read from address 5
      	rd_addr = 4'h6; #10; 		        // Read from address 6
        rd_addr = 4'h7; #10;            // Read from address 7
        rd_addr = 4'h8; #10;            // Read from address 8
      	rd_addr = 4'h9; #10; 		        // Read from address 9
        rd_addr = 4'hA; #10;            // Read from address A
        rd_addr = 4'hB; #10;            // Read from address B

        // Test 3: Read invalid value from memory
        $display("----------Test read invalid value from memory----------");
        rd_addr = 4'hD; #10;
        rd_addr = 4'hE; #10;
        rd_addr = 4'hF; #10;

        // Test 4: Write x, y value and read from memory
        $display("----------Test write x,y value and read it from memory----------");
        rd_en = 1'b0; wr_en = 1'b1;
        wr_addr = 4'h2; data_in = 4'b0x01; #10;
        wr_addr = 4'h3; data_in = 4'b001z; #10;
        wr_addr = 4'h4; data_in = 4'bxxxx; #10;
        wr_addr = 4'hA; data_in = 4'bzzzz; #10;

        rd_en = 1'b1; wr_en = 1'b1;
        rd_addr = 4'h2; #10;
        rd_addr = 4'hA; #10;
        rd_addr = 4'h3; #10;
        rd_addr = 4'h4; #10;
        // Finish simulation
        #20;
        $finish;
    end
  
  	// Monitor outputs
  	initial begin
      $monitor("Time: %0t | wr_en: %b, wr_addr: %b, data_in: %b | rd_en: %b, rd_addr: %b, data_out: %b", $time, wr_en, wr_addr, data_in, rd_en, rd_addr, data_out);
     end
  
  	//Generate Waveform
  	initial begin
      	$dumpfile("dump.vcd");
      	$dumpvars;
    end
endmodule


//---------------------------------------Verify FIFO-------------------------------------------//
module fifo_tb;

    // Parameters
    parameter Width = 5;
    parameter Depth = 32;

    // Signals
    reg clk, rst_n;
    reg wr_en, rd_en;
    reg [Width-1:0] data_in;
    wire empty, full;
    wire [Width-1:0] data_out;
    integer i;
  

    // Instantiate the RAM module
    fifo #(
        .Width(Width),
        .Depth(Depth)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .empty(empty),
        .full(full), 
        .data_out(data_out)
    );

    // Test sequence
    initial begin
        // Initialize input data
        rst_n = 1'b0; wr_en = 1'b0; rd_en = 1'b0; data_in = {Width{1'b0}}; #10;
        // Test write full data
        $display("----------Test write data full memory----------");
        rst_n = 1'b1; wr_en = 1'b1;
        for(i = 0; i < 33; i++) begin
          data_in = $random % 32; #10;
        end

        // Test read empty memory
        $display("----------Test read empty memory----------");
        wr_en = 1'b0; rd_en = 1'b1; #350;
  
        // Test write x,y value to memory and read from it
        $display("----------Test write x, y value to memory and read from----------");
        wr_en = 1'b1; rd_en = 1'b0;
        data_in = 5'b101x1; #10;
        data_in = 5'b1x1x1; #10;
        data_in = 5'b1zx1; #10;
        data_in = 5'b10111; #10;
        data_in = 5'b10101; #10;
        data_in = 5'b111x1; #10;

        wr_en = 1'b0; rd_en = 1'b1; #70;

        $finish;
    end
  
  	// Monitor outputs
  	initial begin
      $monitor("[TIME: %0t] Reset: %b, Write Enable: %b, Read Enable: %b, Data In: %b || Empty: %b, Full: %b, Data Out: %b", $time, rst_n, wr_en, rd_en, data_in, empty, full, data_out);
     end

    // Clock generation
    initial begin
      clk = 0;
      forever #5 clk = ~clk;
    end

  	//Generate Waveform
  	initial begin
      	$dumpfile("dump.vcd");
      	$dumpvars;
    end
endmodule

// --------------------------------------- Verify detect sequence 10110 (Overlapping) ---------------------------------------//
module detect_overlapping_tb;

    reg clk, rst_n, data_in;
    wire valid;

    // Instantiate the FSM
    detect_overlapping uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .valid(valid)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 1'b0; data_in = 1'b0; #10;

        // Test sequence: Provide "10110"
      	$display("----------Test normal flow----------");
      	rst_n = 1'b1;
        data_in = 1'b1; #10;  // S1
        data_in = 1'b0; #10;  // S10
        data_in = 1'b1; #10;  // S101
        data_in = 1'b1; #10;  // S1011
        data_in = 1'b0; #10;  // S10110
        data_in = 1'b1; #10;  // S101
        data_in = 1'b1; #10;  // S1011
        data_in = 1'b0; #10;  // S10110
        data_in = 1'b0; #10;  // Init
        data_in = 1'b0; #10;  // Init
       	data_in = 1'b1; #10;  // S1
        data_in = 1'b0; #10;  // S10
        data_in = 1'b1; #10;  // S101
        data_in = 1'b1; #10;  // S1011
        data_in = 1'b0; #10;  // S10110
        data_in = 1'b1; #10;  // S10110

      	// Test synchronous reset
        $display("----------Test Synchronous Reset----------");
        data_in = 1'b1; #10;  // S1
        data_in = 1'b0; #10;  // S10
        data_in = 1'b1; #10;  // S101
        data_in = 1'b1; #10;  // S1011
        
      	

        
        $stop;
    end

    // Monitor signals for debugging
    initial begin
        $monitor("Time=%0t | clk=%b | rst_n=%b | data_in=%b | valid=%b",
                 $time, clk, rst_n, data_in, valid);
    end
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

//--------------------------------------Verify Traffic Light--------------------------------------//
module traffic_light_tb;

    // Signals
    reg clk, rst_n;
    wire [1:0] data_out;


    traffic_light uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_out(data_out)
    );

    initial begin
        rst_n = 1'b0; #20; 
        // Test normal flow
        rst_n = 1'b1;
        $display("---------Test normal flow----------");
        #1000;

        // Test synchronous reset
        $display("---------Test Synchronous Reset----------");
        rst_n = 1'b0; #100;        
        // Finish simulation
        $finish;
    end

    // Monitor 
    initial begin
        $monitor("Time: %0t | data_out: %b", $time, data_out);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Generate waveform for debugging
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars;
    end

endmodule