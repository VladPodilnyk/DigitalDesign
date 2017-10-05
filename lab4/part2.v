module counter_16bit(data, out, clk, load, reset, enable);
  input clk, load, reset, enable;
  input [15:0] data;
  output reg  [15:0] out;

  always@(posedge clk)
    if (reset) begin
      out <= 16'b0;
    end else if (load) begin
      out <= data;
    end else if (enable) begin
      out <= out + 1;
    end

endmodule
