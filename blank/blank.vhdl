library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity blank is
	port(
		SIG : out std_logic
	);
end blank;

architecture synth of blank is

begin
	SIG <= '1';
end;
