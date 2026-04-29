
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point en en -type PI PI
add mapped point clear_count clear_count -type PI PI
add mapped point seed_load seed_load -type PI PI
add mapped point mode_select mode_select -type PI PI
add mapped point seed_in[14] seed_in[14] -type PI PI
add mapped point seed_in[13] seed_in[13] -type PI PI
add mapped point seed_in[12] seed_in[12] -type PI PI
add mapped point seed_in[11] seed_in[11] -type PI PI
add mapped point seed_in[10] seed_in[10] -type PI PI
add mapped point seed_in[9] seed_in[9] -type PI PI
add mapped point seed_in[8] seed_in[8] -type PI PI
add mapped point seed_in[7] seed_in[7] -type PI PI
add mapped point seed_in[6] seed_in[6] -type PI PI
add mapped point seed_in[5] seed_in[5] -type PI PI
add mapped point seed_in[4] seed_in[4] -type PI PI
add mapped point seed_in[3] seed_in[3] -type PI PI
add mapped point seed_in[2] seed_in[2] -type PI PI
add mapped point seed_in[1] seed_in[1] -type PI PI
add mapped point seed_in[0] seed_in[0] -type PI PI
add mapped point serial_in serial_in -type PI PI

//output ports
add mapped point ref_bit ref_bit -type PO PO
add mapped point bit_error bit_error -type PO PO
add mapped point error_count[31] error_count[31] -type PO PO
add mapped point error_count[30] error_count[30] -type PO PO
add mapped point error_count[29] error_count[29] -type PO PO
add mapped point error_count[28] error_count[28] -type PO PO
add mapped point error_count[27] error_count[27] -type PO PO
add mapped point error_count[26] error_count[26] -type PO PO
add mapped point error_count[25] error_count[25] -type PO PO
add mapped point error_count[24] error_count[24] -type PO PO
add mapped point error_count[23] error_count[23] -type PO PO
add mapped point error_count[22] error_count[22] -type PO PO
add mapped point error_count[21] error_count[21] -type PO PO
add mapped point error_count[20] error_count[20] -type PO PO
add mapped point error_count[19] error_count[19] -type PO PO
add mapped point error_count[18] error_count[18] -type PO PO
add mapped point error_count[17] error_count[17] -type PO PO
add mapped point error_count[16] error_count[16] -type PO PO
add mapped point error_count[15] error_count[15] -type PO PO
add mapped point error_count[14] error_count[14] -type PO PO
add mapped point error_count[13] error_count[13] -type PO PO
add mapped point error_count[12] error_count[12] -type PO PO
add mapped point error_count[11] error_count[11] -type PO PO
add mapped point error_count[10] error_count[10] -type PO PO
add mapped point error_count[9] error_count[9] -type PO PO
add mapped point error_count[8] error_count[8] -type PO PO
add mapped point error_count[7] error_count[7] -type PO PO
add mapped point error_count[6] error_count[6] -type PO PO
add mapped point error_count[5] error_count[5] -type PO PO
add mapped point error_count[4] error_count[4] -type PO PO
add mapped point error_count[3] error_count[3] -type PO PO
add mapped point error_count[2] error_count[2] -type PO PO
add mapped point error_count[1] error_count[1] -type PO PO
add mapped point error_count[0] error_count[0] -type PO PO
add mapped point total_count[31] total_count[31] -type PO PO
add mapped point total_count[30] total_count[30] -type PO PO
add mapped point total_count[29] total_count[29] -type PO PO
add mapped point total_count[28] total_count[28] -type PO PO
add mapped point total_count[27] total_count[27] -type PO PO
add mapped point total_count[26] total_count[26] -type PO PO
add mapped point total_count[25] total_count[25] -type PO PO
add mapped point total_count[24] total_count[24] -type PO PO
add mapped point total_count[23] total_count[23] -type PO PO
add mapped point total_count[22] total_count[22] -type PO PO
add mapped point total_count[21] total_count[21] -type PO PO
add mapped point total_count[20] total_count[20] -type PO PO
add mapped point total_count[19] total_count[19] -type PO PO
add mapped point total_count[18] total_count[18] -type PO PO
add mapped point total_count[17] total_count[17] -type PO PO
add mapped point total_count[16] total_count[16] -type PO PO
add mapped point total_count[15] total_count[15] -type PO PO
add mapped point total_count[14] total_count[14] -type PO PO
add mapped point total_count[13] total_count[13] -type PO PO
add mapped point total_count[12] total_count[12] -type PO PO
add mapped point total_count[11] total_count[11] -type PO PO
add mapped point total_count[10] total_count[10] -type PO PO
add mapped point total_count[9] total_count[9] -type PO PO
add mapped point total_count[8] total_count[8] -type PO PO
add mapped point total_count[7] total_count[7] -type PO PO
add mapped point total_count[6] total_count[6] -type PO PO
add mapped point total_count[5] total_count[5] -type PO PO
add mapped point total_count[4] total_count[4] -type PO PO
add mapped point total_count[3] total_count[3] -type PO PO
add mapped point total_count[2] total_count[2] -type PO PO
add mapped point total_count[1] total_count[1] -type PO PO
add mapped point total_count[0] total_count[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[4]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[4]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[3]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[3]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[2]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[2]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[1]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[1]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[0]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[0]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[5]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[5]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q[6]/q u_prbs_gen_top/u_prbs7_top/u_prbs_core/lfsr_q_reg[6]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[12]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[12]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[11]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[11]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[10]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[10]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[9]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[9]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[8]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[8]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[7]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[7]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[6]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[6]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[5]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[5]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[4]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[4]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[3]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[3]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[2]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[2]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[1]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[1]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[0]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[0]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[13]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[13]/Q -type DFF DFF
add mapped point u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q[14]/q u_prbs_gen_top/u_prbs15_top/u_prbs15_core/lfsr_q_reg[14]/Q -type DFF DFF
add mapped point error_count[0]/q error_count_reg[0]/Q -type DFF DFF
add mapped point error_count[1]/q error_count_reg[1]/Q -type DFF DFF
add mapped point error_count[2]/q error_count_reg[2]/Q -type DFF DFF
add mapped point error_count[3]/q error_count_reg[3]/Q -type DFF DFF
add mapped point error_count[4]/q error_count_reg[4]/Q -type DFF DFF
add mapped point error_count[5]/q error_count_reg[5]/Q -type DFF DFF
add mapped point error_count[6]/q error_count_reg[6]/Q -type DFF DFF
add mapped point error_count[7]/q error_count_reg[7]/Q -type DFF DFF
add mapped point error_count[8]/q error_count_reg[8]/Q -type DFF DFF
add mapped point error_count[9]/q error_count_reg[9]/Q -type DFF DFF
add mapped point error_count[10]/q error_count_reg[10]/Q -type DFF DFF
add mapped point error_count[11]/q error_count_reg[11]/Q -type DFF DFF
add mapped point error_count[12]/q error_count_reg[12]/Q -type DFF DFF
add mapped point error_count[13]/q error_count_reg[13]/Q -type DFF DFF
add mapped point error_count[14]/q error_count_reg[14]/Q -type DFF DFF
add mapped point error_count[15]/q error_count_reg[15]/Q -type DFF DFF
add mapped point error_count[16]/q error_count_reg[16]/Q -type DFF DFF
add mapped point error_count[17]/q error_count_reg[17]/Q -type DFF DFF
add mapped point error_count[18]/q error_count_reg[18]/Q -type DFF DFF
add mapped point error_count[19]/q error_count_reg[19]/Q -type DFF DFF
add mapped point error_count[20]/q error_count_reg[20]/Q -type DFF DFF
add mapped point error_count[21]/q error_count_reg[21]/Q -type DFF DFF
add mapped point error_count[22]/q error_count_reg[22]/Q -type DFF DFF
add mapped point error_count[23]/q error_count_reg[23]/Q -type DFF DFF
add mapped point error_count[24]/q error_count_reg[24]/Q -type DFF DFF
add mapped point error_count[25]/q error_count_reg[25]/Q -type DFF DFF
add mapped point error_count[26]/q error_count_reg[26]/Q -type DFF DFF
add mapped point error_count[27]/q error_count_reg[27]/Q -type DFF DFF
add mapped point error_count[28]/q error_count_reg[28]/Q -type DFF DFF
add mapped point error_count[29]/q error_count_reg[29]/Q -type DFF DFF
add mapped point error_count[30]/q error_count_reg[30]/Q -type DFF DFF
add mapped point error_count[31]/q error_count_reg[31]/Q -type DFF DFF
add mapped point total_count[0]/q total_count_reg[0]/Q -type DFF DFF
add mapped point total_count[1]/q total_count_reg[1]/Q -type DFF DFF
add mapped point total_count[2]/q total_count_reg[2]/Q -type DFF DFF
add mapped point total_count[3]/q total_count_reg[3]/Q -type DFF DFF
add mapped point total_count[4]/q total_count_reg[4]/Q -type DFF DFF
add mapped point total_count[5]/q total_count_reg[5]/Q -type DFF DFF
add mapped point total_count[6]/q total_count_reg[6]/Q -type DFF DFF
add mapped point total_count[7]/q total_count_reg[7]/Q -type DFF DFF
add mapped point total_count[8]/q total_count_reg[8]/Q -type DFF DFF
add mapped point total_count[9]/q total_count_reg[9]/Q -type DFF DFF
add mapped point total_count[10]/q total_count_reg[10]/Q -type DFF DFF
add mapped point total_count[11]/q total_count_reg[11]/Q -type DFF DFF
add mapped point total_count[12]/q total_count_reg[12]/Q -type DFF DFF
add mapped point total_count[13]/q total_count_reg[13]/Q -type DFF DFF
add mapped point total_count[14]/q total_count_reg[14]/Q -type DFF DFF
add mapped point total_count[15]/q total_count_reg[15]/Q -type DFF DFF
add mapped point total_count[16]/q total_count_reg[16]/Q -type DFF DFF
add mapped point total_count[17]/q total_count_reg[17]/Q -type DFF DFF
add mapped point total_count[18]/q total_count_reg[18]/Q -type DFF DFF
add mapped point total_count[19]/q total_count_reg[19]/Q -type DFF DFF
add mapped point total_count[20]/q total_count_reg[20]/Q -type DFF DFF
add mapped point total_count[21]/q total_count_reg[21]/Q -type DFF DFF
add mapped point total_count[22]/q total_count_reg[22]/Q -type DFF DFF
add mapped point total_count[23]/q total_count_reg[23]/Q -type DFF DFF
add mapped point total_count[24]/q total_count_reg[24]/Q -type DFF DFF
add mapped point total_count[25]/q total_count_reg[25]/Q -type DFF DFF
add mapped point total_count[26]/q total_count_reg[26]/Q -type DFF DFF
add mapped point total_count[27]/q total_count_reg[27]/Q -type DFF DFF
add mapped point total_count[28]/q total_count_reg[28]/Q -type DFF DFF
add mapped point total_count[29]/q total_count_reg[29]/Q -type DFF DFF
add mapped point total_count[30]/q total_count_reg[30]/Q -type DFF DFF
add mapped point total_count[31]/q total_count_reg[31]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
