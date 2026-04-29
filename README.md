# PRBS Generator + On-Chip BER Checker Tapeout Project

This project implements a configurable PRBS7/PRBS15 generator with an on-chip BER checker for a TSMC 180nm digital tapeout flow.

## Features
- PRBS7 / PRBS15 pattern generation
- Internal and external loopback modes
- Error injection
- Measurement window control
- 32-bit error and total bit counters
- CSR-based control/status/debug registers
- Serial configuration interface
- RTL simulation, synthesis, P&R, STA, and GDS stream-out flow

## Technology / Flow
- Technology: TSMC 180nm
- Target frequency: 250 MHz
- Tools: SystemVerilog, VCS, Cadence Genus, Cadence Innovus, Hammer, Tcl
