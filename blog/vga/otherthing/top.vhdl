library IEEE;
use IEEE.std_logic_1164.all;

entity top is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(7 downto 0)
  );
end top;

architecture synth of top is
begin
  process (clk, reset)
  begin
    if (reset = '1') then
        count <= "00000001";
    elsif (rising_edge(clk)) then
        count <= count(6 downto 0) & count(7);
    end if;
  end process;
end;
