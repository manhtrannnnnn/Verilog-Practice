//------------------------------------detector for “1010011” using gate level------------------------------------//
module mux2to1 #(   // Muxtiplexer 2 to 1 using gate level
    parameter Width = 8
)( 
    input [Width-1:0] a, b,
    input sel,
    output [Width-1:0] out
);
    wire out1, out2;
    wire not_select;

    // Gate level || out = b & sel | a & (~sel);
    not not1(not_select, select);
    and a1(out1, b,select);
    and a2(out2,a,not_select);
    or or1(out,out1,out2);
endmodule

module mux4to1 (
    input in1, in2, in3, in4,
    input [1:0] select,
    output out
);
    wire out1, out2;
    mux2to1 mux1(
        .a(in1),
        .b(in2),
        .sel(sel[1]),
        .out(out1)
    );

    mux2to1 mux2(
        .a(in3),
        .b(in4),
        .sel(sel[1]),
        .out(out2)
    );

    mux2to1 mux3(
        .a(out1),
        .b(out2),
        .sel[0],
        .out(out)
    );
endmodule

module overlapping(
    input clk, rst_n,
    input data_in,
    output valid
);
    localparam  Init = 7'b00000001,
                S1 = 7'b0000010,
                S10 = 7'b0000100,
                S101 = 7'b0001000,
                S1010 = 7'b0010000,
                S10100 = 7'b0100000,
                S101001 = 7'b1000000;

    // Memory State
    reg [6:0] currentState, nextState;
    always @(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end
        else begin
            currentState <= nextState;
        end
    end

    // Next Logic gate
endmodule