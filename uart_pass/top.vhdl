

--  /*
--  * Copyright (C) 2009 Micah Dowty
--  *           (C) 2018 Trammell Hudson
--  *
--  * Permission is hereby granted, free of charge, to any person obtaining a copy
--  * of this software and associated documentation files (the "Software"), to deal
--  * in the Software without restriction, including without limitation the rights
--  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  * copies of the Software, and to permit persons to whom the Software is
--  * furnished to do so, subject to the following conditions:
--  *
--  * The above copyright notice and this permission notice shall be included in
--  * all copies or substantial portions of the Software.
--  *
--  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  * THE SOFTWARE.
--  */

-- Translated to VHDL by nobodywasishere
-- Original: https://github.com/osresearch/up5k

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port (
        serial_txd : out std_logic;
        serial_rxd : in std_logic;
        spi_cs : out std_logic;
        gpio_2 : out std_logic;
		gpio_46 : in std_logic
    );
end top;

architecture synth of top is

begin

    spi_cs <= '1';

    gpio_2 <= serial_rxd;
    serial_txd <= gpio_46;

end;
