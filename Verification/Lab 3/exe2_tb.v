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
        // Test Addition
        $display("----------Test Addition----------");
        A = 8'b00010010; B = 8'b00001100; opcode = 3'b000; #10; 
        A = 8'b11110000; B = 8'b00001100; opcode = 3'b000; #10; 
        A = 8'b00000001; B = 8'b00000001; opcode = 3'b000; #10; 

        // Test Subtraction
        $display("----------Test Subtraction----------");
        A = 8'b00010010; B = 8'b00001100; opcode = 3'b001; #10; 
        A = 8'b00000000; B = 8'b00000001; opcode = 3'b001; #10; 
        A = 8'b11111111; B = 8'b11111111; opcode = 3'b001; #10; 

        // Test Addition with Carry
        $display("----------Test Addition with Carry----------");
        A = 8'b11010011; B = 8'b11101100; opcode = 3'b000; #10; 
        A = 8'b01111111; B = 8'b00000001; opcode = 3'b000; #10; 
        A = 8'b10000000; B = 8'b10000000; opcode = 3'b000; #10; 

        // Test Subtraction with Borrow
        $display("----------Test Subtraction with Borrow----------");
        A = 8'b00000010; B = 8'b00111100; opcode = 3'b001; #10; 
        A = 8'b10000000; B = 8'b10000000; opcode = 3'b001; #10; 
        A = 8'b00001111; B = 8'b00001000; opcode = 3'b001; #10; 

        // Test XOR
        $display("----------Test XOR----------");
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b010; #10; 
        A = 8'b00000000; B = 8'b11111111; opcode = 3'b010; #10; 
        A = 8'b11001100; B = 8'b10101010; opcode = 3'b010; #10;

        // Test AND
        $display("----------Test AND----------");
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b011; #10; 
        A = 8'b00000000; B = 8'b11111111; opcode = 3'b011; #10; 
        A = 8'b11111111; B = 8'b11111111; opcode = 3'b011; #10; 

        // Test NOR
        $display("----------Test NOR----------");
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b100; #10;
        A = 8'b00000000; B = 8'b11111111; opcode = 3'b100; #10; 
        A = 8'b11111111; B = 8'b00000000; opcode = 3'b100; #10; 

        // Test NAND
        $display("----------Test NAND----------");
        A = 8'b11110000; B = 8'b10101010; opcode = 3'b101; #10;
        A = 8'b00000000; B = 8'b11111111; opcode = 3'b101; #10; 
        A = 8'b11111111; B = 8'b11111111; opcode = 3'b101; #10; 
        // Test Comparison
        $display("----------Test Comparison----------");
        A = 8'b10101010; B = 8'b10101010; opcode = 3'b110; #10; // Equal values
        A = 8'b10000000; B = 8'b11000000; opcode = 3'b110; #10; // A < B
        A = 8'b11000000; B = 8'b10000000; opcode = 3'b110; #10; // A > B

        $finish;
    end

    // Monitor 
    initial begin
        $monitor("Time: %0t | A: %d | B: %d | Op: %b | C: %d | Carry: %b | Borrow: %b | Equal: %b | Less: %b | More: %b", 
                  $time, A, B, opcode, C, carry, borrow, equal, less, more);
    end

    // Generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
