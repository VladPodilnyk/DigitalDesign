`timescale 100ps / 100ps

module mult_tb;
  reg clk, set;
  reg [3:0] mcd;
  reg [3:0] mlr;
  wire busy;
  wire [7:0] product;

  multiplier_nbit #(.DATA_WIDTH(4)) dut(.multiplicand(mcd), .multiplier(mlr), .clk(clk),
                                       .set(set), .busy(busy), .product(product));

  initial
  begin
    clk = 0;
    set = 0;
    mcd = 'b1001;
    mlr = 'b0011;
    #1 set = 1;
    #1 set = 0;
    
  end

  always 
    #2 clk = !clk;
endmodule

