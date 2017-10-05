// BCD adder implementation using if-else statement
module part5 (a, b, carry_in, sum);
    input [3:0] a;
    input [3:0] b;
    input carry_in;
    output [13:0] sum;

    reg [4:0] T0;
    reg [3:0] Z0, S0, S1;
    reg c1;

    always @ (*) begin
      T0 = a + b + carry_in;
      if (T0 > 9) begin
        Z0 = 10;
        c1 = 1;
      end else begin
        Z0 = 0;
        c1 = 0;
      end

      S0 = T0 - Z0;
      S1 = c1;
    end

    seven_bit_decoder b2d_dec0(.in_d(S0), .out(sum[6:0]));
    seven_bit_decoder b2d_dec1(.in_d(S1), .out(sum[13:7]));

endmodule
