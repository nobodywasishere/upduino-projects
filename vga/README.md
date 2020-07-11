## vga

Currently has timings for 640x480 @ 60Hz and 1024x768 @ 60Hz. Outputs test screen with 7 colors. Tests were done to see if higher resolutions would work but these tests have failed, including 720p and 1080p.

Switched to using external 36MHz clock instead of internal clock to reduced noise.

```
Info: Device utilisation:
Info: 	         ICESTORM_LC:   542/ 5280    10%
Info: 	        ICESTORM_RAM:     0/   30     0%
Info: 	               SB_IO:     5/   96     5%
Info: 	               SB_GB:     4/    8    50%
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
