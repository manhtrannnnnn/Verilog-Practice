//---------------------------------------- 8x8 sequential multiplexer ----------------------------------------//

module sequential_multiplier (
    input clk,
    input asyn_rst,
    input load,
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] product,
    output reg valid
);
    // Internal signals
    reg [7:0] multiplicand;
    reg [7:0] multiplier;
    reg [15:0] partial_product;
    reg [3:0] count;

    always @(posedge clk or negedge asyn_rst) begin
        if (!asyn_rst) begin
            // Reset all values
            multiplicand <= 8'b0;
            multiplier <= 8'b0;
            partial_product <= 16'b0;
            product <= 16'b0;
            valid <= 0;
            count <= 0;
        end else if (load) begin
            // Load input values
            multiplicand <= a;
            multiplier <= b;
            partial_product <= 16'b0;
            product <= 16'b0;
            valid <= 0;
            count <= 0;
        end else if (count < 8) begin
            if (multiplier[0]) begin
                partial_product <= partial_product + (multiplicand << count);
            end
            multiplier <= multiplier >> 1;
            count <= count + 1;

          	if (count == 7) begin
                if (multiplier[0]) begin
                    product <= partial_product + (multiplicand << count);
                end
                else begin
                    product <= partial_product;
                end
                valid = 1'b1;
            end
        end
    end
endmodule



