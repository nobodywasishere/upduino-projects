library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		SCK : out std_logic,
        MOSI : out std_logic,
        MISO : in std_logic,
        SSEL : out std_logic
	);
end top;

architecture synth of top is

begin
	SIG <= '1';
end;
