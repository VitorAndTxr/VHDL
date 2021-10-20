library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4_tb is
end;
architecture a_decoder2x4_tb of decoder2x4_tb is
	 component decoder2x4
	 port( 	
		in_a : in std_logic;
		sel_0: in std_logic;
		sel_1: in std_logic;
		y0: out std_logic;
		y1: out std_logic;
		y2: out std_logic;
		y3: out std_logic
	 );
	 end component;
	 signal in_a, sel_0, sel_1, y0, y1,y2,y3: std_logic;
	 begin
 -- uut significa Unit Under Test
	 uut: decoder2x4 port map(
		in_a => in_a,
		sel_0 => sel_0,
		sel_1 => sel_1,
		y0 => y0,
		y1 => y1,
		y2 => y2,
		y3 => y3
	 );
	 process
	 begin
		in_a <= '1';
		 sel_0 <= '0';
		 sel_1 <= '0';
		 wait for 50 ns;
		 in_a <= '1';
		 sel_0 <= '1';
		 sel_1 <= '0';
		 wait for 50 ns;
		 in_a <= '1';
		 sel_0 <= '0';
		 sel_1 <= '1';
		 wait for 50 ns;
		 in_a <= '1';
		 sel_0 <= '1';
		 sel_1 <= '1';
		 wait for 50 ns;
		 in_a <= '0';
		 sel_0 <= '0';
		 sel_1 <= '0';
		 wait for 50 ns;
		 in_a <= '0';
		 sel_0 <= '1';
		 sel_1 <= '0';
		 wait for 50 ns;
		 in_a <= '0';
		 sel_0 <= '0';
		 sel_1 <= '1';
		 wait for 50 ns;
		 in_a <= '0';
		 sel_0 <= '1';
		 sel_1 <= '1';
		 wait for 50 ns;
		wait;
	end process;
end architecture;