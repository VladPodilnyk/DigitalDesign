//
// task: implement a registred multipler circuit
//
module reg_mult_circuit #(parameter DATA_WIDTH = 4)
(
  input  clock,
  input  reset,
  input  [DATA_WIDTH-1:0] data_in0,
  input  [DATA_WIDTH-1:0] data_in1,
  output [2*DATA_WIDTH-1:0] product
);
  
  wire [DATA_WIDTH-1:0] channel_A;
  wire [DATA_WIDTH-1:0] channel_B;
  wire [2*DATA_WIDTH-1:0] channel_P;

  register #(.DATA_WIDTH(DATA_WIDTH)) reg_A(.clk(clock), .reset(reset),
                                            .data(data_in0), .q(channel_A));
  register #(.DATA_WIDTH(DATA_WIDTH)) reg_B(.clk(clock), .reset(reset),
                                            .data(data_in1), .q(channel_B));
  register #(.DATA_WIDTH(DATA_WIDTH)) reg_P(.clk(clock), .reset(reset),
                                            .data(channel_P), .q(product));

  multipler #(.DATA_WIDTH(DATA_WIDTH)) mult_unit(.multipler(channel_A), 
                                                 .multiplicand(channel_B), 
                                                 .product(channel_P));
endmodule

module register #(parameter DATA_WIDTH = 1)
(
  input      clk, 
  input      reset,
  input      [DATA_WIDTH - 1:0] data,
  output reg [DATA_WIDTH - 1:0] q
);

  always @ (posedge clk or negedge reset)
    if (~reset) begin
      q <= 'b0;
    end else begin
      q <= data;
    end

endmodule


module full_adder
(
    input f_bit,
    input s_bit,
    input carry_in,
    output s,
    output carry_out
);

    assign s = f_bit ^ s_bit ^ carry_in;
    assign carry_out = (f_bit & s_bit) | (carry_in & (f_bit ^ s_bit));

endmodule


// ripple-carry n-bit adder
module n_bit_adder #(parameter DATA_WIDTH = 1)
(
  input  [DATA_WIDTH - 1:0] f_number,
  input  [DATA_WIDTH - 1:0] s_number,
  output carry,
  output [DATA_WIDTH - 1:0] sum
);

  wire [DATA_WIDTH:0] inner_carry;
  
  assign inner_carry[0] = 1'b0;

  genvar i;
  generate
    for (i = 0; i < DATA_WIDTH; i = i + 1) begin: full_adder_generator
      full_adder full_adder_inst
      (
        .f_bit(f_number[i]),
        .s_bit(s_number[i]),
        .carry_in(inner_carry[i]),
        .s(sum[i]),
        .carry_out(inner_carry[i + 1])
      );      
    end
  endgenerate

  assign carry = inner_carry[DATA_WIDTH];

endmodule


module multiplier #(parameter DATA_WIDTH = 4)
(
  input  [DATA_WIDTH - 1:0] multiplier,
  input  [DATA_WIDTH - 1:0] multiplicand,
  output [2*DATA_WIDTH - 1:0] product
);

  //some code here
  wire [DATA_WIDTH-1:0] carry_tmp;
  wire [DATA_WIDTH-1:0] product_tmp [DATA_WIDTH-1:0];
  wire [DATA_WIDTH-1:0] multiplicand_tmp [DATA_WIDTH-1:0];

  genvar i;
  generate
    for (i = 0; i < DATA_WIDTH; i = i + 1) begin: gen_temp_products
      assign multiplicand_tmp[i] = multiplicand & {DATA_WIDTH{multiplier[i]}};
    end
    
    assign carry_tmp[0] = 1'b0;
    assign product_tmp[0] = multiplicand_tmp[0];
    assign product[0] = product_tmp[0][0];

    for (i = 1; i < DATA_WIDTH; i = i + 1) begin: gen_adders
      n_bit_adder #(.DATA_WIDTH(DATA_WIDTH)) adder_inst
      (
        .f_number(multiplicand_tmp[i]),
        .s_number({carry_tmp[i-1], product_tmp[i-1][DATA_WIDTH-1:1]}),
        .carry(carry_tmp[i]),
        .sum(product_tmp[i])
      ); 
      assign product[i] = product_tmp[i][0];
    end
    assign product[2*DATA_WIDTH - 1: DATA_WIDTH] = {carry_tmp[DATA_WIDTH-1], product_tmp[DATA_WIDTH-1][DATA_WIDTH-1:1]};
  endgenerate

endmodule