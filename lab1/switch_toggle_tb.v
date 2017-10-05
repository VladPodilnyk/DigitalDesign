`timescale 1ns / 100ps
module test;
  
  reg [9:0] sw;
  reg clk;
  wire [9:0] ledr;
  switch_toggle swt(.sw(sw), .ledr(ledr));
  
  always
    #10 clk = ~clk;
  
  initial
  begin
    clk = 1'b0;
    sw = 0;
    $display("sw= %h, ledr= %h", sw, ledr);
    #10 sw = 10'b00000_11101;
    $display("sw= %h, ledr= %h", sw, ledr);
    #10 sw = 10'b00101_10001;
    $display("sw= %h, ledr= %h", sw, ledr);
    #10 sw = 10'b11011_00000;
    $display("sw= %h, ledr= %h", sw, ledr);
    #10 sw = 10'b11111_10100;
    $display("sw= %h, ledr= %h", sw, ledr);
  end
  
  
endmodule
