//----------------------------------Mux 2 to 1 using gate level-----------------------------------------------//
module mux2to1 (
    input a, b,
    input sel,
    output out
);
    wire out1, out2;
    wire not_sel;

  // Gate level || out = a & (~sel) + b & sel;
  
  	not not1(not_sel, sel);
  	and a1(out1,a,not_sel);
    and a2(out2,b,sel);
    or or1(out,out1,out2);

endmodule

//----------------------------------Mux 4 to 1 using mux 2 to 1------------------------------------------------//
module mux4to1_logicgate (
    input in1, in2, in3, in4,
  	input [1:0] sel,
    output out
);
    wire out1, out2;
    mux2to1 mux1(
        .a(in1),
        .b(in2),
      	.sel(sel[0]),
        .out(out1)
    );

    mux2to1 mux2(
        .a(in3),
        .b(in4),
      	.sel(sel[0]),
        .out(out2)
    );

    mux2to1 mux3(
        .a(out1),
        .b(out2),
      	.sel(sel[1]),
        .out(out)
    );

endmodule 

//-----------------------------Ternary Operator----------------------------------//
module mux2to1_ternary(
    input a, b,
    input sel,
    output out
);
    assign out = (sel) ? b : a;
endmodule

//-----------------------------mux 4 to 1 using Ternary operator------------------//
module mux4to1_ternary(
    input in1, in2, in3, in4,
    input [1:0] sel,
    output out
);
  	assign out = sel[1] ? (sel[0] ? in4 : in3) : (sel[0] ? in2 : in1);
endmodule