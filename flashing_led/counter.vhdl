library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
	port (
		clk : in std_logic;
		reset : in std_logic;
		current : out unsigned(30 downto 0)
	);
end counter;

architecture synth of counter is

signal count : unsigned(30 downto 0);

begin
	process (clk) begin
		if (rising_edge(clk)) then
			count <= count + 1;
			if (reset='1') then
				count <= to_unsigned(0, 31);
			end if;
		end if;
	end process;
	current <= count;
end;
