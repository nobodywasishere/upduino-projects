library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
        rout, gout, bout : out std_logic;
        hsync, vsync : out std_logic;
        probe : in std_logic;
        test : out std_logic
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
    signal ldi : unsigned(10 downto 0); -- logic data index
    signal ldi_int : integer;
    signal ldc_ch1, ldc_ch2, ldc_ch3 : unsigned(1 downto 0); -- logic data current
    signal w : std_logic;

    signal buff0_ch3, buff1_ch3, buff2_ch3, buff3_ch3, buff4_ch3, buff5_ch3 : unsigned(32 downto 0);
    signal counter : unsigned(31 downto 0);

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

    -- True when row/col over channel area
    bound_screen <= True WHEN (row <= 768 AND row >= 0 AND col <= 1024 AND col >= 0) ELSE False;
    bound_border <= True WHEN (bound_screen AND (row <= 10 OR row >= 758 OR col >= 1014 OR col <= 10)) ELSE False;
    bound_ch1 <= True WHEN (row <= 144 AND row >=  48 AND col <= 960 AND col >=  64) ELSE False;
    bound_ch2 <= True WHEN (row <= 288 AND row >= 192 AND col <= 960 AND col >=  64) ELSE False;
    bound_ch3 <= True WHEN (row <= 432 AND row >= 336 AND col <= 960 AND col >=  64) ELSE False;

    -- These are for the color palette along the bottom
    bound_red <= True WHEN (row >= 480 AND row <= 720 AND col >=  64 AND col <= 288) ELSE
                 True WHEN (row >= 480 AND row <= 720 AND col >= 624 AND col <= 848) ELSE False;
    bound_gre <= True WHEN (row >= 480 AND row <= 720 AND col >= 176 AND col <= 512) ELSE
                 True WHEN (row >= 480 AND row <= 720 AND col >= 736 AND col <= 848) ELSE False;
    bound_blu <= True WHEN (row >= 480 AND row <= 720 AND col >= 400 AND col <= 848) ELSE False;


    ldi <= '0' & (col(10 downto 1) - 31) WHEN (bound_screen) ELSE (others => '1');
    ldi_int <= to_integer(ldi);

    -- dont put this higher than 25 otherwise it'll stop working
    test <= counter(24);

    w <= '0' WHEN (NOT bound_screen) ELSE
        '1' WHEN (bound_border) ELSE
        -- Channel 1
        '1' WHEN (ldc_ch1(1) /= ldc_ch1(0) AND bound_ch1) ELSE
        '1' WHEN (ldc_ch1(0) = '1' AND row <=  50 AND bound_ch1) ELSE
        '1' WHEN (ldc_ch1(0) = '0' AND row >= 142 AND bound_ch1) ELSE
        -- Channel 2
        '1' WHEN (ldc_ch2(1) /= ldc_ch2(0) AND bound_ch2) ELSE
        '1' WHEN (ldc_ch2(0) = '1' AND row <= 194 AND bound_ch2) ELSE
        '1' WHEN (ldc_ch2(0) = '0' AND row >= 286 AND bound_ch2) ELSE
        -- Channel 3
        '1' WHEN (ldc_ch3(1) /= ldc_ch3(0) AND bound_ch3) ELSE
        '1' WHEN (ldc_ch3(0) = '1' AND row <= 338 AND bound_ch3) ELSE
        '1' WHEN (ldc_ch3(0) = '0' AND row >= 430 AND bound_ch3) ELSE '0';


    process (clk_pxl) begin
        if (rising_edge(clk_pxl)) then
            counter <= counter + 1;
        end if;
    end process;

    process (counter(1)) begin
        if (rising_edge(counter(1))) then

            ldc_ch1(1) <= ldc_ch1(0);
            ldc_ch1(0) <= ldi(6);

            ldc_ch2(1) <= ldc_ch2(0);
            ldc_ch2(0) <= counter(25);

            -- ldc_ch3(1) <= ldc_ch3(0);
            -- ldc_ch3(0) <= probe;

            if (ldi_int <= 5) then
                ldc_ch3 <= buff0_ch3(ldi_int downto ldi_int-1);
            elsif (ldi_int <= 10) then
                ldc_ch3 <= buff1_ch3(ldi_int downto ldi_int-1);
            elsif (ldi_int <= 15) then
                ldc_ch3 <= buff2_ch3(ldi_int downto ldi_int-1);
            elsif (ldi_int <= 20) then
                ldc_ch3 <= buff3_ch3(ldi_int downto ldi_int-1);
            elsif (ldi_int <= 25) then
                ldc_ch3 <= buff4_ch3(ldi_int downto ldi_int-1);
            elsif (ldi_int <= 30) then
                ldc_ch3 <= buff5_ch3(ldi_int downto ldi_int-1);
            else
                ldc_ch3 <= "00";
            end if;

            -- ldc_ch3 <=  buff1_ch3(ldi downto ldi - 1) WHEN (ldi <  6) ELSE
            --             buff2_ch3(ldi downto ldi - 1) WHEN (ldi < 11) ELSE "00";
        end if;
    end process;

    -- Going lower than 19 introduces a lot of glitching and going higher than 19 is less useful
    process (counter(19)) begin
        if (rising_edge(counter(19))) then
            -- Don't use more than 6 buffers otherwise it'll break
            buff5_ch3(31 downto 1) <= buff5_ch3(30 downto 0);
            buff5_ch3(0) <= buff4_ch3(31);
            buff4_ch3(31 downto 1) <= buff4_ch3(30 downto 0);
            buff4_ch3(0) <= buff3_ch3(31);
            buff3_ch3(31 downto 1) <= buff3_ch3(30 downto 0);
            buff3_ch3(0) <= buff2_ch3(31);
            buff2_ch3(31 downto 1) <= buff2_ch3(30 downto 0);
            buff2_ch3(0) <= buff1_ch3(31);
            buff1_ch3(31 downto 1) <= buff1_ch3(30 downto 0);
            buff1_ch3(0) <= buff0_ch3(31);
            buff0_ch3(31 downto 1) <= buff0_ch3(30 downto 0);
            buff0_ch3(0) <= probe;
        end if;
    end process;

    red <= '1' WHEN (w = '1' OR bound_red) ELSE '0';
    gre <= '1' WHEN (w = '1' OR bound_gre) ELSE '0';
    blu <= '1' WHEN (w = '1' OR bound_blu) ELSE '0';

end;
