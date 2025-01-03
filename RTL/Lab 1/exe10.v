//-----------------------Design D-Latch with enable-----------------------//
module dlatch(
    input en,
    input data_in,
    output reg data_out
);
    always @(*) begin
        if(en) begin
            data_out = data_in;
        end
        else begin
            data_out = data_out;
        end
    end
endmodule

//-----------------------Design D-FF with synchronous reset and enable-----------------------//
module dflipflop(
    input clk,         
    input rst_n,      
    input en,         
    input data_in,     
    output reg data_out 
);
    always @(posedge clk) begin
        if (!rst_n) begin
            data_out <= 1'b0; 
        end
        else if (en) begin
            data_out <= data_in;
        end
    end

endmodule

//-----------------------MOD-5 counter with asynchronous reset and synchronous load-----------------------//
module mod5counter(
    input clk, rst_n, load,
    output reg [2:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(load) begin
            if(count >= 4) begin
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end
endmodule

//-----------------------7-bit PIPO shift register with asynchronus reset and synchronous load.-----------------------//
module pipo_shiftregister7bit #(
    parameter N = 7 
)(
    input clk, rst_n, load,
    input [N-1:0] data_in,
    output reg [N-1:0] data_out
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 0;  
        end
        else if (load) begin
            data_out <= data_in; 
        end
    end
endmodule


//--------------------------6-bit PISO shift register with synchronous load and enable.---------------------------------//
module piso_shiftregister #(
    parameter N = 6  
)(
    input clk, rst_n, load, en,
    input [N-1:0] data_in,
    output reg data_out
);
    reg [N-1:0] shift_reg;  

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 6'b0;        
            data_out <= 0;      
        end
        else begin
            if (load) begin
                shift_reg <= data_in;  
            end
            
            if(en) begin
                data_out <= shift_reg[0];  
                shift_reg <= shift_reg >> 1; 
            end
        end
    end
endmodule


//----------------------------------------16 X 4 RAM----------------------------------------//
module RAM #(
    parameter Width = 4,
    parameter Depth = 16
)(
    input clk,
    input wr_en, rd_en,
    input [3:0] wr_addr, rd_addr,
    input [Width-1:0] data_in,
    output reg [Width-1:0] data_out
);
    reg [Width-1:0] mem [0:Depth-1];
    
    //Write to memory
    always @(posedge clk) begin
        if(wr_en) begin
            mem[wr_addr] <= data_in;
        end
    end

    //Read from memory
    always @(posedge clk) begin
        if(rd_en) begin
            data_out <= mem[rd_addr];
        end
        else begin
            data_out <= {Width{1'bz}};
        end
    end 
endmodule

//----------------------------------------32x5 FIFO-------------------------------------------//
module fifo#(
    parameter Width = 5,
    parameter Depth = 32
)(
    input clk, rst_n,
    input wr_en, rd_en,
    input [Width-1:0] data_in,
    output empty, full,
    output reg [Width-1:0] data_out
);
    localparam size = $clog2(Depth) ;
    reg [Width-1:0] mem [0:Depth-1];
    reg [size:0] wr_ptr, rd_ptr;

    //Reset status
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_out <= 0;
            wr_ptr <= 0;
            rd_ptr <= 0;
        end
    end

    //Write status
    always @(posedge clk) begin
        if(wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end

    //Read status
    always @(posedge clk) begin
        if(rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end

    assign empty = (wr_ptr == rd_ptr);
    assign full = (wr_ptr == {~rd_ptr[size],rd_ptr[size-1:0]});
endmodule


//------------------------------------------Design state machine to detect sequence 10110 (Overlapping). You may use Mealy model------------------------------------------------//
module detect_overlapping(
    input clk, rst_n,
    input data_in,
    output valid
);
    // Set state for FSM
    localparam Init = 6'b000001,
               S1  = 6'b000010,
               S10 = 6'b000100,
               S101 = 6'b001000,
               S1011 = 6'b010000,
               S10110 = 6'b100000;

    reg [5:0] currentState, nextState;


    // Flip-flop    
    always @(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end
        else begin 
            currentState <= nextState;
        end
    end

    //Select Next State

    always @(*) begin
        case(currentState) 
            Init: begin
                if(data_in) nextState = S1;
                else nextState = Init;
            end
            S1: begin
                if(data_in) nextState = S1;
                else nextState = S10;
            end
            S10: begin
                if(data_in) nextState = S101;
                else nextState = Init;
            end
            S101: begin
                if(data_in) nextState = S1011;
                else nextState = S10;
            end
            S1011: begin
                if(data_in) nextState = S1;
                else nextState = S10110;
            end
            S10110: begin
                if(data_in) nextState = S101;
                else nextState = Init;
            end
            default: nextState = Init;
        endcase
    end

    // Select output
    assign valid = (currentState == S10110);

endmodule

//--------------------------------------Design state machine to detect sequence 01010 (Non-Overlapping) --------------------------------------//
module detect_nonoverlapping(
    input clk, rst_n,
    input data_in,
    output valid
);
    // Set state for FSM
    localparam Init = 6'b000001,
               S0  = 6'b000010,
               S01 = 6'b000100,
               S010 = 6'b001000,
               S0101 = 6'b010000,
               S01010 = 6'1000000;

    reg [5:0] currentState, nextState;


    // Flip-flop    
    always @(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end
        else begin 
            currentState <= nextState;
        end
    end

    //Select Next State

    always @(*) begin
        case(currentState) 
            Init: begin
                if(data_in) nextState = Init;
                else nextState = S0;
            end
            S0: begin
                if(data_in) nextState = S01;
                else nextState = S0;
            end
            S01: begin
                if(data_in) nextState = Init;
                else nextState = S010;
            end
            S010: begin
                if(data_in) nextState = S0101;
                else nextState = S0;
            end
            S0101: begin
                if(data_in) nextState = Init;
                else nextState = S01010;
            end
            S01010: begin
                nextState = Init;
            end
            default: nextState = Init;
        endcase
    end

    // Select output
    assign valid = (currentState == S10110);

endmodule


//-------------------------------------------Traffic Light -------------------------------------------//
module traffic_light(
    input clk, rst_n,
    output [1:0] data_out // Red: 00 || Red-Yellow: 01 || Green: 10 || Green-Yellow: 11
);

    localparam  RED = 4'b0001,
                RED_YELLOW = 4'b0010,
                GREEN = 4'b0100,
                GREEN_YELLOW = 4'b1000;
    
    reg [3:0] currentState, nextState;
    reg [4:0] count;

    assign data_out =   (currentState == RED) ? 2'b00 :
                        (currentState == RED_YELLOW) ? 2'b01 : 
                        (currentState == GREEN) ? 2'b10 :
                        (currentState == GREEN_YELLOW) ? 2'b11 : 2'bz;

    always @(posedge clk) begin
        if(!rst_n) begin
            currentState <= RED;
            count <= 5'd25;
        end
        else if(count == 0) begin
            currentState <= nextState;
            case(nextState)  
                RED: count <= 5'd25;
                RED_YELLOW: count <= 5'd2;
                GREEN: count <= 5'd15;
                GREEN_YELLOW: count <= 5'd2;
            endcase
        end
        else begin
            count <= count - 1;
        end
    end

    always @(*) begin
        case(currentState)
            RED: nextState = RED_YELLOW;
            RED_YELLOW: nextState = GREEN;
            GREEN: nextState = GREEN_YELLOW;
            GREEN_YELLOW: nextState = RED;
        endcase
    end
endmodule


