// 
// 8-bit accumulator unit
//

module accumulator_8bit(acc, clock, carry, overflow, clear, sum);
  input clock, clear;
  input [7:0] acc;
  output carry, overflow;
  output [7:0] sum;

  wire carry_out, s, status_sign;
  wire [7:0] channel_A;
  wire [7:0] channel_S;
  wire [7:0] result;

  register #(.DATA_WIDTH(8)) register_A(.data(acc), .clk(clock), .reset(clear), .q(channel_A));
  register #(.DATA_WIDTH(8)) register_S(.data(result), .clk(clock), .reset(clear), .q(channel_S));
  register #(.DATA_WIDTH(1)) ovr(.data(status_sign), .clk(clock), .reset(clear), .q(overflow)); // overflow sign
  register #(.DATA_WIDTH(1)) crr(.data(carry_out), .clk(clock), .reset(clear), .q(carry)); // carry

  overflow_check ovr_test(.msb_a(channel_A[7]), .msb_s(channel_S[7]), .msb_res(result[7]), .status(status_sign));
  
  assign {carry_out, result} = channel_A + channel_S;
  assign sum = channel_S;

endmodule

module register #(parameter DATA_WIDTH = 1) (data, clk, reset, q);
  input clk, reset;
  input [DATA_WIDTH - 1:0] data;
  output reg [DATA_WIDTH - 1:0] q;

  always @ (posedge clk or negedge reset)
    if (~reset) begin
      q <= 'b0;
    end else begin
      q <= data;
    end

endmodule

module overflow_check(msb_a, msb_s, msb_res, status);
  input  msb_a, msb_s, msb_res;
  output status;
  
  assign status = (msb_a & msb_s & ~msb_res) | (~msb_a & ~msb_s & msb_res);

endmodule