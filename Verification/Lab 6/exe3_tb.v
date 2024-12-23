//--------------------------Verify Flow Control--------------------------//
module flowcontrol_tb;
    // Test Inputs and Outputs
    reg clk, asyn_rst, valid_in;
    reg [7:0] data_in;
    wire valid_out;
    wire [15:0] data_out;

    // Instantiate the module
    flowcontrol dut(
        .clk(clk),
        .asyn_rst(asyn_rst),
        .valid_in(valid_in),
        .data_in(data_in),
        .valid_out(valid_out),
        .data_out(data_out)
    );

    // Test Stimulus
    initial begin
        $display("----------Test Flow Control----------");
        data_in = 8'hAB; valid_in = 1'b0; asyn_rst = 0; #15;
        data_in = 8'hAB; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'h43; valid_in = 1'b0; asyn_rst = 1; #5;
        data_in = 8'hCD; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'hAD; valid_in = 1'b0; asyn_rst = 1; #5;
        data_in = 8'h51; valid_in = 1'b1; asyn_rst = 0; #5;
        data_in = 8'h01; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'hDF; valid_in = 1'b0; asyn_rst = 1; #5;
        data_in = 8'hF1; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'h19; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'h1B; valid_in = 1'b0; asyn_rst = 1; #5;
        data_in = 8'hCF; valid_in = 1'b1; asyn_rst = 1; #5;
        data_in = 8'hFF; valid_in = 1'b0; asyn_rst = 1; #5;
        data_in = 8'h61; valid_in = 1'b0; asyn_rst = 1; #5;

    end

    // Generate Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor
    initial begin
        $monitor("[TIME: %0t] Reset: %b, Valid input: %b, Data In: %b || Valid Out: %b, Data Out: %b", $time, asyn_rst, valid_in, data_in, valid_out, data_out);
    end

    // Generate Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule