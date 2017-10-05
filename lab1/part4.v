// 7-segment decoder using only assign statement and boolean algebra
// note: 7-segment display uses active low level, so we need to pass zero to highlight the segment
module seven_segment_decoder(c, out);
  input [1:0] c;
  output [6:0] out;
  
  assign out[0] = ~(~c[1] & c[0]);
  assign out[2:1] = ~((~c[1] & ~c[0]) | (c[1] & ~c[0]));
  assign out[4:3] = ~((~c[1] & ~c[0]) | (~c[1] & c[0]));
  assign out[5] = ~(~c[1] & c[0]);
  assign out[6] = ~((~c[1] & ~c[0]) | (~c[1] & c[0]));
endmodule
  
  
