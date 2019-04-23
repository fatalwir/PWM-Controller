--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-17
-- Design: demux
-- Description: Demultiplexer module
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY demux IS
	GENERIC (
		ADDR_BITS : INTEGER := 4 -- Number of address bits -> 2^N outputs
	);
	PORT (
		inp_i : IN std_logic; -- Input
		addr_i : IN std_logic_vector(ADDR_BITS - 1 DOWNTO 0); -- Address inputs
		out_o : OUT std_logic_vector((2 ** ADDR_BITS) - 1 DOWNTO 0) := (OTHERS => '0') -- Outputs
	);
END demux;

ARCHITECTURE Behavioral OF demux IS
	BEGIN
		OUTPUTS_GEN : FOR i IN 0 TO (2 ** ADDR_BITS) - 1 GENERATE
			-- Source: https://stackoverflow.com/a/30406498
			out_o(i) <= inp_i WHEN (to_integer(unsigned(addr_i)) = i) ELSE '0';
		END GENERATE OUTPUTS_GEN;
 
END Behavioral;