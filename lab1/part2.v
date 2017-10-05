// the module descibes multiplexor with 2 1bit inputs
module mul2_1bit(first_in, second_in, ctrl, out);
  input first_in;
  input second_in;
  input ctrl;
  output out;
  
  assign out = ctrl ? second_in : first_in;
endmodule


// the module descibes multiplexor with 2 4bit inputs
module mul2_4bit(first_in, second_in, ctrl, out);
  input [3:0] first_in;
  input [3:0] second_in;
  input ctrl;
  output [3:0] out;
  
  assign out[0] = ctrl ? second_in[0] : first_in[0];
  assign out[1] = ctrl ? second_in[1] : first_in[1];
  assign out[2] = ctrl ? second_in[2] : first_in[2];
  assign out[3] = ctrl ? second_in[3] : first_in[3];
  
endmodule
  
// the same function as in previous module but implement using mul2_1bit
module mul2_4bit_struct(first_in, second_in, ctrl, out);
  input [3:0] first_in;
  input [3:0] second_in;
  input ctrl;
  output [3:0] out;
  
  mul2_1bit first_mul(first_in[0], second_in[0], ctrl, out[0]);
  mul2_1bit second_mul(first_in[1], second_in[1], ctrl, out[1]);
  mul2_1bit third_mul(first_in[2], second_in[2], ctrl, out[2]);
  mul2_1bit fourth_mul(first_in[3], second_in[3], ctrl, out[3]);
  
endmodule