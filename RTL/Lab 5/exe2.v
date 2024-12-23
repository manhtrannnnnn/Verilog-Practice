//-----------------------------------4-bit Counter-----------------------------------//
module counter4bit(
    input clk,
    input asyn_reset,
    input syn_load,
    input en,
    input [3:0] data_in,
    output reg [3:0] count
);

  	reg [3:0] sequence_tmp [0:13];
    reg [3:0] i;
    reg valid;

    initial begin
        sequence_tmp[0] = 4'b1000;
        sequence_tmp[1] = 4'b0111;
        sequence_tmp[2] = 4'b1011;
        sequence_tmp[3] = 4'b0100;
        sequence_tmp[4] = 4'b1001;
        sequence_tmp[5] = 4'b0010;
        sequence_tmp[6] = 4'b0101;
        sequence_tmp[7] = 4'b1100;
        sequence_tmp[8] = 4'b0110;
        sequence_tmp[9] = 4'b0011;
        sequence_tmp[10] = 4'b1111;
        sequence_tmp[11] = 4'b0001;
        sequence_tmp[12] = 4'b1110;
        sequence_tmp[13] = 4'b1101;
    end

    // Task to find data in sequence array
    task isvalid(
        input [3:0] data_in,
        output valid,
        output [3:0] i
    );
        integer j;
        begin
            for(j = 0; j < 14; j++) begin
                if(data_in == sequence_tmp[j]) begin
                    valid = 1;
                    i = j;
                    break;
                end
                else begin
                    valid = 0;
                    i = 0;
                end
            end
        end
    endtask

    always @(posedge clk or negedge asyn_reset) begin
        if(!asyn_reset) begin
            count <= sequence_tmp[0];
            i <= 0;
        end
        else if(syn_load) begin
            isvalid(data_in, valid, i);
            if(valid) begin
                count <= data_in;
            end
            else begin
                count <= sequence_tmp[0];
            end
        end
        else if(en) begin
            i = (i + 1) % 14;
            count <= sequence_tmp[i];
        end
    end
endmodule

