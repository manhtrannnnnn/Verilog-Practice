//---------------------------------------D Flip Flop ---------------------------------------//
module dflipflop(
    input clk, 
    input asyn_clear,   // Active low 
    input asyn_preset,  // Active high
    input data_in,
    output reg data_out
);

    always@(posedge clk or negedge asyn_clear or posedge asyn_preset) begin
        if(!asyn_clear && asyn_preset) begin
          deassign data_out;
          assign data_out = 1'bX;
        end
        else if(!asyn_clear) begin
            deassign data_out;
            assign data_out = 1'b0;
        end
        else if(asyn_preset) begin
            deassign data_out;
            assign data_out = 1'b1;
        end
        else begin
          	deassign data_out;
            data_out <= data_in;
        end
    end
endmodule