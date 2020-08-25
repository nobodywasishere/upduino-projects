library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
	port(
		clk : in std_logic;
        addr : in unsigned(9 downto 0);
		mem : out unsigned(15 downto 0)
	);
end ROM;

architecture synth of rom is
begin
  process(clk) is
  begin
    if (rising_edge(clk)) then
      case addr is
		when "0000000000" => mem <= "0111111100000000";
		when "0000000001" => mem <= "1011111100000000";
		when "0000000010" => mem <= "1101111100000000";
		when "0000000011" => mem <= "1110111100000000";
		when "0000000100" => mem <= "1111011100000000";
		when "0000000101" => mem <= "1111101100000000";
		when "0000000110" => mem <= "1111110100000000";
		when "0000000111" => mem <= "1111111000000000";

		when "0000001000" => mem <= "0111111100011000";
		when "0000001001" => mem <= "1011111100000000";
		when "0000001010" => mem <= "1101111100000000";
		when "0000001011" => mem <= "1110111100000000";
		when "0000001100" => mem <= "1111011100000000";
		when "0000001101" => mem <= "1111101100000000";
		when "0000001110" => mem <= "1111110100000000";
		when "0000001111" => mem <= "1111111000000000";

		when "0000010000" => mem <= "0111111100010000";
		when "0000010001" => mem <= "1011111100011000";
		when "0000010010" => mem <= "1101111100000000";
		when "0000010011" => mem <= "1110111100000000";
		when "0000010100" => mem <= "1111011100000000";
		when "0000010101" => mem <= "1111101100000000";
		when "0000010110" => mem <= "1111110100000000";
		when "0000010111" => mem <= "1111111000000000";

		when "0000011000" => mem <= "0111111100010000";
		when "0000011001" => mem <= "1011111100010000";
		when "0000011010" => mem <= "1101111100011000";
		when "0000011011" => mem <= "1110111100000000";
		when "0000011100" => mem <= "1111011100000000";
		when "0000011101" => mem <= "1111101100000000";
		when "0000011110" => mem <= "1111110100000000";
		when "0000011111" => mem <= "1111111000000000";

		when "0000100000" => mem <= "0111111100000000";
		when "0000100001" => mem <= "1011111100000000";
		when "0000100010" => mem <= "1101111100001000";
		when "0000100011" => mem <= "1110111100111000";
		when "0000100100" => mem <= "1111011100000000";
		when "0000100101" => mem <= "1111101100000000";
		when "0000100110" => mem <= "1111110100000000";
		when "0000100111" => mem <= "1111111000000000";

		when "0000101000" => mem <= "0111111100000000";
		when "0000101001" => mem <= "1011111100000000";
		when "0000101010" => mem <= "1101111100000000";
		when "0000101011" => mem <= "1110111100000100";
		when "0000101100" => mem <= "1111011100011100";
		when "0000101101" => mem <= "1111101100000000";
		when "0000101110" => mem <= "1111110100000000";
		when "0000101111" => mem <= "1111111000000000";

		when "0000110000" => mem <= "0111111100000000";
		when "0000110001" => mem <= "1011111100000000";
		when "0000110010" => mem <= "1101111100000000";
		when "0000110011" => mem <= "1110111100000000";
		when "0000110100" => mem <= "1111011100000010";
		when "0000110101" => mem <= "1111101100001110";
		when "0000110110" => mem <= "1111110100000000";
		when "0000110111" => mem <= "1111111000000000";

		when "0000111000" => mem <= "0111111100000000";
		when "0000111001" => mem <= "1011111100000000";
		when "0000111010" => mem <= "1101111100000000";
		when "0000111011" => mem <= "1110111100000000";
		when "0000111100" => mem <= "1111011100000000";
		when "0000111101" => mem <= "1111101100000001";
		when "0000111110" => mem <= "1111110100000111";
		when "0000111111" => mem <= "1111111000000000";

		when "0001000000" => mem <= "0111111100000000";
		when "0001000001" => mem <= "1011111100000000";
		when "0001000010" => mem <= "1101111100000000";
		when "0001000011" => mem <= "1110111100000000";
		when "0001000100" => mem <= "1111011100000000";
		when "0001000101" => mem <= "1111101100000000";
		when "0001000110" => mem <= "1111110100000001";
		when "0001000111" => mem <= "1111111000000111";

		when "0001001000" => mem <= "0111111100001000";
		when "0001001001" => mem <= "1011111100000000";
		when "0001001010" => mem <= "1101111100000000";
		when "0001001011" => mem <= "1110111100000000";
		when "0001001100" => mem <= "1111011100000000";
		when "0001001101" => mem <= "1111101100000000";
		when "0001001110" => mem <= "1111110100000001";
		when "0001001111" => mem <= "1111111000000111";

		when "0001010000" => mem <= "0111111100011100";
		when "0001010001" => mem <= "1011111100001000";
		when "0001010010" => mem <= "1101111100000000";
		when "0001010011" => mem <= "1110111100000000";
		when "0001010100" => mem <= "1111011100000000";
		when "0001010101" => mem <= "1111101100000000";
		when "0001010110" => mem <= "1111110100000001";
		when "0001010111" => mem <= "1111111000000111";

		when "0001011000" => mem <= "0111111100000000";
		when "0001011001" => mem <= "1011111100011100";
		when "0001011010" => mem <= "1101111100001000";
		when "0001011011" => mem <= "1110111100000000";
		when "0001011100" => mem <= "1111011100000000";
		when "0001011101" => mem <= "1111101100000000";
		when "0001011110" => mem <= "1111110100000001";
		when "0001011111" => mem <= "1111111000000111";

		when "0001100000" => mem <= "0111111100000000";
		when "0001100001" => mem <= "1011111100001000";
		when "0001100010" => mem <= "1101111100001100";
		when "0001100011" => mem <= "1110111100001000";
		when "0001100100" => mem <= "1111011100000000";
		when "0001100101" => mem <= "1111101100000000";
		when "0001100110" => mem <= "1111110100000001";
		when "0001100111" => mem <= "1111111000000111";

		when "0001101000" => mem <= "0111111100000000";
		when "0001101001" => mem <= "1011111100000000";
		when "0001101010" => mem <= "1101111100001000";
		when "0001101011" => mem <= "1110111100011100";
		when "0001101100" => mem <= "1111011100000000";
		when "0001101101" => mem <= "1111101100000000";
		when "0001101110" => mem <= "1111110100000001";
		when "0001101111" => mem <= "1111111000000111";

		when "0001110000" => mem <= "0111111100000000";
		when "0001110001" => mem <= "1011111100000000";
		when "0001110010" => mem <= "1101111100000000";
		when "0001110011" => mem <= "1110111100010000";
		when "0001110100" => mem <= "1111011100111000";
		when "0001110101" => mem <= "1111101100000000";
		when "0001110110" => mem <= "1111110100000001";
		when "0001110111" => mem <= "1111111000000111";

		when "0001111000" => mem <= "0111111100000000";
		when "0001111001" => mem <= "1011111100000000";
		when "0001111010" => mem <= "1101111100000000";
		when "0001111011" => mem <= "1110111100000000";
		when "0001111100" => mem <= "1111011100010000";
		when "0001111101" => mem <= "1111101100111000";
		when "0001111110" => mem <= "1111110100000001";
		when "0001111111" => mem <= "1111111000000111";

		when "0010000000" => mem <= "0111111100000000";
		when "0010000001" => mem <= "1011111100000000";
		when "0010000010" => mem <= "1101111100000000";
		when "0010000011" => mem <= "1110111100000000";
		when "0010000100" => mem <= "1111011100000000";
		when "0010000101" => mem <= "1111101100010000";
		when "0010000110" => mem <= "1111110100111001";
		when "0010000111" => mem <= "1111111000000111";

		when "0010001000" => mem <= "0111111100000000";
		when "0010001001" => mem <= "1011111100000000";
		when "0010001010" => mem <= "1101111100000000";
		when "0010001011" => mem <= "1110111100000000";
		when "0010001100" => mem <= "1111011100000000";
		when "0010001101" => mem <= "1111101100000000";
		when "0010001110" => mem <= "1111110100010001";
		when "0010001111" => mem <= "1111111000111111";

		when "0010010000" => mem <= "0111111100011000";
		when "0010010001" => mem <= "1011111100000000";
		when "0010010010" => mem <= "1101111100000000";
		when "0010010011" => mem <= "1110111100000000";
		when "0010010100" => mem <= "1111011100000000";
		when "0010010101" => mem <= "1111101100000000";
		when "0010010110" => mem <= "1111110100010001";
		when "0010010111" => mem <= "1111111000111111";

		when "0010011000" => mem <= "0111111100011000";
		when "0010011001" => mem <= "1011111100011000";
		when "0010011010" => mem <= "1101111100000000";
		when "0010011011" => mem <= "1110111100000000";
		when "0010011100" => mem <= "1111011100000000";
		when "0010011101" => mem <= "1111101100000000";
		when "0010011110" => mem <= "1111110100010001";
		when "0010011111" => mem <= "1111111000111111";

		when "0010100000" => mem <= "0111111100000000";
		when "0010100001" => mem <= "1011111100110000";
		when "0010100010" => mem <= "1101111100110000";
		when "0010100011" => mem <= "1110111100000000";
		when "0010100100" => mem <= "1111011100000000";
		when "0010100101" => mem <= "1111101100000000";
		when "0010100110" => mem <= "1111110100010001";
		when "0010100111" => mem <= "1111111000111111";

		when "0010101000" => mem <= "0111111100000000";
		when "0010101001" => mem <= "1011111100000000";
		when "0010101010" => mem <= "1101111101100000";
		when "0010101011" => mem <= "1110111101100000";
		when "0010101100" => mem <= "1111011100000000";
		when "0010101101" => mem <= "1111101100000000";
		when "0010101110" => mem <= "1111110100010001";
		when "0010101111" => mem <= "1111111000111111";

		when "0010110000" => mem <= "0111111100000000";
		when "0010110001" => mem <= "1011111100000000";
		when "0010110010" => mem <= "1101111100000000";
		when "0010110011" => mem <= "1110111111000000";
		when "0010110100" => mem <= "1111011111000000";
		when "0010110101" => mem <= "1111101100000000";
		when "0010110110" => mem <= "1111110100010001";
		when "0010110111" => mem <= "1111111000111111";

		when "0010111000" => mem <= "0111111100000000";
		when "0010111001" => mem <= "1011111100000000";
		when "0010111010" => mem <= "1101111100000000";
		when "0010111011" => mem <= "1110111100000000";
		when "0010111100" => mem <= "1111011111000000";
		when "0010111101" => mem <= "1111101111000000";
		when "0010111110" => mem <= "1111110100010001";
		when "0010111111" => mem <= "1111111000111111";

		when "0011000000" => mem <= "0111111100000000";
		when "0011000001" => mem <= "1011111100000000";
		when "0011000010" => mem <= "1101111100000000";
		when "0011000011" => mem <= "1110111100000000";
		when "0011000100" => mem <= "1111011100000000";
		when "0011000101" => mem <= "1111101111000000";
		when "0011000110" => mem <= "1111110111010001";
		when "0011000111" => mem <= "1111111000111111";

		when "0011001000" => mem <= "0111111100000000";
		when "0011001001" => mem <= "1011111100000000";
		when "0011001010" => mem <= "1101111100000000";
		when "0011001011" => mem <= "1110111100000000";
		when "0011001100" => mem <= "1111011100000000";
		when "0011001101" => mem <= "1111101100000000";
		when "0011001110" => mem <= "1111110111010001";
		when "0011001111" => mem <= "1111111000000000";

		when "0011010000" => mem <= "0111111100001000";
		when "0011010001" => mem <= "1011111100000000";
		when "0011010010" => mem <= "1101111100000000";
		when "0011010011" => mem <= "1110111100000000";
		when "0011010100" => mem <= "1111011100000000";
		when "0011010101" => mem <= "1111101100000000";
		when "0011010110" => mem <= "1111110100000000";
		when "0011010111" => mem <= "1111111011010001";

		when "0011011000" => mem <= "0111111100011000";
		when "0011011001" => mem <= "1011111100001000";
		when "0011011010" => mem <= "1101111100000000";
		when "0011011011" => mem <= "1110111100000000";
		when "0011011100" => mem <= "1111011100000000";
		when "0011011101" => mem <= "1111101100000000";
		when "0011011110" => mem <= "1111110100000000";
		when "0011011111" => mem <= "1111111011010001";

		when "0011100000" => mem <= "0111111100010000";
		when "0011100001" => mem <= "1011111100011000";
		when "0011100010" => mem <= "1101111100001000";
		when "0011100011" => mem <= "1110111100000000";
		when "0011100100" => mem <= "1111011100000000";
		when "0011100101" => mem <= "1111101100000000";
		when "0011100110" => mem <= "1111110100000000";
		when "0011100111" => mem <= "1111111011010001";

		when "0011101000" => mem <= "0111111100000000";
		when "0011101001" => mem <= "1011111100010000";
		when "0011101010" => mem <= "1101111100011000";
		when "0011101011" => mem <= "1110111100001000";
		when "0011101100" => mem <= "1111011100000000";
		when "0011101101" => mem <= "1111101100000000";
		when "0011101110" => mem <= "1111110100000000";
		when "0011101111" => mem <= "1111111011010001";

		when "0011110000" => mem <= "0111111100000000";
		when "0011110001" => mem <= "1011111100000000";
		when "0011110010" => mem <= "1101111100000000";
		when "0011110011" => mem <= "1110111100001100";
		when "0011110100" => mem <= "1111011100011000";
		when "0011110101" => mem <= "1111101100000000";
		when "0011110110" => mem <= "1111110100000000";
		when "0011110111" => mem <= "1111111011010001";

		when "0011111000" => mem <= "0111111100000000";
		when "0011111001" => mem <= "1011111100000000";
		when "0011111010" => mem <= "1101111100000000";
		when "0011111011" => mem <= "1110111100000000";
		when "0011111100" => mem <= "1111011100000110";
		when "0011111101" => mem <= "1111101100001100";
		when "0011111110" => mem <= "1111110100000000";
		when "0011111111" => mem <= "1111111011010001";

		when "0100000000" => mem <= "0111111100000000";
		when "0100000001" => mem <= "1011111100000000";
		when "0100000010" => mem <= "1101111100000000";
		when "0100000011" => mem <= "1110111100000000";
		when "0100000100" => mem <= "1111011100000000";
		when "0100000101" => mem <= "1111101100000011";
		when "0100000110" => mem <= "1111110100000110";
		when "0100000111" => mem <= "1111111011010001";

		when "0100001000" => mem <= "0111111100000000";
		when "0100001001" => mem <= "1011111100000000";
		when "0100001010" => mem <= "1101111100000000";
		when "0100001011" => mem <= "1110111100000000";
		when "0100001100" => mem <= "1111011100000000";
		when "0100001101" => mem <= "1111101100000000";
		when "0100001110" => mem <= "1111110100000011";
		when "0100001111" => mem <= "1111111011010111";

		when "0100010000" => mem <= "0111111100011000";
		when "0100010001" => mem <= "1011111100000000";
		when "0100010010" => mem <= "1101111100000000";
		when "0100010011" => mem <= "1110111100000000";
		when "0100010100" => mem <= "1111011100000000";
		when "0100010101" => mem <= "1111101100000000";
		when "0100010110" => mem <= "1111110100000011";
		when "0100010111" => mem <= "1111111011010111";

		when "0100011000" => mem <= "0111111100001000";
		when "0100011001" => mem <= "1011111100011000";
		when "0100011010" => mem <= "1101111100000000";
		when "0100011011" => mem <= "1110111100000000";
		when "0100011100" => mem <= "1111011100000000";
		when "0100011101" => mem <= "1111101100000000";
		when "0100011110" => mem <= "1111110100000011";
		when "0100011111" => mem <= "1111111011010111";

		when "0100100000" => mem <= "0111111100001000";
		when "0100100001" => mem <= "1011111100001000";
		when "0100100010" => mem <= "1101111100011000";
		when "0100100011" => mem <= "1110111100000000";
		when "0100100100" => mem <= "1111011100000000";
		when "0100100101" => mem <= "1111101100000000";
		when "0100100110" => mem <= "1111110100000011";
		when "0100100111" => mem <= "1111111011010111";

		when "0100101000" => mem <= "0111111100000000";
		when "0100101001" => mem <= "1011111100000000";
		when "0100101010" => mem <= "1101111100111000";
		when "0100101011" => mem <= "1110111100001000";
		when "0100101100" => mem <= "1111011100000000";
		when "0100101101" => mem <= "1111101100000000";
		when "0100101110" => mem <= "1111110100000011";
		when "0100101111" => mem <= "1111111011010111";

		when "0100110000" => mem <= "0111111100000000";
		when "0100110001" => mem <= "1011111100000000";
		when "0100110010" => mem <= "1101111100000000";
		when "0100110011" => mem <= "1110111101110000";
		when "0100110100" => mem <= "1111011100010000";
		when "0100110101" => mem <= "1111101100000000";
		when "0100110110" => mem <= "1111110100000011";
		when "0100110111" => mem <= "1111111011010111";

		when "0100111000" => mem <= "0111111100000000";
		when "0100111001" => mem <= "1011111100000000";
		when "0100111010" => mem <= "1101111100000000";
		when "0100111011" => mem <= "1110111100000000";
		when "0100111100" => mem <= "1111011111100000";
		when "0100111101" => mem <= "1111101100100000";
		when "0100111110" => mem <= "1111110100000011";
		when "0100111111" => mem <= "1111111011010111";

		when "0101000000" => mem <= "0111111100000000";
		when "0101000001" => mem <= "1011111100000000";
		when "0101000010" => mem <= "1101111100000000";
		when "0101000011" => mem <= "1110111100000000";
		when "0101000100" => mem <= "1111011100000000";
		when "0101000101" => mem <= "1111101111100000";
		when "0101000110" => mem <= "1111110100100011";
		when "0101000111" => mem <= "1111111011010111";

		when "0101001000" => mem <= "0111111100000000";
		when "0101001001" => mem <= "1011111100000000";
		when "0101001010" => mem <= "1101111100000000";
		when "0101001011" => mem <= "1110111100000000";
		when "0101001100" => mem <= "1111011100000000";
		when "0101001101" => mem <= "1111101100000000";
		when "0101001110" => mem <= "1111110111100011";
		when "0101001111" => mem <= "1111111011110111";

		when "0101010000" => mem <= "0111111100010000";
		when "0101010001" => mem <= "1011111100000000";
		when "0101010010" => mem <= "1101111100000000";
		when "0101010011" => mem <= "1110111100000000";
		when "0101010100" => mem <= "1111011100000000";
		when "0101010101" => mem <= "1111101100000000";
		when "0101010110" => mem <= "1111110111100011";
		when "0101010111" => mem <= "1111111011110111";

		when "0101011000" => mem <= "0111111100111000";
		when "0101011001" => mem <= "1011111100010000";
		when "0101011010" => mem <= "1101111100000000";
		when "0101011011" => mem <= "1110111100000000";
		when "0101011100" => mem <= "1111011100000000";
		when "0101011101" => mem <= "1111101100000000";
		when "0101011110" => mem <= "1111110111100011";
		when "0101011111" => mem <= "1111111011110111";

		when "0101100000" => mem <= "0111111100000000";
		when "0101100001" => mem <= "1011111100011100";
		when "0101100010" => mem <= "1101111100001000";
		when "0101100011" => mem <= "1110111100000000";
		when "0101100100" => mem <= "1111011100000000";
		when "0101100101" => mem <= "1111101100000000";
		when "0101100110" => mem <= "1111110111100011";
		when "0101100111" => mem <= "1111111011110111";

		when "0101101000" => mem <= "0111111100000000";
		when "0101101001" => mem <= "1011111100000000";
		when "0101101010" => mem <= "1101111100011100";
		when "0101101011" => mem <= "1110111100001000";
		when "0101101100" => mem <= "1111011100000000";
		when "0101101101" => mem <= "1111101100000000";
		when "0101101110" => mem <= "1111110111100011";
		when "0101101111" => mem <= "1111111011110111";

		when "0101110000" => mem <= "0111111100000000";
		when "0101110001" => mem <= "1011111100000000";
		when "0101110010" => mem <= "1101111100000000";
		when "0101110011" => mem <= "1110111100011100";
		when "0101110100" => mem <= "1111011100001000";
		when "0101110101" => mem <= "1111101100000000";
		when "0101110110" => mem <= "1111110111100011";
		when "0101110111" => mem <= "1111111011110111";

		when "0101111000" => mem <= "0111111100000000";
		when "0101111001" => mem <= "1011111100000000";
		when "0101111010" => mem <= "1101111100000000";
		when "0101111011" => mem <= "1110111100000000";
		when "0101111100" => mem <= "1111011100011100";
		when "0101111101" => mem <= "1111101100001000";
		when "0101111110" => mem <= "1111110111100011";
		when "0101111111" => mem <= "1111111011110111";

		when "0110000000" => mem <= "0111111100000000";
		when "0110000001" => mem <= "1011111100000000";
		when "0110000010" => mem <= "1101111100000000";
		when "0110000011" => mem <= "1110111100000000";
		when "0110000100" => mem <= "1111011100000000";
		when "0110000101" => mem <= "1111101100011100";
		when "0110000110" => mem <= "1111110111101011";
		when "0110000111" => mem <= "1111111011110111";

		when "0110001000" => mem <= "0111111100000000";
		when "0110001001" => mem <= "1011111100000000";
		when "0110001010" => mem <= "1101111100000000";
		when "0110001011" => mem <= "1110111100000000";
		when "0110001100" => mem <= "1111011100000000";
		when "0110001101" => mem <= "1111101100000000";
		when "0110001110" => mem <= "1111110111111111";
		when "0110001111" => mem <= "1111111011111111";

		when "0110010000" => mem <= "0111111100000000";
		when "0110010001" => mem <= "1011111100000000";
		when "0110010010" => mem <= "1101111100000000";
		when "0110010011" => mem <= "1110111100000000";
		when "0110010100" => mem <= "1111011100000000";
		when "0110010101" => mem <= "1111101100000000";
		when "0110010110" => mem <= "1111110100000000";
		when "0110010111" => mem <= "1111111000000000";

		when "0110011000" => mem <= "0111111100000000";
		when "0110011001" => mem <= "1011111101111110";
		when "0110011010" => mem <= "1101111101111110";
		when "0110011011" => mem <= "1110111100011000";
		when "0110011100" => mem <= "1111011100011000";
		when "0110011101" => mem <= "1111101100011000";
		when "0110011110" => mem <= "1111110100011000";
		when "0110011111" => mem <= "1111111000000000";

		when "0110100000" => mem <= "0111111100000000";
		when "0110100001" => mem <= "1011111101111110";
		when "0110100010" => mem <= "1101111101111110";
		when "0110100011" => mem <= "1110111100011000";
		when "0110100100" => mem <= "1111011100011000";
		when "0110100101" => mem <= "1111101100011000";
		when "0110100110" => mem <= "1111110100011000";
		when "0110100111" => mem <= "1111111000000000";

		when "0110101000" => mem <= "0111111100000000";
		when "0110101001" => mem <= "1011111101111110";
		when "0110101010" => mem <= "1101111101100000";
		when "0110101011" => mem <= "1110111101111000";
		when "0110101100" => mem <= "1111011101111000";
		when "0110101101" => mem <= "1111101101100000";
		when "0110101110" => mem <= "1111110101111110";
		when "0110101111" => mem <= "1111111000000000";

		when "0110110000" => mem <= "0111111100000000";
		when "0110110001" => mem <= "1011111101111110";
		when "0110110010" => mem <= "1101111101100000";
		when "0110110011" => mem <= "1110111101111000";
		when "0110110100" => mem <= "1111011101111000";
		when "0110110101" => mem <= "1111101101100000";
		when "0110110110" => mem <= "1111110101111110";
		when "0110110111" => mem <= "1111111000000000";

		when "0110111000" => mem <= "0111111100000000";
		when "0110111001" => mem <= "1011111101111110";
		when "0110111010" => mem <= "1101111101111110";
		when "0110111011" => mem <= "1110111100011000";
		when "0110111100" => mem <= "1111011100011000";
		when "0110111101" => mem <= "1111101100011000";
		when "0110111110" => mem <= "1111110100011000";
		when "0110111111" => mem <= "1111111000000000";

		when "0111000000" => mem <= "0111111100000000";
		when "0111000001" => mem <= "1011111101111110";
		when "0111000010" => mem <= "1101111101111110";
		when "0111000011" => mem <= "1110111100011000";
		when "0111000100" => mem <= "1111011100011000";
		when "0111000101" => mem <= "1111101100011000";
		when "0111000110" => mem <= "1111110100011000";
		when "0111000111" => mem <= "1111111000000000";

		when "0111001000" => mem <= "0111111100000000";
		when "0111001001" => mem <= "1011111101111100";
		when "0111001010" => mem <= "1101111101100110";
		when "0111001011" => mem <= "1110111101100110";
		when "0111001100" => mem <= "1111011101111100";
		when "0111001101" => mem <= "1111101101100110";
		when "0111001110" => mem <= "1111110101100010";
		when "0111001111" => mem <= "1111111000000000";

		when "0111010000" => mem <= "0111111100000000";
		when "0111010001" => mem <= "1011111101111100";
		when "0111010010" => mem <= "1101111101100110";
		when "0111010011" => mem <= "1110111101100110";
		when "0111010100" => mem <= "1111011101111100";
		when "0111010101" => mem <= "1111101101100110";
		when "0111010110" => mem <= "1111110101100010";
		when "0111010111" => mem <= "1111111000000000";

		when "0111011000" => mem <= "0111111100000000";
		when "0111011001" => mem <= "1011111101111110";
		when "0111011010" => mem <= "1101111101111110";
		when "0111011011" => mem <= "1110111100011000";
		when "0111011100" => mem <= "1111011100011000";
		when "0111011101" => mem <= "1111101101111110";
		when "0111011110" => mem <= "1111110101111110";
		when "0111011111" => mem <= "1111111000000000";

		when "0111100000" => mem <= "0111111100000000";
		when "0111100001" => mem <= "1011111101111110";
		when "0111100010" => mem <= "1101111101111110";
		when "0111100011" => mem <= "1110111100011000";
		when "0111100100" => mem <= "1111011100011000";
		when "0111100101" => mem <= "1111101101111110";
		when "0111100110" => mem <= "1111110101111110";
		when "0111100111" => mem <= "1111111000000000";

		when "0111101000" => mem <= "0111111100000000";
		when "0111101001" => mem <= "1011111100111100";
		when "0111101010" => mem <= "1101111101000010";
		when "0111101011" => mem <= "1110111100110000";
		when "0111101100" => mem <= "1111011100001100";
		when "0111101101" => mem <= "1111101101000010";
		when "0111101110" => mem <= "1111110100111100";
		when "0111101111" => mem <= "1111111000000000";

		when "0111110000" => mem <= "0111111100000000";
		when "0111110001" => mem <= "1011111100111100";
		when "0111110010" => mem <= "1101111101000010";
		when "0111110011" => mem <= "1110111100110000";
		when "0111110100" => mem <= "1111011100001100";
		when "0111110101" => mem <= "1111101101000010";
		when "0111110110" => mem <= "1111110100111100";
		when "0111110111" => mem <= "1111111000000000";

		when "0111111000" => mem <= "0111111100000000";
		when "0111111001" => mem <= "1011111100000000";
		when "0111111010" => mem <= "1101111100000000";
		when "0111111011" => mem <= "1110111100000000";
		when "0111111100" => mem <= "1111011100000000";
		when "0111111101" => mem <= "1111101100000000";
		when "0111111110" => mem <= "1111110100000000";
		when "0111111111" => mem <= "1111111000000000";

        when others     	=> mem <= "0000000000000000";
      end case;
    end if;
  end process;
end;


--"0111111100000000"
--"1011111100000000"
--"1101111100000000"
--"1110111100000000"
--"1111011100000000"
--"1111101100000000"
--"1111110100000000"
--"1111111000000000"
