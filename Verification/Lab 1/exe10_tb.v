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
        wr_en = 0;
        rd_en = 0;
        wr_addr = 0;
        rd_addr = 0;
        data_in = 0;
        // Test 1: Write data to memory
        #10;
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
      	wr_addr = 4'h1; data_in = 4'b0001; #10;	// Write to address 11
        wr_en = 0;

        // Test 2: Read data from memory
        #10;
        rd_en = 1; 
      	rd_addr = 4'h0; #10; 		   // Read from address 0
        rd_addr = 4'h1; #10;           // Read from address 1
        rd_addr = 4'h2; #10;           // Read from address 2
      	rd_addr = 4'h3; #10; 		   // Read from address 3
        rd_addr = 4'h4; #10;           // Read from address 4
        rd_addr = 4'h5; #10;           // Read from address 5
      	rd_addr = 4'h6; #10; 		   // Read from address 6
        rd_addr = 4'h7; #10;           // Read from address 7
        rd_addr = 4'h8; #10;           // Read from address 8
      	rd_addr = 4'h9; #10; 		   // Read from address 9
        rd_addr = 4'hA; #10;           // Read from address A
        rd_addr = 4'hB; #10;           // Read from address B
        rd_en = 0;

        // Test 3: Invalid read
        #10;
        rd_en = 1; rd_addr = 4'h7; #10; // Read from uninitialized address
        rd_en = 0;
      	rd_addr = 4'hA; #10; // Read from uninitialized address

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
        rst_n = 0;
        data_in = 0;

        // Apply reset
        @(posedge clk);
        rst_n = 1;

        // Test sequence: Provide "10110"
        @(posedge clk);
        data_in = 1;  // S1
        @(posedge clk);
        data_in = 0;  // S10
        @(posedge clk);
        data_in = 1;  // S101
        @(posedge clk);
        data_in = 1;  // S1011
        @(posedge clk);
        data_in = 0;  // S10110
      	@(posedge clk);
        data_in = 1;  // S10110
      	@(posedge clk);
        data_in = 1;  // S10110
      	@(posedge clk);
        data_in = 0;  // S10110
      	@(posedge clk);
        data_in = 0;  // S10110
      	@(posedge clk);
        data_in = 0;  // S10110
        @(posedge clk);
       	data_in = 1;  // S1
        @(posedge clk);
        data_in = 0;  // S10
        @(posedge clk);
        data_in = 1;  // S101
        @(posedge clk);
        data_in = 1;  // S1011
        @(posedge clk);
        data_in = 0;  // S10110
      	@(posedge clk);
        data_in = 1;  // S10110

        // Check valid signal
        @(posedge clk);
        if (valid) 
            $display("TEST PASSED: FSM output is valid at state S10110");
        else 
            $display("TEST FAILED: FSM output is invalid at state S10110");

        // Provide a new input pattern
        @(posedge clk);
        data_in = 1;  // S1
        @(posedge clk);
        data_in = 1;  // S1 (remains in S1 due to consecutive 1s)

        // Reset the FSM
        @(posedge clk);
        rst_n = 0;
        @(posedge clk);
        rst_n = 1;

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

//--------------------------------------Design state machine to detect sequence 01010 (Non-Overlapping) --------------------------------------//
module detect_nonoverlapping(
    input clk, rst_n,
    input data_in,
    output valid
);
    // Set state for FSM
    localparam Init = 6'b000001,
               S0  = 6'b000010,
               S01 = 6'b000100,
               S010 = 6'b001000,
               S0101 = 6'b010000,
               S01010 = 6'1000000;

    reg [5:0] currentState, nextState;


    // Flip-flop    
    always @(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end
        else begin 
            currentState <= nextState;
        end
    end

    //Select Next State

    always @(*) begin
        case(currentState) 
            Init: begin
                if(data_in) nextState = Init;
                else nextState = S0;
            end
            S0: begin
                if(data_in) nextState = S01;
                else nextState = S0;
            end
            S01: begin
                if(data_in) nextState = Init;
                else nextState = S010;
            end
            S010: begin
                if(data_in) nextState = S0101;
                else nextState = S0;
            end
            S0101: begin
                if(data_in) nextState = Init;
                else nextState = S01010;
            end
            S01010: begin
                nextState = Init;
            end
            default: nextState = Init;
        endcase
    end

    // Select output
    assign valid = (currentState == S10110);

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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #20; 
        rst_n = 1;
        
        // Monitor
        $monitor("Time: %0t | data_out: %b", $time, data_out);

        #1000;

        // Finish simulation
        $finish;
    end

    // Generate waveform for debugging
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars;
    end

endmodule