library ieee;
use ieee.std_logic_1164.all;
-- a entidade tem
entity multiplexador8x1restrito is
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
end;

architecture a_multiplexador8x1restrito of multiplexador8x1restrito is
begin
	out_a <= 	in_0  when sel0='0' and sel1='0' and sel2='0' else
				in_1  when sel0='1' and sel1='0' and sel2='0' else
				in_2  when sel0='0' and sel1='1' and sel2='0' else
				in_3  when sel0='1' and sel1='1' and sel2='0' else
				in_4  when sel0='0' and sel1='0' and sel2='1' else
				in_5  when sel0='1' and sel1='0' and sel2='1' else
				in_6  when sel0='0' and sel1='1' and sel2='1' else
				in_7  when sel0='1' and sel1='1' and sel2='1' else
				'0';
				
end architecture;