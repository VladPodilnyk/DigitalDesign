module modk_counter #(parameter DATA_WIDTH = 4, MOD = 16) (clk, reset, Q);
  input clk, reset;
  output reg [DATA_WIDTH-1:0] Q;

  always@(posedge clk or negedge reset)
    if (~reset) begin
      Q <= 'b0;
    end else begin
      Q <= Q + 1'b1;
      if (Q == MOD - 1) begin
        Q <= 'b0;
      end
    end
endmodule
