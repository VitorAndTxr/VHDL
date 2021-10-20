library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4 is
	port(
		in_a: in std_logic;
		sel_0: in std_logic;
		sel_1: in std_logic;
		y0: out std_logic;
		y1: out std_logic;
		y2: out std_logic;
		y3: out std_logic
	);
end entity;

architecture a_decoder2x4 of decoder2x4 is
begin
	y0 <= in_a and not sel_0 and not sel_1;
	y1 <= in_a and sel_0 and not sel_1;
	y2 <= in_a and not sel_0 and sel_1;
	y3 <= in_a and sel_0 and sel_1;
end architecture;