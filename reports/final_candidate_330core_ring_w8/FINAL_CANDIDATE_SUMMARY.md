# PRBS/BER Digital Core P&R Final Candidate Summary

## Design
Top module: prbs_ber_pad_top
Target frequency: 250 MHz
Clock period: 4 ns
Die bbox: approximately 1000.16 µm × 1000.16 µm
Core bbox: approximately 330.4 µm × 330.4 µm

## RTL / Features
PRBS generator + on-chip BER checker
PRBS7 / PRBS15 support
Internal / external serial data path
Serial configuration interface
Error injection / measurement window / counters / debug-status CSR support

## Floorplan / PG
Core power ring: M4/M5
Ring width: 8 µm
Ring spacing: 4 µm
Ring offset: 1 µm
Power mesh: M1 rails + M2/M3/M4/M5/M6 stripes
M4/M5 split stripe extension used to connect core ring while avoiding M6 DRC

## Pin Placement
Core pins redistributed to left and bottom sides.
Left side: clk, rst_n, ext_serial_in, busy, done, bit_error
Bottom side: cfg_sclk, cfg_cs_n, cfg_mosi, cfg_miso, prbs_out

## Timing
Post-route setup WNS: +0.081 ns
Post-route setup TNS: 0
Setup violating paths: 0
Worst setup slack observed: +0.081 ns
Worst hold slack observed: +0.102 ns
Post-route timing status: clean

## DRC / Connectivity
Innovus check_drc: 0 violations
Innovus connectivity: no special-wire open, no unconnected pin, no unrouted net
Remaining connectivity markers: VDD/VSS dangling-wire markers at power-stripe ends

## Important Notes
This is an Innovus P&R clean candidate, not final tapeout signoff.
Final Calibre DRC/LVS is still required after GDS stream-out, SPICE generation, Virtuoso pad-frame integration, and dummy fill.
