#!/bin/bash

# Adopted from Usage in https://github.com/ghdl/ghdl-yosys-plugin
# Modify as necessary for your project, specifically replacing 'blank'
# with your 'top' file, and adding source files to be analyzed

# Analyse all vhdl sources
ghdl -a top.vhdl
ghdl -a counter.vhdl
#ghdl -a other_source_files.vhdl

# Synthesize the design
yosys -m ghdl -p 'ghdl top; synth_ice40 -json top.json'

# P&R specifically for upduino
nextpnr-ice40 --up5k --package sg48 --pcf top.pcf \
--asc top.asc --json top.json

# Generate bitstream
icepack top.asc top.bin

# Flash FPGA, may need to be run with sudo depending on user permissions
sudo iceprog top.bin
