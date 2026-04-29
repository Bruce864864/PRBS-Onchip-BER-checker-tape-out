################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 04/17/2026 18:11:52
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}

read_mmmc genus_invs_des/genus.mmmc.tcl

read_physical -lef {/w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tsmc018_6lm4X1U_40KAUTM_7T.tlef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_Cell/core_cell_library/core_cell_library/7-track/tcb018gbwp7t_290a/TSMCHOME/digital/Back_End/lef/tcb018gbwp7t_270a/lef/tcb018gbwp7t_6lm.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/EXTRAS/tpd018nv_6lm_modified.lef /w/class.1/ee/ee209b/ee209bta/TSMC180PDK/Standard_Cells_and_IO/180_G_Standard_IO/Standard_IO/Standard_IO/tpd018nv_280a/TSMCHOME/digital/../../../tpb018v_190a/TSMCHOME/digital/Back_End/lef/tpb018v_190a/cup/6lm/lef/tpb018v_6lm.lef}

read_netlist genus_invs_des/genus.v.gz

init_design
