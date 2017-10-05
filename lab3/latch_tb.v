`timescale 100ps/10ps

module rs_latch_test;
  reg set, reset, clk;
  wire q;
  
  rs_latch_l dut(.r(reset), .s(set), .clk(clk), .q(q));

  initial 
  begin
    clk = 1;
    reset = 0;
    set = 1;
    #4;
    set = 0;  
    #2;
    set = 1; 
    reset = 1;
    #3;
    reset = 1;
    set = 0;
  end

  always
    #5 clk = !clk;

endmodule


module d_latch_test;
  reg data, reset, clk;
  wire q;
  
  d_latch dut(.data(data), .clk(clk), .reset(reset), .q(q));

  initial 
  begin
    clk = 0;
    reset = 1;
    data = 1;
    #1;
    data = 0;
    #5;
    data = 1;
    #5;
    reset = 0;
    #5;
    reset = 1;
    #3;
    data = 0;
  end

  always
    #5 clk = !clk;

endmodule
