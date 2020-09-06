library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_set is
	port(
		data_in : in unsigned(10 downto 0);
        data_out : out unsigned(15 downto 0)
	);
end hamming_set;

architecture synth of hamming_set is

    signal parity : unsigned(3 downto 0);

begin

    -- find parity bits
    parity(0) <= data_in(0) XOR data_in(1) XOR data_in(3) XOR data_in(4) XOR data_in(6) XOR data_in(8) XOR data_in(10);
    parity(1) <= data_in(0) XOR data_in(2) XOR data_in(3) XOR data_in(5) XOR data_in(6) XOR data_in(9) XOR data_in(10);
    parity(2) <= data_in(1) XOR data_in(2) XOR data_in(3) XOR data_in(7) XOR data_in(8) XOR data_in(9) XOR data_in(10);
    parity(3) <= data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7) XOR data_in(8) XOR data_in(9) XOR data_in(10);

    -- find parity for all
    data_out(0) <=  parity(0) XOR  parity(1) XOR  parity(2) XOR  parity(3) XOR data_in(1) XOR data_in(2) XOR data_in(3) XOR
                   data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7) XOR data_in(8) XOR data_in(9) XOR data_in(10);

    -- set output bits
    data_out(15 downto 1) <= (data_in(10), data_in(9), data_in(8), data_in(7), data_in(6), data_in(5), data_in(4), parity(3),
                              data_in( 3), data_in(2), data_in(1),  parity(2), data_in(0),  parity(1),  parity(0));

end;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_detect is
	port(
		data_in : in unsigned(15 downto 0);
        error_location : out unsigned(3 downto 0);
        error_double : out std_logic
	);
end hamming_detect;

architecture synth of hamming_detect is

    signal parity : unsigned(3 downto 0);
    signal error_location_local : unsigned(3 downto 0);
    signal error_found, error_double_local : std_logic;

begin

    -- check parity for each parity bit
    error_location_local(0) <= data_in(1) XOR data_in(3) XOR data_in( 5) XOR data_in( 7) XOR data_in( 9) XOR data_in(11) XOR data_in(13) XOR data_in(15);
    error_location_local(1) <= data_in(2) XOR data_in(3) XOR data_in( 6) XOR data_in( 7) XOR data_in(10) XOR data_in(11) XOR data_in(14) XOR data_in(15);
    error_location_local(2) <= data_in(4) XOR data_in(5) XOR data_in( 6) XOR data_in( 7) XOR data_in(12) XOR data_in(13) XOR data_in(14) XOR data_in(15);
    error_location_local(3) <= data_in(8) XOR data_in(9) XOR data_in(10) XOR data_in(11) XOR data_in(12) XOR data_in(13) XOR data_in(14) XOR data_in(15);

    -- flag if error found
    error_found <= '1' WHEN (error_location_local /= "0000") ELSE '0';

    -- set double if there was an error but total still passes parity
    error_double_local <= (error_found) AND NOT (data_in(0) XOR data_in(1) XOR data_in( 2) XOR data_in( 3) XOR data_in( 4) XOR data_in( 5) XOR data_in( 6) XOR data_in( 7) XOR
                                                 data_in(8) XOR data_in(9) XOR data_in(10) XOR data_in(11) XOR data_in(12) XOR data_in(13) XOR data_in(14) XOR data_in(15));

    error_double <= error_double_local;

    -- only show error location when not a double error (as it'd be useless)
    error_location <= error_location_local WHEN (error_double_local = '0') ELSE "0000";

end;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hamming_correct is
	port(
		data_in : in unsigned(15 downto 0);
        error_location : in unsigned(3 downto 0);
        data_out : out unsigned(10 downto 0)
	);
end hamming_correct;

architecture synth of hamming_correct is

    signal parity : unsigned(2 downto 0);

begin

    data_out( 0) <= data_in( 3) XOR ( NOT error_location(3) AND NOT error_location(2) AND     error_location(1) AND     error_location(0)); -- 0011
    data_out( 1) <= data_in( 5) XOR ( NOT error_location(3) AND     error_location(2) AND NOT error_location(1) AND     error_location(0)); -- 0101
    data_out( 2) <= data_in( 6) XOR ( NOT error_location(3) AND     error_location(2) AND     error_location(1) AND NOT error_location(0)); -- 0110
    data_out( 3) <= data_in( 7) XOR ( NOT error_location(3) AND     error_location(2) AND     error_location(1) AND     error_location(0)); -- 0111
    data_out( 4) <= data_in( 9) XOR (     error_location(3) AND NOT error_location(2) AND NOT error_location(1) AND     error_location(0)); -- 1001
    data_out( 5) <= data_in(10) XOR (     error_location(3) AND NOT error_location(2) AND     error_location(1) AND NOT error_location(0)); -- 1010
    data_out( 6) <= data_in(11) XOR (     error_location(3) AND NOT error_location(2) AND     error_location(1) AND     error_location(0)); -- 1011
    data_out( 7) <= data_in(12) XOR (     error_location(3) AND     error_location(2) AND NOT error_location(1) AND NOT error_location(0)); -- 1100
    data_out( 8) <= data_in(13) XOR (     error_location(3) AND     error_location(2) AND NOT error_location(1) AND     error_location(0)); -- 1101
    data_out( 9) <= data_in(14) XOR (     error_location(3) AND     error_location(2) AND     error_location(1) AND NOT error_location(0)); -- 1110
    data_out(10) <= data_in(15) XOR (     error_location(3) AND     error_location(2) AND     error_location(1) AND     error_location(0)); -- 1111

end;
