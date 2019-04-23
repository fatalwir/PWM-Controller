--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:17:05 04/10/2019
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xkolar74-xalech00/Project/PWM_controller/tb_comp.vhd
-- Project Name:  PWM_controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparator
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
 
ENTITY tb_comp IS
END tb_comp;
 
ARCHITECTURE behavior OF tb_comp IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparator
    PORT(
         dataA_i : IN  std_logic_vector(7 downto 0);
         dataB_i : IN  std_logic_vector(7 downto 0);
         y_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal dataA_i : std_logic_vector(7 downto 0) := (others => '0');
   signal dataB_i : std_logic_vector(7 downto 0) := (others => '0');

    --Outputs
   signal y_o : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: comparator PORT MAP (
          dataA_i => dataA_i,
          dataB_i => dataB_i,
          y_o => y_o
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--      <clock> <= '0';
--      wait for <clock>_period/2;
--      <clock> <= '1';
--      wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;  

--      wait for <clock>_period*10;

      dataA_i <= x"16";wait for 100 ns;
        dataB_i <= x"12";wait for 100 ns;
        dataB_i <= x"16";wait for 100 ns;
        dataA_i <= x"00";wait for 100 ns;

      wait;
   end process;

END;
