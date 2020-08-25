library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
        rout, gout, bout : out std_logic;
        hsync, vsync : out std_logic;
        clk_ext : in std_logic
	);
end top;

architecture synth of top is

    component SB_HFOSC is
        generic (
            CLKHF_DIV : String := "0b00"
        );
        port (
            CLKHFPU : in std_logic := '1';
            CLKHFEN : in std_logic := '1';
            CLKHF : out std_logic
        );
    end component;

    component vga is
        port(
            clk_48 : in std_logic;
            clk_pxl : out std_logic;
            rin, gin, bin : in std_logic;
            row, col : out unsigned(10 downto 0);
            rout, gout, bout : out std_logic;
            hsync, vsync : out std_logic
        );
    end component;

    signal clk_48, clk_pxl : std_logic;
    signal row, col : unsigned(10 downto 0);
    signal red, gre, blu : std_logic;

    signal bound_ch1, bound_ch2, bound_ch3, bound_screen, bound_border : boolean;
    signal bound_red, bound_gre, bound_blu : boolean;
    signal w : std_logic;

    constant screen_h : integer := 800;
    constant screen_v : integer := 600;
    constant border_size : integer := 10;

begin

    dut1 : SB_HFOSC port map (CLKHF => clk_48);
    dut2 : vga port map (
        clk_48 => clk_ext,
        clk_pxl => clk_pxl,
        rin => red, gin => gre, bin => blu,
        row => row, col => col,
        rout => rout, gout => gout, bout => bout,
        hsync => hsync, vsync => vsync
    );

    bound_screen <= (row <= screen_v AND row >= 0 AND col <= screen_h AND col >= 0);
    bound_border <= bound_screen AND
        (row >= screen_v - border_size OR row <= border_size OR
         col >= screen_h - border_size OR col <= border_size);

    bound_red <= (row >= 48 AND row <= 720 AND col >=  64 AND col <= 288) OR
                 (row >= 48 AND row <= 720 AND col >= 624 AND col <= 848);
    bound_gre <= (row >= 48 AND row <= 720 AND col >= 176 AND col <= 512) OR
                 (row >= 48 AND row <= 720 AND col >= 736 AND col <= 848);
    bound_blu <= (row >= 48 AND row <= 720 AND col >= 400 AND col <= 848);

    red <= '1' WHEN (bound_border or (bound_red and bound_screen)) ELSE '0';
    gre <= '1' WHEN (bound_border or (bound_gre and bound_screen)) ELSE '0';
    blu <= '1' WHEN (bound_border or (bound_blu and bound_screen)) ELSE '0';

end;
