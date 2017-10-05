`timescale 100ps/100ps

module bcd_counter_tb;
  reg clock_50, reset;
  wire [11:0] out;
    
  bcd_3bit_counter dut(clock_50, reset, out);

  initial
  begin
    clock_50 = 0;
    reset = 1;
    #1 reset = 0;
    #2 reset = 1;
  end

  always
    #2 clock_50 = !clock_50;
endmodule
