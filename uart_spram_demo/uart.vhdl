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

-- Translated to VHDL from Verilog by nobodywasishere
-- Original: https://github.com/osresearch/up5k

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

--
-- Byte transmitter, RS-232 8-N-1
--
-- Transmits on 'serial'. When 'ready' goes high, we can accept another byte.
-- It should be supplied on 'data' with a pulse on 'data_strobe'.
--

entity uart_tx is
    port (
        mclk : in std_logic;
        reset : in std_logic;
        baud_x1 : in std_logic;
        data : in unsigned(7 downto 0);
        data_strobe : in std_logic;
        serial : out std_logic;
        ready : out std_logic
    );
end uart_tx;

architecture synth of uart_tx is

    signal shiftreg : unsigned(9 downto 0);
    signal serial_r : std_logic;

begin
    process (mclk) begin
        if (rising_edge(mclk)) then
            ready <= '0';
            if (reset = '1') then
                shiftreg <= "0000000000";
                serial_r <= '0';
            elsif (data_strobe = '1') then
                shiftreg <= '1' & data & '0';
                ready <= '0';
            elsif (baud_x1 = '1') then
                if (shiftreg = "000000000") then
                    serial_r <= '0';
                    ready <= '1';
                else
                    serial_r <= NOT shiftreg(0);
                    shiftreg <= '0' & shiftreg(9 downto 1);
                end if;
            elsif (shiftreg = "000000000") then
                ready <= '1';
            end if;
            serial <= NOT serial_r;
        end if;
    end process;
end;

--/*
-- * Byte receiver, RS-232 8-N-1
-- *
-- * Receives on 'serial'. When a properly framed byte is
-- * received, 'data_strobe' pulses while the byte is on 'data'.
-- *
-- * Error bytes are ignored.
-- */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity uart_rx is
    port (
        mclk : in std_logic;
        reset : in std_logic;
        baud_x4 : in std_logic;
        serial : in std_logic;
        data : out unsigned(7 downto 0);
        data_strobe : out std_logic
    );
end uart_rx;

architecture synth of uart_rx is

    component d_flipflop is
        port(
            clk : in std_logic;
            reset : in std_logic;
            sig_in : in std_logic;
            sig_out : out std_logic
        );
    end component;

    signal serial_sync : std_logic;

    signal shiftreg : unsigned(8 downto 0);
    signal state : unsigned(5 downto 0);
    signal bit_count : unsigned(3 downto 0);
    signal bit_phase : unsigned(1 downto 0);

    signal sampling_phase : std_logic;
    signal start_bit : std_logic;
    signal stop_bit : std_logic;

    signal waiting_for_start : std_logic;
    signal error_sig : std_logic;

begin
    dut1: d_flipflop port map (clk => mclk, reset => reset, sig_in => serial, sig_out => serial_sync);

    bit_count <= state(5 downto 2);
    bit_phase <= state(1 downto 0);

    data <= shiftreg(7 downto 0);

    process (mclk) begin
        if (bit_phase = 1) then
            sampling_phase <= '1';
        else
            sampling_phase <= '0';
        end if;

        if (bit_count = 0 AND sampling_phase = '1') then
            start_bit <= '1';
        else
            start_bit <= '0';
        end if;

        if (bit_count = 9 AND sampling_phase = '1') then
            stop_bit <= '1';
        else
            stop_bit <= '0';
        end if;

        if (state = 0 AND serial_sync = '1') then
            waiting_for_start <= '1';
        else
            waiting_for_start <= '0';
        end if;

        if ((start_bit = '1' AND serial_sync = '1') OR (stop_bit = '1' AND serial_sync = '0')) then
            error_sig <= '1';
        else
            error_sig <= '0';
        end if;
    end process;

    process (mclk) begin
        if (rising_edge(mclk)) then
            if (reset = '1') then
                state <= "000000";
                data_strobe <= '0';
                shiftreg <= shiftreg;
            elsif (baud_x4 = '1') then

                if (waiting_for_start = '1' OR error_sig = '1' OR stop_bit = '1') then
                    state <= "000000";
                else
                    state <= state + 1;
                end if;

                if (bit_phase = 1) then
                    shiftreg <= serial_sync & shiftreg(8 downto 1);
                else
                    shiftreg <= shiftreg;
                end if;

                data_strobe <= (stop_bit AND NOT error_sig);
            end if;

        end if;
    end process;
end;

-- /*
-- * Output UART with a block RAM FIFO queue.
-- *
-- * Add bytes to the queue and they will be printed when the line is idle.
-- */

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity uart_tx_fifo is
    port (
        clk : in std_logic;
        reset : in std_logic;
        baud_x1 : in std_logic;
        data : in unsigned(7 downto 0);
        data_strobe : in std_logic;
        serial : out std_logic
    );
end uart_tx_fifo;

architecture synth of uart_tx_fifo is

    signal NUM : integer := 32;
    signal uart_txd_ready : std_logic;
    signal uart_txd_strobe : std_logic;
    signal uart_txd : unsigned(7 downto 0);

    signal fifo_available : std_logic;
    signal fifo_read_strobe : std_logic;

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

    component fifo is
        generic (
            data_width : integer := 8;
            data_num : integer := 32
        );
        port (
            clk : in std_logic;
            reset : in std_logic;
            data_available : out std_logic;
            write_data : in unsigned(data_width - 1 downto 0);
            write_strobe : in std_logic;
            read_data : out unsigned(data_width - 1 downto 0);
            read_strobe : in std_logic
        );
    end component;

begin
    dut1 : uart_tx port map (mclk => clk, reset => reset, baud_x1 => baud_x1,
        serial => serial, ready => uart_txd_ready, data => uart_txd,
        data_strobe => uart_txd_strobe);
    dut2 : fifo port map (clk => clk, reset => reset, write_data => data, write_strobe => data_strobe,
        data_available => fifo_available, read_data => uart_txd,
        read_strobe => fifo_read_strobe);

        process (clk) begin
            if (rising_edge(clk)) then
                if (fifo_available = '1' and uart_txd_ready = '1' and data_strobe = '0' and uart_txd_strobe = '0') then
                    fifo_read_strobe <= '1';
                    uart_txd_strobe <= '1';
                else
                    uart_txd_strobe <= '0';
                    fifo_read_strobe <= '0';
                end if;
            end if;
        end process;
end;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity d_flipflop is
    port(
        clk : in std_logic;
        reset : in std_logic;
        sig_in : in std_logic;
        sig_out : out std_logic
    );
end d_flipflop;

architecture synth of d_flipflop is

begin
    process (clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                sig_out <= '0';
            else
                sig_out <= sig_in;
            end if;
        end if;
    end process;
end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity divide_by_n is
    generic (
        N : integer
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        sig_out : out std_logic
    );
end divide_by_n;

architecture synth of divide_by_n is

    function CLOG2 (
        x : in integer
    )   return integer is
        variable y : integer;
    begin
        if (x <= 2) then
            y := 1;
        elsif (x <= 4) then
            y := 2;
        elsif (x <= 8) then
            y := 3;
        elsif (x <= 16) then
            y := 4;
        elsif (x <= 32) then
            y := 5;
        elsif (x <= 64) then
            y := 6;
        elsif (x <= 128) then
            y := 7;
        elsif (x <= 256) then
            y := 8;
        elsif (x <= 512) then
            y := 9;
        elsif (x <= 1024) then
            y := 10;
        elsif (x <= 2048) then
            y := 11;
        elsif (x <= 4096) then
            y := 12;
        elsif (x <= 8192) then
            y := 13;
        elsif (x <= 16384) then
            y := 14;
        elsif (x <= 32768) then
            y := 15;
        elsif (x <= 65536) then
            y := 16;
        else
            y := -1;
        end if;
        return y;
    end function;

    signal counter : unsigned(CLOG2(N) - 1 downto 0);

begin
    process (clk) begin
        if (rising_edge(clk)) then
            sig_out <= '0';

            if (reset = '1') then
                counter <= to_unsigned(0, CLOG2(N));
            elsif (counter = "0") then
                sig_out <= '1';
                counter <= to_unsigned((N - 1), CLOG2(N));
            else
                counter <= counter - 1;
            end if;
        end if;
    end process;
end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity fifo is
    port (
        clk : in std_logic;
        reset : in std_logic;
        data_available : out std_logic;
        write_data : in unsigned(7 downto 0);
        write_strobe : in std_logic;
        read_data : out unsigned(7 downto 0);
        read_strobe : in std_logic
    );
end fifo;

architecture synth of fifo is

    function CLOG2 (
        x : in integer
    )   return integer is
        variable y : integer;
    begin
        if (x <= 2) then
            y := 1;
        elsif (x <= 4) then
            y := 2;
        elsif (x <= 8) then
            y := 3;
        elsif (x <= 16) then
            y := 4;
        elsif (x <= 32) then
            y := 5;
        elsif (x <= 64) then
            y := 6;
        elsif (x <= 128) then
            y := 7;
        elsif (x <= 256) then
            y := 8;
        elsif (x <= 512) then
            y := 9;
        elsif (x <= 1024) then
            y := 10;
        elsif (x <= 2048) then
            y := 11;
        elsif (x <= 4096) then
            y := 12;
        elsif (x <= 8192) then
            y := 13;
        elsif (x <= 16384) then
            y := 14;
        elsif (x <= 32768) then
            y := 15;
        elsif (x <= 65536) then
            y := 16;
        else
            y := -1;
        end if;
        return y;
    end function;

    type mem_buffer is array (0 to 7) of unsigned(7 downto 0);
    signal buffer_one : mem_buffer;

    signal write_ptr : unsigned(4 downto 0) := "00000";
    signal read_ptr : unsigned(4 downto 0) := "00000";

begin

    read_data <= buffer_one(to_integer(read_ptr));

    process (clk) begin
        if (rising_edge(clk)) then
            if (read_ptr /= write_ptr) then
                data_available <= '1';
            else
                data_available <= '0';
            end if;

            if (reset = '1') then
                write_ptr <= "00000";
                read_ptr <= "00000";
            else
                if (write_strobe = '1') then
                    buffer_one(to_integer(write_ptr)) <= write_data;
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
use ieee.math_real.all;

entity pwm is
    port (
        clk : in std_logic;
        bright : in unsigned(15 downto 0);
        sig_out : out std_logic
    );
end pwm;

architecture synth of pwm is

    signal counter : unsigned(15 downto 0);

begin
    process (clk) begin
        if (rising_edge(clk)) then
            counter <= counter + 1;
            if (counter < bright) then
                sig_out <= '1';
            else
                sig_out <= '0';
            end if;
        end if;
    end process;
end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
