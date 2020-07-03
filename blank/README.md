## blank

This is a blank project that is meant as a starting point for writing new VHDL
projects with the icestorm and ghdl for the Upduino. Currently, all it does is
set pin 2 of the upduino high.

Requires a working Icestorm toolchain setup (http://www.clifford.at/icestorm/),
GHDL (https://github.com/ghdl/ghdl), and ghdl-yosys-plugin
(https://github.com/ghdl/ghdl-yosys-plugin).

Files:
 - blank.pcf: indicates which variables from your "top" file connect to which
 pins on the FPGA
 - blank.vhdl: your VHDL code
 - cnf.sh: compile and flash your project from an easily modifiable script

The process of compiling and flashing is as follows, where blank would be
the name of your 'top' file:

```
# Analyse all vhdl sources
ghdl -a blank.vhdl

# Synthesize the design
yosys -m ghdl -p 'ghdl blank; synth_ice40 -json blank.json'

# P&R
nextpnr-ice40 --up5k --package sg48 --pcf blank.pcf \
--asc blank.asc --json blank.json

# Generate bitstream
icepack blank.asc blank.bin

# Flash FPGA, may need to be run with sudo depending on user permissions
iceprog blank.bin
```
