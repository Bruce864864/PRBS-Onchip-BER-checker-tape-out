# ============================================================
# PRBS/BER core PG setup
# ============================================================

set_db timing_enable_simultaneous_setup_hold_mode false

connect_global_net VDD -type pg_pin -pin_base_name VDD -all -override
connect_global_net VSS -type pg_pin -pin_base_name VSS -all -override

# Expanded PG area: extend upper-layer stripes beyond core bbox
# so they overlap the 8um/4um core ring.

# For METAL4 vertical stripes:
# keep X inside core, extend Y to top/bottom ring center.
set pg_area_m4 {334.88 318.0 665.28 682.3}

# For METAL5 horizontal stripes:
# extend X to left/right ring center, keep Y inside core.
set pg_area_m5 {318.0 334.88 682.3 665.28}

puts "INFO: pg_area_m4 = $pg_area_m4"
puts "INFO: pg_area_m5 = $pg_area_m5"

# Power strap definition for layer METAL1 (rails):

reset_db -category add_stripes
set_db add_stripes_stacked_via_bottom_layer METAL1
set_db add_stripes_stacked_via_top_layer METAL1
set_db add_stripes_spacing_from_block 2.000
add_stripes -pin_layer METAL1 -layer METAL1 -over_pins 1 -master "FILL2BWP7T" -block_ring_bottom_layer_limit METAL1 -block_ring_top_layer_limit METAL1 -pad_core_ring_bottom_layer_limit METAL1 -pad_core_ring_top_layer_limit METAL1 -direction horizontal -width pin_width -nets { VSS VDD }

# ============================================================
# Core power ring around 500um x 500um digital core
# Put ring after M1 rails and before upper-layer stripes.
# ============================================================

reset_db -category add_rings

add_rings \
  -type core_rings \
  -nets {VSS VDD} \
  -follow core \
  -layer {bottom METAL5 top METAL5 right METAL4 left METAL4} \
  -width {left 8 bottom 8 top 8 right 8} \
  -spacing 4 \
  -offset 1

# Power strap definition for layer METAL2:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL2
set_db add_stripes_stacked_via_bottom_layer METAL1
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL2 -block_ring_top_layer_limit METAL1 -direction vertical -layer METAL2 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL1 -set_to_set_distance 28.000 -spacing 0.280 -switch_layer_over_obs 0 -width 0.280 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 15.820]

# Power strap definition for layer METAL3:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL3
set_db add_stripes_stacked_via_bottom_layer METAL2
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL3 -block_ring_top_layer_limit METAL2 -direction horizontal -layer METAL3 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL2 -set_to_set_distance 28.000 -spacing 0.840 -switch_layer_over_obs 0 -width 0.840 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 6.300]

# Power strap definition for layer METAL4:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL4
set_db add_stripes_stacked_via_bottom_layer METAL3
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL4 -block_ring_top_layer_limit METAL3 -direction vertical -layer METAL4 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL3 -set_to_set_distance 18.480 -spacing 0.840 -switch_layer_over_obs 0 -width 0.840 -area $pg_area_m4 -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 6.300]

# Power strap definition for layer METAL5:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL5
set_db add_stripes_stacked_via_bottom_layer METAL4
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL5 -block_ring_top_layer_limit METAL4 -direction horizontal -layer METAL5 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL4 -set_to_set_distance 5.600 -spacing 0.840 -switch_layer_over_obs 0 -width 0.840 -area $pg_area_m5 -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 1.260]

# Power strap definition for layer METAL6:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL6
set_db add_stripes_stacked_via_bottom_layer METAL5
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 1 -block_ring_bottom_layer_limit METAL6 -block_ring_top_layer_limit METAL5 -direction vertical -layer METAL6 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL5 -set_to_set_distance 255.000 -spacing 7.600 -switch_layer_over_obs 0 -width 7.700 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 55.080]
