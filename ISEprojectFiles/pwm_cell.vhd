--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-03
-- Design: pwm_cell
-- Description: Single PWM cell module with N-bit resolution
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY pwm_cell IS
    GENERIC (
        RESOLUTION : INTEGER := 8 -- Bit resolution
    );
    PORT (
        preset_i : IN std_logic_vector(RESOLUTION - 1 DOWNTO 0); -- Data preset input bus
        counter_i : IN std_logic_vector(RESOLUTION - 1 DOWNTO 0); -- Counter input bus
        counter_ovf_i : IN std_logic; -- Counter overflow input
        en_i : IN std_logic; -- Enable input signal
        set_i : IN std_logic; -- Preset input signal
        out_o : OUT std_logic -- PWM output signal
    );
END pwm_cell;

ARCHITECTURE Behavioral OF pwm_cell IS
    SIGNAL preset : std_logic_vector(RESOLUTION - 1 DOWNTO 0); -- Actual preset value
    SIGNAL q : std_logic := '0'; -- Output latch out
    SIGNAL not_q : std_logic := '1'; -- Output latch complementary out
    SIGNAL reset : std_logic; -- Output latch reset input
BEGIN
    -- Connecting output
    out_o <= '0' WHEN (to_integer(unsigned(preset)) = 0) ELSE (q AND (NOT en_i));
 
    -- Sub-block of preset memory
    MEM : ENTITY work.memory_reg
        GENERIC MAP(
            N_BITS => RESOLUTION
        )
        PORT MAP(
            data_i => preset_i, 
            data_o => preset, 
            wr_i => set_i
        );

    -- Sub-block of comparator
    COMP : ENTITY work.comparator
        GENERIC MAP(
            N_BITS => RESOLUTION
        )
        PORT MAP(
            dataA_i => counter_i, 
            dataB_i => preset, 
            y_o => reset
        );

        -- Output latch
        q <= not_q NOR reset;
        not_q <= q NOR counter_ovf_i;

END Behavioral;