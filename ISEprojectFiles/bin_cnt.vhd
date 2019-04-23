--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Tomas Fryza (tomas.fryza@vut.cz)
-- Date: 2019-02-20 12:17
-- Design: bin_cnt
-- Description: N-bit binary counter with synchronous reset.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- for +/- arithmetic operations

--------------------------------------------------------------------------------
-- Entity declaration for binary counter
--------------------------------------------------------------------------------
ENTITY bin_cnt IS
	GENERIC (
		N_BIT : INTEGER := 8 -- default number of bits
	);
	PORT (
		-- Entity input signals
		clk_i : IN std_logic;
		rst_n_i : IN std_logic; -- reset =0: reset active
								--       =1: no reset
		-- Entity output signals
		bin_cnt_o : OUT std_logic_vector(N_BIT - 1 DOWNTO 0)
	);
END bin_cnt;

--------------------------------------------------------------------------------
-- Architecture declaration for binary counter
--------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF bin_cnt IS
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