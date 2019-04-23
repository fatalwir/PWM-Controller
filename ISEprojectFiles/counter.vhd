--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-15
-- Design: top
-- Description: N-bit counter with shortened cycle
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS
    GENERIC (
        LIMIT : std_logic_vector(N_BIT - 1 DOWNTO 0) := x"64";
        N_BITS : INTEGER := 8 -- default number of bits
    );
    PORT (
        -- Entity input signals
        clk_i : IN std_logic;
        rst_n_i : IN std_logic; -- reset =0: reset active
                                --       =1: no reset
        -- Entity output signals
        bin_cnt_o : OUT std_logic_vector(g_NBIT - 1 DOWNTO 0)
    );
END counter;

ARCHITECTURE Behavioral OF counter IS
    SIGNAL s_reg : std_logic_vector(N_BIT - 1 DOWNTO 0);
    SIGNAL s_next : std_logic_vector(N_BIT - 1 DOWNTO 0);
BEGIN
    --------------------------------------------------------------------------------
    -- Register
    --------------------------------------------------------------------------------
    p_bin_cnt : PROCESS (clk_i)
    BEGIN
        IF rising_edge(clk_i) THEN
            IF rst_n_i = '0' THEN -- synchronous reset
                s_reg <= (OTHERS => '0'); -- clear all bits in register
            ELSE
                s_reg <= s_next; -- update register value
            END IF;
        END IF;
    END PROCESS p_bin_cnt;

    --------------------------------------------------------------------------------
    -- Next-state logic
    --------------------------------------------------------------------------------
    s_next <= s_reg + 1;

    --------------------------------------------------------------------------------
    -- Output logic
    --------------------------------------------------------------------------------
    bin_cnt_o <= s_reg;
END Behavioral;