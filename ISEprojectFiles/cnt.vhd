--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-16
-- Design: cnt
-- Description: N-bit counter with shortened cycle module
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY cnt IS
	GENERIC (
		N_BITS : INTEGER := 8; -- Default bit-resolution
		LIMIT : INTEGER := 100 -- Default counting limit
	);
	PORT (
		clk_i : IN std_logic; -- Clock input
		out_o : OUT std_logic_vector(N_BITS - 1 DOWNTO 0); -- Output vector
		ov_o : OUT std_logic := '0' -- Overflow flag
	);
END cnt;

ARCHITECTURE Behavioral OF cnt IS
	SIGNAL step : std_logic_vector(N_BITS - 1 DOWNTO 0) := (OTHERS => '0'); -- Actual output value
BEGIN
	-- Connecting internal bus to output
	out_o <= step;

	-- Processing clock input
	PROCESS (clk_i) BEGIN
		IF (rising_edge(clk_i)) THEN
			IF (step = LIMIT) THEN
				step <= (OTHERS => '0');
				ov_o <= '1';
			ELSE
				step <= step + 1;
				ov_o <= '0';
			END IF;
		END IF;
	END PROCESS;

END Behavioral;