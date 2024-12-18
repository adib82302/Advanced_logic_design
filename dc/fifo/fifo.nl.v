/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Wed Dec  4 12:27:41 2024
/////////////////////////////////////////////////////////////


module fifo ( clk, write_reset, write_enable, write_data, fast_clk, read_reset, 
        read_enable, read_data, empty_flag, full_flag );
  input [7:0] write_data;
  output [7:0] read_data;
  input clk, write_reset, write_enable, fast_clk, read_reset, read_enable;
  output empty_flag, full_flag;
  wire   n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n339, n340, n341, n342, n343, n344, n345,
         n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356,
         n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378,
         n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411,
         n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n422,
         n423, n424, n425, n426, n427, n428, n429, n430, n431, n432, n433,
         n434, n435, n436, n437, n438, n439, n440, n441, n442, n443, n444,
         n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, n455,
         n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466,
         n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477,
         n478, n479, n480, n481, n482, n483, n484, n485, n486, n487, n488,
         n489, n490, n491, n492, n493, n494, n495, n496, n497, n498, n499,
         n500, n501, n502, n503, n504, n505, n506, n507, n508, n509, n510,
         n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521,
         n522, n523, n524, n525, n526, n527, n528, n529, n530, n531, n532,
         n533, n534, n535, n536, n537, n538, n539, n540, n541, n542, n543,
         n544, n545, n546, n547, n548, n549, n550, n551, n552, n553, n554,
         n555, n556, n557, n558, n559, n560, n561, n562, n563, n564, n565,
         n566, n567, n568, n569, n570, n571, n572, n573, n574, n575, n576,
         n577, n578, n579, n580, n581, n582, n583, n584, n585, n586, n587,
         n588, n589, n590, n591, n592, n593, n594, n595, n596, n597, n598,
         n599, n600, n601, n602, n603, n604, n605, n606, n607, n608, n609,
         n610, n611, n612, n613, n614, n615, n616, n617, n618, n619, n620,
         n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n645, n646, n647, n648, n649, n650, n651, n652, n653,
         n654, n655, n656, n657, n658, n659, n660, n661, n662, n663, n664,
         n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, n675,
         n676, n677, n678, n679, n680, n681, n682, n683, n684, n685, n686,
         n687, n688, n689, n690, n691, n692, n693, n694, n695, n696, n697,
         n698, n699, n700, n701, n702, n703, n704, n705, n706, n707, n708,
         n709, n710, n711, n712, n713, n714, n715, n716, n717, n718, n719,
         n720, n721, n722;
  wire   [4:0] write_pointer;
  wire   [4:0] write_pointer_gray;
  wire   [127:0] memory;
  wire   [4:0] read_pointer;
  wire   [4:0] read_pointer_gray;
  wire   [4:0] read_pointer_gray_sync_w;
  wire   [4:0] write_pointer_gray_sync_r;

  DFFQX1TS read_pointer_gray_sync_w_reg_4_ ( .D(read_pointer_gray[4]), .CK(clk), .Q(read_pointer_gray_sync_w[4]) );
  DFFQX1TS read_pointer_gray_sync_w_reg_3_ ( .D(read_pointer_gray[3]), .CK(clk), .Q(read_pointer_gray_sync_w[3]) );
  DFFQX1TS read_pointer_gray_sync_w_reg_2_ ( .D(read_pointer_gray[2]), .CK(clk), .Q(read_pointer_gray_sync_w[2]) );
  DFFQX1TS read_pointer_gray_sync_w_reg_0_ ( .D(read_pointer_gray[0]), .CK(clk), .Q(read_pointer_gray_sync_w[0]) );
  DFFQX1TS write_pointer_gray_sync_r_reg_3_ ( .D(write_pointer_gray[3]), .CK(
        fast_clk), .Q(write_pointer_gray_sync_r[3]) );
  DFFQX1TS write_pointer_gray_sync_r_reg_2_ ( .D(write_pointer_gray[2]), .CK(
        fast_clk), .Q(write_pointer_gray_sync_r[2]) );
  DFFQX1TS write_pointer_gray_sync_r_reg_1_ ( .D(write_pointer_gray[1]), .CK(
        fast_clk), .Q(write_pointer_gray_sync_r[1]) );
  DFFQX1TS memory_reg_1__0_ ( .D(n329), .CK(clk), .Q(memory[8]) );
  DFFQX1TS memory_reg_1__1_ ( .D(n328), .CK(clk), .Q(memory[9]) );
  DFFQX1TS memory_reg_1__2_ ( .D(n327), .CK(clk), .Q(memory[10]) );
  DFFQX1TS memory_reg_1__3_ ( .D(n326), .CK(clk), .Q(memory[11]) );
  DFFQX1TS memory_reg_1__4_ ( .D(n325), .CK(clk), .Q(memory[12]) );
  DFFQX1TS memory_reg_1__5_ ( .D(n324), .CK(clk), .Q(memory[13]) );
  DFFQX1TS memory_reg_1__6_ ( .D(n323), .CK(clk), .Q(memory[14]) );
  DFFQX1TS memory_reg_1__7_ ( .D(n322), .CK(clk), .Q(memory[15]) );
  DFFQX1TS memory_reg_3__5_ ( .D(n313), .CK(clk), .Q(memory[29]) );
  DFFQX1TS memory_reg_3__6_ ( .D(n312), .CK(clk), .Q(memory[30]) );
  DFFQX1TS memory_reg_3__7_ ( .D(n311), .CK(clk), .Q(memory[31]) );
  DFFQX1TS memory_reg_3__0_ ( .D(n310), .CK(clk), .Q(memory[24]) );
  DFFQX1TS memory_reg_3__1_ ( .D(n309), .CK(clk), .Q(memory[25]) );
  DFFQX1TS memory_reg_3__2_ ( .D(n308), .CK(clk), .Q(memory[26]) );
  DFFQX1TS memory_reg_3__3_ ( .D(n307), .CK(clk), .Q(memory[27]) );
  DFFQX1TS memory_reg_3__4_ ( .D(n306), .CK(clk), .Q(memory[28]) );
  DFFQX1TS memory_reg_5__0_ ( .D(n297), .CK(clk), .Q(memory[40]) );
  DFFQX1TS memory_reg_5__1_ ( .D(n296), .CK(clk), .Q(memory[41]) );
  DFFQX1TS memory_reg_5__2_ ( .D(n295), .CK(clk), .Q(memory[42]) );
  DFFQX1TS memory_reg_5__3_ ( .D(n294), .CK(clk), .Q(memory[43]) );
  DFFQX1TS memory_reg_5__4_ ( .D(n293), .CK(clk), .Q(memory[44]) );
  DFFQX1TS memory_reg_5__5_ ( .D(n292), .CK(clk), .Q(memory[45]) );
  DFFQX1TS memory_reg_5__6_ ( .D(n291), .CK(clk), .Q(memory[46]) );
  DFFQX1TS memory_reg_5__7_ ( .D(n290), .CK(clk), .Q(memory[47]) );
  DFFQX1TS memory_reg_7__0_ ( .D(n281), .CK(clk), .Q(memory[56]) );
  DFFQX1TS memory_reg_7__1_ ( .D(n280), .CK(clk), .Q(memory[57]) );
  DFFQX1TS memory_reg_7__2_ ( .D(n279), .CK(clk), .Q(memory[58]) );
  DFFQX1TS memory_reg_7__3_ ( .D(n278), .CK(clk), .Q(memory[59]) );
  DFFQX1TS memory_reg_7__4_ ( .D(n277), .CK(clk), .Q(memory[60]) );
  DFFQX1TS memory_reg_7__5_ ( .D(n276), .CK(clk), .Q(memory[61]) );
  DFFQX1TS memory_reg_7__6_ ( .D(n275), .CK(clk), .Q(memory[62]) );
  DFFQX1TS memory_reg_7__7_ ( .D(n274), .CK(clk), .Q(memory[63]) );
  DFFQX1TS memory_reg_0__1_ ( .D(n337), .CK(clk), .Q(memory[1]) );
  DFFQX1TS memory_reg_0__2_ ( .D(n336), .CK(clk), .Q(memory[2]) );
  DFFQX1TS memory_reg_0__3_ ( .D(n335), .CK(clk), .Q(memory[3]) );
  DFFQX1TS memory_reg_0__4_ ( .D(n334), .CK(clk), .Q(memory[4]) );
  DFFQX1TS memory_reg_0__5_ ( .D(n333), .CK(clk), .Q(memory[5]) );
  DFFQX1TS memory_reg_0__6_ ( .D(n332), .CK(clk), .Q(memory[6]) );
  DFFQX1TS memory_reg_0__7_ ( .D(n331), .CK(clk), .Q(memory[7]) );
  DFFQX1TS memory_reg_0__0_ ( .D(n330), .CK(clk), .Q(memory[0]) );
  DFFQX1TS memory_reg_2__0_ ( .D(n321), .CK(clk), .Q(memory[16]) );
  DFFQX1TS memory_reg_2__1_ ( .D(n320), .CK(clk), .Q(memory[17]) );
  DFFQX1TS memory_reg_2__2_ ( .D(n319), .CK(clk), .Q(memory[18]) );
  DFFQX1TS memory_reg_2__3_ ( .D(n318), .CK(clk), .Q(memory[19]) );
  DFFQX1TS memory_reg_2__4_ ( .D(n317), .CK(clk), .Q(memory[20]) );
  DFFQX1TS memory_reg_2__5_ ( .D(n316), .CK(clk), .Q(memory[21]) );
  DFFQX1TS memory_reg_2__6_ ( .D(n315), .CK(clk), .Q(memory[22]) );
  DFFQX1TS memory_reg_2__7_ ( .D(n314), .CK(clk), .Q(memory[23]) );
  DFFQX1TS memory_reg_4__0_ ( .D(n305), .CK(clk), .Q(memory[32]) );
  DFFQX1TS memory_reg_4__1_ ( .D(n304), .CK(clk), .Q(memory[33]) );
  DFFQX1TS memory_reg_4__2_ ( .D(n303), .CK(clk), .Q(memory[34]) );
  DFFQX1TS memory_reg_4__3_ ( .D(n302), .CK(clk), .Q(memory[35]) );
  DFFQX1TS memory_reg_4__4_ ( .D(n301), .CK(clk), .Q(memory[36]) );
  DFFQX1TS memory_reg_4__5_ ( .D(n300), .CK(clk), .Q(memory[37]) );
  DFFQX1TS memory_reg_4__6_ ( .D(n299), .CK(clk), .Q(memory[38]) );
  DFFQX1TS memory_reg_4__7_ ( .D(n298), .CK(clk), .Q(memory[39]) );
  DFFQX1TS memory_reg_6__0_ ( .D(n289), .CK(clk), .Q(memory[48]) );
  DFFQX1TS memory_reg_6__1_ ( .D(n288), .CK(clk), .Q(memory[49]) );
  DFFQX1TS memory_reg_6__2_ ( .D(n287), .CK(clk), .Q(memory[50]) );
  DFFQX1TS memory_reg_6__3_ ( .D(n286), .CK(clk), .Q(memory[51]) );
  DFFQX1TS memory_reg_6__4_ ( .D(n285), .CK(clk), .Q(memory[52]) );
  DFFQX1TS memory_reg_6__5_ ( .D(n284), .CK(clk), .Q(memory[53]) );
  DFFQX1TS memory_reg_6__6_ ( .D(n283), .CK(clk), .Q(memory[54]) );
  DFFQX1TS memory_reg_6__7_ ( .D(n282), .CK(clk), .Q(memory[55]) );
  DFFQX1TS memory_reg_8__0_ ( .D(n273), .CK(clk), .Q(memory[64]) );
  DFFQX1TS memory_reg_8__1_ ( .D(n272), .CK(clk), .Q(memory[65]) );
  DFFQX1TS memory_reg_8__2_ ( .D(n271), .CK(clk), .Q(memory[66]) );
  DFFQX1TS memory_reg_8__3_ ( .D(n270), .CK(clk), .Q(memory[67]) );
  DFFQX1TS memory_reg_8__4_ ( .D(n269), .CK(clk), .Q(memory[68]) );
  DFFQX1TS memory_reg_8__5_ ( .D(n268), .CK(clk), .Q(memory[69]) );
  DFFQX1TS memory_reg_8__6_ ( .D(n267), .CK(clk), .Q(memory[70]) );
  DFFQX1TS memory_reg_8__7_ ( .D(n266), .CK(clk), .Q(memory[71]) );
  DFFQX1TS memory_reg_10__0_ ( .D(n257), .CK(clk), .Q(memory[80]) );
  DFFQX1TS memory_reg_10__1_ ( .D(n256), .CK(clk), .Q(memory[81]) );
  DFFQX1TS memory_reg_10__2_ ( .D(n255), .CK(clk), .Q(memory[82]) );
  DFFQX1TS memory_reg_10__3_ ( .D(n254), .CK(clk), .Q(memory[83]) );
  DFFQX1TS memory_reg_10__4_ ( .D(n253), .CK(clk), .Q(memory[84]) );
  DFFQX1TS memory_reg_10__5_ ( .D(n252), .CK(clk), .Q(memory[85]) );
  DFFQX1TS memory_reg_10__6_ ( .D(n251), .CK(clk), .Q(memory[86]) );
  DFFQX1TS memory_reg_10__7_ ( .D(n250), .CK(clk), .Q(memory[87]) );
  DFFQX1TS memory_reg_12__0_ ( .D(n241), .CK(clk), .Q(memory[96]) );
  DFFQX1TS memory_reg_12__1_ ( .D(n240), .CK(clk), .Q(memory[97]) );
  DFFQX1TS memory_reg_12__2_ ( .D(n239), .CK(clk), .Q(memory[98]) );
  DFFQX1TS memory_reg_12__3_ ( .D(n238), .CK(clk), .Q(memory[99]) );
  DFFQX1TS memory_reg_12__4_ ( .D(n237), .CK(clk), .Q(memory[100]) );
  DFFQX1TS memory_reg_12__5_ ( .D(n236), .CK(clk), .Q(memory[101]) );
  DFFQX1TS memory_reg_12__6_ ( .D(n235), .CK(clk), .Q(memory[102]) );
  DFFQX1TS memory_reg_12__7_ ( .D(n234), .CK(clk), .Q(memory[103]) );
  DFFQX1TS memory_reg_14__0_ ( .D(n225), .CK(clk), .Q(memory[112]) );
  DFFQX1TS memory_reg_14__1_ ( .D(n224), .CK(clk), .Q(memory[113]) );
  DFFQX1TS memory_reg_14__2_ ( .D(n223), .CK(clk), .Q(memory[114]) );
  DFFQX1TS memory_reg_14__3_ ( .D(n222), .CK(clk), .Q(memory[115]) );
  DFFQX1TS memory_reg_14__4_ ( .D(n221), .CK(clk), .Q(memory[116]) );
  DFFQX1TS memory_reg_14__5_ ( .D(n220), .CK(clk), .Q(memory[117]) );
  DFFQX1TS memory_reg_14__6_ ( .D(n219), .CK(clk), .Q(memory[118]) );
  DFFQX1TS memory_reg_14__7_ ( .D(n218), .CK(clk), .Q(memory[119]) );
  DFFQX1TS memory_reg_9__0_ ( .D(n265), .CK(clk), .Q(memory[72]) );
  DFFQX1TS memory_reg_9__1_ ( .D(n264), .CK(clk), .Q(memory[73]) );
  DFFQX1TS memory_reg_9__2_ ( .D(n263), .CK(clk), .Q(memory[74]) );
  DFFQX1TS memory_reg_9__3_ ( .D(n262), .CK(clk), .Q(memory[75]) );
  DFFQX1TS memory_reg_9__4_ ( .D(n261), .CK(clk), .Q(memory[76]) );
  DFFQX1TS memory_reg_9__5_ ( .D(n260), .CK(clk), .Q(memory[77]) );
  DFFQX1TS memory_reg_9__6_ ( .D(n259), .CK(clk), .Q(memory[78]) );
  DFFQX1TS memory_reg_9__7_ ( .D(n258), .CK(clk), .Q(memory[79]) );
  DFFQX1TS memory_reg_11__0_ ( .D(n249), .CK(clk), .Q(memory[88]) );
  DFFQX1TS memory_reg_11__1_ ( .D(n248), .CK(clk), .Q(memory[89]) );
  DFFQX1TS memory_reg_11__2_ ( .D(n247), .CK(clk), .Q(memory[90]) );
  DFFQX1TS memory_reg_11__3_ ( .D(n246), .CK(clk), .Q(memory[91]) );
  DFFQX1TS memory_reg_11__4_ ( .D(n245), .CK(clk), .Q(memory[92]) );
  DFFQX1TS memory_reg_11__5_ ( .D(n244), .CK(clk), .Q(memory[93]) );
  DFFQX1TS memory_reg_11__6_ ( .D(n243), .CK(clk), .Q(memory[94]) );
  DFFQX1TS memory_reg_11__7_ ( .D(n242), .CK(clk), .Q(memory[95]) );
  DFFQX1TS memory_reg_13__0_ ( .D(n233), .CK(clk), .Q(memory[104]) );
  DFFQX1TS memory_reg_13__1_ ( .D(n232), .CK(clk), .Q(memory[105]) );
  DFFQX1TS memory_reg_13__2_ ( .D(n231), .CK(clk), .Q(memory[106]) );
  DFFQX1TS memory_reg_13__3_ ( .D(n230), .CK(clk), .Q(memory[107]) );
  DFFQX1TS memory_reg_13__4_ ( .D(n229), .CK(clk), .Q(memory[108]) );
  DFFQX1TS memory_reg_13__5_ ( .D(n228), .CK(clk), .Q(memory[109]) );
  DFFQX1TS memory_reg_13__6_ ( .D(n227), .CK(clk), .Q(memory[110]) );
  DFFQX1TS memory_reg_13__7_ ( .D(n226), .CK(clk), .Q(memory[111]) );
  DFFQX1TS memory_reg_15__0_ ( .D(n217), .CK(clk), .Q(memory[120]) );
  DFFQX1TS memory_reg_15__1_ ( .D(n216), .CK(clk), .Q(memory[121]) );
  DFFQX1TS memory_reg_15__2_ ( .D(n215), .CK(clk), .Q(memory[122]) );
  DFFQX1TS memory_reg_15__3_ ( .D(n214), .CK(clk), .Q(memory[123]) );
  DFFQX1TS memory_reg_15__4_ ( .D(n213), .CK(clk), .Q(memory[124]) );
  DFFQX1TS memory_reg_15__5_ ( .D(n212), .CK(clk), .Q(memory[125]) );
  DFFQX1TS memory_reg_15__6_ ( .D(n211), .CK(clk), .Q(memory[126]) );
  DFFQX1TS memory_reg_15__7_ ( .D(n210), .CK(clk), .Q(memory[127]) );
  DFFRXLTS read_pointer_gray_reg_4_ ( .D(n209), .CK(fast_clk), .RN(n188), .Q(
        read_pointer_gray[4]), .QN(n713) );
  DFFRXLTS read_pointer_gray_reg_3_ ( .D(n208), .CK(fast_clk), .RN(n455), .Q(
        read_pointer_gray[3]), .QN(n715) );
  DFFRXLTS read_pointer_gray_reg_2_ ( .D(n207), .CK(fast_clk), .RN(n454), .Q(
        read_pointer_gray[2]), .QN(n709) );
  DFFRXLTS read_pointer_gray_reg_1_ ( .D(n206), .CK(fast_clk), .RN(n455), .Q(
        read_pointer_gray[1]), .QN(n714) );
  DFFRXLTS read_pointer_gray_reg_0_ ( .D(n205), .CK(fast_clk), .RN(n188), .Q(
        read_pointer_gray[0]) );
  DFFRXLTS write_pointer_gray_reg_0_ ( .D(n204), .CK(clk), .RN(n459), .Q(
        write_pointer_gray[0]), .QN(n720) );
  DFFRXLTS write_pointer_gray_reg_4_ ( .D(n203), .CK(clk), .RN(n457), .Q(
        write_pointer_gray[4]) );
  DFFRXLTS write_pointer_gray_reg_3_ ( .D(n202), .CK(clk), .RN(n458), .Q(
        write_pointer_gray[3]) );
  DFFRXLTS write_pointer_gray_reg_2_ ( .D(n201), .CK(clk), .RN(n458), .Q(
        write_pointer_gray[2]), .QN(n722) );
  DFFRXLTS write_pointer_gray_reg_1_ ( .D(n200), .CK(clk), .RN(n459), .Q(
        write_pointer_gray[1]), .QN(n712) );
  DFFRXLTS write_pointer_reg_0_ ( .D(n199), .CK(clk), .RN(n459), .Q(
        write_pointer[0]), .QN(n711) );
  DFFRXLTS write_pointer_reg_4_ ( .D(n198), .CK(clk), .RN(n457), .Q(
        write_pointer[4]) );
  DFFRXLTS write_pointer_reg_3_ ( .D(n197), .CK(clk), .RN(n457), .Q(
        write_pointer[3]), .QN(n721) );
  DFFRXLTS write_pointer_reg_2_ ( .D(n196), .CK(clk), .RN(n458), .Q(
        write_pointer[2]), .QN(n719) );
  DFFRXLTS write_pointer_reg_1_ ( .D(n195), .CK(clk), .RN(n459), .Q(
        write_pointer[1]), .QN(n718) );
  DFFRXLTS read_pointer_reg_0_ ( .D(n193), .CK(fast_clk), .RN(n455), .Q(
        read_pointer[0]), .QN(n341) );
  DFFRXLTS read_pointer_reg_4_ ( .D(n192), .CK(fast_clk), .RN(n454), .Q(
        read_pointer[4]), .QN(n339) );
  DFFRXLTS read_pointer_reg_3_ ( .D(n191), .CK(fast_clk), .RN(n454), .Q(
        read_pointer[3]), .QN(n717) );
  DFFQX1TS read_data_reg_0_ ( .D(n187), .CK(fast_clk), .Q(read_data[0]) );
  DFFQX1TS read_data_reg_1_ ( .D(n186), .CK(fast_clk), .Q(read_data[1]) );
  DFFQX1TS read_data_reg_2_ ( .D(n185), .CK(fast_clk), .Q(read_data[2]) );
  DFFQX1TS read_data_reg_3_ ( .D(n184), .CK(fast_clk), .Q(read_data[3]) );
  DFFQX1TS read_data_reg_4_ ( .D(n183), .CK(fast_clk), .Q(read_data[4]) );
  DFFQX1TS read_data_reg_5_ ( .D(n182), .CK(fast_clk), .Q(read_data[5]) );
  DFFQX1TS read_data_reg_6_ ( .D(n181), .CK(fast_clk), .Q(read_data[6]) );
  DFFQX1TS read_data_reg_7_ ( .D(n180), .CK(fast_clk), .Q(read_data[7]) );
  DFFQX1TS read_pointer_gray_sync_w_reg_1_ ( .D(read_pointer_gray[1]), .CK(clk), .Q(read_pointer_gray_sync_w[1]) );
  DFFQX1TS write_pointer_gray_sync_r_reg_0_ ( .D(write_pointer_gray[0]), .CK(
        fast_clk), .Q(write_pointer_gray_sync_r[0]) );
  DFFQX1TS write_pointer_gray_sync_r_reg_4_ ( .D(write_pointer_gray[4]), .CK(
        fast_clk), .Q(write_pointer_gray_sync_r[4]) );
  DFFRXLTS read_pointer_reg_2_ ( .D(n190), .CK(fast_clk), .RN(n455), .Q(
        read_pointer[2]), .QN(n710) );
  DFFRXLTS read_pointer_reg_1_ ( .D(n189), .CK(fast_clk), .RN(n454), .Q(
        read_pointer[1]), .QN(n716) );
  AOI221XLTS U343 ( .A0(n714), .A1(write_pointer_gray_sync_r[1]), .B0(n555), 
        .B1(read_pointer_gray[0]), .C0(n554), .Y(n556) );
  OA21XLTS U344 ( .A0(write_pointer[3]), .A1(n550), .B0(n549), .Y(n340) );
  OR2X1TS U345 ( .A(n350), .B(n565), .Y(n342) );
  OR3X1TS U346 ( .A(n350), .B(n411), .C(n716), .Y(n343) );
  OR3X1TS U347 ( .A(n350), .B(n410), .C(read_pointer[1]), .Y(n344) );
  OR3X1TS U348 ( .A(n410), .B(n710), .C(n366), .Y(n345) );
  OR2X1TS U349 ( .A(n710), .B(n565), .Y(n346) );
  NOR2XLTS U350 ( .A(n451), .B(n717), .Y(n347) );
  OR2X1TS U351 ( .A(read_pointer[3]), .B(n653), .Y(n348) );
  INVX2TS U352 ( .A(read_pointer[2]), .Y(n349) );
  INVX2TS U353 ( .A(n349), .Y(n350) );
  INVX2TS U354 ( .A(n339), .Y(n351) );
  INVX2TS U355 ( .A(n711), .Y(n352) );
  INVX2TS U356 ( .A(n340), .Y(n353) );
  INVX2TS U357 ( .A(n340), .Y(n354) );
  INVX2TS U358 ( .A(n685), .Y(n355) );
  INVX2TS U359 ( .A(n355), .Y(n356) );
  INVX2TS U360 ( .A(n689), .Y(n357) );
  INVX2TS U361 ( .A(n357), .Y(n358) );
  INVX2TS U362 ( .A(n708), .Y(n359) );
  INVX2TS U363 ( .A(n359), .Y(n360) );
  INVX2TS U364 ( .A(n359), .Y(n361) );
  INVX2TS U365 ( .A(n659), .Y(n362) );
  INVX2TS U366 ( .A(n647), .Y(n363) );
  INVX2TS U367 ( .A(n363), .Y(n364) );
  INVX2TS U368 ( .A(n363), .Y(n365) );
  INVX2TS U369 ( .A(read_pointer[1]), .Y(n366) );
  INVX2TS U370 ( .A(n719), .Y(n367) );
  INVX2TS U371 ( .A(n696), .Y(n368) );
  INVX2TS U372 ( .A(n368), .Y(n369) );
  INVX2TS U373 ( .A(n352), .Y(n370) );
  INVX2TS U374 ( .A(write_pointer[1]), .Y(n371) );
  INVX2TS U375 ( .A(n371), .Y(n372) );
  INVX2TS U376 ( .A(n371), .Y(n373) );
  INVX2TS U377 ( .A(n347), .Y(n374) );
  INVX2TS U378 ( .A(n347), .Y(n375) );
  INVX2TS U379 ( .A(n348), .Y(n376) );
  INVX2TS U380 ( .A(n348), .Y(n377) );
  INVX2TS U381 ( .A(n666), .Y(n378) );
  INVX2TS U382 ( .A(n477), .Y(n379) );
  INVX2TS U383 ( .A(n668), .Y(n380) );
  INVX2TS U384 ( .A(n380), .Y(n381) );
  INVX2TS U385 ( .A(n380), .Y(n382) );
  INVX2TS U386 ( .A(n671), .Y(n383) );
  INVX2TS U387 ( .A(n673), .Y(n384) );
  INVX2TS U388 ( .A(n674), .Y(n385) );
  INVX2TS U389 ( .A(n422), .Y(n386) );
  INVX2TS U390 ( .A(n675), .Y(n387) );
  INVX2TS U391 ( .A(n425), .Y(n388) );
  INVX2TS U392 ( .A(n678), .Y(n389) );
  INVX2TS U393 ( .A(n680), .Y(n390) );
  INVX2TS U394 ( .A(n431), .Y(n391) );
  INVX2TS U395 ( .A(n681), .Y(n392) );
  INVX2TS U396 ( .A(n392), .Y(n393) );
  INVX2TS U397 ( .A(n392), .Y(n394) );
  INVX2TS U398 ( .A(n683), .Y(n395) );
  INVX2TS U399 ( .A(n480), .Y(n396) );
  INVX2TS U400 ( .A(n684), .Y(n397) );
  INVX2TS U401 ( .A(n434), .Y(n398) );
  INVX2TS U402 ( .A(n686), .Y(n399) );
  INVX2TS U403 ( .A(n437), .Y(n400) );
  INVX2TS U404 ( .A(n688), .Y(n401) );
  INVX2TS U405 ( .A(n690), .Y(n402) );
  INVX2TS U406 ( .A(n402), .Y(n403) );
  INVX2TS U407 ( .A(n402), .Y(n404) );
  INVX2TS U408 ( .A(n693), .Y(n405) );
  INVX2TS U409 ( .A(n405), .Y(n406) );
  INVX2TS U410 ( .A(n405), .Y(n407) );
  INVX2TS U411 ( .A(n697), .Y(n408) );
  INVX2TS U412 ( .A(n445), .Y(n409) );
  INVX2TS U413 ( .A(n341), .Y(n410) );
  INVX2TS U414 ( .A(n341), .Y(n411) );
  INVX2TS U415 ( .A(n681), .Y(n412) );
  INVX2TS U416 ( .A(n668), .Y(n413) );
  INVX2TS U417 ( .A(n671), .Y(n414) );
  INVX2TS U418 ( .A(n414), .Y(n415) );
  INVX2TS U419 ( .A(n414), .Y(n416) );
  INVX2TS U420 ( .A(n673), .Y(n417) );
  INVX2TS U421 ( .A(n417), .Y(n418) );
  INVX2TS U422 ( .A(n417), .Y(n419) );
  INVX2TS U423 ( .A(n674), .Y(n420) );
  INVX2TS U424 ( .A(n420), .Y(n421) );
  INVX2TS U425 ( .A(n420), .Y(n422) );
  INVX2TS U426 ( .A(n675), .Y(n423) );
  INVX2TS U427 ( .A(n423), .Y(n424) );
  INVX2TS U428 ( .A(n423), .Y(n425) );
  INVX2TS U429 ( .A(n678), .Y(n426) );
  INVX2TS U430 ( .A(n426), .Y(n427) );
  INVX2TS U431 ( .A(n426), .Y(n428) );
  INVX2TS U432 ( .A(n680), .Y(n429) );
  INVX2TS U433 ( .A(n429), .Y(n430) );
  INVX2TS U434 ( .A(n429), .Y(n431) );
  INVX2TS U435 ( .A(n684), .Y(n432) );
  INVX2TS U436 ( .A(n432), .Y(n433) );
  INVX2TS U437 ( .A(n432), .Y(n434) );
  INVX2TS U438 ( .A(n686), .Y(n435) );
  INVX2TS U439 ( .A(n435), .Y(n436) );
  INVX2TS U440 ( .A(n435), .Y(n437) );
  INVX2TS U441 ( .A(n688), .Y(n438) );
  INVX2TS U442 ( .A(n438), .Y(n439) );
  INVX2TS U443 ( .A(n438), .Y(n440) );
  INVX2TS U444 ( .A(n690), .Y(n441) );
  INVX2TS U445 ( .A(n693), .Y(n442) );
  INVX2TS U446 ( .A(n697), .Y(n443) );
  INVX2TS U447 ( .A(n443), .Y(n444) );
  INVX2TS U448 ( .A(n443), .Y(n445) );
  INVX2TS U449 ( .A(n702), .Y(n446) );
  INVX2TS U450 ( .A(n446), .Y(n447) );
  INVX2TS U451 ( .A(n446), .Y(n448) );
  INVX2TS U452 ( .A(n446), .Y(n449) );
  INVX2TS U453 ( .A(n653), .Y(n450) );
  INVX2TS U454 ( .A(n450), .Y(n451) );
  INVX2TS U455 ( .A(n450), .Y(n452) );
  INVX2TS U456 ( .A(n188), .Y(n453) );
  INVX2TS U457 ( .A(n453), .Y(n454) );
  INVX2TS U458 ( .A(n453), .Y(n455) );
  INVX2TS U459 ( .A(n194), .Y(n456) );
  INVX2TS U460 ( .A(n456), .Y(n457) );
  INVX2TS U461 ( .A(n456), .Y(n458) );
  INVX2TS U462 ( .A(n456), .Y(n459) );
  INVX2TS U463 ( .A(n449), .Y(n460) );
  INVX2TS U464 ( .A(n448), .Y(n461) );
  INVX2TS U465 ( .A(n702), .Y(n462) );
  INVX2TS U466 ( .A(n361), .Y(n463) );
  INVX2TS U467 ( .A(n360), .Y(n464) );
  INVX2TS U468 ( .A(n361), .Y(n465) );
  INVX2TS U469 ( .A(n342), .Y(n466) );
  INVX2TS U470 ( .A(n342), .Y(n467) );
  INVX2TS U471 ( .A(n342), .Y(n468) );
  INVX2TS U472 ( .A(n342), .Y(n469) );
  INVX2TS U473 ( .A(n704), .Y(n470) );
  INVX2TS U474 ( .A(n470), .Y(n471) );
  INVX2TS U475 ( .A(n470), .Y(n472) );
  INVX2TS U476 ( .A(n470), .Y(n473) );
  INVX2TS U477 ( .A(n470), .Y(n474) );
  INVX2TS U478 ( .A(n666), .Y(n475) );
  INVX2TS U479 ( .A(n475), .Y(n476) );
  INVX2TS U480 ( .A(n475), .Y(n477) );
  INVX2TS U481 ( .A(n683), .Y(n478) );
  INVX2TS U482 ( .A(n478), .Y(n479) );
  INVX2TS U483 ( .A(n478), .Y(n480) );
  INVX2TS U484 ( .A(n363), .Y(n481) );
  INVX2TS U485 ( .A(n363), .Y(n482) );
  INVX2TS U486 ( .A(n346), .Y(n483) );
  INVX2TS U487 ( .A(n346), .Y(n484) );
  INVX2TS U488 ( .A(n346), .Y(n485) );
  INVX2TS U489 ( .A(n346), .Y(n486) );
  INVX2TS U490 ( .A(n343), .Y(n487) );
  INVX2TS U491 ( .A(n343), .Y(n488) );
  INVX2TS U492 ( .A(n343), .Y(n489) );
  INVX2TS U493 ( .A(n343), .Y(n490) );
  INVX2TS U494 ( .A(n345), .Y(n491) );
  INVX2TS U495 ( .A(n345), .Y(n492) );
  INVX2TS U496 ( .A(n345), .Y(n493) );
  INVX2TS U497 ( .A(n345), .Y(n494) );
  INVX2TS U498 ( .A(n344), .Y(n495) );
  INVX2TS U499 ( .A(n344), .Y(n496) );
  INVX2TS U500 ( .A(n344), .Y(n497) );
  INVX2TS U501 ( .A(n344), .Y(n498) );
  INVX2TS U502 ( .A(write_data[0]), .Y(n499) );
  INVX2TS U503 ( .A(n499), .Y(n500) );
  INVX2TS U504 ( .A(n499), .Y(n501) );
  INVX2TS U505 ( .A(n499), .Y(n502) );
  INVX2TS U506 ( .A(n499), .Y(n503) );
  INVX2TS U507 ( .A(write_data[1]), .Y(n504) );
  INVX2TS U508 ( .A(n504), .Y(n505) );
  INVX2TS U509 ( .A(n504), .Y(n506) );
  INVX2TS U510 ( .A(n504), .Y(n507) );
  INVX2TS U511 ( .A(n504), .Y(n508) );
  INVX2TS U512 ( .A(write_data[2]), .Y(n509) );
  INVX2TS U513 ( .A(n509), .Y(n510) );
  INVX2TS U514 ( .A(n509), .Y(n511) );
  INVX2TS U515 ( .A(n509), .Y(n512) );
  INVX2TS U516 ( .A(n509), .Y(n513) );
  INVX2TS U517 ( .A(write_data[3]), .Y(n514) );
  INVX2TS U518 ( .A(n514), .Y(n515) );
  INVX2TS U519 ( .A(n514), .Y(n516) );
  INVX2TS U520 ( .A(n514), .Y(n517) );
  INVX2TS U521 ( .A(n514), .Y(n518) );
  INVX2TS U522 ( .A(write_data[4]), .Y(n519) );
  INVX2TS U523 ( .A(n519), .Y(n520) );
  INVX2TS U524 ( .A(n519), .Y(n521) );
  INVX2TS U525 ( .A(n519), .Y(n522) );
  INVX2TS U526 ( .A(n519), .Y(n523) );
  INVX2TS U527 ( .A(write_data[5]), .Y(n524) );
  INVX2TS U528 ( .A(n524), .Y(n525) );
  INVX2TS U529 ( .A(n524), .Y(n526) );
  INVX2TS U530 ( .A(n524), .Y(n527) );
  INVX2TS U531 ( .A(n524), .Y(n528) );
  INVX2TS U532 ( .A(write_data[6]), .Y(n529) );
  INVX2TS U533 ( .A(n529), .Y(n530) );
  INVX2TS U534 ( .A(n529), .Y(n531) );
  INVX2TS U535 ( .A(n529), .Y(n532) );
  INVX2TS U536 ( .A(n529), .Y(n533) );
  INVX2TS U537 ( .A(write_data[7]), .Y(n534) );
  INVX2TS U538 ( .A(n534), .Y(n535) );
  INVX2TS U539 ( .A(n534), .Y(n536) );
  INVX2TS U540 ( .A(n534), .Y(n537) );
  INVX2TS U541 ( .A(n534), .Y(n538) );
  AOI21X2TS U542 ( .A0(n715), .A1(write_pointer_gray_sync_r[3]), .B0(n558), 
        .Y(empty_flag) );
  AOI21X2TS U543 ( .A0(n720), .A1(read_pointer_gray_sync_w[0]), .B0(n547), .Y(
        full_flag) );
  OR3X1TS U544 ( .A(n411), .B(read_pointer[1]), .C(n710), .Y(n648) );
  INVX2TS U545 ( .A(n648), .Y(n539) );
  INVX2TS U546 ( .A(n648), .Y(n540) );
  INVX2TS U547 ( .A(n648), .Y(n541) );
  INVX2TS U548 ( .A(n648), .Y(n542) );
  NOR3XLTS U549 ( .A(n372), .B(write_pointer[2]), .C(n692), .Y(n682) );
  NOR3XLTS U550 ( .A(n373), .B(n367), .C(n679), .Y(n669) );
  INVX1TS U551 ( .A(write_reset), .Y(n194) );
  OAI22X1TS U552 ( .A0(read_pointer_gray_sync_w[4]), .A1(write_pointer_gray[4]), .B0(read_pointer_gray_sync_w[3]), .B1(write_pointer_gray[3]), .Y(n543) );
  AOI221XLTS U553 ( .A0(read_pointer_gray_sync_w[4]), .A1(
        write_pointer_gray[4]), .B0(write_pointer_gray[3]), .B1(
        read_pointer_gray_sync_w[3]), .C0(n543), .Y(n546) );
  OAI22X1TS U554 ( .A0(read_pointer_gray_sync_w[2]), .A1(n722), .B0(n712), 
        .B1(read_pointer_gray_sync_w[1]), .Y(n544) );
  AOI221XLTS U555 ( .A0(n722), .A1(read_pointer_gray_sync_w[2]), .B0(n712), 
        .B1(read_pointer_gray_sync_w[1]), .C0(n544), .Y(n545) );
  OAI211XLTS U556 ( .A0(n720), .A1(read_pointer_gray_sync_w[0]), .B0(n546), 
        .C0(n545), .Y(n547) );
  NAND2X1TS U557 ( .A(n372), .B(write_pointer[2]), .Y(n696) );
  NOR3XLTS U558 ( .A(n370), .B(n721), .C(n696), .Y(n698) );
  NAND2BXLTS U559 ( .AN(full_flag), .B(write_enable), .Y(n702) );
  OAI32X1TS U560 ( .A0(n698), .A1(n449), .A2(write_pointer[4]), .B0(
        write_pointer_gray[4]), .B1(n462), .Y(n548) );
  INVX2TS U561 ( .A(n548), .Y(n203) );
  NOR2XLTS U562 ( .A(n370), .B(n369), .Y(n550) );
  INVX2TS U563 ( .A(n698), .Y(n549) );
  NAND2X1TS U564 ( .A(n373), .B(n719), .Y(n685) );
  NAND2X1TS U565 ( .A(n367), .B(n718), .Y(n689) );
  OAI221XLTS U566 ( .A0(n352), .A1(n719), .B0(n370), .B1(n685), .C0(n358), .Y(
        n563) );
  NAND2X1TS U567 ( .A(n563), .B(n461), .Y(n663) );
  INVX2TS U568 ( .A(n663), .Y(n551) );
  AOI22X1TS U569 ( .A0(write_pointer_gray[2]), .A1(n448), .B0(n551), .B1(n354), 
        .Y(n552) );
  OAI31X1TS U570 ( .A0(n447), .A1(n353), .A2(n563), .B0(n552), .Y(n201) );
  OAI22X1TS U571 ( .A0(write_pointer_gray_sync_r[2]), .A1(n709), .B0(n713), 
        .B1(write_pointer_gray_sync_r[4]), .Y(n553) );
  AOI221XLTS U572 ( .A0(n709), .A1(write_pointer_gray_sync_r[2]), .B0(n713), 
        .B1(write_pointer_gray_sync_r[4]), .C0(n553), .Y(n557) );
  INVX2TS U573 ( .A(write_pointer_gray_sync_r[0]), .Y(n555) );
  OAI22X1TS U574 ( .A0(write_pointer_gray_sync_r[1]), .A1(n714), .B0(n555), 
        .B1(read_pointer_gray[0]), .Y(n554) );
  OAI211XLTS U575 ( .A0(n715), .A1(write_pointer_gray_sync_r[3]), .B0(n557), 
        .C0(n556), .Y(n558) );
  NAND2BXLTS U576 ( .AN(empty_flag), .B(read_enable), .Y(n708) );
  INVX2TS U577 ( .A(n360), .Y(n706) );
  NAND2X1TS U578 ( .A(n410), .B(read_pointer[1]), .Y(n564) );
  NOR2XLTS U579 ( .A(n710), .B(n564), .Y(n704) );
  INVX2TS U580 ( .A(n474), .Y(n659) );
  NAND2X1TS U581 ( .A(n659), .B(n717), .Y(n560) );
  AOI21X1TS U582 ( .A0(read_pointer[4]), .A1(n560), .B0(n360), .Y(n559) );
  OAI21XLTS U583 ( .A0(n351), .A1(n560), .B0(n559), .Y(n561) );
  OAI21XLTS U584 ( .A0(n465), .A1(n715), .B0(n561), .Y(n208) );
  INVX2TS U585 ( .A(read_reset), .Y(n188) );
  AOI22X1TS U586 ( .A0(n372), .A1(n352), .B0(n370), .B1(n718), .Y(n562) );
  NAND2X1TS U587 ( .A(n462), .B(n562), .Y(n664) );
  OAI222X1TS U588 ( .A0(n664), .A1(n563), .B0(n712), .B1(n461), .C0(n663), 
        .C1(n562), .Y(n200) );
  NAND2X1TS U589 ( .A(n411), .B(n716), .Y(n565) );
  OAI21XLTS U590 ( .A0(n410), .A1(n366), .B0(n565), .Y(n657) );
  NAND2X1TS U591 ( .A(n465), .B(n657), .Y(n658) );
  OAI21XLTS U592 ( .A0(n464), .A1(n366), .B0(n658), .Y(n189) );
  NOR2XLTS U593 ( .A(read_pointer[2]), .B(n564), .Y(n647) );
  AO21XLTS U594 ( .A0(n350), .A1(n564), .B0(n364), .Y(n662) );
  NAND2X1TS U595 ( .A(n463), .B(n662), .Y(n661) );
  OAI21XLTS U596 ( .A0(n465), .A1(n349), .B0(n661), .Y(n190) );
  AOI22X1TS U597 ( .A0(memory[64]), .A1(n495), .B0(memory[80]), .B1(n487), .Y(
        n569) );
  AOI22X1TS U598 ( .A0(memory[72]), .A1(n466), .B0(memory[88]), .B1(n647), .Y(
        n568) );
  AOI22X1TS U599 ( .A0(memory[96]), .A1(n539), .B0(memory[112]), .B1(n491), 
        .Y(n567) );
  AOI22X1TS U600 ( .A0(memory[104]), .A1(n483), .B0(memory[120]), .B1(n362), 
        .Y(n566) );
  AND4X1TS U601 ( .A(n569), .B(n568), .C(n567), .D(n566), .Y(n576) );
  NAND2X1TS U602 ( .A(n188), .B(n359), .Y(n653) );
  AOI22X1TS U603 ( .A0(memory[0]), .A1(n495), .B0(memory[16]), .B1(n487), .Y(
        n573) );
  AOI22X1TS U604 ( .A0(memory[8]), .A1(n466), .B0(memory[24]), .B1(n365), .Y(
        n572) );
  AOI22X1TS U605 ( .A0(memory[32]), .A1(n539), .B0(memory[48]), .B1(n491), .Y(
        n571) );
  AOI22X1TS U606 ( .A0(memory[40]), .A1(n483), .B0(memory[56]), .B1(n362), .Y(
        n570) );
  NAND4XLTS U607 ( .A(n573), .B(n572), .C(n571), .D(n570), .Y(n574) );
  AOI22X1TS U608 ( .A0(n376), .A1(n574), .B0(read_data[0]), .B1(n452), .Y(n575) );
  OAI21XLTS U609 ( .A0(n576), .A1(n374), .B0(n575), .Y(n187) );
  AOI22X1TS U610 ( .A0(memory[65]), .A1(n496), .B0(memory[81]), .B1(n488), .Y(
        n580) );
  AOI22X1TS U611 ( .A0(memory[73]), .A1(n467), .B0(memory[89]), .B1(n481), .Y(
        n579) );
  AOI22X1TS U612 ( .A0(memory[97]), .A1(n540), .B0(memory[113]), .B1(n492), 
        .Y(n578) );
  AOI22X1TS U613 ( .A0(memory[105]), .A1(n484), .B0(memory[121]), .B1(n472), 
        .Y(n577) );
  AND4X1TS U614 ( .A(n580), .B(n579), .C(n578), .D(n577), .Y(n587) );
  AOI22X1TS U615 ( .A0(memory[1]), .A1(n496), .B0(memory[17]), .B1(n488), .Y(
        n584) );
  AOI22X1TS U616 ( .A0(memory[9]), .A1(n467), .B0(memory[25]), .B1(n481), .Y(
        n583) );
  AOI22X1TS U617 ( .A0(memory[33]), .A1(n540), .B0(memory[49]), .B1(n492), .Y(
        n582) );
  AOI22X1TS U618 ( .A0(memory[41]), .A1(n484), .B0(memory[57]), .B1(n473), .Y(
        n581) );
  NAND4XLTS U619 ( .A(n584), .B(n583), .C(n582), .D(n581), .Y(n585) );
  AOI22X1TS U620 ( .A0(n377), .A1(n585), .B0(read_data[1]), .B1(n451), .Y(n586) );
  OAI21XLTS U621 ( .A0(n587), .A1(n375), .B0(n586), .Y(n186) );
  AOI22X1TS U622 ( .A0(memory[68]), .A1(n497), .B0(memory[84]), .B1(n489), .Y(
        n591) );
  AOI22X1TS U623 ( .A0(memory[76]), .A1(n468), .B0(memory[92]), .B1(n482), .Y(
        n590) );
  AOI22X1TS U624 ( .A0(memory[100]), .A1(n541), .B0(memory[116]), .B1(n493), 
        .Y(n589) );
  AOI22X1TS U625 ( .A0(memory[108]), .A1(n485), .B0(memory[124]), .B1(n474), 
        .Y(n588) );
  AND4X1TS U626 ( .A(n591), .B(n590), .C(n589), .D(n588), .Y(n598) );
  AOI22X1TS U627 ( .A0(memory[4]), .A1(n497), .B0(memory[20]), .B1(n489), .Y(
        n595) );
  AOI22X1TS U628 ( .A0(memory[12]), .A1(n468), .B0(memory[28]), .B1(n482), .Y(
        n594) );
  AOI22X1TS U629 ( .A0(memory[36]), .A1(n541), .B0(memory[52]), .B1(n493), .Y(
        n593) );
  AOI22X1TS U630 ( .A0(memory[44]), .A1(n485), .B0(memory[60]), .B1(n472), .Y(
        n592) );
  NAND4XLTS U631 ( .A(n595), .B(n594), .C(n593), .D(n592), .Y(n596) );
  AOI22X1TS U632 ( .A0(n376), .A1(n596), .B0(read_data[4]), .B1(n451), .Y(n597) );
  OAI21XLTS U633 ( .A0(n598), .A1(n374), .B0(n597), .Y(n183) );
  AOI22X1TS U634 ( .A0(memory[69]), .A1(n498), .B0(memory[85]), .B1(n490), .Y(
        n602) );
  AOI22X1TS U635 ( .A0(memory[77]), .A1(n469), .B0(memory[93]), .B1(n365), .Y(
        n601) );
  AOI22X1TS U636 ( .A0(memory[101]), .A1(n542), .B0(memory[117]), .B1(n494), 
        .Y(n600) );
  AOI22X1TS U637 ( .A0(memory[109]), .A1(n486), .B0(memory[125]), .B1(n471), 
        .Y(n599) );
  AND4X1TS U638 ( .A(n602), .B(n601), .C(n600), .D(n599), .Y(n609) );
  AOI22X1TS U639 ( .A0(memory[5]), .A1(n498), .B0(memory[21]), .B1(n490), .Y(
        n606) );
  AOI22X1TS U640 ( .A0(memory[13]), .A1(n469), .B0(memory[29]), .B1(n364), .Y(
        n605) );
  AOI22X1TS U641 ( .A0(memory[37]), .A1(n542), .B0(memory[53]), .B1(n494), .Y(
        n604) );
  AOI22X1TS U642 ( .A0(memory[45]), .A1(n486), .B0(memory[61]), .B1(n474), .Y(
        n603) );
  NAND4XLTS U643 ( .A(n606), .B(n605), .C(n604), .D(n603), .Y(n607) );
  AOI22X1TS U644 ( .A0(n377), .A1(n607), .B0(read_data[5]), .B1(n452), .Y(n608) );
  OAI21XLTS U645 ( .A0(n609), .A1(n375), .B0(n608), .Y(n182) );
  AOI22X1TS U646 ( .A0(memory[70]), .A1(n495), .B0(memory[86]), .B1(n487), .Y(
        n613) );
  AOI22X1TS U647 ( .A0(memory[78]), .A1(n466), .B0(memory[94]), .B1(n364), .Y(
        n612) );
  AOI22X1TS U648 ( .A0(memory[102]), .A1(n539), .B0(memory[118]), .B1(n491), 
        .Y(n611) );
  AOI22X1TS U649 ( .A0(memory[110]), .A1(n483), .B0(memory[126]), .B1(n362), 
        .Y(n610) );
  AND4X1TS U650 ( .A(n613), .B(n612), .C(n611), .D(n610), .Y(n620) );
  AOI22X1TS U651 ( .A0(memory[6]), .A1(n495), .B0(memory[22]), .B1(n487), .Y(
        n617) );
  AOI22X1TS U652 ( .A0(memory[14]), .A1(n466), .B0(memory[30]), .B1(n365), .Y(
        n616) );
  AOI22X1TS U653 ( .A0(memory[38]), .A1(n539), .B0(memory[54]), .B1(n491), .Y(
        n615) );
  AOI22X1TS U654 ( .A0(memory[46]), .A1(n483), .B0(memory[62]), .B1(n362), .Y(
        n614) );
  NAND4XLTS U655 ( .A(n617), .B(n616), .C(n615), .D(n614), .Y(n618) );
  AOI22X1TS U656 ( .A0(n376), .A1(n618), .B0(read_data[6]), .B1(n653), .Y(n619) );
  OAI21XLTS U657 ( .A0(n620), .A1(n374), .B0(n619), .Y(n181) );
  AOI22X1TS U658 ( .A0(memory[71]), .A1(n496), .B0(memory[87]), .B1(n488), .Y(
        n624) );
  AOI22X1TS U659 ( .A0(memory[79]), .A1(n467), .B0(memory[95]), .B1(n481), .Y(
        n623) );
  AOI22X1TS U660 ( .A0(memory[103]), .A1(n540), .B0(memory[119]), .B1(n492), 
        .Y(n622) );
  AOI22X1TS U661 ( .A0(memory[111]), .A1(n484), .B0(memory[127]), .B1(n471), 
        .Y(n621) );
  AND4X1TS U662 ( .A(n624), .B(n623), .C(n622), .D(n621), .Y(n631) );
  AOI22X1TS U663 ( .A0(memory[7]), .A1(n496), .B0(memory[23]), .B1(n488), .Y(
        n628) );
  AOI22X1TS U664 ( .A0(memory[15]), .A1(n467), .B0(memory[31]), .B1(n481), .Y(
        n627) );
  AOI22X1TS U665 ( .A0(memory[39]), .A1(n540), .B0(memory[55]), .B1(n492), .Y(
        n626) );
  AOI22X1TS U666 ( .A0(memory[47]), .A1(n484), .B0(memory[63]), .B1(n472), .Y(
        n625) );
  NAND4XLTS U667 ( .A(n628), .B(n627), .C(n626), .D(n625), .Y(n629) );
  AOI22X1TS U668 ( .A0(n377), .A1(n629), .B0(read_data[7]), .B1(n451), .Y(n630) );
  OAI21XLTS U669 ( .A0(n631), .A1(n375), .B0(n630), .Y(n180) );
  AOI22X1TS U670 ( .A0(memory[66]), .A1(n497), .B0(memory[82]), .B1(n489), .Y(
        n635) );
  AOI22X1TS U671 ( .A0(memory[74]), .A1(n468), .B0(memory[90]), .B1(n482), .Y(
        n634) );
  AOI22X1TS U672 ( .A0(memory[98]), .A1(n541), .B0(memory[114]), .B1(n493), 
        .Y(n633) );
  AOI22X1TS U673 ( .A0(memory[106]), .A1(n485), .B0(memory[122]), .B1(n473), 
        .Y(n632) );
  AND4X1TS U674 ( .A(n635), .B(n634), .C(n633), .D(n632), .Y(n642) );
  AOI22X1TS U675 ( .A0(memory[2]), .A1(n497), .B0(memory[18]), .B1(n489), .Y(
        n639) );
  AOI22X1TS U676 ( .A0(memory[10]), .A1(n468), .B0(memory[26]), .B1(n482), .Y(
        n638) );
  AOI22X1TS U677 ( .A0(memory[34]), .A1(n541), .B0(memory[50]), .B1(n493), .Y(
        n637) );
  AOI22X1TS U678 ( .A0(memory[42]), .A1(n485), .B0(memory[58]), .B1(n471), .Y(
        n636) );
  NAND4XLTS U679 ( .A(n639), .B(n638), .C(n637), .D(n636), .Y(n640) );
  AOI22X1TS U680 ( .A0(n376), .A1(n640), .B0(read_data[2]), .B1(n452), .Y(n641) );
  OAI21XLTS U681 ( .A0(n642), .A1(n374), .B0(n641), .Y(n185) );
  AOI22X1TS U682 ( .A0(memory[67]), .A1(n498), .B0(memory[83]), .B1(n490), .Y(
        n646) );
  AOI22X1TS U683 ( .A0(memory[75]), .A1(n469), .B0(memory[91]), .B1(n364), .Y(
        n645) );
  AOI22X1TS U684 ( .A0(memory[99]), .A1(n542), .B0(memory[115]), .B1(n494), 
        .Y(n644) );
  AOI22X1TS U685 ( .A0(memory[107]), .A1(n486), .B0(memory[123]), .B1(n472), 
        .Y(n643) );
  AND4X1TS U686 ( .A(n646), .B(n645), .C(n644), .D(n643), .Y(n656) );
  AOI22X1TS U687 ( .A0(memory[3]), .A1(n498), .B0(memory[19]), .B1(n490), .Y(
        n652) );
  AOI22X1TS U688 ( .A0(memory[11]), .A1(n469), .B0(memory[27]), .B1(n365), .Y(
        n651) );
  AOI22X1TS U689 ( .A0(memory[35]), .A1(n542), .B0(memory[51]), .B1(n494), .Y(
        n650) );
  AOI22X1TS U690 ( .A0(memory[43]), .A1(n486), .B0(memory[59]), .B1(n473), .Y(
        n649) );
  NAND4XLTS U691 ( .A(n652), .B(n651), .C(n650), .D(n649), .Y(n654) );
  AOI22X1TS U692 ( .A0(n377), .A1(n654), .B0(read_data[3]), .B1(n452), .Y(n655) );
  OAI21XLTS U693 ( .A0(n656), .A1(n375), .B0(n655), .Y(n184) );
  OAI222X1TS U694 ( .A0(n658), .A1(n662), .B0(n714), .B1(n464), .C0(n661), 
        .C1(n657), .Y(n206) );
  AOI22X1TS U695 ( .A0(read_pointer[3]), .A1(n471), .B0(n659), .B1(n717), .Y(
        n660) );
  NAND2X1TS U696 ( .A(n464), .B(n660), .Y(n665) );
  OAI222X1TS U697 ( .A0(n662), .A1(n665), .B0(n661), .B1(n660), .C0(n709), 
        .C1(n463), .Y(n207) );
  OAI21XLTS U698 ( .A0(n462), .A1(n719), .B0(n663), .Y(n196) );
  OAI21XLTS U699 ( .A0(n461), .A1(n718), .B0(n664), .Y(n195) );
  OAI21XLTS U700 ( .A0(n706), .A1(n717), .B0(n665), .Y(n191) );
  NOR3XLTS U701 ( .A(write_pointer[3]), .B(write_reset), .C(n448), .Y(n667) );
  NAND2X1TS U702 ( .A(n667), .B(n711), .Y(n676) );
  NOR3XLTS U703 ( .A(n372), .B(n367), .C(n676), .Y(n666) );
  AO22XLTS U704 ( .A0(n476), .A1(n505), .B0(n378), .B1(memory[1]), .Y(n337) );
  AO22XLTS U705 ( .A0(n477), .A1(n510), .B0(n379), .B1(memory[2]), .Y(n336) );
  AO22XLTS U706 ( .A0(n476), .A1(n515), .B0(n378), .B1(memory[3]), .Y(n335) );
  AO22XLTS U707 ( .A0(n476), .A1(n520), .B0(n379), .B1(memory[4]), .Y(n334) );
  AO22XLTS U708 ( .A0(n477), .A1(n525), .B0(n378), .B1(memory[5]), .Y(n333) );
  AO22XLTS U709 ( .A0(n666), .A1(n530), .B0(n379), .B1(memory[6]), .Y(n332) );
  AO22XLTS U710 ( .A0(n476), .A1(n535), .B0(n378), .B1(memory[7]), .Y(n331) );
  AO22XLTS U711 ( .A0(n477), .A1(n500), .B0(n379), .B1(memory[0]), .Y(n330) );
  NAND2X1TS U712 ( .A(n352), .B(n667), .Y(n679) );
  INVX2TS U713 ( .A(n669), .Y(n668) );
  AO22XLTS U714 ( .A0(n380), .A1(n501), .B0(n381), .B1(memory[8]), .Y(n329) );
  AO22XLTS U715 ( .A0(n413), .A1(n506), .B0(n382), .B1(memory[9]), .Y(n328) );
  AO22XLTS U716 ( .A0(n413), .A1(n511), .B0(n381), .B1(memory[10]), .Y(n327)
         );
  AO22XLTS U717 ( .A0(n669), .A1(n516), .B0(n382), .B1(memory[11]), .Y(n326)
         );
  AO22XLTS U718 ( .A0(n413), .A1(n521), .B0(n381), .B1(memory[12]), .Y(n325)
         );
  AO22XLTS U719 ( .A0(n380), .A1(n526), .B0(n382), .B1(memory[13]), .Y(n324)
         );
  AO22XLTS U720 ( .A0(n669), .A1(n531), .B0(n381), .B1(memory[14]), .Y(n323)
         );
  AO22XLTS U721 ( .A0(n413), .A1(n536), .B0(n382), .B1(memory[15]), .Y(n322)
         );
  NOR2XLTS U722 ( .A(n676), .B(n356), .Y(n671) );
  INVX2TS U723 ( .A(n415), .Y(n670) );
  AO22XLTS U724 ( .A0(n416), .A1(n502), .B0(n670), .B1(memory[16]), .Y(n321)
         );
  AO22XLTS U725 ( .A0(n416), .A1(n507), .B0(n383), .B1(memory[17]), .Y(n320)
         );
  AO22XLTS U726 ( .A0(n415), .A1(n512), .B0(n670), .B1(memory[18]), .Y(n319)
         );
  AO22XLTS U727 ( .A0(n416), .A1(n517), .B0(n383), .B1(memory[19]), .Y(n318)
         );
  AO22XLTS U728 ( .A0(n671), .A1(n522), .B0(n414), .B1(memory[20]), .Y(n317)
         );
  AO22XLTS U729 ( .A0(n415), .A1(n527), .B0(n383), .B1(memory[21]), .Y(n316)
         );
  AO22XLTS U730 ( .A0(n416), .A1(n532), .B0(n670), .B1(memory[22]), .Y(n315)
         );
  AO22XLTS U731 ( .A0(n671), .A1(n537), .B0(n383), .B1(memory[23]), .Y(n314)
         );
  NOR2XLTS U732 ( .A(n679), .B(n356), .Y(n673) );
  INVX2TS U733 ( .A(n418), .Y(n672) );
  AO22XLTS U734 ( .A0(n419), .A1(n528), .B0(n672), .B1(memory[29]), .Y(n313)
         );
  AO22XLTS U735 ( .A0(n419), .A1(n533), .B0(n384), .B1(memory[30]), .Y(n312)
         );
  AO22XLTS U736 ( .A0(n418), .A1(n538), .B0(n672), .B1(memory[31]), .Y(n311)
         );
  AO22XLTS U737 ( .A0(n419), .A1(n503), .B0(n384), .B1(memory[24]), .Y(n310)
         );
  AO22XLTS U738 ( .A0(n673), .A1(n508), .B0(n417), .B1(memory[25]), .Y(n309)
         );
  AO22XLTS U739 ( .A0(n418), .A1(n513), .B0(n384), .B1(memory[26]), .Y(n308)
         );
  AO22XLTS U740 ( .A0(n419), .A1(n518), .B0(n672), .B1(memory[27]), .Y(n307)
         );
  AO22XLTS U741 ( .A0(n673), .A1(n523), .B0(n384), .B1(memory[28]), .Y(n306)
         );
  NOR2XLTS U742 ( .A(n676), .B(n689), .Y(n674) );
  AO22XLTS U743 ( .A0(n421), .A1(n500), .B0(n385), .B1(memory[32]), .Y(n305)
         );
  AO22XLTS U744 ( .A0(n422), .A1(n505), .B0(n386), .B1(memory[33]), .Y(n304)
         );
  AO22XLTS U745 ( .A0(n421), .A1(n510), .B0(n385), .B1(memory[34]), .Y(n303)
         );
  AO22XLTS U746 ( .A0(n421), .A1(n515), .B0(n386), .B1(memory[35]), .Y(n302)
         );
  AO22XLTS U747 ( .A0(n422), .A1(n520), .B0(n385), .B1(memory[36]), .Y(n301)
         );
  AO22XLTS U748 ( .A0(n674), .A1(n525), .B0(n386), .B1(memory[37]), .Y(n300)
         );
  AO22XLTS U749 ( .A0(n421), .A1(n530), .B0(n385), .B1(memory[38]), .Y(n299)
         );
  AO22XLTS U750 ( .A0(n422), .A1(n535), .B0(n386), .B1(memory[39]), .Y(n298)
         );
  NOR2XLTS U751 ( .A(n679), .B(n358), .Y(n675) );
  AO22XLTS U752 ( .A0(n424), .A1(n501), .B0(n387), .B1(memory[40]), .Y(n297)
         );
  AO22XLTS U753 ( .A0(n425), .A1(n506), .B0(n388), .B1(memory[41]), .Y(n296)
         );
  AO22XLTS U754 ( .A0(n424), .A1(n511), .B0(n387), .B1(memory[42]), .Y(n295)
         );
  AO22XLTS U755 ( .A0(n424), .A1(n516), .B0(n388), .B1(memory[43]), .Y(n294)
         );
  AO22XLTS U756 ( .A0(n425), .A1(n521), .B0(n387), .B1(memory[44]), .Y(n293)
         );
  AO22XLTS U757 ( .A0(n675), .A1(n526), .B0(n388), .B1(memory[45]), .Y(n292)
         );
  AO22XLTS U758 ( .A0(n424), .A1(n531), .B0(n387), .B1(memory[46]), .Y(n291)
         );
  AO22XLTS U759 ( .A0(n425), .A1(n536), .B0(n388), .B1(memory[47]), .Y(n290)
         );
  NOR2XLTS U760 ( .A(n676), .B(n369), .Y(n678) );
  INVX2TS U761 ( .A(n427), .Y(n677) );
  AO22XLTS U762 ( .A0(n428), .A1(n502), .B0(n677), .B1(memory[48]), .Y(n289)
         );
  AO22XLTS U763 ( .A0(n428), .A1(n507), .B0(n389), .B1(memory[49]), .Y(n288)
         );
  AO22XLTS U764 ( .A0(n427), .A1(n512), .B0(n677), .B1(memory[50]), .Y(n287)
         );
  AO22XLTS U765 ( .A0(n428), .A1(n517), .B0(n389), .B1(memory[51]), .Y(n286)
         );
  AO22XLTS U766 ( .A0(n678), .A1(n522), .B0(n426), .B1(memory[52]), .Y(n285)
         );
  AO22XLTS U767 ( .A0(n427), .A1(n527), .B0(n389), .B1(memory[53]), .Y(n284)
         );
  AO22XLTS U768 ( .A0(n428), .A1(n532), .B0(n677), .B1(memory[54]), .Y(n283)
         );
  AO22XLTS U769 ( .A0(n678), .A1(n537), .B0(n389), .B1(memory[55]), .Y(n282)
         );
  NOR2XLTS U770 ( .A(n679), .B(n369), .Y(n680) );
  AO22XLTS U771 ( .A0(n430), .A1(n503), .B0(n390), .B1(memory[56]), .Y(n281)
         );
  AO22XLTS U772 ( .A0(n431), .A1(n508), .B0(n391), .B1(memory[57]), .Y(n280)
         );
  AO22XLTS U773 ( .A0(n430), .A1(n513), .B0(n390), .B1(memory[58]), .Y(n279)
         );
  AO22XLTS U774 ( .A0(n430), .A1(n518), .B0(n391), .B1(memory[59]), .Y(n278)
         );
  AO22XLTS U775 ( .A0(n431), .A1(n523), .B0(n390), .B1(memory[60]), .Y(n277)
         );
  AO22XLTS U776 ( .A0(n680), .A1(n528), .B0(n391), .B1(memory[61]), .Y(n276)
         );
  AO22XLTS U777 ( .A0(n430), .A1(n533), .B0(n390), .B1(memory[62]), .Y(n275)
         );
  AO22XLTS U778 ( .A0(n431), .A1(n538), .B0(n391), .B1(memory[63]), .Y(n274)
         );
  NAND4XLTS U779 ( .A(write_pointer[3]), .B(n460), .C(n711), .D(n458), .Y(n692) );
  INVX2TS U780 ( .A(n682), .Y(n681) );
  AO22XLTS U781 ( .A0(n392), .A1(n500), .B0(n393), .B1(memory[64]), .Y(n273)
         );
  AO22XLTS U782 ( .A0(n412), .A1(n505), .B0(n394), .B1(memory[65]), .Y(n272)
         );
  AO22XLTS U783 ( .A0(n412), .A1(n510), .B0(n393), .B1(memory[66]), .Y(n271)
         );
  AO22XLTS U784 ( .A0(n682), .A1(n515), .B0(n394), .B1(memory[67]), .Y(n270)
         );
  AO22XLTS U785 ( .A0(n412), .A1(n520), .B0(n393), .B1(memory[68]), .Y(n269)
         );
  AO22XLTS U786 ( .A0(n392), .A1(n525), .B0(n394), .B1(memory[69]), .Y(n268)
         );
  AO22XLTS U787 ( .A0(n682), .A1(n530), .B0(n393), .B1(memory[70]), .Y(n267)
         );
  AO22XLTS U788 ( .A0(n412), .A1(n535), .B0(n394), .B1(memory[71]), .Y(n266)
         );
  NAND4XLTS U789 ( .A(write_pointer[3]), .B(write_pointer[0]), .C(n460), .D(
        n457), .Y(n695) );
  NOR3XLTS U790 ( .A(n373), .B(n367), .C(n695), .Y(n683) );
  AO22XLTS U791 ( .A0(n479), .A1(n501), .B0(n395), .B1(memory[72]), .Y(n265)
         );
  AO22XLTS U792 ( .A0(n480), .A1(n506), .B0(n396), .B1(memory[73]), .Y(n264)
         );
  AO22XLTS U793 ( .A0(n479), .A1(n511), .B0(n395), .B1(memory[74]), .Y(n263)
         );
  AO22XLTS U794 ( .A0(n479), .A1(n516), .B0(n396), .B1(memory[75]), .Y(n262)
         );
  AO22XLTS U795 ( .A0(n480), .A1(n521), .B0(n395), .B1(memory[76]), .Y(n261)
         );
  AO22XLTS U796 ( .A0(n683), .A1(n526), .B0(n396), .B1(memory[77]), .Y(n260)
         );
  AO22XLTS U797 ( .A0(n479), .A1(n531), .B0(n395), .B1(memory[78]), .Y(n259)
         );
  AO22XLTS U798 ( .A0(n480), .A1(n536), .B0(n396), .B1(memory[79]), .Y(n258)
         );
  NOR2XLTS U799 ( .A(n356), .B(n692), .Y(n684) );
  AO22XLTS U800 ( .A0(n433), .A1(n502), .B0(n397), .B1(memory[80]), .Y(n257)
         );
  AO22XLTS U801 ( .A0(n434), .A1(n507), .B0(n398), .B1(memory[81]), .Y(n256)
         );
  AO22XLTS U802 ( .A0(n433), .A1(n512), .B0(n397), .B1(memory[82]), .Y(n255)
         );
  AO22XLTS U803 ( .A0(n433), .A1(n517), .B0(n398), .B1(memory[83]), .Y(n254)
         );
  AO22XLTS U804 ( .A0(n434), .A1(n522), .B0(n397), .B1(memory[84]), .Y(n253)
         );
  AO22XLTS U805 ( .A0(n684), .A1(n527), .B0(n398), .B1(memory[85]), .Y(n252)
         );
  AO22XLTS U806 ( .A0(n433), .A1(n532), .B0(n397), .B1(memory[86]), .Y(n251)
         );
  AO22XLTS U807 ( .A0(n434), .A1(n537), .B0(n398), .B1(memory[87]), .Y(n250)
         );
  NOR2XLTS U808 ( .A(n356), .B(n695), .Y(n686) );
  AO22XLTS U809 ( .A0(n436), .A1(n503), .B0(n399), .B1(memory[88]), .Y(n249)
         );
  AO22XLTS U810 ( .A0(n437), .A1(n508), .B0(n400), .B1(memory[89]), .Y(n248)
         );
  AO22XLTS U811 ( .A0(n436), .A1(n513), .B0(n399), .B1(memory[90]), .Y(n247)
         );
  AO22XLTS U812 ( .A0(n436), .A1(n518), .B0(n400), .B1(memory[91]), .Y(n246)
         );
  AO22XLTS U813 ( .A0(n437), .A1(n523), .B0(n399), .B1(memory[92]), .Y(n245)
         );
  AO22XLTS U814 ( .A0(n686), .A1(n528), .B0(n400), .B1(memory[93]), .Y(n244)
         );
  AO22XLTS U815 ( .A0(n436), .A1(n533), .B0(n399), .B1(memory[94]), .Y(n243)
         );
  AO22XLTS U816 ( .A0(n437), .A1(n538), .B0(n400), .B1(memory[95]), .Y(n242)
         );
  NOR2XLTS U817 ( .A(n358), .B(n692), .Y(n688) );
  INVX2TS U818 ( .A(n439), .Y(n687) );
  AO22XLTS U819 ( .A0(n440), .A1(n500), .B0(n687), .B1(memory[96]), .Y(n241)
         );
  AO22XLTS U820 ( .A0(n440), .A1(n505), .B0(n401), .B1(memory[97]), .Y(n240)
         );
  AO22XLTS U821 ( .A0(n439), .A1(n510), .B0(n687), .B1(memory[98]), .Y(n239)
         );
  AO22XLTS U822 ( .A0(n440), .A1(n515), .B0(n401), .B1(memory[99]), .Y(n238)
         );
  AO22XLTS U823 ( .A0(n688), .A1(n520), .B0(n438), .B1(memory[100]), .Y(n237)
         );
  AO22XLTS U824 ( .A0(n439), .A1(n525), .B0(n401), .B1(memory[101]), .Y(n236)
         );
  AO22XLTS U825 ( .A0(n440), .A1(n530), .B0(n687), .B1(memory[102]), .Y(n235)
         );
  AO22XLTS U826 ( .A0(n688), .A1(n535), .B0(n401), .B1(memory[103]), .Y(n234)
         );
  NOR2XLTS U827 ( .A(n358), .B(n695), .Y(n691) );
  INVX2TS U828 ( .A(n691), .Y(n690) );
  AO22XLTS U829 ( .A0(n402), .A1(n501), .B0(n403), .B1(memory[104]), .Y(n233)
         );
  AO22XLTS U830 ( .A0(n441), .A1(n506), .B0(n404), .B1(memory[105]), .Y(n232)
         );
  AO22XLTS U831 ( .A0(n441), .A1(n511), .B0(n403), .B1(memory[106]), .Y(n231)
         );
  AO22XLTS U832 ( .A0(n691), .A1(n516), .B0(n404), .B1(memory[107]), .Y(n230)
         );
  AO22XLTS U833 ( .A0(n441), .A1(n521), .B0(n403), .B1(memory[108]), .Y(n229)
         );
  AO22XLTS U834 ( .A0(n402), .A1(n526), .B0(n404), .B1(memory[109]), .Y(n228)
         );
  AO22XLTS U835 ( .A0(n691), .A1(n531), .B0(n403), .B1(memory[110]), .Y(n227)
         );
  AO22XLTS U836 ( .A0(n441), .A1(n536), .B0(n404), .B1(memory[111]), .Y(n226)
         );
  NOR2XLTS U837 ( .A(n696), .B(n692), .Y(n694) );
  INVX2TS U838 ( .A(n694), .Y(n693) );
  AO22XLTS U839 ( .A0(n405), .A1(n502), .B0(n406), .B1(memory[112]), .Y(n225)
         );
  AO22XLTS U840 ( .A0(n442), .A1(n507), .B0(n407), .B1(memory[113]), .Y(n224)
         );
  AO22XLTS U841 ( .A0(n442), .A1(n512), .B0(n406), .B1(memory[114]), .Y(n223)
         );
  AO22XLTS U842 ( .A0(n694), .A1(n517), .B0(n407), .B1(memory[115]), .Y(n222)
         );
  AO22XLTS U843 ( .A0(n442), .A1(n522), .B0(n406), .B1(memory[116]), .Y(n221)
         );
  AO22XLTS U844 ( .A0(n405), .A1(n527), .B0(n407), .B1(memory[117]), .Y(n220)
         );
  AO22XLTS U845 ( .A0(n694), .A1(n532), .B0(n406), .B1(memory[118]), .Y(n219)
         );
  AO22XLTS U846 ( .A0(n442), .A1(n537), .B0(n407), .B1(memory[119]), .Y(n218)
         );
  NOR2XLTS U847 ( .A(n369), .B(n695), .Y(n697) );
  AO22XLTS U848 ( .A0(n444), .A1(n503), .B0(n408), .B1(memory[120]), .Y(n217)
         );
  AO22XLTS U849 ( .A0(n445), .A1(n508), .B0(n409), .B1(memory[121]), .Y(n216)
         );
  AO22XLTS U850 ( .A0(n444), .A1(n513), .B0(n408), .B1(memory[122]), .Y(n215)
         );
  AO22XLTS U851 ( .A0(n444), .A1(n518), .B0(n409), .B1(memory[123]), .Y(n214)
         );
  AO22XLTS U852 ( .A0(n445), .A1(n523), .B0(n408), .B1(memory[124]), .Y(n213)
         );
  AO22XLTS U853 ( .A0(n697), .A1(n528), .B0(n409), .B1(memory[125]), .Y(n212)
         );
  AO22XLTS U854 ( .A0(n444), .A1(n533), .B0(n408), .B1(memory[126]), .Y(n211)
         );
  AO22XLTS U855 ( .A0(n445), .A1(n538), .B0(n409), .B1(memory[127]), .Y(n210)
         );
  AOI21X1TS U856 ( .A0(n474), .A1(read_pointer[3]), .B0(n351), .Y(n703) );
  AOI22X1TS U857 ( .A0(n706), .A1(n703), .B0(n713), .B1(n360), .Y(n209) );
  AO22XLTS U858 ( .A0(n465), .A1(n716), .B0(n361), .B1(read_pointer_gray[0]), 
        .Y(n205) );
  AOI22X1TS U859 ( .A0(n461), .A1(n373), .B0(n720), .B1(n447), .Y(n204) );
  XNOR2X1TS U860 ( .A(n698), .B(write_pointer[4]), .Y(n701) );
  AOI21X1TS U861 ( .A0(n353), .A1(n701), .B0(n447), .Y(n699) );
  OAI21XLTS U862 ( .A0(n354), .A1(n701), .B0(n699), .Y(n700) );
  OAI2BB1X1TS U863 ( .A0N(n449), .A1N(write_pointer_gray[3]), .B0(n700), .Y(
        n202) );
  AOI22X1TS U864 ( .A0(write_pointer[0]), .A1(n460), .B0(n449), .B1(n711), .Y(
        n199) );
  AOI2BB2XLTS U865 ( .B0(n446), .B1(n701), .A0N(write_pointer[4]), .A1N(n460), 
        .Y(n198) );
  AOI22X1TS U866 ( .A0(n462), .A1(n353), .B0(n721), .B1(n448), .Y(n197) );
  AOI2BB2XLTS U867 ( .B0(n464), .B1(read_pointer[0]), .A0N(n411), .A1N(n463), 
        .Y(n193) );
  AOI31XLTS U868 ( .A0(n704), .A1(read_pointer[3]), .A2(n351), .B0(n703), .Y(
        n705) );
  NAND2X1TS U869 ( .A(n463), .B(n705), .Y(n707) );
  OAI2BB1X1TS U870 ( .A0N(n361), .A1N(read_pointer[4]), .B0(n707), .Y(n192) );
endmodule

