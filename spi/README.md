## template

This is a blank project that is meant as a starting point for writing new VHDL
projects with the icestorm and ghdl for the Upduino. Currently, all it does is
set pin 2 of the upduino high.

Requires a working Icestorm toolchain setup (http://www.clifford.at/icestorm/),
GHDL (https://github.com/ghdl/ghdl), and ghdl-yosys-plugin
(https://github.com/ghdl/ghdl-yosys-plugin).

Files:
 - top.pcf: indicates which variables from your "top" file connect to which
 pins on the FPGA
 - top.vhdl: your VHDL code
 - Makefile: compile and flash your project, see `make help` for usage info
 - test.vhdl: your other VHDL code


```
///////////////// Statistics: /////////////////
from build.log:
   816
   817	   Number of wires:                  3
   818	   Number of wire bits:              3
   819	   Number of public wires:           3
   820	   Number of public wire bits:       3
   821	   Number of memories:               0
   822	   Number of memory bits:            0
   823	   Number of processes:              0
   824	   Number of cells:                  0
--
   857	Info: Device utilisation:
   858	Info: 	         ICESTORM_LC:     1/ 5280     0%
   859	Info: 	        ICESTORM_RAM:     0/   30     0%
   860	Info: 	               SB_IO:     1/   96     1%
   861	Info: 	               SB_GB:     0/    8     0%
   862	Info: 	        ICESTORM_PLL:     0/    1     0%
   863	Info: 	         SB_WARMBOOT:     0/    1     0%
   864	Info: 	        ICESTORM_DSP:     0/    8     0%
   865	Info: 	      ICESTORM_HFOSC:     0/    1     0%
   866	Info: 	      ICESTORM_LFOSC:     0/    1     0%
   867	Info: 	              SB_I2C:     0/    2     0%
   868	Info: 	              SB_SPI:     0/    2     0%
   869	Info: 	              IO_I3C:     0/    2     0%
   870	Info: 	         SB_LEDDA_IP:     0/    1     0%
   871	Info: 	         SB_RGBA_DRV:     0/    1     0%
   872	Info: 	      ICESTORM_SPRAM:     0/    4     0%
   873
```
