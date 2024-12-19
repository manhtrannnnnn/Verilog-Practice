//----------------------------------------detecting “10110” - Nonoverlapping----------------------------------------//
module detecting_nonverlapp(
    input clk, rst_n,
    input data_in,
    output valid
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
        end
    end

    //Output Logic
    wire out1;
    assign out1 = data_in ? 0 : 1;
    assign valid = (currentState == S1011) ? out1 : 0;

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

//------------------------------Verify------------------------------//
module detecting_tb;

    reg clk, rst_n, data_in;
    wire valid;

    // Instantiate the FSM
    detecting uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .valid(valid)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        data_in = 0;

        // Apply reset
        @(posedge clk);
        rst_n = 1;

        // Test sequence: Provide "10110"
        @(posedge clk);
        data_in = 1;  
        @(posedge clk);
        data_in = 0;  
        @(posedge clk);
        data_in = 1; 
        @(posedge clk);
        data_in = 0;  
        @(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 1;
      	@(posedge clk);
        data_in = 0;    // Valid
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1; 
        @(posedge clk);
       	data_in = 1; 
        @(posedge clk);
        data_in = 0;    // Valid
        @(posedge clk);
        data_in = 1;  
        @(posedge clk);
        data_in = 1; 
        @(posedge clk);
        data_in = 0;  // Unvalid because it a non Overlapp
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0; 
      	@(posedge clk);
        data_in = 1; 
      	@(posedge clk);
        data_in = 1;  
      	@(posedge clk);
        data_in = 0;    // Valid
      	@(posedge clk);
        data_in = 0;  
      	@(posedge clk);
        data_in = 1; 
      	@(posedge clk);
        data_in = 0;  

        // Reset the FSM
        @(posedge clk);
        rst_n = 0;
        @(posedge clk);
        rst_n = 1;

        $stop;
    end

    // Monitor signals for debugging
    initial begin
        $monitor("Time=%0t | clk=%b | rst_n=%b | data_in=%b | valid=%b",
                 $time, clk, rst_n, data_in, valid);
    end
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule


//----------------------------------------detecting “10110” - Overlapp----------------------------------------//
module detecting_overlapp(
    input clk, rst_n,
    input data_in,
    output valid
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
        end
    end

    //Output Logic
    wire out1;
    assign out1 = data_in ? 0 : 1;
    assign valid = (currentState == S1011) ? out1 : 0;

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