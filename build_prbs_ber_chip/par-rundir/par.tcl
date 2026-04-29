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
} else {
    puts "WARNING: cell */G* was not found for set_dont_use"
}
            
puts "write_db pre_tsmc180_innovus_settings" 
write_db pre_tsmc180_innovus_settings
puts "ln -sfn pre_tsmc180_innovus_settings latest" 
ln -sfn pre_tsmc180_innovus_settings latest


##########################################################
# Placement attributes  [get_db -category place]
##########################################################
#-------------------------------------------------------------------------------
set_db opt_honor_fences true
set_db place_detail_dpt_flow true
set_db place_detail_color_aware_legal true
set_db place_global_solver_effort high
set_db place_detail_check_cut_spacing true
set_db place_global_cong_effort high

##########################################################
# Optimization attributes  [get_db -category opt]
##########################################################
#-------------------------------------------------------------------------------

set_db opt_fix_fanout_load true
set_db opt_clock_gate_aware false
set_db opt_area_recovery true
set_db opt_post_route_area_reclaim setup_aware
set_db opt_fix_hold_verbose true

##########################################################
# Clock attributes  [get_db -category cts]
##########################################################
#-------------------------------------------------------------------------------
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
source -echo -verbose /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/floorplan.tcl
puts "write_db pre_place_bumps" 
write_db pre_place_bumps
puts "ln -sfn pre_place_bumps latest" 
ln -sfn pre_place_bumps latest
puts "write_db pre_tsmc180_add_endcaps" 
write_db pre_tsmc180_add_endcaps
puts "ln -sfn pre_tsmc180_add_endcaps latest" 
ln -sfn pre_tsmc180_add_endcaps latest

set_db add_endcaps_boundary_tap     true
set_db add_endcaps_left_edge        FILL2BWP7T
set_db add_endcaps_right_edge       FILL2BWP7T
add_endcaps
    
puts "write_db pre_place_tap_cells" 
write_db pre_place_tap_cells
puts "ln -sfn pre_place_tap_cells latest" 
ln -sfn pre_place_tap_cells latest
set_db add_well_taps_cell TAPCELLBWP7T
add_well_taps -cell_interval 28 -in_row_offset 16
puts "write_db pre_power_straps" 
write_db pre_power_straps
puts "ln -sfn pre_power_straps latest" 
ln -sfn pre_power_straps latest
puts "source -echo -verbose /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/power_straps.tcl" 
source -echo -verbose /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/power_straps.tcl
puts "write_db pre_place_pins" 
write_db pre_place_pins
puts "ln -sfn pre_place_pins latest" 
ln -sfn pre_place_pins latest
puts "set_db assign_pins_edit_in_batch true" 
set_db assign_pins_edit_in_batch true
puts "edit_pin -fixed_pin -pin * -hinst prbs_ber_chip_top -pattern fill_optimised -layer { METAL2 METAL4 } -side bottom -start { 1600 0 } -end { 0 0 }   " 
edit_pin -fixed_pin -pin * -hinst prbs_ber_chip_top -pattern fill_optimised -layer { METAL2 METAL4 } -side bottom -start { 1600 0 } -end { 0 0 }   
puts "set_db assign_pins_edit_in_batch false" 
set_db assign_pins_edit_in_batch false
puts "write_db pre_place_opt_design" 
write_db pre_place_opt_design
puts "ln -sfn pre_place_opt_design latest" 
ln -sfn pre_place_opt_design latest
puts "place_opt_design" 
place_opt_design
puts "write_db pre_innovus_snap_floorplan" 
write_db pre_innovus_snap_floorplan
puts "ln -sfn pre_innovus_snap_floorplan latest" 
ln -sfn pre_innovus_snap_floorplan latest
puts "snap_floorplan -all" 
snap_floorplan -all
puts "write_db pre_clock_tree" 
write_db pre_clock_tree
puts "ln -sfn pre_clock_tree latest" 
ln -sfn pre_clock_tree latest
puts "create_clock_tree_spec" 
create_clock_tree_spec
puts "ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts" 
ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts
puts "write_db pre_add_fillers" 
write_db pre_add_fillers
puts "ln -sfn pre_add_fillers latest" 
ln -sfn pre_add_fillers latest
set_db add_fillers_cells "FILL1BWP7T FILL2BWP7T FILL4BWP7T FILL8BWP7T FILL16BWP7T FILL32BWP7T FILL64BWP7T"
puts "add_fillers" 
add_fillers
puts "write_db pre_route_design" 
write_db pre_route_design
puts "ln -sfn pre_route_design latest" 
ln -sfn pre_route_design latest
puts "set_db design_express_route true" 
set_db design_express_route true
puts "route_design" 
route_design
puts "write_db pre_opt_design" 
write_db pre_opt_design
puts "ln -sfn pre_opt_design latest" 
ln -sfn pre_opt_design latest
puts "opt_design -post_route -setup -hold -expanded_views" 
opt_design -post_route -setup -hold -expanded_views
puts "write_db pre_write_regs" 
write_db pre_write_regs
puts "ln -sfn pre_write_regs latest" 
ln -sfn pre_write_regs latest

        set write_cells_ir "./find_regs_cells.json"
        set write_cells_ir [open $write_cells_ir "w"]
        puts $write_cells_ir "\["

        set refs [get_db [get_db lib_cells -if .is_sequential==true] .base_name]

        set len [llength $refs]

        for {set i 0} {$i < [llength $refs]} {incr i} {
            if {$i == $len - 1} {
                puts $write_cells_ir "    \"[lindex $refs $i]\""
            } else {
                puts $write_cells_ir "    \"[lindex $refs $i]\","
            }
        }

        puts $write_cells_ir "\]"
        close $write_cells_ir
        set write_regs_ir "./find_regs_paths.json"
        set write_regs_ir [open $write_regs_ir "w"]
        puts $write_regs_ir "\["

        set regs [get_db [get_db [all_registers -edge_triggered -output_pins] -if .direction==out] .name]

        set len [llength $regs]

        for {set i 0} {$i < [llength $regs]} {incr i} {
            #regsub -all {/} [lindex $regs $i] . myreg
            set myreg [lindex $regs $i]
            if {$i == $len - 1} {
                puts $write_regs_ir "    \"$myreg\""
            } else {
                puts $write_regs_ir "    \"$myreg\","
            }
        }

        puts $write_regs_ir "\]"

        close $write_regs_ir
        
puts "write_db pre_innovus_overwrite_write_sdf_funct" 
write_db pre_innovus_overwrite_write_sdf_funct
puts "ln -sfn pre_innovus_overwrite_write_sdf_funct latest" 
ln -sfn pre_innovus_overwrite_write_sdf_funct latest
puts "write_db pre_innovus_extra_reports" 
write_db pre_innovus_extra_reports
puts "ln -sfn pre_innovus_extra_reports latest" 
ln -sfn pre_innovus_extra_reports latest
puts "report_power -hierarchy all -out_file prbs_ber_chip_top_power.rpt" 
report_power -hierarchy all -out_file prbs_ber_chip_top_power.rpt
puts "report_area -detail > prbs_ber_chip_top_area.rpt" 
report_area -detail > prbs_ber_chip_top_area.rpt
set pg_list [get_path_group -include_internal_groups]
set_db timing_enable_simultaneous_setup_hold_mode true
foreach_in_collection g $pg_list {
  report_timing -check_type setup -group [get_property $g name] -nworst 50 > timingReports/prbs_ber_chip_top_postRoute_[get_property $g name].tarpt.gz
  report_timing -check_type  hold -group [get_property $g name] -nworst 50 > timingReports/prbs_ber_chip_top_postRoute_[get_property $g name]_hold.tarpt.gz
}
puts "write_db pre_write_design" 
write_db pre_write_design
puts "ln -sfn pre_write_design latest" 
ln -sfn pre_write_design latest
puts "write_db prbs_ber_chip_top_FINAL -def -verilog" 
write_db prbs_ber_chip_top_FINAL -def -verilog
puts "set_db write_stream_virtual_connection false" 
set_db write_stream_virtual_connection false
puts "write_netlist /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.lvs.v -top_module_first -top_module prbs_ber_chip_top -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELLBWP7T FILL1BWP7T FILL2BWP7T FILL4BWP7T FILL8BWP7T FILL16BWP7T FILL32BWP7T FILL64BWP7T PCORNER PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005 PAD50LAU_TRL PAD60LAU_TRL PAD60LU_TRL } " 
write_netlist /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.lvs.v -top_module_first -top_module prbs_ber_chip_top -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELLBWP7T FILL1BWP7T FILL2BWP7T FILL4BWP7T FILL8BWP7T FILL16BWP7T FILL32BWP7T FILL64BWP7T PCORNER PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005 PAD50LAU_TRL PAD60LAU_TRL PAD60LU_TRL } 
puts "write_netlist /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.sim.v -top_module_first -top_module prbs_ber_chip_top -exclude_leaf_cells -exclude_insts_of_cells { TAPCELLBWP7T FILL1BWP7T FILL2BWP7T FILL4BWP7T FILL8BWP7T FILL16BWP7T FILL32BWP7T FILL64BWP7T PCORNER PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005 PAD50LAU_TRL PAD60LAU_TRL PAD60LU_TRL } " 
write_netlist /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.sim.v -top_module_first -top_module prbs_ber_chip_top -exclude_leaf_cells -exclude_insts_of_cells { TAPCELLBWP7T FILL1BWP7T FILL2BWP7T FILL4BWP7T FILL8BWP7T FILL16BWP7T FILL32BWP7T FILL64BWP7T PCORNER PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005 PAD50LAU_TRL PAD60LAU_TRL PAD60LU_TRL } 
puts "write_stream -mode ALL -map_file /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer/src/hammer-vlsi/technology/tsmc180/extra/streamOut.tsmc.map -uniquify_cell_names -merge { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/gds/tcb018gbwp7t_270a/tcb018gbwp7t.gds /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Back_End/gds/tpd018nv_280a/mt_2/6lm/tpd018nv.gds /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/../../../tpb018v_190a/TSMCHOME/digital/Back_End/gds/tpb018v_190a/cup/6lm/tpb018v.gds } -unit 1000 /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.gds" 
write_stream -mode ALL -map_file /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer/src/hammer-vlsi/technology/tsmc180/extra/streamOut.tsmc.map -uniquify_cell_names -merge { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/gds/tcb018gbwp7t_270a/tcb018gbwp7t.gds /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Back_End/gds/tpd018nv_280a/mt_2/6lm/tpd018nv.gds /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/../../../tpb018v_190a/TSMCHOME/digital/Back_End/gds/tpb018v_190a/cup/6lm/tpb018v.gds } -unit 1000 /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.gds
puts "write_sdf /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.par.sdf -recompute_delaycal -edges library -min_period_edges posedge" 
write_sdf /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.par.sdf -recompute_delaycal -edges library -min_period_edges posedge
puts "write_sdc /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.par.sdc" 
write_sdc /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.par.sdc
puts "set_db extract_rc_coupled true" 
set_db extract_rc_coupled true
puts "extract_rc" 
extract_rc
puts "write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.WCCOM.par.spef -rc_corner WCCOM.setup_rc" 
write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.WCCOM.par.spef -rc_corner WCCOM.setup_rc
puts "write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.BCCOM.par.spef -rc_corner BCCOM.hold_rc" 
write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.BCCOM.par.spef -rc_corner BCCOM.hold_rc
puts "write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.NCCOM.par.spef -rc_corner NCCOM.extra_rc" 
write_parasitics -spef_file /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_chip/par-rundir/prbs_ber_chip_top.NCCOM.par.spef -rc_corner NCCOM.extra_rc
puts "write_db post_write_design" 
write_db post_write_design
puts "ln -sfn post_write_design latest" 
ln -sfn post_write_design latest
puts "exit" 
exit