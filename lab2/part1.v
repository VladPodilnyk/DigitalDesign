module part2(v, d);
  input [3:0] v;
  output [13:0] d;
  
  wire [3:0] a;
  wire z;
  wire [3:0] select_d0;
  

  comparator comp(.v(v), .z(z));
  mux2_4bit mux(.v(v), .a(a), .sel(z), .out(select_d0));
  circuit_A  cA(.v(v), .a(a));
  convert_Z_signal zconv(.z(z), .out(d[13:7]));
  seven_bit_decoder bcd_dec(.in_d(select_d0), .out(d[6:0]));  
endmodule

module comparator(v, z);
  input [3:0] v;
  output z;
  
  assign z = (v[3] & v[1]) | (v[3] & v[2]);
endmodule

module mux2_4bit(v, a, sel, out);
  input [3:0] v;
  input [3:0] a;
  input sel;
  output [3:0] out;
  
  assign out = sel ? a : v;
endmodule

module circuit_A(v, a);
  input [3:0] v;
  output [3:0] a;
  
  assign a[0] = v[3] & v[0];
  assign a[1] = v[2] & ~v[1];
  assign a[2] = v[2] & v[1];
  assign a[3] = 0;
endmodule

module seven_bit_decoder(in_d, out);
  input [3:0] in_d;
  output [6:0] out;
  
  assign out[0] = ~(in_d[3] | in_d[1] | (in_d[2] & in_d[0]) | (~in_d[2] & ~in_d[0]));
  assign out[1] = ~(in_d[3] | ~in_d[2]| (in_d[1] & in_d[0]) | (~in_d[3] & ~in_d[1] & ~in_d[0]));
  assign out[2] = ~(in_d[3] | in_d[2] | ~in_d[1] | in_d[0]);
  assign out[3] = ~(in_d[3] | (~in_d[2] & in_d[1]) | (in_d[1] & ~in_d[0]) | (~in_d[2] & ~in_d[0])
                  | (~in_d[3] & in_d[2] & ~in_d[1] & in_d[0]));
  assign out[4] = ~((~in_d[2] & ~in_d[0]) | (in_d[1] & ~in_d[0]));
  assign out[5] = ~(in_d[3] | (in_d[2] & ~in_d[0]) | (in_d[2] & ~in_d[1]) | (~in_d[3] & ~in_d[1] & ~in_d[0]));
  assign out[6] = ~(in_d[3] | (~in_d[2] & in_d[1]) | (in_d[2] & ~in_d[0]) | (in_d[2] & ~in_d[1]));  
endmodule


module convert_Z_signal(z, out);
  input z;
  output [6:0] out;
  
  assign out[6] = 1;
  assign out[5:3] = {3{z}};
  assign out[0] = z;
  assign out[2:1] = 0;
endmodule