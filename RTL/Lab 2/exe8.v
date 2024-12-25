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





//---------------------------------------------D flip-flop with asynchronous reset using If-else Statement--------------------------------------------//
module dflipflop_asynrst #(
    parameter Width = 6
)(
    input clk, asyn_rst, 
    input [Width-1:0] data_in,
    output reg [Width-1:0] data_out
);
    always@(posedge clk or negedge asyn_rst) begin
        if(!asyn_rst) begin
            data_out <= 0;
        end
        else begin
            data_out <= data_in;
        end
    end
endmodule