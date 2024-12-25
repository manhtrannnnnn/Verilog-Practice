//----------------------------------------detecting “10110” - Nonoverlapping----------------------------------------//
module detecting_nonverlapp(
    input clk, rst_n,
    input data_in,
    output reg valid
);
    localparam  Init = 5'b00001,
                S1 = 5'b00010,
                S10 = 5'b00100,
                S101 = 5'b01000,
                S1011 = 5'b10000;

    reg [4:0] currentState, nextState;

    //State Memory
    always@(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end 
        else begin
            currentState <= nextState;
            if (currentState == S1011 && data_in == 0)
                valid <= 1;
            else
                valid <= 0;
        end
    end

    //Next State Logic
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
                else nextState = Init;
            end
            default: nextState = Init;
        endcase
    end

endmodule

//----------------------------------------detecting “10110” - Overlapp----------------------------------------//
module detecting_overlapp(
    input clk, rst_n,
    input data_in,
    output reg valid
);
    localparam  Init = 5'b00001,
                S1 = 5'b00010,
                S10 = 5'b00100,
                S101 = 5'b01000,
                S1011 = 5'b10000;

    reg [4:0] currentState, nextState;

    //State Memory
    always@(posedge clk) begin
        if(!rst_n) begin
            currentState <= Init;
        end 
        else begin
            currentState <= nextState;
            if (currentState == S1011 && data_in == 0)
                valid <= 1;
            else
                valid <= 0;
        end
    end

    //Next State Logic

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
                else nextState = S10;
            end
            default: nextState = Init;
        endcase
    end

endmodule