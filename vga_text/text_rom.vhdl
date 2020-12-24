
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity text_rom is
	port(
        clk : in std_logic;
        row : in unsigned(5 downto 0);
        col : in unsigned(5 downto 0);
        char : out unsigned(7 downto 0)
	);
end text_rom;

architecture synth of text_rom is

    signal addr : unsigned (11 downto 0) := (others => '0');

begin

    addr <= row & col;

    process (clk) begin
        if (rising_edge(clk)) then
            case addr is
                when "000000000001" => char <= "01001000";	-- H
                when "000000000010" => char <= "01000101";	-- E
                when "000000000011" => char <= "01001100";	-- L
                when "000000000100" => char <= "01001100";	-- L
                when "000000000101" => char <= "01001111";	-- O
                when "000000000110" => char <= "00100000";	--
                when "000000000111" => char <= "01010100";	-- T
                when "000000001000" => char <= "01001000";	-- H
                when "000000001001" => char <= "01000101";	-- E
                when "000000001010" => char <= "01010010";	-- R
                when "000000001011" => char <= "01000101";	-- E

                when "000000100001" => char <= "01001101";	-- M
                when "000000100010" => char <= "01011001";	-- Y
                when "000000100011" => char <= "00100000";	--
                when "000000100100" => char <= "01001110";	-- N
                when "000000100101" => char <= "01000001";	-- A
                when "000000100110" => char <= "01001101";	-- M
                when "000000100111" => char <= "01000101";	-- E
                when "000000101000" => char <= "00100000";	--
                when "000000101001" => char <= "01001001";	-- I
                when "000000101010" => char <= "01010011";	-- S
                when "000000101011" => char <= "00100000";	--
                when "000000101100" => char <= "01001101";	-- M
                when "000000101101" => char <= "01001001";	-- I
                when "000000101110" => char <= "01000011";	-- C
                when "000000101111" => char <= "01001000";	-- H
                when "000000110000" => char <= "01000001";	-- A
                when "000000110001" => char <= "01000101";	-- E
                when "000000110010" => char <= "01001100";	-- L

                when "000001000001" => char <= "01001000";	-- H
                when "000001000010" => char <= "01001111";	-- O
                when "000001000011" => char <= "01010111";	-- W
                when "000001000100" => char <= "00100000";	--
                when "000001000101" => char <= "01000001";	-- A
                when "000001000110" => char <= "01010010";	-- R
                when "000001000111" => char <= "01000101";	-- E
                when "000001001000" => char <= "00100000";	--
                when "000001001001" => char <= "01011001";	-- Y
                when "000001001010" => char <= "01001111";	-- O
                when "000001001011" => char <= "01010101";	-- U
                when "000001001100" => char <= "00100000";	--
                when "000001001101" => char <= "01000100";	-- D
                when "000001001110" => char <= "01001111";	-- O
                when "000001001111" => char <= "01001001";	-- I
                when "000001010000" => char <= "01001110";	-- N
                when "000001010001" => char <= "01000111";	-- G
                when "000001010010" => char <= "00111111";	-- ?

                when         others => char <= "00000000";
            end case;
        end if;
    end process;

end;
