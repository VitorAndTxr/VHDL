library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegFileUla is
    end entity;

architecture a_RegFileUla of RegFileUla is
    component RegFile is
        port(A1, A2, A3: in unsigned(2 downto 0);                   -- ENTRADA: portas com 3 bits, A1: qual registrador vai ser colocado em RD1, A2: qual registrador vai ser colocado em RD2, A3: Seleção de qual registrador será escrito
        WD3: in unsigned(15 downto 0);                              -- ENTRADA: write data, barramento de dados para escrita (o valor a ser escrito)
        RD1, RD2: out unsigned(15 downto 0);                        -- SAIDA: cria um Read Data 1 e um Read Data 2 
        CLK, RST, WE3: in std_logic                                 -- clock, reset e write enable
        );
    end component;
    
    component ula is
        port(
            x1, x2: in unsigned(15 downto 0);
            select_op: in unsigned(1 downto 0); --sum_overflow: out std_logic;		
            result: out unsigned(15 downto 0)
        );
    end component;

    component mux2x1 is
        port(
            in_a, in_b: in unsigned(15 downto 0);
            sel: in std_logic;
            y: out unsigned(15 downto 0)
        );
    end component; 

    constant period_time : time := 100 ns;

    signal finished : std_logic := '0';  
    signal clk_sig, rst_sig, write_sig : std_logic;

    signal ula1, ula2, ulaResp: unsigned(15 downto 0);                      --Entradas e Saidas da ULA
    signal ulaOp: unsigned(1 downto 0);                                     --Operação da Ula
    signal muxControl: std_logic;                                           --Sinal que controla a Mux
    signal muxA, muxB: unsigned(15 downto 0);                       
    signal read1, read2, writeR: unsigned(2 downto 0);

    signal readAdress1, readAdress2, writeAdress: unsigned(2 downto 0);     --Endereços de Escrita e Leitura


begin

    p_ula: ula port map(x1=> ula1, x2=> ula2, select_op => ulaOp, result => ulaResp);

    p_mux2x1: mux2x1 port map(in_a => muxA, in_b => muxB, sel => muxControl,  y=> ula2);

    p_RegFile: RegFile port map(A1 => readAdress1, A2 => readAdress2, A3 => writeAdress, WD3 => ulaResp, RD1 => ula1, RD2 => ula2, CLK => clk_sig, RST => rst_sig, WE3 => write_sig);



    sim_time_proc: process
    begin
        wait for 10 us; -- <== TEMPO TOTAL DA SIMULACAOO!!!
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
        rst_sig <= '1';
        wait for 50 ns;
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
        
        muxControl <='0';
        write_sig <= '0';                           -- coloca 0 no write enable, ou seja, não deve dar certo
 
        wait for 200 ns;

        write_sig <= '0';                           -- coloca 0 no write enable, ou seja, não deve dar certo
        writeR <= "001";                            -- o registrador 1 será escrito
        read1 <= "000";                            -- RD1:0
        read2 <= "001";                            -- RD2:1
        wait for 100 ns;

        write_sig <= '1';                           -- coloca 1 no write enable, ou seja, deve dar certo
        writeR <= "001";                            -- o registrador 1 será escrito
        read1 <= "100";                            -- RD1: 4
        read2 <= "001";                            -- RD2: 1
        wait for 100 ns;

        writeR <= "010";                            -- o registrador 2 será escrito
        read1 <= "001";                            -- RD1: 1
        read2 <= "010";                            -- RD2: 2
        wait for 100 ns;

        writeR <= "011";                            -- o registrador 3 será escrito
        read1 <= "010";                            -- RD1: 2
        read2 <= "011";                            -- RD3:3
        wait;
    end process;

end architecture;

