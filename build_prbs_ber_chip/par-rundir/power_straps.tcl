# Power strap definition for layer METAL1 (rails):

reset_db -category add_stripes
set_db add_stripes_stacked_via_bottom_layer METAL1
set_db add_stripes_stacked_via_top_layer METAL1
set_db add_stripes_spacing_from_block 2.000
add_stripes -pin_layer METAL1 -layer METAL1 -over_pins 1 -master "FILL2BWP7T" -block_ring_bottom_layer_limit METAL1 -block_ring_top_layer_limit METAL1 -pad_core_ring_bottom_layer_limit METAL1 -pad_core_ring_top_layer_limit METAL1 -direction horizontal -width pin_width -nets { VSS VDD }

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
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL4 -block_ring_top_layer_limit METAL3 -direction vertical -layer METAL4 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL3 -set_to_set_distance 18.480 -spacing 0.840 -switch_layer_over_obs 0 -width 0.840 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 6.300]

# Power strap definition for layer METAL5:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL5
set_db add_stripes_stacked_via_bottom_layer METAL4
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit METAL5 -block_ring_top_layer_limit METAL4 -direction horizontal -layer METAL5 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL4 -set_to_set_distance 5.600 -spacing 0.840 -switch_layer_over_obs 0 -width 0.840 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 1.260]

# Power strap definition for layer METAL6:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer METAL6
set_db add_stripes_stacked_via_bottom_layer METAL5
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 2.000
add_stripes -create_pins 1 -block_ring_bottom_layer_limit METAL6 -block_ring_top_layer_limit METAL5 -direction vertical -layer METAL6 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit METAL5 -set_to_set_distance 255.000 -spacing 7.600 -switch_layer_over_obs 0 -width 7.700 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 55.080]
