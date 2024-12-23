//-------------------------------------------Zero Count-------------------------------------------//
module zero_count(
    input [31:0] data_in,
    output reg [5:0] count
);
    integer i;
    always @(*) begin
        count = 0;
        for(i = 0; i < 32; i = i + 2) begin
            if(data_in[i] == 1'b0) begin
                count = count + 1;
            end
        end
    end
endmodule