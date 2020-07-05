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

-- Translated to VHDL
-- Original: https://github.com/osresearch/up5k

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- /* \file
--  * Single Ported RAM wrapper.
--  *
--  * The up5k has 1024 Kb of single ported block RAM.
--  * This is can't read/write simultaneously, so it is necessary to
--  * mux the read/write pins.
--  *
--  * Implement an 8-bit wide SPRAM using the 16-bit wide 16K block.
--  */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spram_32k is
    port(
        clk : in std_logic;
        reset : in std_logic := '0';
        cs : in std_logic := '1';
        wren : in std_logic;
        addr : in unsigned(14 downto 0);
        write_data : in unsigned(7 downto 0);
        read_data : out unsigned(7 downto 0)
    );
end spram_32k;

architecture synth of spram_32k is

    component SB_SPRAM256KA is
        port(
            DATAOUT : unsigned(15 downto 0);
            ADDRESS : unsigned(13 downto 0);
            DATAIN : unsigned(15 downto 0);
            MASKWREN : unsigned(3 downto 0);
            WREN : std_logic;
            CHIPSELECT : std_logic;
            CLOCK : std_logic;
            STANDBY : std_logic;
            SLEEP : std_logic;
            POWEROFF : std_logic
        );
    end component;

    signal align : std_logic;
    signal rdata_16 : unsigned(15 downto 0);
    signal write_data_double : unsigned(15 downto 0);
    signal align_quad : unsigned(3 downto 0);
    signal chip_select : std_logic;

begin

    dut1: SB_SPRAM256KA port map (
        DATAOUT => rdata_16,
        ADDRESS => addr(14 downto 1),
        DATAIN => write_data_double,
        MASKWREN => align_quad,
        WREN => wren,
        CHIPSELECT => chip_select,
        CLOCK => clk,
        STANDBY => '0',
        SLEEP => '0',
        POWEROFF => '1'
    );

    align <= addr(0);
    write_data_double <= write_data & write_data;
    align_quad <= align & align & not align & not align;
    chip_select <= (cs and not reset);

    process (clk) begin
        if (align = '1') then
            read_data <= rdata_16(15 downto 8);
        else
            read_data <= rdata_16(7 downto 0);
        end if;
    end process;

end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- // This works like the dual-ported FIFO, but the read_data is
-- // only available when write_strobe is not set.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_spram is
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
end fifo_spram;

architecture synth of fifo_spram is

    component spram_32k is
        port(
            clk : in std_logic;
            reset : in std_logic;
            cs : in std_logic;
            wren : in std_logic;
            addr : in unsigned(14 downto 0);
            write_data : in unsigned(7 downto 0);
            read_data : out unsigned(7 downto 0)
        );
    end component;

    signal write_ptr : unsigned(BIT_NUM - 1 downto 0);
    signal read_ptr : unsigned(BIT_NUM - 1 downto 0);
    signal addr : unsigned(14 downto 0);

begin

    dut1 : spram_32k port map (
        clk => clk,
        reset => reset,
        cs => '1',
        wren => write_strobe,
        addr => addr,
        write_data => write_data,
        read_data => read_data
    );

    process (write_strobe) begin
        if (write_strobe = '1') then
            addr <= write_ptr;
        else
            addr <= read_ptr;
        end if;
    end process;

    process (read_ptr, write_ptr) begin
        if (read_ptr /= write_ptr) then
            data_available <= '1';
        else
            data_available <= '0';
        end if;
    end process;

    process (clk) begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                write_ptr <= (others => '0');
                read_ptr <= (others => '0');
            else
                if (write_strobe = '1') then
                    write_ptr <= write_ptr + 1;
                end if;
                if (read_strobe = '1') then
                    read_ptr <= read_ptr + 1;
                end if;
            end if;
        end if;
    end process;

end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_spram_16to8 is
    generic (
        BIT_NUM : integer := 15
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        data_available : out std_logic;
        write_data : in unsigned(15 downto 0);
        write_strobe : in std_logic;
        read_data : out unsigned(7 downto 0);
        read_strobe : in std_logic;
        debug1 : out std_logic
    );
end fifo_spram_16to8;

architecture synth of fifo_spram_16to8 is

    component SB_SPRAM256KA is
        port(
            DATAOUT : unsigned(15 downto 0);
            ADDRESS : unsigned(13 downto 0);
            DATAIN : unsigned(15 downto 0);
            MASKWREN : unsigned(3 downto 0);
            WREN : std_logic;
            CHIPSELECT : std_logic;
            CLOCK : std_logic;
            STANDBY : std_logic;
            SLEEP : std_logic;
            POWEROFF : std_logic
        );
    end component;

    signal write_ptr : unsigned(BIT_NUM - 1 downto 0);
    signal read_ptr : unsigned(BIT_NUM - 1 downto 0);
    signal addr : unsigned(13 downto 0);

    signal rdata_16 : unsigned(15 downto 0) := "0000000000000000";
    signal chip_select : std_logic;

begin

    dut1: SB_SPRAM256KA port map (
        DATAOUT => rdata_16,
        ADDRESS => addr,
        DATAIN => write_data,
        MASKWREN => "1111",
        WREN => write_strobe,
        CHIPSELECT => chip_select,
        CLOCK => clk,
        STANDBY => '0',
        SLEEP => '0',
        POWEROFF => '1'
    );

    --debug1 <= write_strobe;
    chip_select <= not reset;
    data_available <= '1' WHEN (read_ptr /= write_ptr) ELSE '0';
    read_data <= rdata_16(15 downto 8) WHEN (read_ptr(0) = '0') ELSE rdata_16(7 downto 0);
    addr <= write_ptr(BIT_NUM - 1 downto 1) WHEN (write_strobe = '1') ELSE (read_ptr(BIT_NUM - 1 downto 1));
    debug1 <= '0' WHEN (read_strobe = '1') ELSE '1';

    process (clk) begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                write_ptr <= (others => '0');
                read_ptr <= (others => '0');
            else
                if (write_strobe = '1') then
                    write_ptr <= write_ptr + 2;
                end if;
                if (read_strobe = '1') then
                    read_ptr <= read_ptr + 1;
                end if;
            end if;
        end if;
    end process;

end;
