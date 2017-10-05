module morse(letter, reset, clk, led);
  input reset, clk;
  input [2:0] letter;
  output reg led;

  wire [25:0] c0_out;
  wire c1_out;
  wire [3:0] indx;
  reg [15:0] signal;
  reg inner_clk;

  modk_counter #(.DATA_WIDTH(26), .MOD(25_000_000)) count0(clk, reset, c0_out);
  modk_counter #(.DATA_WIDTH(1), .MOD(2)) count1(inner_clk, reset, c1_out);

  always @ (negedge clk)
    if (c0_out == 24_999_999) begin
      inner_clk <= 1;
    end else begin
      inner_clk <= 0;
    end
  
  always @ (letter) begin
    case (letter)
      0: signal = 16'b0010111000000000; // A
      1: signal = 16'b0011101010100000; // B
      2: signal = 16'b0011101011101000; // C
      3: signal = 16'b0011101010000000; // D
      4: signal = 16'b0010000000000000; // E
      5: signal = 16'b0010101110100000; // F
      6: signal = 16'b0011101110100000; // G
      7: signal = 16'b0010101010000000; // H
    endcase
  end

  modk_counter #(.DATA_WIDTH(4), .MOD(14)) count2(c1_out, reset, indx);


  always @ (indx) begin
    case (indx)
      0:led = signal[13];
      1:led = signal[12];
      2:led = signal[11];
      3:led = signal[10];
      4:led = signal[9];
      5:led = signal[8];
      6:led = signal[7];
      7:led = signal[6];
      8:led = signal[5];
      9:led = signal[4];
      10:led = signal[3];
      11:led = signal[2];
      12:led = signal[1];
      13:led = signal[0];
    endcase
  end

endmodule
