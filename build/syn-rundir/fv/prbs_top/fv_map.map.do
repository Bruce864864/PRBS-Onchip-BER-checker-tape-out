
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point en en -type PI PI
add mapped point seed_load seed_load -type PI PI
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
add mapped point u_prbs_core/lfsr_q[6]/q u_prbs_core/lfsr_q_reg[6]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[5]/q u_prbs_core/lfsr_q_reg[5]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[4]/q u_prbs_core/lfsr_q_reg[4]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[3]/q u_prbs_core/lfsr_q_reg[3]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[2]/q u_prbs_core/lfsr_q_reg[2]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[1]/q u_prbs_core/lfsr_q_reg[1]/Q -type DFF DFF
add mapped point u_prbs_core/lfsr_q[0]/q u_prbs_core/lfsr_q_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
