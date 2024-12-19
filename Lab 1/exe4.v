//--------------------------------T flipflop using Latches--------------------------------------//
module T_flipflop (
    input wire T,         
    input wire clk,      
    input wire async_set,
    input wire async_clear, 
    output reg Q         
);

    wire D;
    assign D = T ^ Q;

    // Asynchronous set and clear control
    always @(posedge clk or posedge async_set or posedge async_clear) begin
        if (async_set) 
            Q <= 1;       
        else if (async_clear)
            Q <= 0;      
        else
            Q <= D;      
    end
endmodule
