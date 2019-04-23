--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Author: Tomas Fryza (tomas.fryza@vut.cz), Ondrej Kolar, Ivan Alechko
-- Date: 2019-02-12 10:13
-- Design: hex_to_sseg
-- Description: Hexadecimal digit to seven-segment LED decoder.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
-- Entity declaration for hexadecimal to seven-segment decoder
--------------------------------------------------------------------------------
ENTITY hex_to_sseg IS
    PORT (
        -- Entity input signals
        hex_i : IN std_logic_vector(4 - 1 DOWNTO 0); -- 4-bit data

        -- Entity output signals
        sseg_o : OUT std_logic_vector(7 - 1 DOWNTO 0) -- active-low cathodes
    );
END hex_to_sseg;

--------------------------------------------------------------------------------
-- Architecture declaration for hexadecimal to seven-segment decoder
--------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF hex_to_sseg IS
BEGIN
    -- hexadecimal digit to seven-segment LED decoder
    sseg_o <= "0000001" WHEN hex_i = "0000" ELSE -- 0
              "1001111" WHEN hex_i = "0001" ELSE -- 1
              "0010010" WHEN hex_i = "0010" ELSE -- 2
              "0000110" WHEN hex_i = "0011" ELSE -- 3
              "1001100" WHEN hex_i = "0100" ELSE -- 4
              "0100100" WHEN hex_i = "0101" ELSE -- 5
              "0100000" WHEN hex_i = "0110" ELSE -- 6
              "0001111" WHEN hex_i = "0111" ELSE -- 7
              "0000000" WHEN hex_i = "1000" ELSE -- 8
              "0000100" WHEN hex_i = "1001" ELSE -- 9
              "0001000" WHEN hex_i = "1010" ELSE -- A
              "1100000" WHEN hex_i = "1011" ELSE -- B
              "0110001" WHEN hex_i = "1100" ELSE -- C
              "1000010" WHEN hex_i = "1101" ELSE -- D
              "0110000" WHEN hex_i = "1110" ELSE -- E
              "0111000"; -- F
END Behavioral;