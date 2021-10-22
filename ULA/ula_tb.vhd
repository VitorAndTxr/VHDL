library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
	component ula
		port(
			x, y: in unsigned(15 downto 0);
			select_op: in unsigned(1 downto 0);
			--sum_overflow: out std_logic;
			result: out unsigned(15 downto 0)
		);
	end component;
	signal x,y,result: unsigned(15 downto 0);
	signal select_op: unsigned(1 downto 0);
	begin
	uut: ula port map(
		x => x,
		y => y,
		select_op => select_op,
		result => result
	);
	process
	begin
		select_op <= "00";
		x <= "0100111000100000"; -- 20000
		y <= "0001001110001000"; -- 5000
		wait for 50 ns;
		x <= "0100111000100000"; -- 20000
		y <= "1010110111111000"; -- (-21000)
		wait for 50 ns;
		x <= "0100111000100000"; -- 20000
		y <= "0100111000100000"; -- 20000
		wait for 50 ns;
		x <= "1010110111111000"; -- (-21000)
		y <= "1010110111111000"; -- (-21000)
		wait for 50 ns;
		select_op <= "01";
		x <= "0100111000100000"; -- 20000
		y <= "0001001110001000"; -- 5000
		wait for 50 ns;
		x <= "0100111000100000"; -- 20000
		y <= "1110110001111000"; -- (-5000)
		wait for 50 ns;
		x <= "0100111000100000"; -- 20000
		y <= "0100111000100000"; -- 20000
		wait for 50 ns;
		x <= "1010110111111000"; -- (-21000)
		y <= "1010110111111000"; -- (-21000)
		wait for 50 ns;
		select_op <= "10";
		x <= "0000000111110100"; -- 500
		y <= "0000000111110100"; -- 500
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "1111111000001100"; -- (-500)
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "0001000110010100"; -- 4500
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "0000000000000000"; -- 0
		wait for 50 ns;
		select_op <= "11";
		x <= "0001001110001000"; -- 5000
		y <= "0000000111110100"; -- 500
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "1111111000001100"; -- (-500)
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "0001000110010100"; -- 4500
		wait for 50 ns;
		x <= "0000000111110100"; -- 500
		y <= "0000000111110100"; -- 500
		wait for 50 ns;
		wait;
	end process;
end architecture;