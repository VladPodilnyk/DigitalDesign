`timescale 100ps / 100ps

module part1_tb;
  reg clk, reset;
  reg [7:0] acc;
  wire ovr, crr;
  wire [7:0] sum;

  accumulator_8bit dut(.acc(acc), .clock(clk), .carry(crr), 
                       .overflow(ovr), .clear(reset), .sum(sum));

  initial
  begin
    clk = 0;
    reset = 1;
    acc = 8'b0000_0010;
    #1 reset = 0;
    #1 reset = 1;
    
  end

  always 
    #2 clk = !clk;
endmodule
