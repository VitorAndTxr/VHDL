library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
	port(
		in_a, in_b: in unsigned(15 downto 0);
		sel: in std_logic;
		y: out unsigned(15 downto 0)
	);
end entity;

architecture a_mux2x1 of mux2x1 is
begin
	y <=   in_a when sel='0' else
            in_b when sel='1';
end architecture;