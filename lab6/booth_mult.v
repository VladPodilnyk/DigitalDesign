//
// booth's multiplier
//

module multiplier_nbit #(parameter DATA_WIDTH = 8)
(
  input  [DATA_WIDTH-1:0] multiplicand,
  input  [DATA_WIDTH-1:0] multiplier,
  input  clk,
  input  set,
  output busy,
  output [2*DATA_WIDTH - 1:0] product
);

  reg [DATA_WIDTH-1:0] sum_diff;

  reg Q_0;
  reg [DATA_WIDTH-1:0] Q;
  reg [DATA_WIDTH-1:0] accumulator;
  reg [DATA_WIDTH-1:0] multc;
  reg [DATA_WIDTH-1:0] counter;

  always @ (posedge clk or posedge set)
    if (set) begin
      Q <= multiplier;
      multc <= multiplicand;
      Q_0 = 'd0;
      accumulator = 'd0;
      counter = DATA_WIDTH;    
    end
    else if (counter) begin
      Q_0 <= Q[0];
      Q <= {sum_diff[0], Q[DATA_WIDTH-1:1]};
      accumulator <= $signed(sum_diff) >>> 1;
      counter <= counter - 1;
    end

  always @ (Q[0], Q_0) 
    case ({Q[0], Q_0}) 
      2'b10 : sum_diff = accumulator - multc;
      2'b01 : sum_diff = accumulator + multc;
      default : sum_diff = accumulator;
    endcase

  assign product = {accumulator, Q};
  assign busy = {counter > 0};

endmodule


/*
module add_sub_unit #(parameter DATA_WIDTH = 8)
(
  input  [DATA_WIDTH-1:0] f_operand,
  input  [DATA_WIDTH-1:0] s_operand,
  input  c_in,
  output [DATA_WIDTH-1:0] result
);

  assign result = f_operand + s_operand + c_in;

endmodule
*/  