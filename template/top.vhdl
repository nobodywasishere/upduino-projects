library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
		SIG : out std_logic
	);
end top;

architecture synth of top is

begin
	SIG <= '1';
end;
