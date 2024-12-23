//---------------------------------------Verify---------------------------------------//
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
        // Test cases
      	$monitor("Time=%0t din=%b -> Parity=%b", $time, data_in, parity);

        data_in = 16'b0000000000000000; #10; // Expect Parity=0
        data_in = 16'b1111111111111111; #10; // Expect Parity=0
        data_in = 16'b0000000000000001; #10; // Expect Parity=1
        data_in = 16'b1010101010101010; #10; // Expect Parity=0
        data_in = 16'b1111000011110000; #10; // Expect Parity=0
        data_in = 16'b1100110011001100; #10; // Expect Parity=0

        $finish;
    end
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

endmodule