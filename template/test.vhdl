library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test is
    port (
        test_port : out std_logic
    );
end test;

architecture synth of test is

begin
    test_port <= '1';
end;
