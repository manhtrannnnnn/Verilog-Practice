//-----------------------Design D-Latch with enable-----------------------//
module d_latch(
    input en,
    input data_in,
    output data_out
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

//-----------------------b.Design D-FF with synchronous reset and enable-----------------------//
module d_flipflop(
    input clk, rst_n, en
    input data_in,
    output reg data_out
);
    always @(posedge clk) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else if(en) begin
            data_out <= data_in;
        end
        else begin
            data_out <= data_out;
        end
    end
endmodule

//-----------------------MOD-5 counter with asynchronous reset and synchronous load-----------------------//
module mode5counter(
    input clk, rst_n, load,
    output reg [2:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(load) begin
            if(count == 4) begin
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
        else begin
            count <= count;
        end
    end
endmodule

//-----------------------7-bit PIPO shift register with asynchronus reset and synchronous load.-----------------------//
module pipo_shiftregister #(
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
    input clk, rst_n, load, enable,
    input [N-1:0] parallel_in,
    output reg serial_out
);
    reg [N-1:0] shift_reg;  

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 0;        
            serial_out <= 0;      
        end
        else if (load) begin
            shift_reg <= parallel_in;  
        end
        else if (enable) begin
            serial_out <= shift_reg[0];  
            shift_reg <= shift_reg >> 1; 
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
    reg [Width-1:0] mem [Depth-1:0];
    
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
            data_out <= Width'bz;
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
    localparam size = $clog(Depth) ;
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
module fsm(
    input clk, rst_n,
    input data_in,
    output valid
);
    // Set state for FSM
    localparam Init = 6'b000001,
                 = 6'b000010,
               S10 = 6'b000100,
               S101 = 6'b001000,
               S1011 = 6'b010000,
               S10110 = 6'1000000;

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




