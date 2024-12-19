//--------------------------------------------D latch with reset using if-else statement--------------------------------------------//
module d_latch #(
    parameter Width = 6
)(
    input en, rst_n,
    input [Width-1:0] data_in,
    output reg [Width-1:0] data_out
);
    always@(*) begin
      if(!rst_n) begin
            data_out = 1'b0;
        end
        else if(en) begin
            data_out = data_in;
        end
        else begin
            data_out = data_out;
        end
    end
endmodule

//--------------------------------------------D flip-flop using latch designed--------------------------------------------//
module d_flipflop #(
    parameter Width = 6
)(
    input clk, rst_n,
    input [Width-1:0] data_in,
    output [Width-1:0] data_out
);
    wire [Width-1:0] out1;
    // Toggle Clock
    wire not_clk;
    assign not_clk = ~clk;
    
    d_latch #(.Width(Width)) d1(
        .en(not_clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(out1)
    );

    d_latch #(.Width(Width)) d2(
        .en(~not_clk),
        .rst_n(rst_n),
        .data_in(out1),
        .data_out(data_out)
    );
endmodule


//-------------------------------------------- Verify D-flipflop using D Latch --------------------------------------------//
module d_flipflop_tb();
  
  	parameter Width = 4;
  
//Declare Input and Output 
  	reg clk, rst_n;
  	reg [Width-1:0] data_in;
  	wire [Width-1:0] data_out;
  
// DUT
  	d_flipflop #(.Width(Width)) dut(
    	.clk(clk),
    	.rst_n(rst_n),
    	.data_in(data_in),
    	.data_out(data_out)
  );
  
// Input 
  	initial begin
      rst_n = 0;
      #10; rst_n = 1;
      @(posedge clk);
      data_in = 4'b0101;
      @(posedge clk);
      data_in = 4'b0000;
      @(posedge clk);
      data_in = 4'b1011;
      @(posedge clk);
      data_in = 4'b0111;
      @(posedge clk);
      data_in = 4'b1111;
      @(posedge clk);
      data_in = 4'b0011;
      @(posedge clk);
      data_in = 4'b1011;
      @(posedge clk);
      data_in = 4'b0001;
      @(posedge clk);
      data_in = 4'b0010;
      @(posedge clk);
      data_in = 4'b0011;
      @(posedge clk);
      data_in = 4'b1011;
      
      // Testing asynchronous or synchronous Reset
      @(negedge clk);
      rst_n = 0;
      
      #50;
      $finish;
    end
  
// Generate clk
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



//---------------------------------------------D flip-flop with asynchronous reset using If-else Statement--------------------------------------------//
module dflipflop_synchronousrst #(
    parameter Width = 6
)(
    input clk, rst_n, 
    input [Width-1:0] data_in,
    output [Width-1:0] data_out
);
    always@(posedge clk or rst_n) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else begin
            data_out <= data_in;
        end
    end
endmodule