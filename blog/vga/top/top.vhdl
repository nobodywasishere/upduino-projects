library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
    port (
        Clk : in std_logic;
        row, col : out unsigned(10 downto 0);
        HSYNC, VSYNC : out std_logic
    );
end top;

architecture synth of top is

    signal H_A, H_F, H_S, H_B, H_T : integer := 0;
    signal V_A, V_F, V_S, V_B, V_T : integer := 0;

    signal vert, hori : unsigned(10 downto 0);

begin

    -- 49.5 MHz / 800x600
    H_A <= 800;
    H_F <= 16;
    H_S <= 80;
    H_B <= 160;
    H_T <= H_A + H_F + H_S + H_B;
    V_A <= 600;
    V_F <= 1;
    V_S <= 3;
    V_B <= 21;
    V_T <= V_A + V_F + V_S + V_B;

    process (Clk) begin
        if (rising_edge(Clk)) then

            if (hori < H_T - 1) then
                hori <= hori + 1;
            else
                hori <= (others => '0');

                if (vert < V_T - 1) then
                    vert <= vert + 1;
                else
                    vert <= (others => '0');
                end if;
            end if;

            if (hori >= (H_A + H_F) and hori <= (H_A + H_F + H_S)) then
                hsync <= '0';
            else
                hsync <= '1';
            end if;

            if (vert >= (V_A + V_F) and vert <= (V_A + V_F + V_S)) then
                vsync <= '0';
            else
                vsync <= '1';
            end if;

            row <= vert;
            col <= hori;
        end if;
    end process;

end;
