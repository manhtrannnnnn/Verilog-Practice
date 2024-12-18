//---------------------------------------16:4 Priority Encoder using if-else Statement---------------------------------------//
module encoder(
    input [15:0] data_in,
    output reg [3:0] data_out
);
    always @(*) begin
        if(data_in[15]) begin
            data_out = 4'b1111;
        end
        else if(data_in[14]) begin
            data_out = 4'b1110;
        end
        else if(data_in[13]) begin
            data_out = 4'b1101;
        end
        else if(data_in[12]) begin
            data_out = 4'b1100;
        end
        else if(data_in[11]) begin
            data_out = 4'b1011;
        end
        else if(data_in[10]) begin
            data_out = 4'b1010;
        end
        else if(data_in[9]) begin
            data_out = 4'b1001;
        end
        else if(data_in[8]) begin
            data_out = 4'b1000;
        end
        else if(data_in[7]) begin
            data_out = 4'b0111;
        end
        else if(data_in[6]) begin
            data_out = 4'b0110;
        end
        else if(data_in[5]) begin
            data_out = 4'b0101;
        end
        else if(data_in[4]) begin
            data_out = 4'b0100;
        end
        else if(data_in[3]) begin
            data_out = 4'b0011;
        end
        else if(data_in[2]) begin
            data_out = 4'b0010;
        end
        else if(data_in[1]) begin
            data_out = 4'b0001;
        end
        else if(data_in[0]) begin
            data_out = 4'b0000;
        end
        else begin
            data_out = 4'bx;
        end
    end
endmodule


//----------------------------------------- Verify -----------------------------------------//

module encoder_tb;

  reg [15:0] data_in;
  wire [3:0] data_out;

    // Instantiate the FSM
    encoder uut (
      .data_in(data_in),
      .data_out(data_out)
    );
  
  reg [3:0] i;

    // Test sequence
    initial begin
      data_in = 16'b0000000000000000;
      #5;
      data_in = 16'b0001000000000000;
      #5;
      data_in = 16'b1000000000000000;
      #5;
      data_in = 16'b0010000000000000;
      #5;
      data_in = 16'b0000001000000000;
      #5;
      data_in = 16'b0000000000011000;
      #5;
      data_in = 16'b0000000100001000;
      #5;
      data_in = 16'b0000100000100010;
      #5;
      data_in = 16'b0010000100100000;
      #5;
      data_in = 16'b0011000110000000;
      #5;
      data_in = 16'b1000011100000000;
      #5;
      data_in = 16'b0000110000000000;
      #5;
      data_in = 16'b0000000000000000;
      #5;
      data_in = 16'b0000000111000000;
      #5;
      data_in = 16'b0011000000000000;
      #5;
      data_in = 16'b0000010010000000;
      #5;
      data_in = 16'b0100000000010000;
      #5;
      data_in = 16'b0000110000000000;
      #5;
      data_in = 16'b0000000110000000;
      #5;
      data_in = 16'b0000000000100100;
      #5;
		#50;
        $stop;
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
