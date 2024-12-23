// ------------------------------------------------ Parity function --------------------------------------------------//
module parity #(
    parameter Width = 16
)(
    input [Width-1:0] data_in,
    output parity
);
    function xor_logic(input a, b);
        begin
            xor_logic = a ^ b;
        end
    endfunction

  	function parity_check(input [Width-1:0] data_in);
        begin
            integer i;
            reg parity_bit;
            parity_bit = data_in[0];

          	for(i = 1; i < Width; i++) begin
                parity_bit = xor_logic(parity_bit, data_in[i]);
            end
            assign parity_check = parity_bit;
        end
    endfunction

    assign parity = parity_check(data_in);
endmodule


