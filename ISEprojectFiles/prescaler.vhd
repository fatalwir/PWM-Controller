--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-17
-- Design: prescaler
-- Description: Prescaler module
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY prescaler IS
    PORT (
        clk_i : IN std_logic; -- Clock input
        clk_o : OUT std_logic; -- Clock output
        sel_i : IN std_logic_vector(1 DOWNTO 0) -- Prescaling factor input
    );
END prescaler;

ARCHITECTURE Behavioral OF prescaler IS
    SIGNAL outs : std_logic_vector(3 DOWNTO 0); -- Vector of all clock outputs
BEGIN
    -- No prescaling
    outs(0) <= clk_i;

    -- 2x, 4x, 8x prescaler counter sub-block
    CNT : ENTITY work.cnt
        GENERIC MAP(
            LIMIT => 7, 
            N_BITS => 3
        )
        PORT MAP(
            clk_i => clk_i, 
            out_o => outs(3 DOWNTO 1)
        );
 
        -- Connecting selected clock to output
        clk_o <= outs(to_integer(unsigned(sel_i)));

END Behavioral;