module eight_bit_counter(enable, clock, clear, out);
  input enable, clock, clear;
  output [7:0] out;

  wire [6:0] internal_conn;

  assign internal_conn[0] = enable & out[0];
  assign internal_conn[1] = internal_conn[0] & out[1];
  assign internal_conn[2] = internal_conn[1] & out[2];
  assign internal_conn[3] = internal_conn[2] & out[3];
  assign internal_conn[4] = internal_conn[3] & out[4];
  assign internal_conn[5] = internal_conn[4] & out[5];
  assign internal_conn[6] = internal_conn[5] & out[6];


  t_ff t0(.t(enable), .clk(clock), .reset(clear), .q(out[0]));
  t_ff t1(.t(internal_conn[0]), .clk(clock), .reset(clear), .q(out[1]));
  t_ff t2(.t(internal_conn[1]), .clk(clock), .reset(clear), .q(out[2]));
  t_ff t3(.t(internal_conn[2]), .clk(clock), .reset(clear), .q(out[3]));
  t_ff t4(.t(internal_conn[3]), .clk(clock), .reset(clear), .q(out[4]));
  t_ff t5(.t(internal_conn[4]), .clk(clock), .reset(clear), .q(out[5]));
  t_ff t6(.t(internal_conn[5]), .clk(clock), .reset(clear), .q(out[6]));
  t_ff t7(.t(internal_conn[6]), .clk(clock), .reset(clear), .q(out[7]));
  
endmodule

module t_ff(t, clk, reset, q);
  input t, clk, reset;
  output reg q;
  
  always@ (posedge clk)
    if (!reset) begin
      q <= 0'b0;
    end else begin
      q <= q ^ t;
    end

endmodule
