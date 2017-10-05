// testbench for 4bit ripple-carry adder
`timescale 1ns / 10ps

module part3_tb;
    reg [3:0] a;
    reg  [3:0] b;
    reg c_in;
    wire [3:0] s;
    wire c_out;

    integer i, j;

    ripple_carry_adder dut(a, b, c_in, c_out, s);

    initial
    begin
      j = -3;
      c_in = 0;
      for (i = 2; i < 6; i = i + 1)
      begin
        a = i;
        b = j;
        #1;
        j = j + 1;
        c_in = ~c_in;
      end
    end
endmodule
