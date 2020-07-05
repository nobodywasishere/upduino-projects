

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

component pwm is
    port (
        clk : in std_logic;
        bright : in unsigned(15 downto 0);
        sig_out : out std_logic
    );
end component;

component divide_by_n is
    generic (
        N : integer
    );
    port(
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

component uart_rx is
    port (
        mclk : in std_logic;
        reset : in std_logic;
        baud_x4 : in std_logic;
        serial : in std_logic;
        data : out unsigned(7 downto 0);
        data_strobe : out std_logic
    );
end component;

signal debug0 : std_logic;
signal debug1 : std_logic;
signal clk_1, clk_4, clk_48 : std_logic;
signal reset : std_logic := '0';
signal counter : unsigned(31 downto 0);
signal serial_txd_interm : std_logic;

signal pwm_g : std_logic;
signal pwm_debug : std_logic;

signal uart_rxd : unsigned(7 downto 0);
signal uart_rxd_strobe : std_logic;

begin
    dut1 : SB_HFOSC port map (CLKHF => clk_48);
    dut2 : pwm port map (clk => clk_48, bright => "0000000000111111", sig_out => pwm_g);
    dut3 : divide_by_n
        generic map (N => 16)
        port map (clk => clk_48, reset => '0', sig_out => clk_1);
    dut4 : divide_by_n
        generic map (N => 4)
        port map (clk => clk_48, reset => '0', sig_out => clk_4);
    dut5 : uart_tx port map (mclk => clk_48, reset => reset, baud_x1 => clk_1,
        serial => serial_txd_interm, data => uart_rxd, data_strobe => uart_rxd_strobe);
    dut6 : uart_rx port map (mclk => clk_48, reset => reset, baud_x4 => clk_4,
        serial => serial_rxd, data => uart_rxd, data_strobe => uart_rxd_strobe);
    dut7 : pwm port map (clk => clk_48, bright => "0000001111111111", sig_out => pwm_debug);


    spi_cs <= '1';
    gpio_2 <= debug0 AND pwm_debug;

    led_b <= serial_rxd;
    led_r <= serial_txd_interm;
    debug0 <= serial_txd_interm;
    serial_txd <= serial_txd_interm;

    process (clk_48) begin
        -- if (uart_rxd = "00001101" and uart_rxd_strobe = '1') then
        --     debug0 <= '1';
        -- else
        --     debug0 <= '0';
        -- end if;

        if (counter(25 downto 23) = "000" and pwm_g = '1') then
            led_g <= '0';
        else
            led_g <= '1';
        end if;

        if (rising_edge(clk_48)) then
            counter <= counter + 1;
        end if;
    end process;

end;
