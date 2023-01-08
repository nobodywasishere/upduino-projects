library IEEE;
use IEEE.std_logic_1164.all;

entity top is
	port(
		A, B : in std_logic_vector (15 downto 0);
		Ci : in std_logic;
		S : out std_logic_vector (15 downto 0);
		Co : out std_logic
	);
end top;

architecture rtl of top is

	component rc4 is
		port(
        		A,  B : in std_logic_vector (3 downto 0);
        		Ci, T : in std_logic;
        		S     : out std_logic_vector (3 downto 0);
        		Co, Z, V : out std_logic
		);
	end component;

	signal C0, C1, C2 : std_logic; -- intermediate carry signals
begin
	rc40 : rc4 port map (
		A => A(3 downto 0),
		B => B(3 downto 0),
		Ci => Ci,
		T => '0',
		S => S(3 downto 0),
		Co => C0
	);

	rc41 : rc4 port map (
		A => A(7 downto 4),
		B => B(7 downto 4),
		Ci => C0,
		T => '0',
		S => S(7 downto 4),
		Co => C1
	);

	rc42 : rc4 port map (
		A => A(11 downto 8),
		B => B(11 downto 8),
		Ci => C1,
		T => '0',
		S => S(11 downto 8),
		Co => C2
	);

	rc43 : rc4 port map (
		A => A(15 downto 12),
		B => B(15 downto 12),
		Ci => C2,
		T => '0',
		S => S(15 downto 12),
		Co => Co
	);

end rtl;

----

library IEEE;
use IEEE.std_logic_1164.all;

entity rc4 is
    port(
        A,  B : in std_logic_vector (3 downto 0);
        Ci, T : in std_logic;
        S     : out std_logic_vector (3 downto 0);
        Co, Z, V : out std_logic
    );
end rc4;

architecture rtl of rc4 is

    component fulladder is
    	port (
    		A, B, Ci : in std_logic;
    		S, Co : out std_logic
    	);
    end component;

    signal Sb, BTb : std_logic_vector (3 downto 0); -- intermediate output and 2nd operand
    signal C0, C1, C2, C3, Cti : std_logic; -- intermediate carry signals

begin

    fa0 : fulladder port map (
        A => A(0),
        B => BTb(0),
        Ci => Cti,
        Co => C0,
        S => Sb(0)
    );

    fa1 : fulladder port map (
        A => A(1),
        B => BTb(1),
        Ci => C0,
        Co => C1,
        S => Sb(1)
    );

    fa2 : fulladder port map (
        A => A(2),
        B => BTb(2),
        Ci => C1,
        Co => C2,
        S => Sb(2)
    );

    fa3 : fulladder port map (
        A => A(3),
        B => BTb(3),
        Ci => C2,
        Co => C3,
        S => Sb(3)
    );

    Cti <= T xor Ci;

    BTb <= B xor (T & T & T & T);

    S <= Sb;

    Co <= C3;

    V <= C3 xor C2;

    Z <= not ( Sb(0) or Sb(1) or Sb(2) or Sb(3) );

end rtl;

----

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
	port (
		A, B, Ci : in std_logic;
		S, Co : out std_logic
	);
end fulladder;

architecture rtl of fulladder is
begin
	S <= A xor B xor Ci;
	Co <= ( A and B ) or ( A and Ci ) or ( B and Ci );
end rtl;
