library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
		x1, x2: in unsigned(15 downto 0);
		select_op: in unsigned(1 downto 0); --sum_overflow: out std_logic;		
		result: out unsigned(15 downto 0)
	);
end entity;
architecture a_ula of ula is
	begin
		result <= 	x1+x2 when select_op="00" else --soma
					x1-x2 when select_op="01" else --subtração
					('0' & x1(15 downto 1))+('0' & x2(15 downto 1)) when select_op="10" else --media
					"0000000000000011" when select_op ="11" and x1>=x2 else
					"0000000000000010" when select_op ="11" and x1<x2 else
				"0000000000000000"; --comparação
		--sum_overflow <= 1 when x(15)='0' and y(15) = 0 and x+y(15)
end architecture;		