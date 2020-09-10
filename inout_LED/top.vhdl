library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
    port(
        gpio_28 : inout std_logic;
        gpio_2  : out std_logic
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

component counter is
    port (
        clk : in std_logic;
        reset : in std_logic;
        current : out unsigned(30 downto 0)
    );
end component;

signal clk,reset : std_logic;
signal count : unsigned(30 downto 0);


begin
    dut1 : SB_HFOSC port map (CLKHF => clk);
    dut2 : counter port map (clk => clk, reset => reset, current => count);

    process (clk) begin
        -- Jump back and forth between reading and writing
        -- Don't go below count(10)
		    if (count(12) = '1') then
            -- Flash the LED
		        gpio_28 <= count(23);

		        gpio_2 <= '0';
		    else
            -- Set the first LED to high impedence for reading it's state
		        gpio_28 <= 'Z';
            -- Set the read state to the second LED
            -- Turns it on if button open, off if button closed
		        gpio_2 <= gpio_28;
		    end if;
    end process;
end;
