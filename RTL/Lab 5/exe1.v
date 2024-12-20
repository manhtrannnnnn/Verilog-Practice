//---------------------------------------D Flip Flop ---------------------------------------//
module dflipflop(
    input clk, rst_n,
    input asyn_clear, asyn_preset,
    input data_in,
    output data_out
);

    assign data_out =   (!asyn_clear && asyn_preset) ? 'bz :
                        (!asyn_clear) ? 0 :
                        (asyn_preset) ? 1 : tmp_dataout;

    reg tmp_dataout;
    always(posedge clk) begin
        tmp_dataout <= data_in;
    end
endmodule