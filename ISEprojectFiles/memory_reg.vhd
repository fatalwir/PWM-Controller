--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-03
-- Design: memory_reg
-- Description: N-bit memory register module
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY memory_reg IS
    GENERIC (
        N_BITS : INTEGER := 8 -- Number of bits in memory
    );
    PORT (
        data_i : IN std_logic_vector(N_BITS - 1 DOWNTO 0); -- Data input bus
        data_o : OUT std_logic_vector(N_BITS - 1 DOWNTO 0); -- Data output bus
        wr_i : IN std_logic -- Write input signal
    );
END memory_reg;

ARCHITECTURE Behavioral OF memory_reg IS
    SIGNAL data : std_logic_vector(N_BITS - 1 DOWNTO 0) := (OTHERS => '0'); -- Internal memory bus
BEGIN
    -- Connecting internal bus to output
    data_o <= data;
 
    -- Memorizing new data
    P_WRITE : PROCESS (wr_i)
    BEGIN
        IF (rising_edge(wr_i)) THEN
            data <= data_i;
        END IF;
    END PROCESS P_WRITE;

END Behavioral;