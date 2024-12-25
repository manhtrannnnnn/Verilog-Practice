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
