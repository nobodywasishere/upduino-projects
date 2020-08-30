library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
        rout, gout, bout : out std_logic;
        hsync, vsync : out std_logic
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

    component ascii is
    	port(
            clk : in std_logic;
            char : in unsigned(7 downto 0);
            row : in unsigned(2 downto 0);
            col : in unsigned(2 downto 0);
            lum : out std_logic
    	);
    end component;

    component text_buffer is
    	port(
            clk : in std_logic;
            row : in unsigned(5 downto 0);
            col : in unsigned(5 downto 0);
            char : out unsigned(7 downto 0)
    	);
    end component;

    signal clk_48, clk_pxl : std_logic;
    signal row, col : unsigned(10 downto 0);
    signal red, gre, blu : std_logic;

    signal bound_ch1, bound_ch2, bound_ch3, bound_screen, bound_border : boolean;
    signal bound_red, bound_gre, bound_blu : boolean;
    signal w : std_logic;

    constant screen_h : integer := 1024;
    constant screen_v : integer := 768;
    constant border_size : integer := 8;

    signal bound_A, bound_B, bound_C : boolean;
    signal char : unsigned(7 downto 0);
    signal char_row : unsigned(2 downto 0);
    signal char_col : unsigned(2 downto 0);
    signal char_lum : std_logic := '0';
    signal char_h, char_v : unsigned(10 downto 0);
    signal char_size : integer := 16;
    signal txt_row, txt_col : unsigned(5 downto 0);

begin

    dut1 : SB_HFOSC port map (CLKHF => clk_48);
    dut2 : vga port map (
        clk_48 => clk_48,
        clk_pxl => clk_pxl,
        rin => red, gin => gre, bin => blu,
        row => row, col => col,
        rout => rout, gout => gout, bout => bout,
        hsync => hsync, vsync => vsync
    );
    dut3 : ascii port map (
        clk => clk_pxl,
        char => char,
        row => char_row,
        col => char_col,
        lum => char_lum
    );
    dut4 : text_buffer port map (
        clk => clk_pxl,
        char => char,
        row => txt_row,
        col => txt_col
    );

    char_v <= "00010000000";
    char_h <= "00011000000";

    txt_row <= row(9 downto 4) - char_v(10 downto 5);
    txt_col <= col(9 downto 4) - char_h(10 downto 5);

    -- char <= "01000001" WHEN (bound_A) ELSE
    --         "01000010" WHEN (bound_B) ELSE
    --         "01000011" WHEN (bound_C) ELSE "00000000";
    char_row <= row(3 downto 1);
    char_col <= col(3 downto 1);

    bound_screen <= (row <= screen_v AND row >= 0 AND col <= screen_h AND col >= 0);
    -- bound_border <= bound_screen AND
    --     (row >= screen_v - border_size OR row <= border_size OR
    --      col >= screen_h - border_size OR col <= border_size);

    -- bound_A <= bound_screen AND
    --     (row >= char_v AND row < char_v + char_size AND
    --      col >= char_h AND col < char_h + char_size);
    -- bound_B <= bound_screen AND
    --     (row >= char_v AND row < char_v + char_size AND
    --      col >= char_h +     char_size AND col < char_h + 2 * char_size);
    -- bound_C <= bound_screen AND
    --     (row >= char_v AND row < char_v + char_size AND
    --      col >= char_h + 2 * char_size AND col < char_h + 3 * char_size);

    -- bound_red <= (row >= 320 AND row <= 720 AND col >=  64 AND col <= 288) OR
    --              (row >= 320 AND row <= 720 AND col >= 624 AND col <= 848);
    -- bound_gre <= (row >= 320 AND row <= 720 AND col >= 176 AND col <= 512) OR
    --              (row >= 320 AND row <= 720 AND col >= 736 AND col <= 848);
    -- bound_blu <= (row >= 320 AND row <= 720 AND col >= 400 AND col <= 848);

    w <= '1' WHEN (bound_border) ELSE
         '1' WHEN (char_lum = '1') ELSE '0';

    -- red <= '1' WHEN (w = '1' OR bound_red) ELSE '0';
    -- gre <= '1' WHEN (w = '1' OR bound_gre) ELSE '0';
    -- blu <= '1' WHEN (w = '1' OR bound_blu) ELSE '0';
    red <= w;
    gre <= w;
    blu <= w;

end;
