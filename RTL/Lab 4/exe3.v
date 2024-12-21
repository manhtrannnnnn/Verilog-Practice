//-----------------------------------------------Design 16 x 16 bidirectional memory-----------------------------------------------//
module bidirectional_memory(
    input clk,
    input wr_en, rd_en,
    input [3:0] addr,
    input [15:0] data_in,
    output reg [15:0] data_out
);
    // Declare Memory
    reg [15:0] mem [0:15];
    wire [15:0] bus; 

    // Write to memory
    always @(posedge clk) begin
        if(wr_en) begin
            mem[addr] <= data_in;
        end    
    end

    // Read frome memory
    generate 
        genvar i;
        for(i = 0; i < 16; i++) begin
            bufif1(bus[i],mem[addr][i],rd_en); // Tristate for output
        end
    endgenerate

    always @(posedge clk) begin
        data_out <= bus;
    end

endmodule