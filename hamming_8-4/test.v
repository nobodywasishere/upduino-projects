/* Generated by Yosys 0.9+4052 (open-tool-forge build) (git sha1 0ccc7229, gcc 9.3.0-17ubuntu1~20.04 -Os) */

module top(gpio_31, gpio_37, gpio_34, gpio_43, gpio_36, gpio_42, gpio_38, gpio_28, gpio_9, gpio_6, gpio_44, gpio_4, gpio_45, gpio_47, gpio_46, gpio_2);
  wire [3:0] _0_;
  output gpio_2;
  input gpio_28;
  input gpio_31;
  input gpio_34;
  input gpio_36;
  input gpio_37;
  input gpio_38;
  output gpio_4;
  input gpio_42;
  input gpio_43;
  output gpio_44;
  output gpio_45;
  output gpio_46;
  output gpio_47;
  output gpio_6;
  output gpio_9;
  hamming_correct correct1 (
    .data_in(8'h4f),
    .data_out(_0_),
    .error_location(3'h6)
  );
  assign gpio_9 = _0_[0];
  assign gpio_6 = _0_[1];
  assign gpio_44 = _0_[2];
  assign gpio_4 = _0_[3];
  assign gpio_45 = 1'hz;
  assign gpio_47 = 1'hz;
  assign gpio_46 = 1'hz;
  assign gpio_2 = 1'hz;
endmodule
