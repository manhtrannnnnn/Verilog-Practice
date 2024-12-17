//--------------------------------D latch with reset using if-else statement--------------------------------//
module d_latch(
    input data_in, en, rst_n,
    output data_out
);
    always@(*) begin
        if(!rst) begin
            data_out = 1'b0;
        end
        else if(en) begin
            data_out = data_in;
        end
    end
endmodule

//--------------------------------D flip-flop using latch designed--------------------------------//