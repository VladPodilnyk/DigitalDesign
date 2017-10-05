// testbench for part2 lab2
`timescale 1ns / 100ps

module bcd_test;
  reg [3:0] v;
  wire [13:0] d;
  integer i;

  part2 dut(v, d);

  initial 
  begin
    for (i = 0; i < 16; i = i + 1)
    begin
      v = i;
      #10;
      $display("v = %h d = %h", v, d);
    end    
  end
endmodule
