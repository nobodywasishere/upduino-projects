## vga_logic_analyzer

Very basic proof of concept for a logic analyzer outputting to a 1024x768 VGA display. ch1 currently shows a value from the col index. ch2 oscillates at twice the frequency of ch3. ch3 oscillates at multiples lower of the pixel clock, taking in the value of pin 37 at pin 28 and holds it in a small buffer, showing it on screen as a logic analyzer/oscilloscope would. Work needs to be done to create a better buffer (moving the index instead of all the data, and using actual memory, and increase the BW/Resolution).

It is very touchy, and small changes to the code may stop it from working - even if the changes seemingly did nothing (this may be due to the lack of shielding of the wires going from the FPGA to the VGA connector - or just poor code ;) ). It will go black every minute or so, probably also due to shielding.

Connect a wire between pins 28 and 37 to see the oscilloscope in action (it currently only stores 160 values - the goal eventually is 912), or connect pin 28 to whatever it is you want to analyze. I added a color palette for fun and to demonstrate one way of drawing to the display. Be sure to add 270ohm resistors in series with the VGA color lines to reduce noise.

![Logic Analyzer Display Output](./logic_analyzer.jpg)

![](./top.svg)

```
Info: Device utilisation:
Info: 	         ICESTORM_LC:  1452/ 5280    27%
Info: 	        ICESTORM_RAM:     0/   30     0%
Info: 	               SB_IO:     7/   96     7%
Info: 	               SB_GB:     6/    8    75%
Info: 	        ICESTORM_PLL:     1/    1   100%
Info: 	         SB_WARMBOOT:     0/    1     0%
Info: 	        ICESTORM_DSP:     0/    8     0%
Info: 	      ICESTORM_HFOSC:     1/    1   100%
Info: 	      ICESTORM_LFOSC:     0/    1     0%
Info: 	              SB_I2C:     0/    2     0%
Info: 	              SB_SPI:     0/    2     0%
Info: 	              IO_I3C:     0/    2     0%
Info: 	         SB_LEDDA_IP:     0/    1     0%
Info: 	         SB_RGBA_DRV:     0/    1     0%
Info: 	      ICESTORM_SPRAM:     0/    4     0%
```
