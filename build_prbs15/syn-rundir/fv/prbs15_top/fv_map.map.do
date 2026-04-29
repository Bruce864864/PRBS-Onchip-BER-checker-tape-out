
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point en en -type PI PI
add mapped point seed_load seed_load -type PI PI
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

//output ports
add mapped point prbs_out prbs_out -type PO PO

//inout ports




//Sequential Pins
add mapped point u_prbs15_core/lfsr_q[14]/q u_prbs15_core/lfsr_q_reg[14]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[13]/q u_prbs15_core/lfsr_q_reg[13]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[12]/q u_prbs15_core/lfsr_q_reg[12]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[11]/q u_prbs15_core/lfsr_q_reg[11]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[10]/q u_prbs15_core/lfsr_q_reg[10]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[9]/q u_prbs15_core/lfsr_q_reg[9]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[8]/q u_prbs15_core/lfsr_q_reg[8]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[7]/q u_prbs15_core/lfsr_q_reg[7]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[6]/q u_prbs15_core/lfsr_q_reg[6]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[5]/q u_prbs15_core/lfsr_q_reg[5]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[4]/q u_prbs15_core/lfsr_q_reg[4]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[3]/q u_prbs15_core/lfsr_q_reg[3]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[2]/q u_prbs15_core/lfsr_q_reg[2]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[1]/q u_prbs15_core/lfsr_q_reg[1]/Q -type DFF DFF
add mapped point u_prbs15_core/lfsr_q[0]/q u_prbs15_core/lfsr_q_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
