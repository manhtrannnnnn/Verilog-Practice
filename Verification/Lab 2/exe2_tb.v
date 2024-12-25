//--------------------Verify Encoder--------------------//
module encoder_tb;

  reg [7:0] data_in;
  wire [2:0] data_out;

    // Instantiate the FSM
    encoder uut (
      .data_in(data_in),
      .data_out(data_out)
    );
  
    // Test sequence
    initial begin
      $display("----------Test Normal Data----------");
      data_in = 7'b0010110; #10;
      data_in = 7'b0100110; #10;
      data_in = 7'b0001100; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'b1000010; #10;
      data_in = 7'b0001100; #10;
      data_in = 7'b1000100; #10;
      data_in = 7'b0000001; #10;
      data_in = 7'b1000000; #10;
      data_in = 7'b1100000; #10;
      data_in = 7'b1000000; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'b1110000; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'b0100000; #10;
      data_in = 7'b0001000; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'b1100000; #10;
      data_in = 7'b0000010; #10;
      
      // Test with x, y value
      $display("----------Test x, y Value----------");
      data_in = 7'b10xx000; #10;
      data_in = 7'bz1x0000; #10;
      data_in = 7'b0110000; #10;
      data_in = 7'bz1000x0; #10;
      data_in = 7'bz001000; #10;
      data_in = 7'b0000000; #10;
      data_in = 7'bxx00100; #10;
      data_in = 7'b0z01010; #10;
      data_in = 7'bxxxxxxx; #10;
      data_in = 7'bzzzzzzz; #10;
    end

    // Monitor signals for debugging
    initial begin
      $monitor("Time=%0t | data_in= %b | data_out=%b ",
                 $time, data_in, data_out);
    end
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule
