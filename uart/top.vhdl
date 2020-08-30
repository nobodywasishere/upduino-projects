

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

-- /** \file
--  * Test the serial output to the FTDI cable.
--  *
--  * The schematic disagrees with the PCF, but the PCF works...
--  *
--  * The SPI flash chip select *MUST* be pulled high to disable the
--  * flash chip, otherwise they will both be driving the bus.
--  *
--  * This may interfere with programming; `iceprog -e 128` should erase enough
--  * to make it compliant for re-programming
--  *
--  * The USB port will have to be cycled to get the FTDI to renumerate as
--  * /dev/ttyUSB0.  Not sure what is going on with iceprog.
--  */

-- Translated to VHDL by nobodywasishere
-- Original: https://github.com/osresearch/up5k

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port (
        led_r : out std_logic;
        led_g : out std_logic;
        led_b : out std_logic;
        serial_txd : out std_logic;
        serial_rxd : in std_logic;
        spi_cs : out std_logic;
        gpio_2 : out std_logic
    );
end top;

architecture synth of top is

signal debug0 : std_logic;
signal clk_48 : std_logic;
signal reset : std_logic := '0';
signal counter : unsigned(31 downto 0);
signal clk_1 : std_logic;
signal serial_txd_interm : std_logic;

signal uart_txd : unsigned(7 downto 0);
signal uart_txd_strobe : std_logic;
signal uart_txd_ready : std_logic;

signal byte_counter : unsigned(3 downto 0);

signal bool : std_logic := '0';

component SB_HFOSC is
	generic (
		CLKHF_DIV : String := "0b00"
	);
	port (
		CLKHFPU : in std_logic := '1';
		CLKHFEN : in std_logic := '1';
		CLKHF : out std_logic
	);
end component;

component divide_by_n is
    generic (
        N : integer
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        sig_out : out std_logic
    );
end component;

component uart_tx is
    port (
        mclk : in std_logic;
        reset : in std_logic;
        baud_x1 : in std_logic;
        data : in unsigned(7 downto 0);
        data_strobe : in std_logic;
        serial : out std_logic;
        ready : out std_logic
    );
end component;

begin
    dut1 : SB_HFOSC port map (CLKHF => clk_48);
    dut2 : divide_by_n
        generic map (N => 48)
        port map (clk => clk_48, reset => reset, sig_out => clk_1);
    dut3 : uart_tx port map (mclk => clk_48, reset => reset, baud_x1 => clk_1,
        serial => serial_txd_interm, ready => uart_txd_ready, data => uart_txd,
        data_strobe => uart_txd_strobe);

    spi_cs <= '1'; -- it is necessary to turn off the SPI flash chip
    gpio_2 <= debug0;

    --led_g <= '1';
    led_b <= serial_rxd;

    serial_txd <= serial_txd_interm;
    debug0 <= serial_txd_interm;

    process (clk_48) begin
        if (rising_edge(clk_48)) then
            if (reset = '1') then
                counter <= "00000000000000000000000000000000";
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    process (clk_48) begin
        if (rising_edge(clk_48)) then

            led_r <= '1';

            uart_txd_strobe <= '0';

            if (reset = '1') then
                byte_counter <= "0000";
            elsif (uart_txd_ready = '1'
                and not (uart_txd_strobe = '1')
                and counter(14 downto 0) = "0000000000000000") then
                uart_txd_strobe <= '1';

                if (byte_counter = "00") then
                    uart_txd <= "00001101";
                elsif (byte_counter = "01") then
                    uart_txd <= "00001010";
                else
                    uart_txd <= "01000001" + byte_counter - 2;
                end if;

                byte_counter <= byte_counter + 1;
                led_r <= '0';
                led_g <= '0';
            end if;
        end if;
    end process;
end;
