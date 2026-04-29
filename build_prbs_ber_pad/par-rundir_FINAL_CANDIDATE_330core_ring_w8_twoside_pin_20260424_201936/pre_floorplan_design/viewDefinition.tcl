if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name WCCOM.setup_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcb018gbwp7twc_ccs.lib\
    ${::IMEX::libVar}/mmmc/tpd018nvwc.lib]
create_library_set -name BCCOM.hold_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcb018gbwp7tlt_ccs.lib\
    ${::IMEX::libVar}/mmmc/tpd018nvlt.lib]
create_library_set -name NCCOM.extra_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcb018gbwp7ttc_ccs.lib\
    ${::IMEX::libVar}/mmmc/tpd018nvtc.lib]
create_timing_condition -name NCCOM.extra_cond\
   -library_sets [list NCCOM.extra_set]
create_timing_condition -name BCCOM.hold_cond\
   -library_sets [list BCCOM.hold_set]
create_timing_condition -name WCCOM.setup_cond\
   -library_sets [list WCCOM.setup_set]
create_rc_corner -name NCCOM.extra_rc\
   -cap_table ${::IMEX::libVar}/mmmc/t018lo_1p6m_typical.captable\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 25\
   -qrc_tech ${::IMEX::libVar}/mmmc/NCCOM.extra_rc/qrcTechFile
create_rc_corner -name WCCOM.setup_rc\
   -cap_table ${::IMEX::libVar}/mmmc/t018lo_1p6m_typical.captable\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 125\
   -qrc_tech ${::IMEX::libVar}/mmmc/NCCOM.extra_rc/qrcTechFile
create_rc_corner -name BCCOM.hold_rc\
   -cap_table ${::IMEX::libVar}/mmmc/t018lo_1p6m_typical.captable\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature -40\
   -qrc_tech ${::IMEX::libVar}/mmmc/NCCOM.extra_rc/qrcTechFile
create_delay_corner -name WCCOM.setup_delay\
   -timing_condition {WCCOM.setup_cond}\
   -rc_corner WCCOM.setup_rc
create_delay_corner -name BCCOM.hold_delay\
   -timing_condition {BCCOM.hold_cond}\
   -rc_corner BCCOM.hold_rc
create_delay_corner -name NCCOM.extra_delay\
   -timing_condition {NCCOM.extra_cond}\
   -rc_corner NCCOM.extra_rc
create_constraint_mode -name my_constraint_mode\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/prbs_ber_pad_top.mapped.sdc]
create_analysis_view -name WCCOM.setup_view -constraint_mode my_constraint_mode -delay_corner WCCOM.setup_delay
create_analysis_view -name NCCOM.extra_view -constraint_mode my_constraint_mode -delay_corner NCCOM.extra_delay
create_analysis_view -name BCCOM.hold_view -constraint_mode my_constraint_mode -delay_corner BCCOM.hold_delay
set_analysis_view -setup [list WCCOM.setup_view] -hold [list BCCOM.hold_view NCCOM.extra_view]
