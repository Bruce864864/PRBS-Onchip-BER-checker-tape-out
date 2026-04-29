# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Wed Apr 08 16:33:23 PDT 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design prbs_gen_top

create_clock -name "clk" -period 4.0 -waveform {0.0 2.0} [get_ports clk]
set_load -pin_load 0.005 [get_ports prbs_out]
set_clock_groups -name "clock_groups_clk_to_others" -asynchronous -group [get_clocks clk]
group_path -weight 1.000000 -name cg_enable_group_clk -through [list \
  [get_pins u_prbs7_top/u_prbs_core/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins u_prbs7_top/u_prbs_core/CLKGATE_RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_prbs15_top/u_prbs15_core/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins u_prbs15_top/u_prbs15_core/CLKGATE_RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_prbs7_top/u_prbs_core/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins u_prbs7_top/u_prbs_core/CLKGATE_RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_prbs15_top/u_prbs15_core/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins u_prbs15_top/u_prbs15_core/CLKGATE_RC_CG_HIER_INST1/RC_CGIC_INST/E] ]
set_clock_gating_check -setup 0.0 
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GAN2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GAN2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GAOI21D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GAOI21D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GAOI22D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GBUFFD1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GBUFFD2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GBUFFD3BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GBUFFD8BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDCAP10BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDCAP2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDCAP3BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDCAP4BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDCAPBWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDFCNQD1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GDFQD1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GFILL10BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GFILL2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GFILL3BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GFILL4BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GFILLBWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GINVD1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GINVD2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GINVD3BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GINVD8BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GMUX2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GMUX2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GMUX2ND1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GMUX2ND2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GND2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GND2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GND2D3BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GND3D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GND3D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GNR2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GNR2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GNR3D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GNR3D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GOAI21D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GOAI21D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GOR2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GOR2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GSDFCNQD1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GTIEHBWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GTIELBWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GXNR2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GXNR2D2BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GXOR2D1BWP7T]
set_dont_use true [get_lib_cells tcb018gbwp7twc_ccs/GXOR2D2BWP7T]
