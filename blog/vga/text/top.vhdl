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
            text_addr : out unsigned(12 downto 0)
        );
    end component;

    component TEXT_BUFFER is
        port (
            Clk : in std_logic;
            RADDR : in unsigned(12 downto 0);
            RDATA : out unsigned(6 downto 0)
        );
    end component;

    component FONT is
        port (
            ASCII : in unsigned(6 downto 0);
            R, G, B : out std_logic
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
    signal text_addr : unsigned(12 downto 0);
    signal text_data : unsigned(6 downto 0);
    signal s_row, s_col : unsigned(9 downto 0);
    signal R, G, B : std_logic;

begin

	Clk1 : HSOSC port map (ClkHF => Clk);

    butler1 : BUTLER
        port map (
            s_row => s_row,
            s_col => s_col,
            text_addr => text_addr
        );

    color_buffer1 : TEXT_BUFFER
        port map (
            Clk => Clk,
            RADDR => text_addr,
            RDATA => text_data
        );

    font1 : FONT
        port map (
            ASCII => text_data,
            R => R, G => G, B => B
        );

    vga1 : VGA
        port map (
            r_in => R, b_in => B, g_in => G, Clk => Clk,
            HSYNC => HSYNC, VSYNC => VSYNC,
            r_out => r_out, g_out => g_out, b_out => b_out,
            s_row => s_row, s_col => s_col
        );

end;
