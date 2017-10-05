// the module implements 4 bit ripple-carry adder
module ripple_carry_adder(f_nibble, s_nibble, carry_in, carry_out, sum);
    input [3:0] f_nibble;
    input [3:0] s_nibble;
    input carry_in;
    output carry_out;
    output [3:0] sum;

    wire [2:0] ripple_carry_sig;

    full_adder lsb(f_nibble[0], s_nibble[0], carry_in, ripple_carry_sig[0], sum[0]);
    full_adder second_bit(f_nibble[1], s_nibble[1], ripple_carry_sig[0], ripple_carry_sig[1], sum[1]);
    full_adder third_bit(f_nibble[2], s_nibble[2], ripple_carry_sig[1], ripple_carry_sig[2], sum[2]);
    full_adder msb(f_nibble[3], s_nibble[3], ripple_carry_sig[2], carry_out, sum[3]);

endmodule


module full_adder(f_bit, s_bit, carry_in, carry_out, s);
    input f_bit;
    input s_bit;
    input carry_in;
    output s;
    output carry_out;


    assign s = f_bit ^ s_bit ^ carry_in;
    assign carry_out = (f_bit & s_bit) | (carry_in & (f_bit ^ s_bit));
endmodule
