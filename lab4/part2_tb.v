`timescale 100ps/100ps

module part2_test;
  reg clk, en, clear, load;
  reg [15:0] data;
  wire [15:0] out;


  counter_16bit dut(.data(data), .out(out), .clk(clk), .load(load),
                    .reset(clear), .enable(en));

  initial 
  begin
    clk = 0;
    en = 1;
    data = 4'hF;
    load = 0;
    clear = 0;
    #1 clear = 1;
    #1 clear = 0;
    #1 load = 1;
    #1 load = 0;
  end

  always 
    #1 clk = !clk;
endmodule

