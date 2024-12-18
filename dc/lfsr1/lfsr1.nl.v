/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Wed Dec  4 13:04:49 2024
/////////////////////////////////////////////////////////////


module lfsr1 ( clk, resetn, seed, lfsr_out );
  input [15:0] seed;
  output [15:0] lfsr_out;
  input clk, resetn;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, n50, n60, n70, n80, n90, n100, n110, n120, n130, n140, n150,
         n160, n170, n180;

  DFFQX1TS lfsr_out_reg_1_ ( .D(N4), .CK(clk), .Q(lfsr_out[1]) );
  DFFQX1TS lfsr_out_reg_2_ ( .D(N5), .CK(clk), .Q(lfsr_out[2]) );
  DFFQX1TS lfsr_out_reg_3_ ( .D(N6), .CK(clk), .Q(lfsr_out[3]) );
  DFFQX1TS lfsr_out_reg_4_ ( .D(N7), .CK(clk), .Q(lfsr_out[4]) );
  DFFQX1TS lfsr_out_reg_6_ ( .D(N9), .CK(clk), .Q(lfsr_out[6]) );
  DFFQX1TS lfsr_out_reg_7_ ( .D(N10), .CK(clk), .Q(lfsr_out[7]) );
  DFFQX1TS lfsr_out_reg_8_ ( .D(N11), .CK(clk), .Q(lfsr_out[8]) );
  DFFQX1TS lfsr_out_reg_9_ ( .D(N12), .CK(clk), .Q(lfsr_out[9]) );
  DFFQX1TS lfsr_out_reg_10_ ( .D(N13), .CK(clk), .Q(lfsr_out[10]) );
  DFFQX1TS lfsr_out_reg_11_ ( .D(N14), .CK(clk), .Q(lfsr_out[11]) );
  DFFQX1TS lfsr_out_reg_13_ ( .D(N16), .CK(clk), .Q(lfsr_out[13]) );
  DFFQX1TS lfsr_out_reg_14_ ( .D(N17), .CK(clk), .Q(lfsr_out[14]) );
  DFFQX1TS lfsr_out_reg_15_ ( .D(N18), .CK(clk), .Q(lfsr_out[15]) );
  DFFQX1TS lfsr_out_reg_12_ ( .D(N15), .CK(clk), .Q(lfsr_out[12]) );
  DFFHQX4TS lfsr_out_reg_0_ ( .D(N3), .CK(clk), .Q(lfsr_out[0]) );
  DFFQX1TS lfsr_out_reg_5_ ( .D(N8), .CK(clk), .Q(lfsr_out[5]) );
  INVX2TS U23 ( .A(n70), .Y(n110) );
  INVX2TS U24 ( .A(n80), .Y(n60) );
  AO22XLTS U25 ( .A0(n110), .A1(lfsr_out[6]), .B0(n140), .B1(seed[7]), .Y(N10)
         );
  AO22XLTS U26 ( .A0(n100), .A1(lfsr_out[13]), .B0(n130), .B1(seed[14]), .Y(
        N17) );
  AO22XLTS U27 ( .A0(n110), .A1(lfsr_out[14]), .B0(n140), .B1(seed[15]), .Y(
        N18) );
  AO22XLTS U28 ( .A0(n60), .A1(lfsr_out[7]), .B0(n150), .B1(seed[8]), .Y(N11)
         );
  AO22XLTS U29 ( .A0(n90), .A1(lfsr_out[8]), .B0(n120), .B1(seed[9]), .Y(N12)
         );
  AO22XLTS U30 ( .A0(n50), .A1(lfsr_out[11]), .B0(n150), .B1(seed[12]), .Y(N15) );
  AO22XLTS U31 ( .A0(n90), .A1(lfsr_out[12]), .B0(n120), .B1(seed[13]), .Y(N16) );
  AO22XLTS U32 ( .A0(n100), .A1(lfsr_out[9]), .B0(n130), .B1(seed[10]), .Y(N13) );
  AO22XLTS U33 ( .A0(n100), .A1(lfsr_out[1]), .B0(n130), .B1(seed[2]), .Y(N5)
         );
  AO22XLTS U34 ( .A0(n90), .A1(lfsr_out[4]), .B0(n120), .B1(seed[5]), .Y(N8)
         );
  AO22XLTS U35 ( .A0(n90), .A1(lfsr_out[0]), .B0(n120), .B1(seed[1]), .Y(N4)
         );
  AO22XLTS U36 ( .A0(n110), .A1(lfsr_out[2]), .B0(n140), .B1(seed[3]), .Y(N6)
         );
  AO22XLTS U37 ( .A0(n110), .A1(lfsr_out[10]), .B0(n140), .B1(seed[11]), .Y(
        N14) );
  AO22XLTS U38 ( .A0(n60), .A1(lfsr_out[3]), .B0(n150), .B1(seed[4]), .Y(N7)
         );
  INVX2TS U39 ( .A(n80), .Y(n50) );
  INVX1TS U40 ( .A(n70), .Y(n90) );
  INVX1TS U41 ( .A(n70), .Y(n100) );
  CLKBUFX2TS U42 ( .A(n70), .Y(n80) );
  INVX2TS U43 ( .A(resetn), .Y(n70) );
  INVX2TS U44 ( .A(n60), .Y(n120) );
  INVX2TS U45 ( .A(n50), .Y(n130) );
  INVX2TS U46 ( .A(n60), .Y(n140) );
  INVX2TS U47 ( .A(n50), .Y(n150) );
  XOR2X1TS U48 ( .A(lfsr_out[15]), .B(lfsr_out[0]), .Y(n170) );
  XOR2X1TS U49 ( .A(lfsr_out[12]), .B(lfsr_out[5]), .Y(n160) );
  XOR2X1TS U50 ( .A(n170), .B(n160), .Y(n180) );
  AO22X1TS U51 ( .A0(n50), .A1(n180), .B0(n150), .B1(seed[0]), .Y(N3) );
  AO22X1TS U52 ( .A0(n100), .A1(lfsr_out[5]), .B0(n130), .B1(seed[6]), .Y(N9)
         );
endmodule

