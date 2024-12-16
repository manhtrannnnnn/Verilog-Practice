//-----------------------Design D-Latch with enable-----------------------//
module d_latch #(
    parameter Width = 8
)(
    input [Width-1:0] d_in,
    input en,
    output [Width-1:0] d_out
);

    assign d_out = (en) ? d_in : d_out;
endmodule

//-----------------------Design D-flipflop with enable-----------------------//
module d_flipflop #(
    parameter Width = 8
)(
    input clk, rst_n
    input [Width-1:0] d_in,
    output [Width-1:0] d_out
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            d_out <= 'd0;
        end
        else if begin
            d_out <= d_in;
        end
    end
endmodule

//-----------------------MOD-5 counter with asynchronous reset and synchronous load.-----------------------//
module mod5_counter #(
    parameter Width = 8
)(
    input clk, rst_n, load,
    input [Width-1:0] d_in,
    output [Width-1:0] count
);
    always @(posedge clk or negedge rst_n) begin 
        if(!rst_n) begin
            count <= 0;
        end
        else if(load) begin
            count <= count;
        end
        else begin
            if(count == 4) count <= 0;
            else count <= count + 1;
        end
    end
endmodule

//-----------------------7-bit PIPO shift register with asynchronus reset and synchronous load.-----------------------//
module 7bit_pipo(
    input clk, rst_n, load
    input [6:0] data_in,
    output [6:0] data_out
);
    
endmodule