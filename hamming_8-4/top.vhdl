library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port (
        gpio_9  : out std_logic;
        gpio_6  : out std_logic;
        gpio_44 : out std_logic;
        gpio_4  : out std_logic;
        gpio_45 : out std_logic;
        gpio_47 : out std_logic;
        gpio_46 : out std_logic;
        gpio_2  : out std_logic;
        gpio_31 :  in std_logic;
        gpio_37 :  in std_logic;
        gpio_34 :  in std_logic;
        gpio_43 :  in std_logic;
        gpio_36 :  in std_logic;
        gpio_42 :  in std_logic;
        gpio_38 :  in std_logic;
        gpio_28 :  in std_logic
    );
end top;

architecture synth of top is

    component hamming_set is
        port(
    		data_in : in unsigned(3 downto 0);
            data_out : out unsigned(7 downto 0)
    	);
    end component;

    component hamming_detect is
        port(
    		data_in : in unsigned(7 downto 0);
            error_location : out unsigned(2 downto 0);
            error_double : out std_logic
    	);
    end component;

    component hamming_correct is
        port(
            data_in : in unsigned(7 downto 0);
            error_location : in unsigned(2 downto 0);
            data_out : out unsigned(3 downto 0)
        );
    end component;

    signal leds : unsigned(7 downto 0) := "00000000";
    signal data_in : unsigned(7 downto 0);

begin

    -- set1 : hamming_set
    --     port map (
    --         data_in => data_in(3 downto 0),
    --         data_out => leds
    --     );

    -- detect1 : hamming_detect
    --     port map (
    --         data_in => data_in,
    --         error_location => leds(2 downto 0),
    --         error_double => leds(4)
    --     );

    correct1 : hamming_correct
        port map (
            data_in => "01001111",
            error_location => "110",
            data_out => leds(3 downto 0)
        );

    (gpio_2, gpio_46, gpio_47, gpio_45, gpio_4, gpio_44, gpio_6, gpio_9) <= leds(7 downto 0);

    data_in <= NOT (gpio_28, gpio_38, gpio_42, gpio_36, gpio_43, gpio_34, gpio_37, gpio_31);

end;
