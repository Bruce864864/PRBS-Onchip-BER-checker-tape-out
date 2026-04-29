checkpoint pre_setup_designs -replace
ln -sfn pre_setup_designs latest
set_dofile_abort exit
set_parallel_option -threads 1,4
read_library -liberty /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7ttc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tbc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tlt_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tml_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7twc_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7twcl_ccs.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvwc.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvbc.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvtc.lib /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvlt.lib -both
read_design /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_core.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_core.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_gen_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ber_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/measure_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/csr_regbank.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ber_chip_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/cfg_serial_if.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ber_pad_top.sv -sv09 -sva -golden
read_design /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber_pad/syn-rundir/prbs_ber_pad_top.mapped.v -sv09 -sva -revised
set_root_module prbs_ber_pad_top -both
set_analyze_option -auto
report_design_data
checkpoint pre_compare_designs -replace
ln -sfn pre_compare_designs latest
set_flatten_model -seq_constant
set_flatten_model -seq_constant_x_to 0
set_flatten_model -nodff_to_dlat_zero
set_flatten_model -nodff_to_dlat_feedback
set_flatten_model -hier_seq_merge
set_flatten_model -balanced_modeling
set_analyze_option -auto -report_map
write_hier_compare_dofile hier_compare.tcl -verbose -noexact_pin_match -constraint -usage -replace -balanced_extraction -input_output_pin_equivalence -prepend_string "report_design_data; report_unmapped_points -summary; report_unmapped_points -notmapped; analyze_datapath -module -verbose; eval analyze_datapath -verbose"
run_hier_compare hier_compare.tcl -dynamic_hierarchy
set_system_mode lec
report_statistics
checkpoint post_compare_designs -replace
ln -sfn post_compare_designs latest
exit