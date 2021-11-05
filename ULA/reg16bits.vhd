
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits is                             -- mantiveram-se os mesmos parâmetros da entidade, alterando apenas o tamanho dos dados
    port( clk : in std_logic;                   -- clock, 0 ou 1
        rst : in std_logic;                     -- reset, 0 ou 1
        wr_en : in std_logic;                   -- write enable, 0 ou 1
        data_in : in unsigned(15 downto 0);     -- entrada de 16 bits
        data_out : out unsigned(15 downto 0)    -- saída de 16 bits
    );
end entity;

architecture a_reg16bits of reg16bits is        -- arquitetura do reg16bits, igual à de 8 bits fornecida no material dos professores
    signal registro: unsigned(15 downto 0);
begin
    process(clk,rst,wr_en)                      -- acionado se houver mudança em clk, rst ou wr_en
    begin
        if rst='1' then                         -- se o reset for igual a 1, então devemos resetar todos os registradores
            registro <= "0000000000000000";     -- reseta todos os registradores para 0
        elsif wr_en='1' then                    -- se o write enable estiver ativo, então devemos escrever
            if rising_edge(clk) then            -- se estiver na borda de subida do clock
                registro <= data_in;            -- escreve no registrador o valor de entrada
            end if;
        end if;
    end process;
    
    data_out <= registro;                       -- conexao direta, fora do processo
end architecture;