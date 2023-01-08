library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		a : in unsigned(3 downto 0);
		b : in unsigned(3 downto 0);
		s : in unsigned(1 downto 0);
		y : out unsigned(3 downto 0)
	);
end top;

architecture rtl of top is

begin

	y <= a when s="00" else
		 b when s="01" else
	     "0000" when s="10" else
	     a + b when s="11" else (others => '0');

end;
