//-------------------------------Verify Parity Generator-------------------------------//
module parity_generator_tb;
	// Test Inputs and Ouputs
  	reg clk, asyn_rst;
  	reg valid_in;
  	reg data_in;
  	wire [7:0] data_out;
  	wire parity;
    wire valid_out;

    // Instantiate the module
    parity_generator dut (
        .clk(clk),
        .asyn_rst(asyn_rst),
        .valid_in(valid_in),
        .data_in(data_in),
      	.parity(parity),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    // Test stimulus
    initial begin
        $display("--------Test Parity Generator--------");
        asyn_rst = 1'b0; valid_in = 1'b0; data_in = 1'b0; #20;

      	asyn_rst = 1'b1; valid_in = 1'b1; 
        // Send serial stream: 11001100
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
        data_in = 1; #10;
        data_in = 1; #10;
        data_in = 0; #10;
        data_in = 0; #10;
      
      	valid_in = 1'b0;
      	#50; $finish;


        $finish;
        

    end

    // Generate Clock
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