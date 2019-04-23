--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Tomas Fryza (tomas.fryza@vut.cz), Ondrej Kolar, Ivan Alechko
-- Date: 2019-02-13 14:22
-- Design: one_of_four
-- Description: 1-of-4 decoder.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
-- Entity declaration for 1 of 4 decoder
--------------------------------------------------------------------------------
ENTITY one_of_four IS
    PORT (
        -- Entity input signals
        a_i : IN std_logic_vector(2 - 1 DOWNTO 0); -- 2 address inputs

        -- Entity output signals
        y_o : OUT std_logic_vector(4 - 1 DOWNTO 0) -- active-low outputs
    );
END one_of_four;

--------------------------------------------------------------------------------
-- Architecture declaration for 1 of 4 decoder
--------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF one_of_four IS
BEGIN
    --  addr | outputs
    -- ------+---------
    --   0 0 | H H H L
    --   0 1 | H H L H
    --   1 0 | H L H H
    --   1 1 | L H H H
    y_o(3) <= (NOT a_i(0)) OR (NOT a_i(1));
    y_o(2) <= a_i(0) OR (NOT a_i(1));
    y_o(1) <= '1';--(not a_i(0)) OR a_i(1); -- Digit isn't used in this project
    y_o(0) <= a_i(0) OR a_i(1);
 
END Behavioral;