//------------------------------Design frequency divide by 8 circuit using T Flip Flop.---------------------------------------//
module DivideBy2 (
    input clk_in, rst_n,
    output reg clk_out
);
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) 
            clk_out <= 0;
        else 
            clk_out <= ~clk_out;
    end
endmodule

module DivideBy8 (
    input clk_in, rst_n,
    output clk_out
);
    wire clk_div2, clk_div4;

    // Instantiate three DivideBy2 modules
    DivideBy2 stage1 (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .clk_out(clk_div2)
    );

    DivideBy2 stage2 (
        .clk_in(clk_div2),
        .rst_n(rst_n),
        .clk_out(clk_div4)
    );

    DivideBy2 stage3 (
        .clk_in(clk_div4),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );
endmodule
