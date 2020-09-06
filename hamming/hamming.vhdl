library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_set is
	port(
		data_in : in unsigned(3 downto 0);
        data_out : out unsigned(7 downto 0)
	);
end hamming_set;

architecture synth of hamming_set is

    signal parity : unsigned(2 downto 0);

begin

    -- find parity bits
    parity(0) <= (data_in(0) XOR data_in(1)) XOR data_in(3);
    parity(1) <= (data_in(0) XOR data_in(2)) XOR data_in(3);
    parity(2) <= (data_in(1) XOR data_in(2)) XOR data_in(3);

    -- find parity for all
    data_out(0) <= (parity(0) XOR parity(1) XOR parity(2) XOR data_in(0) XOR data_in(1) XOR data_in(2) XOR data_in(3));

    -- set output bits
    data_out(7 downto 1) <= (data_in(3), data_in(2), parity(2), data_in(1), parity(1), data_in(0), parity(0));

end;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_detect is
	port(
		data_in : in unsigned(7 downto 0);
        error_location : out unsigned(2 downto 0);
        error_double : out std_logic
	);
end hamming_detect;

architecture synth of hamming_detect is

    signal parity : unsigned(2 downto 0);
    signal error_location_local : unsigned(2 downto 0);
    signal error_found, error_double_local : std_logic;

begin

    -- check parity for each parity bit
    error_location_local(0) <= data_in(1) XOR data_in(3) XOR data_in(5) XOR data_in(7);
    error_location_local(1) <= data_in(2) XOR data_in(3) XOR data_in(6) XOR data_in(7);
    error_location_local(2) <= data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7);

    -- flag if error found
    error_found <= '1' WHEN (error_location_local /= "000") ELSE '0';

    -- set double if there was an error but total still passes parity
    error_double_local <= (error_found) AND NOT (data_in(0) XOR data_in(1) XOR data_in(2) XOR data_in(3) XOR data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7));
    error_double <= error_double_local;

    -- only show error location when not a double error (as it'd be useless)
    error_location <= error_location_local WHEN (error_double_local = '0') ELSE "000";

end;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_correct is
	port(
		data_in : in unsigned(7 downto 0);
        error_location : in unsigned(2 downto 0);
        data_out : out unsigned(3 downto 0)
	);
end hamming_correct;

architecture synth of hamming_correct is

    signal parity : unsigned(2 downto 0);

begin

    data_out(0) <= data_in(3) XOR (    error_location(0) AND     error_location(1) AND NOT error_location(2));
    data_out(1) <= data_in(5) XOR (    error_location(0) AND NOT error_location(1) AND     error_location(2));
    data_out(2) <= data_in(6) XOR (NOT error_location(0) AND     error_location(1) AND     error_location(2));
    data_out(3) <= data_in(7) XOR (    error_location(0) AND     error_location(1) AND     error_location(2));

end;
