--------------------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
--------------------------------------------------------------------------------
-- Authors: Ondrej Kolar, Ivan Alechko
-- Date: 2019-04-10
-- Design: top
-- Description: Top module of PWM controller
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY top IS
    GENERIC (
        RESOLUTION : INTEGER := 100; -- Maximum possible preset input value
        BUS_RESOLUTION : INTEGER := 7; -- Resolution needed for counter and buses
        N_OUTS : INTEGER := 16 -- Number of PWM outputs
    );
    PORT (
        clk_i : IN std_logic; -- HW clock input
        cpld_sw_i : IN std_logic_vector(15 DOWNTO 0); -- HW switches input
        btn_i : IN std_logic; -- HW button input
        cpld_led_o : OUT std_logic_vector(15 DOWNTO 0); -- HW LEDs output
        disp_digit_o : OUT std_logic_vector(4 - 1 DOWNTO 0); -- HW 7segment display - digit outs
        disp_sseg_o : OUT std_logic_vector(7 - 1 DOWNTO 0) -- HW 7segment display - segment outs
    );
END top;

ARCHITECTURE Behavioral OF top IS
    SIGNAL prescaled_clk : std_logic; -- Prescaler output
    SIGNAL counter_out : std_logic_vector(BUS_RESOLUTION - 1 DOWNTO 0); -- Main counter output
    SIGNAL counter_ov : std_logic; -- Main counter overflow output
    SIGNAL demux_out : std_logic_vector(N_OUTS - 1 DOWNTO 0); -- Demux outputs
    SIGNAL preset : std_logic_vector(BUS_RESOLUTION - 1 DOWNTO 0); -- Duty cycle preset value
    SIGNAL disp_hex : std_logic_vector(16 - 1 DOWNTO 0); -- Data to display
    SIGNAL setBtn : std_logic; -- "Activate preset" button input
    SIGNAL enSwitch : std_logic; -- "Enable" switch input
BEGIN
    -- Connecting inputs to signals
    setBtn <= NOT btn_i;
    enSwitch <= NOT cpld_sw_i(8);

    -- Connecting data to display
    disp_hex(14 DOWNTO 8) <= preset;
    disp_hex(3 DOWNTO 0) <= cpld_sw_i(7 DOWNTO 4);

    -- Sub-block of display
    DISPLAY : ENTITY work.disp
        PORT MAP(
            clk2_i => counter_out(1 DOWNTO 0), 
            hex4_i => disp_hex, 
            disp_digit_o => disp_digit_o, 
            disp_sseg_o => disp_sseg_o
        );
 
    -- Sub-block of prescaler
    PRESCALER : ENTITY work.prescaler
        PORT MAP(
            clk_i => clk_i, 
            clk_o => prescaled_clk, 
            sel_i => cpld_sw_i(1 DOWNTO 0)
        );

    -- Sub-block of main counter
    COUNTER : ENTITY work.cnt
        GENERIC MAP(
            LIMIT => RESOLUTION - 1, 
            N_BITS => BUS_RESOLUTION
        )
        PORT MAP(
            clk_i => prescaled_clk, 
            out_o => counter_out, 
            ov_o => counter_ov
        );

    -- Sub-block of demultiplexer
    DEMUX : ENTITY work.demux
        GENERIC MAP(
            ADDR_BITS => 4
        )
        PORT MAP(
            inp_i => setBtn, 
            addr_i => cpld_sw_i(7 DOWNTO 4), 
            out_o => demux_out
        );

        -- Multiple PWM cell sub-blocks
        PWM_CELLS : FOR i IN 0 TO N_OUTS - 1 GENERATE
            PWM_CELL : ENTITY work.pwm_cell
                GENERIC MAP(
                    RESOLUTION => BUS_RESOLUTION
                )
                PORT MAP(
                    preset_i => preset, 
                    counter_i => counter_out, 
                    counter_ovf_i => counter_ov, 
                    en_i => enSwitch, 
                    set_i => demux_out(i), 
                    out_o => cpld_led_o(i)
                );
        END GENERATE PWM_CELLS;

        -- Activate preset input process
        PRESET_PROC : PROCESS (cpld_sw_i(15 DOWNTO 9)) BEGIN
            -- Handle values bigger than RESOLUTION limit
            IF to_integer(unsigned(cpld_sw_i(15 DOWNTO 9))) > RESOLUTION THEN
                preset <= std_logic_vector(to_unsigned(RESOLUTION, preset'length));
            ELSE
                preset <= cpld_sw_i(15 DOWNTO 9);
            END IF;
        END PROCESS PRESET_PROC;

END Behavioral;