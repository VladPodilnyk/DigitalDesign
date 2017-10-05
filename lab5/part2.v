module bcd_3bit_counter(clock_50, reset, out);
  input clock_50, reset;
  output [11:0] out;
  
  wire timer;
  wire [3:0] timer_out;
  reg [1:0] inner_clk;
   
  assign timer = &timer_out; // 1sec clock
  //assign inner_clk[1] = out[3] & out[0]; // zero 'till ones != 10
  //assign inner_clk[2] = out[7] & out[4]; // zero 'till tens != 10
  
  modk_counter #(.DATA_WIDTH(4), .MOD(16)) slow_counter(clock_50, reset, timer_out);
  
  modk_counter #(.DATA_WIDTH(4), .MOD(10)) ones(timer, reset, out[3:0]);
  modk_counter #(.DATA_WIDTH(4), .MOD(10)) tens(inner_clk[0], reset, out[7:4]);
  modk_counter #(.DATA_WIDTH(4), .MOD(10)) hundreds(inner_clk[1], reset, out[11:8]);

  always @ (posedge timer) begin
    if (out[3:0] == 9) begin
      inner_clk[0] <= 1;
    end else begin
      inner_clk[0] <= 0;
    end
    
    if(out[7:4] == 9) begin
      inner_clk[1] <= 1;
    end else begin
      inner_clk[1] <= 0;
    end

  end
    
endmodule
