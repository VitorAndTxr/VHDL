
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegFile_tb is
end entity;

architecture a_RegFile_tb of RegFile_tb is
    component RegFile is                                        -- componente do tipo RegFile
        port(A1, A2, A3: in unsigned(2 downto 0);
            WD3: in unsigned(15 downto 0);
            RD1, RD2: out unsigned(15 downto 0);
            CLK, RST, WE3: in std_logic
        );
    end component;

    constant period_time : time := 100 ns;

    signal content_to_write : unsigned(15 downto 0);            -- sinal com o conteúdo para escrever (valor a ser colocado)
    signal A1_sig, A2_sig, A3_sig : unsigned(2 downto 0);       -- indicação de quais registradores
    signal clk_sig, rst_sig, write_sig : std_logic;             -- clock, reset e write signal
    signal finished : std_logic := '0';
    signal s1, s2 : unsigned(15 downto 0);                      -- sinais com 16 bits, simulando os registradores



begin
    uut: RegFile port map(WD3=>content_to_write, A1=>A1_sig, A2=>A2_sig, A3=>A3_sig, CLK=>clk_sig, RST=>rst_sig, WE3=>write_sig, RD1=>s1, RD2=>s2); -- instância do componente


    -- Obrigatoriamente façam um reset explícito de todos os registradores/flip-flops no início da simulação.
    -- O de reset eh um pulso inicial e o resto '0', ou seja, um wait; final que paralisa o processo

    sim_time_proc: process
    begin
        wait for 1 us; -- <== TEMPO TOTAL DA SIMULACAOO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clk_sig <= '0';
            wait for period_time/2;
            clk_sig <= '1';
            wait for period_time/2;
            end loop;
        wait;
    end process clk_proc;

    reset_proc: process
    begin -- gera reset até que sim_time_proc termine
        while finished /= '1' loop
            rst_sig <= '0';
            wait for 3*period_time;
            rst_sig <= '1';
            wait for period_time;
            end loop;
        wait;
    end process reset_proc;

   
   

    process                                         -- sinais dos casos de teste
    begin
        wait for 100 ns;

        write_sig <= '0';                           -- coloca 0 no write enable, ou seja, não deve dar certo
        A3_sig <= "001";                            -- o registrador 1 será escrito
        content_to_write <= "1111111111111111";     -- conteúdo a ser escrito
        A1_sig <= "000";                            -- RD1:0
        A2_sig <= "001";                            -- RD2:1
        wait for 100 ns;

        write_sig <= '1';                           -- coloca 1 no write enable, ou seja, deve dar certo
        A3_sig <= "001";                            -- o registrador 1 será escrito
        content_to_write <= "0010001010001001";     -- conteúdo a ser escrito, por exemplo 8840
        A1_sig <= "100";                            -- RD1: 4
        A2_sig <= "001";                            -- RD2: 1
        wait for 100 ns;

        A3_sig <= "010";                            -- o registrador 2 será escrito
        content_to_write <= "0001111010110111";     -- conteúdo a ser escrito, por exemplo
        A1_sig <= "001";                            -- RD1: 1
        A2_sig <= "010";                            -- RD2: 2
        wait for 100 ns;

        A3_sig <= "011";                            -- o registrador 3 será escrito
        content_to_write <= "0010001001001010";     -- conteúdo a ser escrito, por exemplo
        A1_sig <= "010";                            -- RD1: 2
        A2_sig <= "011";                            -- RD3:3
        wait;
    end process;

end architecture;