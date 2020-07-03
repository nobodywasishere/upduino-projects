library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
		SIG : out unsigned(15 downto 0)
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

component ROM is
	port(
		clk : in std_logic;
    addr : in unsigned(9 downto 0);
		mem : out unsigned(15 downto 0)
	);
end component;

signal clk,reset : std_logic;
signal count : unsigned(30 downto 0);
signal addr : unsigned(9 downto 0);

begin
	dut1 : SB_HFOSC port map (CLKHF => clk);
	dut2 : counter port map (clk => clk, reset => reset, current => count);
	dut3 : ROM port map (clk => clk, addr => addr, mem => SIG);

	process (clk) begin
		addr(9) <= '0';
		addr(8 downto 0) <= count(28 downto 23) & count(15 downto 13);
	end process;
end;
