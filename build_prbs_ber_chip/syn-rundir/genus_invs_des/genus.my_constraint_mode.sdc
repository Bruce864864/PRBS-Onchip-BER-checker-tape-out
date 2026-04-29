# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Fri Apr 17 18:11:51 PDT 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design prbs_ber_chip_top

create_clock -name "clk" -period 4.0 -waveform {0.0 2.0} [get_ports clk]
set_load -pin_load 0.005 [get_ports {cfg_rdata[31]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[30]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[29]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[28]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[27]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[26]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[25]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[24]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[23]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[22]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[21]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[20]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[19]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[18]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[17]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[16]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[15]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[14]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[13]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[12]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[11]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[10]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[9]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[8]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[7]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[6]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[5]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[4]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[3]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[2]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[1]}]
set_load -pin_load 0.005 [get_ports {cfg_rdata[0]}]
set_load -pin_load 0.005 [get_ports busy]
set_load -pin_load 0.005 [get_ports done]
set_load -pin_load 0.005 [get_ports prbs_out]
set_load -pin_load 0.005 [get_ports bit_error]
set_clock_groups -name "clock_groups_clk_to_others" -asynchronous -group [get_clocks clk]
set_clock_gating_check -setup 0.0 
