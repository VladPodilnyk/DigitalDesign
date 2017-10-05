`timescale 100ps/100ps

module part3_test;
  reg clk, en, clear;
  wire [3:0] out;


  counter_with_delay dut(.out(out), .clk(clk), .reset(clear), .enable(en));

  initial 
  begin
    clk = 0;
    en = 1;
    clear = 0;
    #1 clear = 1;
    #1 clear = 0;
  end

  always 
    #1 clk = !clk;
endmodule


