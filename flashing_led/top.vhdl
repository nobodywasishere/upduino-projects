library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
		SIG : out unsigned(2 downto 0);
        BTN : in unsigned (1 downto 0)
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
signal bool_onoff : std_logic := '1';
signal bool_pattern : std_logic := '1';


begin
	dut1 : SB_HFOSC port map (CLKHF => clk);
	dut2 : counter port map (clk => clk, reset => reset, current => count);

    process (clk) begin
        if (count(3 downto 0) = "1111") then --brightness control
            SIG(0) <= count(23);
            SIG(1) <= count(24);
            SIG(2) <= count(25);
        else
            SIG(0) <= '1';
            SIG(1) <= '1';
            SIG(2) <= '1';
        end if;
    end process;
end;
