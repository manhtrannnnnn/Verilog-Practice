//------------------------------------------2. Design an 8-bit ALU------------------------------------------//
module alu(
    input [7:0] A, B,
    input [2:0] opcode, // 000 -> add | 001 -> subtract | 010 -> xor | 011 -> and | 100 -> nor | 101 -> nand | 110 -> comparision | 111 -> NOP(no operation)
    output reg borrow, carry, equal, less, more, // Flag
    output reg [7:0] C,
);
    
    always @(*) begin
        case(opcode)
            3'b000: begin // ADD
                {carry, C} = A + B;
            end
            3'b001: begin // SUBTRACT
                {borrow, C} = A - B;
            end
            3'b010: begin // XOR
                C = A ^ B;
            end
            3'b011: begin // AND
                C = A & B;
            end
            3'b100: begin // NOR
                C = ~(A | B);
            end
            3'b101: begin // NAND
                C = ~(A & B);
            end
            3'b110: begin // Comparision
                C = 0;
                equal = (A == B);
                less = (A < B);
                more = (A > B);
            end
        endcase
    end

endmodule

//------------------------------------------------ Verify-------------------------------------------------------//
module alu_tb;

    reg [7:0] A, B;
    reg [2:0] opcode;
    wire [7:0] C;
    wire carry, borrow, equal, less, more;

    // Instantiate ALU
    alu uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .C(C),
        .carry(carry),
        .borrow(borrow),
        .equal(equal),
        .less(less),
        .more(more)
    );

    initial begin
        $monitor("Time: %0t | A: %b | B: %b | Op: %b | C: %b | Carry: %b | Borrow: %b | Equal: %b | Less: %b | More: %b", 
                  $time, A, B, opcode, C, carry, borrow, equal, less, more);

        // Test Addition
        A = 8'b00010010; B = 8'b00001100; opcode = 3'b000; #10;

        // Test Subtraction
        A = 8'b00010010; B = 8'b00001100; opcode = 3'b001; #10;
      
      	// Test Addition with Carry
        A = 8'b11010011; B = 8'b11101100; opcode = 3'b000; #10;

        // Test Subtraction with Borrow
        A = 8'b00000010; B = 8'b00111100; opcode = 3'b001; #10;

        // Test XOR
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b010; #10;

        // Test AND
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b011; #10;

        // Test NOR
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b100; #10;

        // Test NAND
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b101; #10;

        // Test Comparison
        A = 8'b10101010; B = 8'b10101010; opcode = 3'b110; #10;
        A = 8'b10000000; B = 8'b11000000; opcode = 3'b110; #10;

        $stop;
    end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
