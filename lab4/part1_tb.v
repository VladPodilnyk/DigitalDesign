`timescale 100ps/100ps

module part1_test;
  reg clk, en, clear;
  wire [7:0] out;

  eight_bit_counter dut(.enable(en), .clock(clk), .clear(clear), .out(out));

  initial 
  begin
    clk = 0;
    en = 1;
    clear = 0;
    #2 clear = 1;
    //#1 clear = 1;
  end

  always 
    #1 clk = !clk;
endmodule
