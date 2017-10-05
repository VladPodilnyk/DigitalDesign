module mul4_2bit
(
 first_in, 
 second_in, 
 third_in, 
 fourth_in, 
 ctrl, 
 out
);

input [1:0] first_in;
input [1:0] second_in;
input [1:0] third_in;
input [1:0] fourth_in;
input [1:0] ctrl;

output [1:0] out;

assign out = ctrl[1] ? (ctrl[0] ? fourth_in : third_in) 
                     : (ctrl[0] ? second_in : first_in);

endmodule

// the same module but with structural implementation

module mul4_1bit(u, v, w, x, s, out);
  input u;
  input v;
  input w;
  input x;
  input [1:0] s;
  
  output out;
  
  assign out = s[1] ? (s[0] ?  x : w) 
                    : (s[0] ? v : u);
  
// fancy variant 
// input [3:0] i
// assign out = i[s];

endmodule

module mul4_2bit_struct
(
 first_in, 
 second_in, 
 third_in, 
 fourth_in, 
 ctrl, 
 out
);

input [1:0] first_in;
input [1:0] second_in;
input [1:0] third_in;
input [1:0] fourth_in;
input [1:0] ctrl;

output [1:0] out;

mul4_1bit first_mul(first_in[0], second_in[0], third_in[0], fourth_in[0], ctrl, out[0]);
mul4_1bit second_mul(first_in[1], second_in[1], third_in[1], fourth_in[1], ctrl, out[1]);

endmodule