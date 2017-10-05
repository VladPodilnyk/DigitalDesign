// RS latch implementation using gate instantiation
module rs_latch_inst(r, s, clk, q);
  input r, s, clk;
  output q;

  wire S_g, R_g, Qa, Qb /* synthesis keep */;

  and(R_g, r, clk);
  and(S_g, s, clk);
  nor(Qa, R_g, Qb);
  nor(Qb, S_g, Qa);

  assign q = Qa; 

endmodule

// RS latch implementation using logic expressions
module rs_latch_l(r, s, clk, q);
  input r, s, clk;
  output q;

  wire S_g, R_g, Qa, Qb /* synthesis keep */;

  assign R_g = r & clk;
  assign S_g = s & clk;
  assign Qa = ~(R_g | Qb);
  assign Qb = ~(S_g | Qa); 

  assign q = Qa;

endmodule


// D latch implementation using always block
module d_latch(data, clk, reset, q);
  input data, clk, reset;
  output reg q;

  always@ (data, clk, reset) 
    if (~reset) begin
      q <= 1'b0;
    end else if (clk) begin
      q <= data;
    end

endmodule


// implementation of positive edge triggered d flip-flop with asynchronous reset
module d_ff_async_reset(data, clk, reset, q, qbar);
  input data, clk, reset;
  output reg q, qbar;

  always@ (posedge clk, negedge reset)
    if (~reset) begin
      q <= 1'b0;
      qbar <= 1'b1;
    end else begin
      q <= data;
      qbar <= ~data;
    end

endmodule


// implementation of positive edge triggered d flip-flop with synchronous reset
module d_ff_sync_reset(data, clk, reset, q, qbar);
  input data, clk, reset;
  output reg q, qbar;

  always@ (posedge clk)
    if (~reset) begin
      q <= 1'b0;
      qbar <= 1'b1;
    end else begin
      q <= data;
      qbar <= ~data;
    end

endmodule


