library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity segment is
    port (
        clk : in std_logic;
        data : in unsigned(7 downto 0);
        display : out unsigned(8 downto 0)
    );
end segment;

architecture synth of segment is

    type segments is array(15 downto 0) of unsigned(6 downto 0);

    signal font : segments;

    signal counter : unsigned(9 downto 0);
    signal index_low : unsigned(3 downto 0);
    signal index_hi : unsigned(3 downto 0);

begin

    font(0)  <= "0000001";
    font(1)  <= "1001111";
    font(2)  <= "0010010";
    font(3)  <= "0000110";
    font(4)  <= "1001100";
    font(5)  <= "0100100";
    font(6)  <= "0100000";
    font(7)  <= "0001111";
    font(8)  <= "0000000";
    font(9)  <= "0000100";
    font(10) <= "0001000";
    font(11) <= "1100000";
    font(12) <= "1110010";
    font(13) <= "1000010";
    font(14) <= "0110000";
    font(15) <= "0111000";

    index_low <= data(3 downto 0);
    index_hi <= data(7 downto 4);

    process (clk) begin
        if (rising_edge(clk)) then
            counter <= counter + 1;

            if (counter(9) = '0') then
                display(8) <= '0';
                display(7) <= '1';
                display(6 downto 0) <= font(to_integer(index_low));
            else
                display(8) <= '1';
                display(7) <= '0';
                display(6 downto 0) <= font(to_integer(index_hi));
            end if;
        end if;
    end process;

end;
