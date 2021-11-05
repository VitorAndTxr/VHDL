
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegFile is                                               -- banco de registradores
    port(A1, A2, A3: in unsigned(2 downto 0);                   -- ENTRADA: portas com 3 bits, A1: qual registrador vai ser colocado em RD1, A2: qual registrador vai ser colocado em RD2, A3: Seleção de qual registrador será escrito
    WD3: in unsigned(15 downto 0);                              -- ENTRADA: write data, barramento de dados para escrita (o valor a ser escrito)
    RD1, RD2: out unsigned(15 downto 0);                        -- SAIDA: cria um Read Data 1 e um Read Data 2 
    CLK, RST, WE3: in std_logic                                 -- clock, reset e write enable
    );
   end entity;

architecture a_RegFile of RegFile is                            -- arquitetura do banco
    component reg16bits is                                      -- componente do tipo registrador de 16 bits
        port( clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
    end component;
    type reg_vect is array(0 to 7) of unsigned(15 downto 0);    -- cria um vetor com 8 posições, ou seja, 8 registradores, cada um com um o conteúdo de 16 bits 
    signal reg_vect_obj : reg_vect;                             -- cria um objeto (signal) do tipo "reg_vect"
    signal output_vector_A3: std_logic_vector (7 downto 0);     -- instancia a determinação dos valores de A3 (Decoders de escrita e os Multiplexadores de leitura)
    signal write_individual : std_logic_vector (7 downto 0);    -- 
begin
    with A3 select                                              -- Com A3 selecionado, ou seja, com o registrador a ser escrito
        output_vector_A3 <= 
                "00000001" when "000",                          -- Se A3 for 000, então é o registrador 0 que será escrito, então coloca em output_vector 
                "00000010" when "001",                          -- Se A3 for 001, então é o registrador 1 que será escrito, então coloca em output_vector
                "00000100" when "010",
                "00001000" when "011",
                "00010000" when "100",
                "00100000" when "101",
                "01000000" when "110",
                "10000000" when "111",
                "00000000" when others;
    write_individual(0) <= '0';                                 -- deve sempre ser 0
    write_individual(1) <= (output_vector_A3(1) and WE3);       -- coloca no registrador 1, se o write enable estiver ativo, e houver
    write_individual(2) <= (output_vector_A3(2) and WE3);
    write_individual(3) <= (output_vector_A3(3) and WE3);
    write_individual(4) <= (output_vector_A3(4) and WE3);
    write_individual(5) <= (output_vector_A3(5) and WE3);
    write_individual(6) <= (output_vector_A3(6) and WE3);
    write_individual(7) <= (output_vector_A3(7) and WE3);
    
-- registradores são escritos conforme definição de A3 utilizando um signal auxiliar output_vector_A3 (Decoders de escrita e os Multiplexadores de leitura)
    
    register0: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(0), data_in=>WD3, data_out=>reg_vect_obj(0));
    register1: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(1), data_in=>WD3, data_out=>reg_vect_obj(1));
    register2: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(2), data_in=>WD3, data_out=>reg_vect_obj(2));
    register3: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(3), data_in=>WD3, data_out=>reg_vect_obj(3));
    register4: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(4), data_in=>WD3, data_out=>reg_vect_obj(4));
    register5: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(5), data_in=>WD3, data_out=>reg_vect_obj(5));
    register6: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(6), data_in=>WD3, data_out=>reg_vect_obj(6));
    register7: reg16bits port map (clk=>CLK, rst=>RST, wr_en=> write_individual(7), data_in=>WD3, data_out=>reg_vect_obj(7));

    with A1 select                                          -- se A1 for selecionado, ou seja, o registrador que vai ser colocado em RD1
        RD1 <= 
            reg_vect_obj(0) when "000",                     -- coloca em RD1 o valor x, quando A1 é 000, ou seja, referente ao registrador 0
            reg_vect_obj(1) when "001",
            reg_vect_obj(2) when "010",
            reg_vect_obj(3) when "011",
            reg_vect_obj(4) when "100",
            reg_vect_obj(5) when "101",
            reg_vect_obj(6) when "110",
            reg_vect_obj(7) when "111",
            "0000000000000000" when others;
    
    with A2 select                                          -- se A2 for selecionado, ou seja, o registrador que vai ser colocado em RD2
        RD2 <= 
            reg_vect_obj(0) when "000",                     -- coloca em RD2 o reg_vect_obj, quando A1 eh 000, ou seja, referente ao registrador 0
            reg_vect_obj(1) when "001",
            reg_vect_obj(2) when "010",
            reg_vect_obj(3) when "011",
            reg_vect_obj(4) when "100",
            reg_vect_obj(5) when "101",
            reg_vect_obj(6) when "110",
            reg_vect_obj(7) when "111",
            "0000000000000000" when others;

    
end architecture;