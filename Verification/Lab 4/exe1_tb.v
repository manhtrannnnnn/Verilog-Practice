//------------------------------Verify detecting “10110” - Nonoverlapping------------------------------//
module detecting_tb;

    reg clk, rst_n, data_in;
    wire valid;

    // Instantiate the FSM
    detecting_nonverlapp uut (
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
        data_in = 1;  
        @(posedge clk);
        data_in = 0;  
        @(posedge clk);
        data_in = 1; 
        @(posedge clk);
        data_in = 0;  
        @(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 1;
      	@(posedge clk);
        data_in = 0;    // Valid
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1; 
        @(posedge clk);
       	data_in = 1; 
        @(posedge clk);
        data_in = 0;    // Valid
        @(posedge clk);
        data_in = 1;  
        @(posedge clk);
        data_in = 1; 
        @(posedge clk);
        data_in = 0;  // Unvalid because it a non Overlapp
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0; 
      	@(posedge clk);
        data_in = 1; 
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0;    // Valid
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1; 
      	@(posedge clk);
        data_in = 0;  

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