library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity vga is
	port(
		clk_48 : in std_logic;
        clk_pxl : out std_logic;
        rin, gin, bin : in std_logic;
        row, col : out unsigned(10 downto 0);
        rout, gout, bout : out std_logic;
        hsync, vsync : out std_logic
	);
end vga;

architecture synth of vga is

    component pll is
        port (
            clk_in : in std_logic;
            clk_out : out std_logic;
            clk_locked : out std_logic
        );
    end component;

    signal clk_pxl_local, clk_locked : std_logic;

    -- *_A active signal
    -- *_F front porch
    -- *_S sync pulse
    -- *_B back porch
    -- *_T total
    signal H_A, H_F, H_S, H_B, H_T : integer := 0;
    signal V_A, V_F, V_S, V_B, V_T : integer := 0;

    signal vert, hori : integer;

begin

    dut2 : pll port map (
        clk_in => clk_48,
        clk_out => clk_pxl_local,
        clk_locked => clk_locked
    );

    clk_pxl <= clk_pxl_local;

    -- Uncomment one of these to choose a resolution
    -- Make sure the PLL has the matching clk speed

    -- 25.125 MHz / 480p
    -- H_A <= 640;
    -- H_F <= 16;
    -- H_S <= 96;
    -- H_B <= 48;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 480;
    -- V_F <= 10;
    -- V_S <= 2;
    -- V_B <= 33;
    -- V_T <= V_A + V_F + V_S + V_B;

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

    -- -- 65 MHz / 1024x768
    -- H_A <= 1024;
    -- H_F <= 24;
    -- H_S <= 136;
    -- H_B <= 160;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 768;
    -- V_F <= 3;
    -- V_S <= 6;
    -- V_B <= 29;
    -- V_T <= V_A + V_F + V_S + V_B;

    -- 74.25 MHz / 720p Doesn't work
    -- H_A <= 1280;
    -- H_F <= 110;
    -- H_S <= 40;
    -- H_B <= 220;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 720;
    -- V_F <= 5;
    -- V_S <= 5;
    -- V_B <= 20;
    -- V_T <= V_A + V_F + V_S + V_B;

    -- 86 MHz / 1368x768 Doesn't work
    -- H_A <= 1368;
    -- H_F <= 72;
    -- H_S <= 144;
    -- H_B <= 216;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 768;
    -- V_F <= 1;
    -- V_S <= 3;
    -- V_B <= 23;
    -- V_T <= V_A + V_F + V_S + V_B;

    -- 148.5 MHz / 1080p Doesn't work
    -- H_A <= 1920;
    -- H_F <= 88;
    -- H_S <= 44;
    -- H_B <= 148;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 1080;
    -- V_F <= 4;
    -- V_S <= 5;
    -- V_B <= 36;
    -- V_T <= V_A + V_F + V_S + V_B;

    -- 1280x1024
    -- H_A <= 1280;
    -- H_F <= 88;--1368-1280;
    -- H_S <= 128;
    -- H_B <= 216;
    -- H_T <= H_A + H_F + H_S + H_B;
    -- V_A <= 1024;
    -- V_F <= 3;
    -- V_S <= 7;
    -- V_B <= 11;
    -- V_T <= V_A + V_F + V_S + V_B;

    -- hsync <= '0' WHEN (hori >= (H_A + H_F) and hori <= (H_A + H_F + H_S)) ELSE '1';
    -- vsync <= '0' WHEN (vert >= (V_A + V_F) and vert <= (V_A + V_F + V_S)) ELSE '1';

    process (clk_pxl_local) begin
        if (rising_edge(clk_pxl_local)) then

            if (hori < H_T - 1) then
                hori <= hori + 1;
            else
                hori <= 0;

                if (vert < V_T - 1) then
                    vert <= vert + 1;
                else
                    vert <= 0;
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

            row <= to_unsigned(vert,11);
            col <= to_unsigned(hori,11);
        end if;

		if (falling_edge(clk_pxl_local)) then
			rout <= rin;
			gout <= gin;
			bout <= bin;
		end if;
    end process;
end;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pll is
    port (
        clk_in : in std_logic;
        clk_out : out std_logic;
        clk_locked : out std_logic
    );
end pll;

architecture synth of pll is

    component SB_PLL40_CORE is
        generic (

            -- Uncomment one of these to choose a resolution
            -- Make sure the VGA has the matching clk speed

            -- 48 MHz > 25.125 MHz / 480p
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0011";
            -- DIVF : unsigned(6 downto 0) := "1000010";
            -- DIVQ : unsigned(2 downto 0) := "101";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 48 MHz > 65 MHz / 1024x768
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0010";
            -- DIVF : unsigned(6 downto 0) := "1000000";
            -- DIVQ : unsigned(2 downto 0) := "100";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 48 MHz > 74 MHz / 720p Doesn't work
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0010";
            -- DIVF : unsigned(6 downto 0) := "0100100";
            -- DIVQ : unsigned(2 downto 0) := "011";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 48 MHz > 86 MHz / 1368x768 Doesn't work
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0010";
            -- DIVF : unsigned(6 downto 0) := "0101010";
            -- DIVQ : unsigned(2 downto 0) := "011";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 36 MHz > 65.25 MHz / 1024x768
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0000";
            -- DIVF : unsigned(6 downto 0) := "0011100";
            -- DIVQ : unsigned(2 downto 0) := "100";
            -- FILTER_RANGE : unsigned(2 downto 0) := "011"

            -- 36 MHz > 74.25 MHz / 720p
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0001";
            -- DIVF : unsigned(6 downto 0) := "0100000";
            -- DIVQ : unsigned(2 downto 0) := "011";
            -- FILTER_RANGE : unsigned(2 downto 0) := "010"

            -- 36 MHz > 148.5 MHz / 1080p
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0001";
            -- DIVF : unsigned(6 downto 0) := "0100000";
            -- DIVQ : unsigned(2 downto 0) := "010";
            -- FILTER_RANGE : unsigned(2 downto 0) := "010"

            -- 36 > 109 MHz / 1280x1024 / Black screen doesn't work
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0010";
            -- DIVF : unsigned(6 downto 0) := "1001000";
            -- DIVQ : unsigned(2 downto 0) := "011";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 12 MHz > 25.125 MHz / 640x480
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0000";
            -- DIVF : unsigned(6 downto 0) := "1000010";
            -- DIVQ : unsigned(2 downto 0) := "101";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- 12 MHz > 49.5 MHz / 800x600
            FEEDBACK_PATH : String := "SIMPLE";
            DIVR : unsigned(3 downto 0) := "0000";
            DIVF : unsigned(6 downto 0) := "1000001";
            DIVQ : unsigned(2 downto 0) := "100";
            FILTER_RANGE : unsigned(2 downto 0) := "001"

            -- -- 12 MHz > 65 MHz / 1024x768
            -- FEEDBACK_PATH : String := "SIMPLE";
            -- DIVR : unsigned(3 downto 0) := "0000";
            -- DIVF : unsigned(6 downto 0) := "1010110";
            -- DIVQ : unsigned(2 downto 0) := "100";
            -- FILTER_RANGE : unsigned(2 downto 0) := "001"

        );
        port (
            LOCK : out std_logic;
            RESETB : in std_logic;
            BYPASS : in std_logic;
            REFERENCECLK : in std_logic;
            PLLOUTGLOBAL : out std_logic
        );
    end component;

begin

    dut1 : SB_PLL40_CORE port map (
        LOCK => clk_locked,
        RESETB => '1',
        BYPASS => '0',
        REFERENCECLK => clk_in,
        PLLOUTGLOBAL => clk_out
    );

end;
