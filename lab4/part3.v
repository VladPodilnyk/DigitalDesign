module counter_with_delay(out, clk, reset, enable);
  input clk, reset, enable;
  output [3:0] out;

  wire [3:0] inner_out;
  wire inner_en;

  universal_counter #(.DATA_WIDTH(4)) fast_counter(.data(4'b0), .out(inner_out), .clk(clk),
                                                    .load(1'b0), .reset(reset), .enable(enable));
  assign inner_en = ~(|inner_out);
  universal_counter #(.DATA_WIDTH(4)) slow_counter(.data(4'b0), .out(out), .clk(clk), .load(1'b0), 
                                                   .reset(reset), .enable(inner_en));

endmodule



module universal_counter #(parameter DATA_WIDTH)(data, out, clk, load, reset, enable);
  input clk, reset, enable, load;
  input [DATA_WIDTH-1:0] data;
  output reg [DATA_WIDTH-1:0] out;

  always@(posedge clk)
    if (reset) begin
      out <= 0;
    end else if (load) begin
      out <= data;
    end else if (enable) begin
      out <= out + 1;
    end

endmodule