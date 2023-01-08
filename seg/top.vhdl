library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
		digits : out std_logic_vector(6 downto 0)
	);
end top;

architecture synth of top is

begin
	digits <= "0000000";
end;
