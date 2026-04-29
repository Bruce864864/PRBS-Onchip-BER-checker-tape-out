#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Apr 17 17:56:53 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.19-s058_1 (64bit) 04/04/2024 09:59 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.19-s058_1 NR231113-0413/21_19-UB (database version 18.20.605) {superthreading v2.17}
#@(#)CDS: AAE 21.19-s004 (64bit) 04/04/2024 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.19-s010_1 () Mar 27 2024 01:55:37 ( )
#@(#)CDS: SYNTECH 21.19-s002_1 () Sep  6 2023 22:17:00 ( )
#@(#)CDS: CPE v21.19-s026
#@(#)CDS: IQuantus/TQuantus 21.1.1-s966 (64bit) Wed Mar 8 10:22:20 PST 2023 (Linux 3.10.0-693.el7.x86_64)

#@ source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/par.tcl
#@ Begin verbose source (pre): source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/par.tcl
puts "set_db design_process_node 180" 
set_db design_process_node 180
puts "set_multi_cpu_usage -local_cpu 4" 
set_multi_cpu_usage -local_cpu 4
puts "set_db timing_analysis_cppr both" 
set_db timing_analysis_cppr both
puts "set_db timing_analysis_type ocv" 
set_db timing_analysis_type ocv
puts "set_library_unit -time 1ns" 
set_library_unit -time 1ns
puts "set_db init_design_uniquify true" 
set_db init_design_uniquify true
puts "set_db si_delay_separate_on_data true" 
set_db si_delay_separate_on_data true
puts "set_db si_delay_enable_report true" 
set_db si_delay_enable_report true
puts "read_physical -lef { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tsmc018_6lm4X1U_40KAUTM_7T.tlef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/lef/tcb018gbwp7t_6lm.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tpd018nv_6lm_modified.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/../../../tpb018v_190a/TSMCHOME/digital/Back_End/lef/tpb018v_190a/cup/6lm/lef/tpb018v_6lm.lef }" 
read_physical -lef { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tsmc018_6lm4X1U_40KAUTM_7T.tlef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/lef/tcb018gbwp7t_6lm.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tpd018nv_6lm_modified.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/../../../tpb018v_190a/TSMCHOME/digital/Back_End/lef/tpb018v_190a/cup/6lm/lef/tpb018v_6lm.lef }
puts "read_mmmc /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/mmmc.tcl" 
read_mmmc /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/mmmc.tcl
#@ Begin verbose source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/mmmc.tcl (pre)
puts "create_constraint_mode -name my_constraint_mode -sdc_files [list /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/syn-rundir/prbs_ber_chip_top.mapped.sdc]" 
create_constraint_mode -name my_constraint_mode -sdc_files [list /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/syn-rundir/prbs_ber_chip_top.mapped.sdc]
puts "create_library_set -name WCCOM.setup_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7twc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvwc.lib]" 
create_library_set -name WCCOM.setup_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7twc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvwc.lib]
puts "create_timing_condition -name WCCOM.setup_cond -library_sets [list WCCOM.setup_set]" 
create_timing_condition -name WCCOM.setup_cond -library_sets [list WCCOM.setup_set]
puts "create_rc_corner -name WCCOM.setup_rc -temperature 125.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable" 
create_rc_corner -name WCCOM.setup_rc -temperature 125.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable
puts "create_delay_corner -name WCCOM.setup_delay -timing_condition WCCOM.setup_cond -rc_corner WCCOM.setup_rc" 
create_delay_corner -name WCCOM.setup_delay -timing_condition WCCOM.setup_cond -rc_corner WCCOM.setup_rc
puts "create_analysis_view -name WCCOM.setup_view -delay_corner WCCOM.setup_delay -constraint_mode my_constraint_mode" 
create_analysis_view -name WCCOM.setup_view -delay_corner WCCOM.setup_delay -constraint_mode my_constraint_mode
puts "create_library_set -name BCCOM.hold_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tlt_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvlt.lib]" 
create_library_set -name BCCOM.hold_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tlt_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvlt.lib]
puts "create_timing_condition -name BCCOM.hold_cond -library_sets [list BCCOM.hold_set]" 
create_timing_condition -name BCCOM.hold_cond -library_sets [list BCCOM.hold_set]
puts "create_rc_corner -name BCCOM.hold_rc -temperature -40.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable" 
create_rc_corner -name BCCOM.hold_rc -temperature -40.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable
puts "create_delay_corner -name BCCOM.hold_delay -timing_condition BCCOM.hold_cond -rc_corner BCCOM.hold_rc" 
create_delay_corner -name BCCOM.hold_delay -timing_condition BCCOM.hold_cond -rc_corner BCCOM.hold_rc
puts "create_analysis_view -name BCCOM.hold_view -delay_corner BCCOM.hold_delay -constraint_mode my_constraint_mode" 
create_analysis_view -name BCCOM.hold_view -delay_corner BCCOM.hold_delay -constraint_mode my_constraint_mode
puts "create_library_set -name NCCOM.extra_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7ttc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvtc.lib]" 
create_library_set -name NCCOM.extra_set -timing [list /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7ttc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvtc.lib]
puts "create_timing_condition -name NCCOM.extra_cond -library_sets [list NCCOM.extra_set]" 
create_timing_condition -name NCCOM.extra_cond -library_sets [list NCCOM.extra_set]
puts "create_rc_corner -name NCCOM.extra_rc -temperature 25.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable" 
create_rc_corner -name NCCOM.extra_rc -temperature 25.0 -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable
puts "create_delay_corner -name NCCOM.extra_delay -timing_condition NCCOM.extra_cond -rc_corner NCCOM.extra_rc" 
create_delay_corner -name NCCOM.extra_delay -timing_condition NCCOM.extra_cond -rc_corner NCCOM.extra_rc
puts "create_analysis_view -name NCCOM.extra_view -delay_corner NCCOM.extra_delay -constraint_mode my_constraint_mode" 
create_analysis_view -name NCCOM.extra_view -delay_corner NCCOM.extra_delay -constraint_mode my_constraint_mode
puts "set_analysis_view -setup { WCCOM.setup_view } -hold { BCCOM.hold_view NCCOM.extra_view }" 
set_analysis_view -setup { WCCOM.setup_view } -hold { BCCOM.hold_view NCCOM.extra_view }
#@ End verbose source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/mmmc.tcl
puts "read_netlist { /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/syn-rundir/prbs_ber_chip_top.mapped.v } -top prbs_ber_chip_top" 
read_netlist { /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/syn-rundir/prbs_ber_chip_top.mapped.v } -top prbs_ber_chip_top
puts "init_design" 
init_design
puts "read_power_intent -cpf /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/power_spec.cpf" 
read_power_intent -cpf /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/power_spec.cpf
puts "commit_power_intent" 
commit_power_intent
puts "set_db design_flow_effort extreme" 
set_db design_flow_effort extreme
puts "set_dont_use \[get_db lib_cells */G*\]"
if { [get_db lib_cells */G*] ne "" } {
set_dont_use [get_db lib_cells */G*]
}
puts "write_db pre_tsmc180_innovus_settings" 
write_db pre_tsmc180_innovus_settings
puts "ln -sfn pre_tsmc180_innovus_settings latest" 
ln -sfn pre_tsmc180_innovus_settings latest
set_db opt_honor_fences true
set_db place_detail_dpt_flow true
set_db place_detail_color_aware_legal true
set_db place_global_solver_effort high
set_db place_detail_check_cut_spacing true
set_db place_global_cong_effort high
set_db opt_fix_fanout_load true
set_db opt_clock_gate_aware false
set_db opt_area_recovery true
set_db opt_post_route_area_reclaim setup_aware
set_db opt_fix_hold_verbose true
set_db cts_target_skew 450ps
set_db cts_max_fanout 10
set_db cts_target_max_transition_time 400ps
set_db opt_setup_target_slack 0.1
set_db opt_hold_target_slack 0.1
create_route_rule -name cts_spec_1w_2s_leaf -width {METAL1 0.23 METAL2 0.28 METAL3 0.28 METAL4 0.28 METAL5 0.28 METAL6 2.6} -spacing {METAL1 0.23 METAL2 0.28 METAL3 0.28 METAL4 0.28 METAL5 0.28 METAL6 2.5} 
create_route_type -name RT_LEAF_RULE -route_rule cts_spec_1w_2s_leaf -top_preferred_layer METAL6 -bottom_preferred_layer METAL2 -preferred_routing_layer_effort high
create_route_rule -name cts_spec_2w_2s_shield -width {METAL1 0.46 METAL2 0.56 METAL3 0.56 METAL4 0.56 METAL5 0.56 METAL6 5.2} -spacing {METAL1 0.46 METAL2 0.56 METAL3 0.56 METAL4 0.56 METAL5 0.56 METAL6 5.0} 
create_route_type -name RT_TRUNK_RULE -route_rule cts_spec_2w_2s_shield -shield_net VSS -top_preferred_layer METAL4 -bottom_preferred_layer METAL3 -preferred_routing_layer_effort high
set_db cts_route_type_top "default"
set_db cts_route_type_trunk "RT_TRUNK_RULE"
set_db cts_route_type_leaf "RT_LEAF_RULE"
commit_clock_tree_route_attributes
set_db cts_primary_delay_corner WCCOM.setup_delay
set_db cts_buffer_cells {{CKBD1BWP7T} {CKBD2BWP7T} {CKBD3BWP7T} {CKBD4BWP7T} {CKBD6BWP7T} {CKBD8BWP7T} {CKBD10BWP7T} {CKBD12BWP7T}}
set_db cts_inverter_cells {{CKND0BWP7T} {CKND1BWP7T} {CKND2BWP7T} {CKND3BWP7T} {CKND4BWP7T} {CKND6BWP7T}{CKND8BWP7T} {CKND10BWP7T} {CKND12BWP7T}}
set_db cts_logic_cells {{CKAN2D0BWP7T} {CKAN2D1BWP7T} {CKAN2D2BWP7T} {CKAN2D8BWP7T} {CKXOR2D0BWP7T} {CKXOR2D1BWP7T} {CKXOR2D2BWP7T} {CKXOR2D4BWP7T} {CKMUX2D0BWP7T} {CKMUX2D1BWP7T} {CKMUX2D2BWP7T} {CKND2D0BWP7T} {CKND2D1BWP7T} {CKND2D2BWP7T} {CKND2D3BWP7T} {CKND2D4BWP7T} {CKND2D8BWP7T}}
set_db route_design_antenna_diode_insertion true
set_db route_design_antenna_cell_name ANTENNABWP7T
set_db extract_rc_engine post_route
set_db extract_rc_effort_level high
set_db extract_rc_coupled true
puts "write_db pre_floorplan_design" 
write_db pre_floorplan_design
puts "ln -sfn pre_floorplan_design latest" 
ln -sfn pre_floorplan_design latest
puts "source -echo -verbose /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/floorplan.tcl" 
#@ source -echo -verbose /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/floorplan.tcl
#@ Begin verbose source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/floorplan.tcl (pre)
create_floorplan \
  -site core7T \
  -flip f \
  -core_margins_by die \
  -die_size { 1000 1000 130 130 130 130 }
createPlaceBlockage -type hard -box {129.92 129.92 870.24 300.00}
#@ End verbose source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/floorplan.tcl
#@ End verbose source /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/par.tcl
