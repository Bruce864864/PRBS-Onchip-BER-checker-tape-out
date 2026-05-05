#################################################################################
#
# Created by Genus(TM) Synthesis Solution 21.19-s055_1 on Sun May 03 12:04:33 PDT 2026
#
#################################################################################

## library_sets
create_library_set -name WCCOM.setup_set \
    -timing { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7twc_ccs.lib \
              /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvwc.lib }
create_library_set -name BCCOM.hold_set \
    -timing { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7tlt_ccs.lib \
              /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvlt.lib }
create_library_set -name NCCOM.extra_set \
    -timing { /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcb018gbwp7t_270a/tcb018gbwp7ttc_ccs.lib \
              /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpd018nv_280a/tpd018nvtc.lib }

## timing_condition
create_timing_condition -name WCCOM.setup_cond \
    -library_sets { WCCOM.setup_set }
create_timing_condition -name BCCOM.hold_cond \
    -library_sets { BCCOM.hold_set }
create_timing_condition -name NCCOM.extra_cond \
    -library_sets { NCCOM.extra_set }

## rc_corner
create_rc_corner -name WCCOM.setup_rc \
    -temperature 125.0 \
    -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile \
    -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}
create_rc_corner -name BCCOM.hold_rc \
    -temperature -40.0 \
    -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile \
    -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}
create_rc_corner -name NCCOM.extra_rc \
    -temperature 25.0 \
    -qrc_tech /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/qrcTechFile \
    -cap_table /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/techfiles/captable/t018lo_1p6m_typical.captable \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name WCCOM.setup_delay \
    -early_timing_condition { WCCOM.setup_cond } \
    -late_timing_condition { WCCOM.setup_cond } \
    -early_rc_corner WCCOM.setup_rc \
    -late_rc_corner WCCOM.setup_rc
create_delay_corner -name BCCOM.hold_delay \
    -early_timing_condition { BCCOM.hold_cond } \
    -late_timing_condition { BCCOM.hold_cond } \
    -early_rc_corner BCCOM.hold_rc \
    -late_rc_corner BCCOM.hold_rc
create_delay_corner -name NCCOM.extra_delay \
    -early_timing_condition { NCCOM.extra_cond } \
    -late_timing_condition { NCCOM.extra_cond } \
    -early_rc_corner NCCOM.extra_rc \
    -late_rc_corner NCCOM.extra_rc

## constraint_mode
create_constraint_mode -name my_constraint_mode \
    -sdc_files { genus_invs_des/genus.my_constraint_mode.sdc }

## analysis_view
create_analysis_view -name WCCOM.setup_view \
    -constraint_mode my_constraint_mode \
    -delay_corner WCCOM.setup_delay
create_analysis_view -name BCCOM.hold_view \
    -constraint_mode my_constraint_mode \
    -delay_corner BCCOM.hold_delay
create_analysis_view -name NCCOM.extra_view \
    -constraint_mode my_constraint_mode \
    -delay_corner NCCOM.extra_delay

## set_analysis_view
set_analysis_view -setup { WCCOM.setup_view } \
                  -hold { BCCOM.hold_view NCCOM.extra_view }
