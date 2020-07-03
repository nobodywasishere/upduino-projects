#!/bin/bash

# Adopted from Usage in https://github.com/ghdl/ghdl-yosys-plugin
# Modify as necessary for your project, specifically replacing 'blank'
# with your 'top' file, and adding source files to be analyzed

# Remove old files
rm -rf *.bin *.asc *.json work-obj93.cf

# Analyse all vhdl sources
ghdl -a blank.vhdl
#ghdl -a other_source_files.vhdl

# Synthesize the design
yosys -m ghdl -p 'ghdl blank; synth_ice40 -json blank.json'

# P&R specifically for upduino
nextpnr-ice40 --up5k --package sg48 --pcf blank.pcf \
--asc blank.asc --json blank.json

# Generate bitstream
icepack blank.asc blank.bin

# Flash FPGA, may need to be run with sudo depending on user permissions
sudo iceprog blank.bin
