--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:52:51 04/21/2019
-- Design Name:   
-- Module Name:   D:/Programy/Xilinx/ISE_projects/PWM_controller/tb_top.vhd
-- Project Name:  PWM_controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         cpld_sw_i : IN  std_logic_vector(15 downto 0);
         btn_i : IN  std_logic;
         cpld_led_o : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal cpld_sw_i : std_logic_vector(15 downto 0) := (others => '0');
   signal btn_i : std_logic := '0';

    --Outputs
   signal cpld_led_o : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 1 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          cpld_sw_i => cpld_sw_i,
          btn_i => btn_i,
          cpld_led_o => cpld_led_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
        clk_i <= '0';
        wait for clk_i_period/2;
        clk_i <= '1';
        wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      cpld_sw_i(8) <= '1';
   
      cpld_sw_i(7 downto 4) <= "0010";
      cpld_sw_i(15 downto 9) <= "0000001";
      
      btn_i <= '1';wait for 1 ns;
      btn_i <= '0';
      
      cpld_sw_i(7 downto 4) <= "0100";
      cpld_sw_i(15 downto 9) <= "1101000";
      
      btn_i <= '1';wait for 1 ns;
      btn_i <= '0';
      
      wait for 300 ns;
      cpld_sw_i(1 downto 0)<="01";
      wait for 300 ns;
      cpld_sw_i(1 downto 0)<="10";
      
      wait;
   end process;

END;
