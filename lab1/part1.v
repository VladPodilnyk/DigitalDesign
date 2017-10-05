module switch_toggle(sw, ledr);
  input [9:0] sw;
  output [9:0] ledr;
  
  assign ledr = sw;
endmodule
