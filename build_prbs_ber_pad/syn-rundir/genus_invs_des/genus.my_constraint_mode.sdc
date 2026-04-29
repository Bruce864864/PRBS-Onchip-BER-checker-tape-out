# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Tue Apr 28 14:29:46 PDT 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design prbs_ber_pad_top

create_clock -name "clk" -period 4.0 -waveform {0.0 2.0} [get_ports clk]
set_load -pin_load 0.005 [get_ports cfg_miso]
set_load -pin_load 0.005 [get_ports busy]
set_load -pin_load 0.005 [get_ports done]
set_load -pin_load 0.005 [get_ports prbs_out]
set_load -pin_load 0.005 [get_ports bit_error]
set_clock_groups -name "clock_groups_clk_to_others" -asynchronous -group [get_clocks clk]
set_clock_gating_check -setup 0.0 
