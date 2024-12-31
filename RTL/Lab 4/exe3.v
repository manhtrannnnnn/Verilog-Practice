module bidirectional_memory (
    input clk,
    input wr_en,
    input rd_en,
    input [3:0] addr,
    inout [15:0] bus
);
    // Internal memory array
    reg [15:0] mem [0:15];

    // Internal data wire for connecting to bus
    wire [15:0] data_out;

    // Read from memory
    assign data_out = rd_en ? mem[addr] : 16'hZZZZ;
  	generate
      genvar i;
      for(i = 0;i < 16; i++) begin
        bufif1 buffer0(bus[i], data_out[i], rd_en);
      end
    endgenerate

    // Write to memory
    always @(posedge clk) begin
        if (wr_en)
            mem[addr] <= bus;
    end
endmodule
