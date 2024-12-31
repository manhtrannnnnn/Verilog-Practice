//-------------------------------Chirp Counter-------------------------------//
module chirpcounter(
    input clk, asyn_rst,
    output reg out
);
    reg [3:0] count;
    reg [3:0] tmp;

    always @(posedge clk or negedge asyn_rst) begin
        if(!asyn_rst) begin
            out <= 1;
            tmp <= 4'b1111;
            count <= 4'b1111;
        end
        else if(count == 1'b0) begin
            out <= ~out;
            count <= tmp - 1'b1;
            tmp <= tmp - 1'b1;
        end
        else begin
            count <= count - 1;
        end
    end 
endmodule