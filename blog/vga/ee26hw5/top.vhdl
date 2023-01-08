library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		A_exponent : in unsigned(3 downto 0);
		A_mantissa : in unsigned(3 downto 0);
		B_exponent : in unsigned(3 downto 0);
		B_mantissa : in unsigned(3 downto 0);
		Y_exponent : out unsigned(3 downto 0);
		Y_mantissa : out unsigned(7 downto 0)
	);
end top;

architecture rtl of top is

	component normalize_fp is
		port (
			in_exponent : in unsigned(3 downto 0);
			in_mantissa : in unsigned(7 downto 0);
			out_exponent : out unsigned(3 downto 0);
			out_mantissa : out unsigned(7 downto 0)
		);
	end component;


	signal exponent : unsigned(3 downto 0);
	signal mantissa : unsigned(7 downto 0);

begin

	dut : normalize_fp port map (
		in_exponent => exponent,
		in_mantissa => mantissa,
		out_exponent => Y_exponent,
		out_mantissa => Y_mantissa
	);

	exponent <= A_exponent + B_exponent;
	mantissa <= A_mantissa * B_mantissa;

end rtl;
