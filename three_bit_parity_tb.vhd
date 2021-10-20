library ieee;
use ieee.std_logic_1164.all;

entity three_bit_parity_tb is
end;

architecture a_three_bit_parity_tb of three_bit_parity_tb is
	component three_bit_parity
	port(
		in_a: in std_logic;
		in_b: in std_logic;
		in_c: in std_logic;
		out_a: out std_logic
	);
	end component;
	signal in_a, in_b, in_c, out_a: std_logic;
	begin
	uut: three_bit_parity port map(
		in_a => in_a,
		in_b => in_b,
		in_c => in_c,
		out_a => out_a
	);
	process
	begin
		in_a <= '0';
		in_b <= '0';
		in_c <= '0';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '0';
		in_c <= '0';
		wait for 50 ns;
		in_a <= '0';
		in_b <= '1';
		in_c <= '0';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '1';
		in_c <= '0';
		wait for 50 ns;		
		in_a <= '0';
		in_b <= '0';
		in_c <= '1';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '0';
		in_c <= '1';
		wait for 50 ns;
		in_a <= '0';
		in_b <= '1';
		in_c <= '1';
		wait for 50 ns;
		in_a <= '1';
		in_b <= '1';
		in_c <= '1';
		wait for 50 ns;
		wait;
	end process;
end architecture;
		