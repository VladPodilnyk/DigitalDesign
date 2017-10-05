// 
// 8-bit accumulator unit
//

module accumulator_8bit_add_sub(acc, clock, add_sub, carry, overflow, clear, sum);
  input clock, clear, add_sub;
  input [7:0] acc;
  output carry, overflow;
  output [7:0] sum;

  wire s, status_sign, carry_out;
  wire [7:0] extend;
  wire [7:0] reg_A_out;
  wire [7:0] channel_A;
  wire [7:0] channel_S;
  wire [7:0] result;

  register #(.DATA_WIDTH(8)) register_A(.data(acc), .clk(clock), .reset(clear), .q(reg_A_out));
  register #(.DATA_WIDTH(8)) register_S(.data(result), .clk(clock), .reset(clear), .q(channel_S));
  register #(.DATA_WIDTH(1)) ovr(.data(status_sign), .clk(clock), .reset(clear), .q(overflow)); // overflow sign
  register #(.DATA_WIDTH(1)) crr(.data(carry_out), .clk(clock), .reset(clear), .q(carry)); // carry

  overflow_check ovr_test(.msb_a(channel_A[7]), .msb_s(channel_S[7]), .msb_res(result[7]), .status(status_sign));
  ripple_carry_8bit_adder rc_adder (.f_operand(channel_A), .s_operand(channel_S), 
                          .carry_in(add_sub), .carry_out(carry_out), .sum(result));

  assign extend = {8{add_sub}};
  assign channel_A = reg_A_out ^ extend;

  // is's also posible to write adder/substruction design like in code below
  /*always @ (posedge clock)  // also sensitive list can looks like this --> (channel_A or channel_S or add_sub) 
    if (~add_sub)
      {carry_out, result} = channel_S + channel_A;
    else 
      {carry_out, result} = channel_S - channel_A;
  */
 
  assign sum = channel_S;

endmodule


module full_adder(f_bit, s_bit, carry_in, carry_out, s);
    input f_bit;
    input s_bit;
    input carry_in;
    output s;
    output carry_out;


    assign s = f_bit ^ s_bit ^ carry_in;
    assign carry_out = (f_bit & s_bit) | (carry_in & (f_bit ^ s_bit));
endmodule



module ripple_carry_8bit_adder
(
  input [7:0] f_operand,
  input [7:0] s_operand,
  input carry_in,
  output carry_out,
  output [7:0] sum
);

  wire [6:0] ripple_carry_sig;

  full_adder add0(f_operand[0], s_operand[0], carry_in, ripple_carry_sig[0], sum[0]);
  full_adder add1(f_operand[1], s_operand[1], ripple_carry_sig[0], ripple_carry_sig[1], sum[1]);
  full_adder add2(f_operand[2], s_operand[2], ripple_carry_sig[1], ripple_carry_sig[2], sum[2]);
  full_adder add3(f_operand[3], s_operand[3], ripple_carry_sig[2], ripple_carry_sig[3], sum[3]);

  full_adder add4(f_operand[4], s_operand[4], ripple_carry_sig[3], ripple_carry_sig[4], sum[4]);
  full_adder add5(f_operand[5], s_operand[5], ripple_carry_sig[4], ripple_carry_sig[5], sum[5]);
  full_adder add6(f_operand[6], s_operand[6], ripple_carry_sig[5], ripple_carry_sig[6], sum[6]);
  full_adder add7(f_operand[7], s_operand[7], ripple_carry_sig[6], carry_out, sum[7]);

endmodule
