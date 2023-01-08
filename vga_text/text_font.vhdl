
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity text_font is
	port(
        clk : in std_logic;
        char : in unsigned(7 downto 0);
        row : in unsigned(2 downto 0);
        col : in unsigned(2 downto 0);
        lum : out std_logic
	);
end text_font;

architecture synth of text_font is

    signal addr : unsigned(10 downto 0) := (others => '0');
    signal mem : unsigned(7 downto 0);

begin

    addr <= char & row;
    lum <= mem(to_integer(col));

    process (clk) begin
        if (rising_edge(clk)) then
            case addr is

				--
				when "00100000000" => mem <= "00000000";
				when "00100000001" => mem <= "00000000";
				when "00100000010" => mem <= "00000000";
				when "00100000011" => mem <= "00000000";
				when "00100000100" => mem <= "00000000";
				when "00100000101" => mem <= "00000000";
				when "00100000110" => mem <= "00000000";

				-- !
				when "00100001000" => mem <= "00001000";
				when "00100001001" => mem <= "00001000";
				when "00100001010" => mem <= "00001000";
				when "00100001011" => mem <= "00001000";
				when "00100001100" => mem <= "00001000";
				when "00100001101" => mem <= "00000000";
				when "00100001110" => mem <= "00001000";

				-- "
				when "00100010000" => mem <= "00101000";
				when "00100010001" => mem <= "00101000";
				when "00100010010" => mem <= "00000000";
				when "00100010011" => mem <= "00000000";
				when "00100010100" => mem <= "00000000";
				when "00100010101" => mem <= "00000000";
				when "00100010110" => mem <= "00000000";

				-- #
				when "00100011000" => mem <= "00101000";
				when "00100011001" => mem <= "00101000";
				when "00100011010" => mem <= "00111110";
				when "00100011011" => mem <= "00010100";
				when "00100011100" => mem <= "00111110";
				when "00100011101" => mem <= "00001010";
				when "00100011110" => mem <= "00001010";

				-- $
				when "00100100000" => mem <= "00111000";
				when "00100100001" => mem <= "00000100";
				when "00100100010" => mem <= "00000100";
				when "00100100011" => mem <= "00011000";
				when "00100100100" => mem <= "00100000";
				when "00100100101" => mem <= "00100000";
				when "00100100110" => mem <= "00011100";

				-- %
				when "00100101000" => mem <= "00101110";
				when "00100101001" => mem <= "00011010";
				when "00100101010" => mem <= "00011010";
				when "00100101011" => mem <= "00111110";
				when "00100101100" => mem <= "00101100";
				when "00100101101" => mem <= "00101100";
				when "00100101110" => mem <= "00111010";

				-- &
				when "00100110000" => mem <= "00001000";
				when "00100110001" => mem <= "00010100";
				when "00100110010" => mem <= "00010100";
				when "00100110011" => mem <= "00101100";
				when "00100110100" => mem <= "00110010";
				when "00100110101" => mem <= "00010010";
				when "00100110110" => mem <= "00101100";

				-- '
				when "00100111000" => mem <= "00001000";
				when "00100111001" => mem <= "00001000";
				when "00100111010" => mem <= "00000000";
				when "00100111011" => mem <= "00000000";
				when "00100111100" => mem <= "00000000";
				when "00100111101" => mem <= "00000000";
				when "00100111110" => mem <= "00000000";

				-- (
				when "00101000000" => mem <= "00010000";
				when "00101000001" => mem <= "00001000";
				when "00101000010" => mem <= "00000100";
				when "00101000011" => mem <= "00000100";
				when "00101000100" => mem <= "00000100";
				when "00101000101" => mem <= "00000100";
				when "00101000110" => mem <= "00000100";

				-- )
				when "00101001000" => mem <= "00001000";
				when "00101001001" => mem <= "00010000";
				when "00101001010" => mem <= "00100000";
				when "00101001011" => mem <= "00100000";
				when "00101001100" => mem <= "00100000";
				when "00101001101" => mem <= "00100000";
				when "00101001110" => mem <= "00100000";

				-- *
				when "00101010000" => mem <= "00010000";
				when "00101010001" => mem <= "01111100";
				when "00101010010" => mem <= "00010000";
				when "00101010011" => mem <= "00101000";
				when "00101010100" => mem <= "00000000";
				when "00101010101" => mem <= "00000000";
				when "00101010110" => mem <= "00000000";

				-- +
				when "00101011000" => mem <= "00000000";
				when "00101011001" => mem <= "00010000";
				when "00101011010" => mem <= "00010000";
				when "00101011011" => mem <= "01111100";
				when "00101011100" => mem <= "00010000";
				when "00101011101" => mem <= "00010000";
				when "00101011110" => mem <= "00000000";

				-- ,
				when "00101100000" => mem <= "00000000";
				when "00101100001" => mem <= "00000000";
				when "00101100010" => mem <= "00000000";
				when "00101100011" => mem <= "00000000";
				when "00101100100" => mem <= "00000000";
				when "00101100101" => mem <= "00000000";
				when "00101100110" => mem <= "00001000";

				-- -
				when "00101101000" => mem <= "00000000";
				when "00101101001" => mem <= "00000000";
				when "00101101010" => mem <= "00000000";
				when "00101101011" => mem <= "00111000";
				when "00101101100" => mem <= "00000000";
				when "00101101101" => mem <= "00000000";
				when "00101101110" => mem <= "00000000";

				-- .
				when "00101110000" => mem <= "00000000";
				when "00101110001" => mem <= "00000000";
				when "00101110010" => mem <= "00000000";
				when "00101110011" => mem <= "00000000";
				when "00101110100" => mem <= "00000000";
				when "00101110101" => mem <= "00000000";
				when "00101110110" => mem <= "00001000";

				-- /
				when "00101111000" => mem <= "00100000";
				when "00101111001" => mem <= "00010000";
				when "00101111010" => mem <= "00010000";
				when "00101111011" => mem <= "00010000";
				when "00101111100" => mem <= "00001000";
				when "00101111101" => mem <= "00001000";
				when "00101111110" => mem <= "00001000";

				-- 0
				when "00110000000" => mem <= "00011000";
				when "00110000001" => mem <= "00100100";
				when "00110000010" => mem <= "00100100";
				when "00110000011" => mem <= "00111100";
				when "00110000100" => mem <= "00100100";
				when "00110000101" => mem <= "00100100";
				when "00110000110" => mem <= "00011000";

				-- 1
				when "00110001000" => mem <= "00010000";
				when "00110001001" => mem <= "00011100";
				when "00110001010" => mem <= "00010000";
				when "00110001011" => mem <= "00010000";
				when "00110001100" => mem <= "00010000";
				when "00110001101" => mem <= "00010000";
				when "00110001110" => mem <= "00111100";

				-- 2
				when "00110010000" => mem <= "00011000";
				when "00110010001" => mem <= "00100100";
				when "00110010010" => mem <= "00100000";
				when "00110010011" => mem <= "00010000";
				when "00110010100" => mem <= "00001000";
				when "00110010101" => mem <= "00000100";
				when "00110010110" => mem <= "00111100";

				-- 3
				when "00110011000" => mem <= "00011100";
				when "00110011001" => mem <= "00100000";
				when "00110011010" => mem <= "00100000";
				when "00110011011" => mem <= "00011000";
				when "00110011100" => mem <= "00100000";
				when "00110011101" => mem <= "00100000";
				when "00110011110" => mem <= "00011100";

				-- 4
				when "00110100000" => mem <= "00011000";
				when "00110100001" => mem <= "00011000";
				when "00110100010" => mem <= "00010100";
				when "00110100011" => mem <= "00010010";
				when "00110100100" => mem <= "00111110";
				when "00110100101" => mem <= "00010000";
				when "00110100110" => mem <= "00010000";

				-- 5
				when "00110101000" => mem <= "00111100";
				when "00110101001" => mem <= "00000100";
				when "00110101010" => mem <= "00000100";
				when "00110101011" => mem <= "00011100";
				when "00110101100" => mem <= "00100000";
				when "00110101101" => mem <= "00100000";
				when "00110101110" => mem <= "00011100";

				-- 6
				when "00110110000" => mem <= "00110000";
				when "00110110001" => mem <= "00001000";
				when "00110110010" => mem <= "00000100";
				when "00110110011" => mem <= "00011100";
				when "00110110100" => mem <= "00100100";
				when "00110110101" => mem <= "00100100";
				when "00110110110" => mem <= "00011000";

				-- 7
				when "00110111000" => mem <= "00111100";
				when "00110111001" => mem <= "00100000";
				when "00110111010" => mem <= "00010000";
				when "00110111011" => mem <= "00010000";
				when "00110111100" => mem <= "00001000";
				when "00110111101" => mem <= "00001000";
				when "00110111110" => mem <= "00001000";

				-- 8
				when "00111000000" => mem <= "00011000";
				when "00111000001" => mem <= "00100100";
				when "00111000010" => mem <= "00100100";
				when "00111000011" => mem <= "00011000";
				when "00111000100" => mem <= "00100100";
				when "00111000101" => mem <= "00100100";
				when "00111000110" => mem <= "00011100";

				-- 9
				when "00111001000" => mem <= "00011000";
				when "00111001001" => mem <= "00100100";
				when "00111001010" => mem <= "00100100";
				when "00111001011" => mem <= "00111000";
				when "00111001100" => mem <= "00100000";
				when "00111001101" => mem <= "00010000";
				when "00111001110" => mem <= "00001100";

				-- :
				when "00111010000" => mem <= "00000000";
				when "00111010001" => mem <= "00000000";
				when "00111010010" => mem <= "00001000";
				when "00111010011" => mem <= "00000000";
				when "00111010100" => mem <= "00000000";
				when "00111010101" => mem <= "00000000";
				when "00111010110" => mem <= "00001000";

				-- ;
				when "00111011000" => mem <= "00000000";
				when "00111011001" => mem <= "00000000";
				when "00111011010" => mem <= "00001000";
				when "00111011011" => mem <= "00000000";
				when "00111011100" => mem <= "00000000";
				when "00111011101" => mem <= "00000000";
				when "00111011110" => mem <= "00001000";

				-- <
				when "00111100000" => mem <= "00000000";
				when "00111100001" => mem <= "00100000";
				when "00111100010" => mem <= "00011000";
				when "00111100011" => mem <= "00000100";
				when "00111100100" => mem <= "00011000";
				when "00111100101" => mem <= "00100000";
				when "00111100110" => mem <= "00000000";

				-- =
				when "00111101000" => mem <= "00000000";
				when "00111101001" => mem <= "00000000";
				when "00111101010" => mem <= "00111100";
				when "00111101011" => mem <= "00000000";
				when "00111101100" => mem <= "00111100";
				when "00111101101" => mem <= "00000000";
				when "00111101110" => mem <= "00000000";

				-- >
				when "00111110000" => mem <= "00000000";
				when "00111110001" => mem <= "00000100";
				when "00111110010" => mem <= "00011000";
				when "00111110011" => mem <= "00100000";
				when "00111110100" => mem <= "00011000";
				when "00111110101" => mem <= "00000100";
				when "00111110110" => mem <= "00000000";

				-- ?
				when "00111111000" => mem <= "00011100";
				when "00111111001" => mem <= "00100000";
				when "00111111010" => mem <= "00100000";
				when "00111111011" => mem <= "00010000";
				when "00111111100" => mem <= "00001000";
				when "00111111101" => mem <= "00000000";
				when "00111111110" => mem <= "00001000";

				-- @
				when "01000000000" => mem <= "00011000";
				when "01000000001" => mem <= "00100100";
				when "01000000010" => mem <= "00100010";
				when "01000000011" => mem <= "00110010";
				when "01000000100" => mem <= "00101010";
				when "01000000101" => mem <= "00101010";
				when "01000000110" => mem <= "00110010";

				-- A
				when "01000001000" => mem <= "00001000";
				when "01000001001" => mem <= "00010100";
				when "01000001010" => mem <= "00010100";
				when "01000001011" => mem <= "00010100";
				when "01000001100" => mem <= "00011100";
				when "01000001101" => mem <= "00100010";
				when "01000001110" => mem <= "00100010";

				-- B
				when "01000010000" => mem <= "00011100";
				when "01000010001" => mem <= "00100100";
				when "01000010010" => mem <= "00100100";
				when "01000010011" => mem <= "00011100";
				when "01000010100" => mem <= "00100100";
				when "01000010101" => mem <= "00100100";
				when "01000010110" => mem <= "00011100";

				-- C
				when "01000011000" => mem <= "00111000";
				when "01000011001" => mem <= "00000100";
				when "01000011010" => mem <= "00000100";
				when "01000011011" => mem <= "00000100";
				when "01000011100" => mem <= "00000100";
				when "01000011101" => mem <= "00000100";
				when "01000011110" => mem <= "00111000";

				-- D
				when "01000100000" => mem <= "00011100";
				when "01000100001" => mem <= "00100100";
				when "01000100010" => mem <= "00100100";
				when "01000100011" => mem <= "00100100";
				when "01000100100" => mem <= "00100100";
				when "01000100101" => mem <= "00100100";
				when "01000100110" => mem <= "00011100";

				-- E
				when "01000101000" => mem <= "00111100";
				when "01000101001" => mem <= "00000100";
				when "01000101010" => mem <= "00000100";
				when "01000101011" => mem <= "00011100";
				when "01000101100" => mem <= "00000100";
				when "01000101101" => mem <= "00000100";
				when "01000101110" => mem <= "00111100";

				-- F
				when "01000110000" => mem <= "00111100";
				when "01000110001" => mem <= "00000100";
				when "01000110010" => mem <= "00000100";
				when "01000110011" => mem <= "00111100";
				when "01000110100" => mem <= "00000100";
				when "01000110101" => mem <= "00000100";
				when "01000110110" => mem <= "00000100";

				-- G
				when "01000111000" => mem <= "00111000";
				when "01000111001" => mem <= "00000100";
				when "01000111010" => mem <= "00000100";
				when "01000111011" => mem <= "00000100";
				when "01000111100" => mem <= "00100100";
				when "01000111101" => mem <= "00100100";
				when "01000111110" => mem <= "00111000";

				-- H
				when "01001000000" => mem <= "00100100";
				when "01001000001" => mem <= "00100100";
				when "01001000010" => mem <= "00100100";
				when "01001000011" => mem <= "00111100";
				when "01001000100" => mem <= "00100100";
				when "01001000101" => mem <= "00100100";
				when "01001000110" => mem <= "00100100";

				-- I
				when "01001001000" => mem <= "00111000";
				when "01001001001" => mem <= "00010000";
				when "01001001010" => mem <= "00010000";
				when "01001001011" => mem <= "00010000";
				when "01001001100" => mem <= "00010000";
				when "01001001101" => mem <= "00010000";
				when "01001001110" => mem <= "00111000";

				-- J
				when "01001010000" => mem <= "00111000";
				when "01001010001" => mem <= "00100000";
				when "01001010010" => mem <= "00100000";
				when "01001010011" => mem <= "00100000";
				when "01001010100" => mem <= "00100000";
				when "01001010101" => mem <= "00100100";
				when "01001010110" => mem <= "00011000";

				-- K
				when "01001011000" => mem <= "00100100";
				when "01001011001" => mem <= "00010100";
				when "01001011010" => mem <= "00010100";
				when "01001011011" => mem <= "00001100";
				when "01001011100" => mem <= "00010100";
				when "01001011101" => mem <= "00010100";
				when "01001011110" => mem <= "00100100";

				-- L
				when "01001100000" => mem <= "00000100";
				when "01001100001" => mem <= "00000100";
				when "01001100010" => mem <= "00000100";
				when "01001100011" => mem <= "00000100";
				when "01001100100" => mem <= "00000100";
				when "01001100101" => mem <= "00000100";
				when "01001100110" => mem <= "00111100";

				-- M
				when "01001101000" => mem <= "00100010";
				when "01001101001" => mem <= "00110110";
				when "01001101010" => mem <= "00110110";
				when "01001101011" => mem <= "00101010";
				when "01001101100" => mem <= "00100010";
				when "01001101101" => mem <= "00100010";
				when "01001101110" => mem <= "00100010";

				-- N
				when "01001110000" => mem <= "00100100";
				when "01001110001" => mem <= "00101100";
				when "01001110010" => mem <= "00101100";
				when "01001110011" => mem <= "00110100";
				when "01001110100" => mem <= "00110100";
				when "01001110101" => mem <= "00110100";
				when "01001110110" => mem <= "00100100";

				-- O
				when "01001111000" => mem <= "00011000";
				when "01001111001" => mem <= "00100100";
				when "01001111010" => mem <= "00100100";
				when "01001111011" => mem <= "00100100";
				when "01001111100" => mem <= "00100100";
				when "01001111101" => mem <= "00100100";
				when "01001111110" => mem <= "00011000";

				-- P
				when "01010000000" => mem <= "00011100";
				when "01010000001" => mem <= "00100100";
				when "01010000010" => mem <= "00100100";
				when "01010000011" => mem <= "00100100";
				when "01010000100" => mem <= "00011100";
				when "01010000101" => mem <= "00000100";
				when "01010000110" => mem <= "00000100";

				-- Q
				when "01010001000" => mem <= "00011000";
				when "01010001001" => mem <= "00100100";
				when "01010001010" => mem <= "00100100";
				when "01010001011" => mem <= "00100100";
				when "01010001100" => mem <= "00100100";
				when "01010001101" => mem <= "00100100";
				when "01010001110" => mem <= "00011000";

				-- R
				when "01010010000" => mem <= "00011100";
				when "01010010001" => mem <= "00100100";
				when "01010010010" => mem <= "00100100";
				when "01010010011" => mem <= "00011100";
				when "01010010100" => mem <= "00010100";
				when "01010010101" => mem <= "00100100";
				when "01010010110" => mem <= "00100100";

				-- S
				when "01010011000" => mem <= "00111000";
				when "01010011001" => mem <= "00000100";
				when "01010011010" => mem <= "00000100";
				when "01010011011" => mem <= "00011000";
				when "01010011100" => mem <= "00100000";
				when "01010011101" => mem <= "00100000";
				when "01010011110" => mem <= "00011100";

				-- T
				when "01010100000" => mem <= "01111100";
				when "01010100001" => mem <= "00010000";
				when "01010100010" => mem <= "00010000";
				when "01010100011" => mem <= "00010000";
				when "01010100100" => mem <= "00010000";
				when "01010100101" => mem <= "00010000";
				when "01010100110" => mem <= "00010000";

				-- U
				when "01010101000" => mem <= "00100100";
				when "01010101001" => mem <= "00100100";
				when "01010101010" => mem <= "00100100";
				when "01010101011" => mem <= "00100100";
				when "01010101100" => mem <= "00100100";
				when "01010101101" => mem <= "00100100";
				when "01010101110" => mem <= "00011000";

				-- V
				when "01010110000" => mem <= "00100010";
				when "01010110001" => mem <= "00100010";
				when "01010110010" => mem <= "00010100";
				when "01010110011" => mem <= "00010100";
				when "01010110100" => mem <= "00010100";
				when "01010110101" => mem <= "00011100";
				when "01010110110" => mem <= "00001000";

				-- W
				when "01010111000" => mem <= "01000010";
				when "01010111001" => mem <= "01000010";
				when "01010111010" => mem <= "01000010";
				when "01010111011" => mem <= "01011010";
				when "01010111100" => mem <= "01011010";
				when "01010111101" => mem <= "01011010";
				when "01010111110" => mem <= "00100100";

				-- X
				when "01011000000" => mem <= "00100010";
				when "01011000001" => mem <= "00010100";
				when "01011000010" => mem <= "00010100";
				when "01011000011" => mem <= "00001000";
				when "01011000100" => mem <= "00010100";
				when "01011000101" => mem <= "00010100";
				when "01011000110" => mem <= "00100010";

				-- Y
				when "01011001000" => mem <= "01000100";
				when "01011001001" => mem <= "00101000";
				when "01011001010" => mem <= "00101000";
				when "01011001011" => mem <= "00010000";
				when "01011001100" => mem <= "00010000";
				when "01011001101" => mem <= "00010000";
				when "01011001110" => mem <= "00010000";

				-- Z
				when "01011010000" => mem <= "00111100";
				when "01011010001" => mem <= "00100000";
				when "01011010010" => mem <= "00010000";
				when "01011010011" => mem <= "00001000";
				when "01011010100" => mem <= "00001000";
				when "01011010101" => mem <= "00000100";
				when "01011010110" => mem <= "00111100";

				-- [
				when "01011011000" => mem <= "00111000";
				when "01011011001" => mem <= "00001000";
				when "01011011010" => mem <= "00001000";
				when "01011011011" => mem <= "00001000";
				when "01011011100" => mem <= "00001000";
				when "01011011101" => mem <= "00001000";
				when "01011011110" => mem <= "00001000";

				-- \
				when "01011100000" => mem <= "00000100";
				when "01011100001" => mem <= "00001000";
				when "01011100010" => mem <= "00001000";
				when "01011100011" => mem <= "00001000";
				when "01011100100" => mem <= "00010000";
				when "01011100101" => mem <= "00010000";
				when "01011100110" => mem <= "00010000";

				-- ]
				when "01011101000" => mem <= "00011100";
				when "01011101001" => mem <= "00010000";
				when "01011101010" => mem <= "00010000";
				when "01011101011" => mem <= "00010000";
				when "01011101100" => mem <= "00010000";
				when "01011101101" => mem <= "00010000";
				when "01011101110" => mem <= "00010000";

				-- ^
				when "01011110000" => mem <= "00010000";
				when "01011110001" => mem <= "00101000";
				when "01011110010" => mem <= "00101000";
				when "01011110011" => mem <= "01000100";
				when "01011110100" => mem <= "00000000";
				when "01011110101" => mem <= "00000000";
				when "01011110110" => mem <= "00000000";

				-- _
				when "01011111000" => mem <= "00000000";
				when "01011111001" => mem <= "00000000";
				when "01011111010" => mem <= "00000000";
				when "01011111011" => mem <= "00000000";
				when "01011111100" => mem <= "00000000";
				when "01011111101" => mem <= "00000000";
				when "01011111110" => mem <= "00000000";

				-- `
				when "01100000000" => mem <= "00010000";
				when "01100000001" => mem <= "00000000";
				when "01100000010" => mem <= "00000000";
				when "01100000011" => mem <= "00000000";
				when "01100000100" => mem <= "00000000";
				when "01100000101" => mem <= "00000000";
				when "01100000110" => mem <= "00000000";

				-- a
				when "01100001000" => mem <= "00000000";
				when "01100001001" => mem <= "00011000";
				when "01100001010" => mem <= "00100000";
				when "01100001011" => mem <= "00111000";
				when "01100001100" => mem <= "00100100";
				when "01100001101" => mem <= "00100100";
				when "01100001110" => mem <= "00111000";

				-- b
				when "01100010000" => mem <= "00000100";
				when "01100010001" => mem <= "00011100";
				when "01100010010" => mem <= "00100100";
				when "01100010011" => mem <= "00100100";
				when "01100010100" => mem <= "00100100";
				when "01100010101" => mem <= "00100100";
				when "01100010110" => mem <= "00011100";

				-- c
				when "01100011000" => mem <= "00000000";
				when "01100011001" => mem <= "00111000";
				when "01100011010" => mem <= "00000100";
				when "01100011011" => mem <= "00000100";
				when "01100011100" => mem <= "00000100";
				when "01100011101" => mem <= "00000100";
				when "01100011110" => mem <= "00111000";

				-- d
				when "01100100000" => mem <= "00100000";
				when "01100100001" => mem <= "00111000";
				when "01100100010" => mem <= "00100100";
				when "01100100011" => mem <= "00100100";
				when "01100100100" => mem <= "00100100";
				when "01100100101" => mem <= "00100100";
				when "01100100110" => mem <= "00111000";

				-- e
				when "01100101000" => mem <= "00000000";
				when "01100101001" => mem <= "00011000";
				when "01100101010" => mem <= "00100100";
				when "01100101011" => mem <= "00111100";
				when "01100101100" => mem <= "00000100";
				when "01100101101" => mem <= "00000100";
				when "01100101110" => mem <= "00111000";

				-- f
				when "01100110000" => mem <= "00001000";
				when "01100110001" => mem <= "00111100";
				when "01100110010" => mem <= "00001000";
				when "01100110011" => mem <= "00001000";
				when "01100110100" => mem <= "00001000";
				when "01100110101" => mem <= "00001000";
				when "01100110110" => mem <= "00001000";

				-- g
				when "01100111000" => mem <= "00000000";
				when "01100111001" => mem <= "00111100";
				when "01100111010" => mem <= "00100010";
				when "01100111011" => mem <= "00100010";
				when "01100111100" => mem <= "00100010";
				when "01100111101" => mem <= "00100010";
				when "01100111110" => mem <= "00111100";

				-- h
				when "01101000000" => mem <= "00000100";
				when "01101000001" => mem <= "00011100";
				when "01101000010" => mem <= "00100100";
				when "01101000011" => mem <= "00100100";
				when "01101000100" => mem <= "00100100";
				when "01101000101" => mem <= "00100100";
				when "01101000110" => mem <= "00100100";

				-- i
				when "01101001000" => mem <= "00000000";
				when "01101001001" => mem <= "00001100";
				when "01101001010" => mem <= "00001000";
				when "01101001011" => mem <= "00001000";
				when "01101001100" => mem <= "00001000";
				when "01101001101" => mem <= "00001000";
				when "01101001110" => mem <= "00110000";

				-- j
				when "01101010000" => mem <= "00000000";
				when "01101010001" => mem <= "00111100";
				when "01101010010" => mem <= "00100000";
				when "01101010011" => mem <= "00100000";
				when "01101010100" => mem <= "00100000";
				when "01101010101" => mem <= "00100000";
				when "01101010110" => mem <= "00100000";

				-- k
				when "01101011000" => mem <= "00000100";
				when "01101011001" => mem <= "00100100";
				when "01101011010" => mem <= "00010100";
				when "01101011011" => mem <= "00001100";
				when "01101011100" => mem <= "00001100";
				when "01101011101" => mem <= "00010100";
				when "01101011110" => mem <= "00100100";

				-- l
				when "01101100000" => mem <= "00001000";
				when "01101100001" => mem <= "00001000";
				when "01101100010" => mem <= "00001000";
				when "01101100011" => mem <= "00001000";
				when "01101100100" => mem <= "00001000";
				when "01101100101" => mem <= "00001000";
				when "01101100110" => mem <= "00110000";

				-- m
				when "01101101000" => mem <= "00000000";
				when "01101101001" => mem <= "00011110";
				when "01101101010" => mem <= "00101010";
				when "01101101011" => mem <= "00101010";
				when "01101101100" => mem <= "00101010";
				when "01101101101" => mem <= "00100010";
				when "01101101110" => mem <= "00100010";

				-- n
				when "01101110000" => mem <= "00000000";
				when "01101110001" => mem <= "00011100";
				when "01101110010" => mem <= "00100100";
				when "01101110011" => mem <= "00100100";
				when "01101110100" => mem <= "00100100";
				when "01101110101" => mem <= "00100100";
				when "01101110110" => mem <= "00100100";

				-- o
				when "01101111000" => mem <= "00000000";
				when "01101111001" => mem <= "00011000";
				when "01101111010" => mem <= "00100100";
				when "01101111011" => mem <= "00100100";
				when "01101111100" => mem <= "00100100";
				when "01101111101" => mem <= "00100100";
				when "01101111110" => mem <= "00011000";

				-- p
				when "01110000000" => mem <= "00000000";
				when "01110000001" => mem <= "00011100";
				when "01110000010" => mem <= "00100100";
				when "01110000011" => mem <= "00100100";
				when "01110000100" => mem <= "00100100";
				when "01110000101" => mem <= "00100100";
				when "01110000110" => mem <= "00011100";

				-- q
				when "01110001000" => mem <= "00000000";
				when "01110001001" => mem <= "00111000";
				when "01110001010" => mem <= "00100100";
				when "01110001011" => mem <= "00100100";
				when "01110001100" => mem <= "00100100";
				when "01110001101" => mem <= "00100100";
				when "01110001110" => mem <= "00111000";

				-- r
				when "01110010000" => mem <= "00000000";
				when "01110010001" => mem <= "00111100";
				when "01110010010" => mem <= "00000100";
				when "01110010011" => mem <= "00000100";
				when "01110010100" => mem <= "00000100";
				when "01110010101" => mem <= "00000100";
				when "01110010110" => mem <= "00000100";

				-- s
				when "01110011000" => mem <= "00000000";
				when "01110011001" => mem <= "00111000";
				when "01110011010" => mem <= "00000100";
				when "01110011011" => mem <= "00001000";
				when "01110011100" => mem <= "00010000";
				when "01110011101" => mem <= "00100000";
				when "01110011110" => mem <= "00011100";

				-- t
				when "01110100000" => mem <= "00001000";
				when "01110100001" => mem <= "00111100";
				when "01110100010" => mem <= "00001000";
				when "01110100011" => mem <= "00001000";
				when "01110100100" => mem <= "00001000";
				when "01110100101" => mem <= "00001000";
				when "01110100110" => mem <= "00110000";

				-- u
				when "01110101000" => mem <= "00000000";
				when "01110101001" => mem <= "00100100";
				when "01110101010" => mem <= "00100100";
				when "01110101011" => mem <= "00100100";
				when "01110101100" => mem <= "00100100";
				when "01110101101" => mem <= "00100100";
				when "01110101110" => mem <= "00111000";

				-- v
				when "01110110000" => mem <= "00000000";
				when "01110110001" => mem <= "00100010";
				when "01110110010" => mem <= "00100010";
				when "01110110011" => mem <= "00010100";
				when "01110110100" => mem <= "00010100";
				when "01110110101" => mem <= "00010100";
				when "01110110110" => mem <= "00001000";

				-- w
				when "01110111000" => mem <= "00000000";
				when "01110111001" => mem <= "00100010";
				when "01110111010" => mem <= "00101010";
				when "01110111011" => mem <= "00101010";
				when "01110111100" => mem <= "00101110";
				when "01110111101" => mem <= "00010100";
				when "01110111110" => mem <= "00010100";

				-- x
				when "01111000000" => mem <= "00000000";
				when "01111000001" => mem <= "00100010";
				when "01111000010" => mem <= "00010100";
				when "01111000011" => mem <= "00001000";
				when "01111000100" => mem <= "00001000";
				when "01111000101" => mem <= "00010100";
				when "01111000110" => mem <= "00100010";

				-- y
				when "01111001000" => mem <= "00000000";
				when "01111001001" => mem <= "00100100";
				when "01111001010" => mem <= "00100100";
				when "01111001011" => mem <= "00100100";
				when "01111001100" => mem <= "00101000";
				when "01111001101" => mem <= "00011000";
				when "01111001110" => mem <= "00010000";

				-- z
				when "01111010000" => mem <= "00000000";
				when "01111010001" => mem <= "00111100";
				when "01111010010" => mem <= "00100000";
				when "01111010011" => mem <= "00010000";
				when "01111010100" => mem <= "00001000";
				when "01111010101" => mem <= "00000100";
				when "01111010110" => mem <= "00111100";

				-- {
				when "01111011000" => mem <= "00001000";
				when "01111011001" => mem <= "00001000";
				when "01111011010" => mem <= "00001000";
				when "01111011011" => mem <= "00000100";
				when "01111011100" => mem <= "00001000";
				when "01111011101" => mem <= "00001000";
				when "01111011110" => mem <= "00001000";

				-- |
				when "01111100000" => mem <= "00010000";
				when "01111100001" => mem <= "00010000";
				when "01111100010" => mem <= "00010000";
				when "01111100011" => mem <= "00010000";
				when "01111100100" => mem <= "00010000";
				when "01111100101" => mem <= "00010000";
				when "01111100110" => mem <= "00010000";

				-- }
				when "01111101000" => mem <= "00010000";
				when "01111101001" => mem <= "00010000";
				when "01111101010" => mem <= "00010000";
				when "01111101011" => mem <= "00100000";
				when "01111101100" => mem <= "00010000";
				when "01111101101" => mem <= "00010000";
				when "01111101110" => mem <= "00010000";

				-- ~
				when "01111110000" => mem <= "00000000";
				when "01111110001" => mem <= "00000000";
				when "01111110010" => mem <= "00000000";
				when "01111110011" => mem <= "00100100";
				when "01111110100" => mem <= "00011010";
				when "01111110101" => mem <= "00000000";
				when "01111110110" => mem <= "00000000";

                when        others => mem <= "00000000";
            end case;
        end if;
    end process;

end;
