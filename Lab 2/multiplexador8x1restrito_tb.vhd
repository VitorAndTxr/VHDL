library ieee;
use ieee.std_logic_1164.all;
-- a entidade tem
entity multiplexador8x1restrito_tb is
end;
architecture a_multiplexador8x1restrito_tb of multiplexador8x1restrito_tb is
	component multiplexador8x1restrito
	port(
		in_0: in std_logic;
		in_1: in std_logic;
		in_2: in std_logic;
		in_3: in std_logic;
		in_4: in std_logic;
		in_5: in std_logic;
		in_6: in std_logic;
		in_7: in std_logic;
		sel0: in std_logic;
		sel1: in std_logic;
		sel2: in std_logic;
		out_a: out std_logic
	);
	end component;
	signal in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, 	sel0, sel1, sel2, out_a: std_logic;
	begin
	uut: multiplexador8x1restrito port map(
		in_0 => in_0,
		in_1 => in_1,
		in_2 => in_2,
		in_3 => in_3,
		in_4 => in_4,
		in_5 => in_5,
		in_6 => in_6,
		in_7 => in_7, 
		sel0 => sel0,
		sel1 => sel1,
		sel2 => sel2,
		out_a => out_a
	);
	process
	begin
		in_0 <= '0';
		in_1 <= '0';
		in_5 <= '0';
		in_3 <= '1';
		in_7 <= '1';
		sel0 <= '0';
		sel1 <= '0';
		sel2 <= '0';
		wait for 50 ns;
		sel0 <= '1';
		sel1 <= '0';
		sel2 <= '0';
		wait for 50 ns;
		sel0 <= '0';
		sel1 <= '1';
		sel2 <= '0';
		wait for 50 ns;
		sel0 <= '1';
		sel1 <= '1';
		sel2 <= '0';
		wait for 50 ns;
		sel0 <= '0';
		sel1 <= '0';
		sel2 <= '1';
		wait for 50 ns;
		sel0 <= '1';
		sel1 <= '0';
		sel2 <= '1';
		wait for 50 ns;
		sel0 <= '0';
		sel1 <= '1';
		sel2 <= '1';
		wait for 50 ns;
		sel0 <= '1';
		sel1 <= '1';
		sel2 <= '1';
		wait for 50 ns;
		wait;
	end process;
end architecture;