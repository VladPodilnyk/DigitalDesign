// Adder for two BCD numbers. Most of modules already implemented in part2.v
module main_circuit(x, y, carry_in, d, err_led);
  input [3:0] x;
  input [3:0] y;
  input carry_in;
  output err_led;
  output [13:0] d;
  
  wire z;
  wire [1:0] error_check;
  wire [4:0] v;
  wire [3:0] a;
  wire [3:0] select_d0;

  // test if operands are correct
  comparator compar1(.v(x), .z(error_check[0]));
  comparator compar2(.v(y), .z(error_check[1]));
  assign err_led = error_check[0] | error_check[1];

  
  ripple_carry_adder adder(.f_nibble(x), .s_nibble(y), .carry_in(carry_in), 
                           .carry_out(v[4]), .sum(v[3:0]));
  comp comparator3(.v(v), .z(z));
  mux2_4bit mux(.v(v[3:0]), .a(a), .sel(z), .out(select_d0));
  circuit_a  cA(.v(v), .a(a)); 
  convert_Z_signal zconv(.z(z), .out(d[13:7]));
  seven_bit_decoder bcd_dec(.in_d(select_d0), .out(d[6:0]));  
endmodule

module comp(v, z);
  input [4:0] v;
  output z;
  
  assign z = (v[3] & v[1]) | (v[3] & v[2]) | v[4];
endmodule


module circuit_a(v, a);
  input [4:0] v;
  output [3:0] a;
  
  assign a[0] = v[3] & v[0] | v[4] & v[0];
  assign a[1] = v[2] & ~v[1] | v[4] & ~v[1];
  assign a[2] = v[2] & v[1] | v[4] & ~v[1];
  assign a[3] = v[4] & v[1];
endmodule


