# Floorplan manually specified from HAMMER
# Disable simultaneous setup/hold mode during implementation/streamout.
# This avoids Innovus IMPSYT-901 style implementation/streamout issues.
set_db timing_enable_simultaneous_setup_hold_mode false

create_floorplan \
  -site core7T \
  -flip f \
  -core_margins_by die \
  -die_size { 1000 1000 335 335 335 335 }
