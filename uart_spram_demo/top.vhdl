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
--  * Demo reading / writing to the single port RAM.
--  *
--  * The up5k has 1024 Kb of single ported block RAM.
--  * This is can't read/write simultaneously, so it is necessary to
--  * mux the read/write pins.
--  *
--  * This is another serial demo, but the FIFO is stored in the
--  * SPRAM and clocked out slowly to show how much the FIFO can store.
--  * If you overflow the FIFO, bad things happen.
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
        gpio_2 : out std_logic;
        gpio_28 : in std_logic
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

    component fifo_spram is
        generic (
            BIT_WIDTH : integer := 8;
            BIT_NUM : integer := 15
        );
        port(
            clk : in std_logic;
            reset : in std_logic;
            data_available : out std_logic;
            write_data : in unsigned(BIT_WIDTH - 1 downto 0);
            write_strobe : in std_logic;
            read_data : out unsigned(BIT_WIDTH - 1 downto 0);
            read_strobe : in std_logic
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

    signal debug0 : std_logic;

    signal clk_1, clk_4, clk_48 : std_logic;
    signal reset : std_logic;

    signal counter : unsigned(31 downto 0);

    signal pwm_g_bright : unsigned(15 downto 0) := "0000000000111111";
    signal pwm_g : std_logic;

    signal uart_txd : unsigned(7 downto 0);
    signal uart_txd_strobe : std_logic;
    signal uart_txd_ready : std_logic;

    signal uart_rxd : unsigned(7 downto 0);
    signal uart_rxd_strobe : std_logic;
    signal serial_txd_interm : std_logic;

    signal fifo_read_strobe : std_logic;
    signal fifo_available : std_logic;

begin

    dut1 : SB_HFOSC port map (CLKHF => clk_48);

    dut2 : pwm port map (
        clk => clk_48,
        bright => pwm_g_bright,
        sig_out => pwm_g
    );

    dut3 : divide_by_n
        generic map (N => 16)
        port map (clk => clk_48, reset => '0', sig_out => clk_1);

    dut4 : divide_by_n
        generic map (N => 4)
        port map (clk => clk_48, reset => '0', sig_out => clk_4);

    dut5 : uart_tx port map (
        mclk => clk_48,
        reset => reset,
        baud_x1 => clk_1,
        serial => serial_txd_interm,
        ready => uart_txd_ready,
        data => uart_txd,
        data_strobe => uart_txd_strobe
    );

    dut6 : uart_rx port map (
        mclk => clk_48,
        reset => reset,
        baud_x4 => clk_4,
        serial => serial_rxd,
        data => uart_rxd,
        data_strobe => uart_rxd_strobe
    );

    dut7 : fifo_spram port map (
        clk => clk_48,
        reset => reset,
        data_available => fifo_available,
        write_data => uart_rxd,
        write_strobe => uart_rxd_strobe,
        read_data => uart_txd,
        read_strobe => uart_txd_strobe
    );

    spi_cs <= '1';
    gpio_2 <= debug0;
    led_b <= serial_rxd;
    serial_txd <= serial_txd_interm;
    debug0 <= serial_txd_interm;

    process (clk_48) begin
        if (rising_edge(clk_48)) then
            counter <= counter + 1;
        end if;

        if (counter(25 downto 23) = "000" and pwm_g = '1') then
            led_g <= '0';
        else
            led_g <= '1';
        end if;
    end process;

    process (clk_48) begin
        if (rising_edge(clk_48)) then
            uart_txd_strobe <= '0';
            fifo_read_strobe <= '0';
            led_r <= '1';

            if (fifo_available = '1' and uart_txd_ready = '1' and
                uart_rxd_strobe = '0' and uart_txd_strobe = '0'
                and counter(18 downto 0) = "0000000000000000000") then
                fifo_read_strobe <= '1';
                uart_txd_strobe <= '1';
                led_r <= '0';
            end if;
        end if;
    end process;

end;
