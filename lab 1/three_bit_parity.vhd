library ieee;
use ieee.std_logic_1164.all;

entity three_bit_parity is
	port(
		in_a: in std_logic;
		in_b: in std_logic;
		in_c: in std_logic;
		out_a: out std_logic
	);
end entity; 

architecture a_three_bit_parity of three_bit_parity is
begin
	out_a <= (in_a and in_b and in_c) or (in_a and (in_b nor in_c)) or(in_b and (in_a nor in_c)) or (in_c and (in_b nor in_a));
end architecture;
