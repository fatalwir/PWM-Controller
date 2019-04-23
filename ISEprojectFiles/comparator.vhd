--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-10
-- Design: comparator
-- Description: N-bit binary number equivalence comparator module
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY comparator IS
	GENERIC (
		N_BITS : INTEGER := 8 -- Bit-resolution of buses
	);
	PORT (
		dataA_i : IN std_logic_vector(N_BITS - 1 DOWNTO 0); -- Data A input bus
		dataB_i : IN std_logic_vector(N_BITS - 1 DOWNTO 0); -- Data B input bus
		y_o : OUT std_logic -- Output
	);
END comparator;

ARCHITECTURE Behavioral OF comparator IS
	SIGNAL equalSigs : std_logic_vector(N_BITS DOWNTO 0); -- Internal cascade bus
BEGIN
	equalSigs(0) <= '1';
	y_o <= equalSigs(N_BITS);
 
	gen_xnors : FOR i IN 0 TO N_BITS - 1 GENERATE
		equalSigs(i + 1) <= equalSigs(i) AND (dataA_i(i) XNOR dataB_i(i));
	END GENERATE gen_xnors;
 
END Behavioral;