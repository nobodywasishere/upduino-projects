--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spi_slave is
	port(
        clk : in std_logic,
		SCK : in std_logic,
        MOSI : in std_logic,
        MISO : out std_logic,
        SSEL : in std_logic
	);
end spi_slave;

architecture synth of spi_slave is

begin

end;
