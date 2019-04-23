--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Authors: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-17
-- Design: disp
-- Description: Display module
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY disp IS
    PORT (
        clk2_i : IN std_logic_vector(1 DOWNTO 0); -- 2-bit clock input
        hex4_i : IN std_logic_vector(16 - 1 DOWNTO 0); -- 4x4-bit data to display
        disp_digit_o : OUT std_logic_vector(4 - 1 DOWNTO 0); -- 7segment display - digit outs
        disp_sseg_o : OUT std_logic_vector(7 - 1 DOWNTO 0) -- 7segment display - segment outs
    );
END disp;

ARCHITECTURE Behavioral OF disp IS
    SIGNAL hex1 : std_logic_vector(4 - 1 DOWNTO 0); -- Internal temporary 4-bit data bus
BEGIN
    -- Sub-block of one_of_four entity
    ONEOFFOUR : ENTITY work.one_of_four
        PORT MAP(clk2_i, disp_digit_o);
 
    -- Sub-block of hex_to_sseg entity
    HEX2SSEG : ENTITY work.hex_to_sseg
        PORT MAP(hex1, disp_sseg_o);
 
    -- Displaying one of four 4-bit numbers
    hex1 <= hex4_i(15 DOWNTO 12) WHEN clk2_i = "11" ELSE
            hex4_i(11 DOWNTO 8) WHEN clk2_i = "10" ELSE
            hex4_i(7 DOWNTO 4) WHEN clk2_i = "01" ELSE
            hex4_i(3 DOWNTO 0) WHEN clk2_i = "00";

END Behavioral;