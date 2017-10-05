//
// 4-bit multiplier usign structural modeling
// 

module multiplier_4bit
(
  input  [3:0] a,
  input  [3:0] b,
  output [7:0] p
);
  wire       c_in;
  wire [10:0] c_out;
  wire [5:0] tmp_sum;

  assign c_in = 0;
  assign p[0] = a[0] & b[0];
  // full_adder module described in part2.v
  full_adder add0(a[1] & b[0], a[0] & b[1], c_in, c_out[0], p[1]);
  full_adder add1(a[2] & b[0], a[1] & b[1], c_out[0], c_out[1], tmp_sum[0]);
  full_adder add2(a[3] & b[0], a[2] & b[1], c_out[1], c_out[2], tmp_sum[1]);
  full_adder add3(a[3] & b[1], 0, c_out[2], c_out[3], tmp_sum[2]);

  full_adder add4(a[0] & b[2], tmp_sum[0], c_in, c_out[4], p[2]);
  full_adder add5(a[1] & b[2], tmp_sum[1], c_out[4], c_out[5], tmp_sum[3]);
  full_adder add6(a[2] & b[2], tmp_sum[2], c_out[5], c_out[6], tmp_sum[4]);
  full_adder add7(a[3] & b[2], c_out[3], c_out[6], c_out[7], tmp_sum[5]);

  full_adder add8(a[0] & b[3], tmp_sum[3], c_in, c_out[8], p[3]);
  full_adder add9(a[1] & b[3], tmp_sum[4], c_out[8], c_out[9], p[4]);
  full_adder add10(a[2] & b[3], tmp_sum[5], c_out[9], c_out[10], p[5]);
  full_adder add11(a[3] & b[3], c_out[7], c_out[10], p[7], p[6]);

endmodule