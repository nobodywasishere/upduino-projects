library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
    port (
        HSYNC, VSYNC, r_out, b_out, g_out : out std_logic
    );
end top;

architecture synth of top is

    component HSOSC is
        port (
            ClkHF : out std_logic
        );
    end component;

    component BUTLER is
        port (
            s_row : in unsigned(9 downto 0);
            s_col : in unsigned(9 downto 0);
            frame_addr : out unsigned(12 downto 0);
            frame_en : out std_logic;
            color_addr : out unsigned(12 downto 0);
            color_en : out std_logic
        );
    end component;

    component FRAME_BUFFER is
        port (
            Clk : in std_logic;
            RADDR : in unsigned(12 downto 0);
            RE : in std_logic;
            RDATA : out unsigned(7 downto 0)
        );
    end component;

    component COLOR_BUFFER is
        port (
            Clk : in std_logic;
            RADDR : in unsigned(12 downto 0);
            RE : in std_logic;
            RDATA : out unsigned(7 downto 0)
        );
    end component;

    component INFUZER is
        port (
            Clk : in std_logic;
            frame_data : in unsigned(7 downto 0);
            color_data : in unsigned(7 downto 0);
            R : out std_logic;
            G : out std_logic;
            B : out std_logic;
            s_col : in unsigned(9 downto 0)
        );
    end component;

    component VGA is
        port (
            r_in, g_in, b_in, Clk : in std_logic;
            HSYNC, VSYNC, r_out, b_out, g_out : out std_logic;
            s_row, s_col : out unsigned(9 downto 0)
        );
    end component;

    signal Clk : std_logic;
    signal frame_addr, color_addr : unsigned(12 downto 0);
    signal frame_en, color_en : std_logic;
    signal s_row, s_col : unsigned(9 downto 0);
    signal frame_data, color_data : unsigned(7 downto 0);
    signal R, G, B : std_logic;

begin

	Clk1 : HSOSC port map (ClkHF => Clk);

    butler1 : BUTLER
        port map (
            s_row => s_row,
            s_col => s_col,
            frame_addr => frame_addr,
            frame_en  => frame_en,
            color_addr => color_addr,
            color_en  => color_en
        );

    frame_buffer1 : FRAME_BUFFER
        port map (
            Clk => Clk,
            RADDR => frame_addr,
            RE => frame_en,
            RDATA => frame_data
        );

    color_buffer1 : COLOR_BUFFER
        port map (
            Clk => Clk,
            RADDR => color_addr,
            RE => color_en,
            RDATA => color_data
        );

    infuze1 : INFUZER
        port map (
            Clk => Clk,
            frame_data => frame_data,
            color_data => color_data,
            R => R, G => G, B => B,
            s_col => s_col
        );

    vga1 : VGA
        port map (
            r_in => R, b_in => B, g_in => G, Clk => Clk,
            HSYNC => HSYNC, VSYNC => VSYNC,
            r_out => r_out, g_out => g_out, b_out => b_out,
            s_row => s_row, s_col => s_col
        );

end;
