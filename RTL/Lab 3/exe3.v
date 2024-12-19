//--------------------------------------------16 bit parallel in parallel out universal Shift Registe------------------------------------------/
module pipo_shiftregister(
    input clk, rst_n, load, shift_en, 
    input [1:0] opcode,             // 00 -> Left Shift || 01 -> Right Shift || 10 -> Rotational Left Shift || 11 -> Rotational Right Shift
    input [15:0] data_in,
    output reg [15:0] data_out
);
    always @(posedge clk) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else if(load) begin
            data_out <= data_in;
        end
        else if(shift_en) begin
            case(opcode)
                2'b00: begin    // Left Shift
                    data_out <= (data_out << 1);
                end
                2'b01: begin    // Right Shift
                    data_out <= (data_out >> 1);
                end
                2'b10: begin    // Rotational Left Shift
                    data_out <= {data_out[14:0],data_out[15]};
                end
                2'b11: begin    // Rotational Right Shift
                    data_out <= {data_out[0],data_out[15:1]};
                end
                default: data_out <= 16'bx;
            endcase
        end
    end

endmodule 


//------------------------------------------- Verify -------------------------------------------------------// 
module tb_pipo_shiftregister;

    reg clk, rst_n, shift_en, load;
    reg [1:0] opcode;
    reg [15:0] data_in;
    wire [15:0] data_out;

    // Instantiate the shift register module
    pipo_shiftregister uut (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_en),
        .load(load),
        .opcode(opcode),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0; rst_n = 0; shift_en = 0; load = 0; opcode = 2'b00; data_in = 16'b0;

        // Reset the system
        #10 rst_n = 1;

        // Load data into the register
        #10 load = 1; data_in = 16'b1010101010101010;
        #10 load = 0;

        // Perform left shift
        #10 shift_en = 1; opcode = 2'b00;
        #50;

        // Perform right shift
        #10 opcode = 2'b01;
        #50;

        // Perform rotational left shift
        #10 opcode = 2'b10;
        #50;

        // Perform rotational right shift
        #10 opcode = 2'b11;
        #50 shift_en = 0;

        // Reset the system again
        #10 rst_n = 0;
        #20 rst_n = 1;
      	// Testing load value
      	data_in = 16'b1010101010111101;
      	#10 load = 1;
      	#10
      	

        // End simulation
        #20 $finish;
    end

    initial begin
        // Monitor signals
      $monitor("Time: %0t | rst_n: %b | load: %b | shift_en: %b | opcode: %b | data_in: %b | data_out: %b", $time, rst_n, load, shift_en, opcode, data_in, data_out);
    end
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

endmodule
