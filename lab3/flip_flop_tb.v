`timescale 10ps/10ps

// test for D flip-flop with sync/async reset
module d_ff_test;
  reg data, clk, reset;
  wire q, qbar;

  //d_ff_async_reset dut(.data(data), .clk(clk), .reset(reset), .q(q), .qbar(qbar));
  d_ff_sync_reset dut(.data(data), .clk(clk), .reset(reset), .q(q), .qbar(qbar));

  initial
  begin
    clk = 0;
    reset = 1;
    data = 1;
    #7;
    reset = 0;
    //#2;
    //reset = 1;
    //#7;
    //data = 0;
  end

  always
    #5 clk = !clk;

endmodule
