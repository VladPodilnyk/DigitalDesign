`timescale 100ns/100ns

module morse_test;
  reg clk, reset;
  reg [2:0] letter;
  wire led;

  morse dut(letter, reset, clk, led);

  initial begin
    clk = 0;
    letter = 0;
    reset = 1;
    #1 reset = 0;
    #1 reset = 1;
  end

  always
    #1 clk = !clk;

endmodule
