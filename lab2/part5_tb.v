// testbench for 4bit ripple-carry adder
`timescale 1ns / 100ps

module part5_tb;
    reg [3:0] x;
    reg  [3:0] y;
    reg c_in;
    wire [13:0] d;


    part5 dut(x, y, c_in, d);

    initial
    begin
      x = 5;
      y = 6;
      c_in = 1;
      #10;
      x = 9;
      y = 9;
      c_in = 1;
      #10;
      x = 10;
      y = 1;
      c_in = 0;
    end
endmodule
