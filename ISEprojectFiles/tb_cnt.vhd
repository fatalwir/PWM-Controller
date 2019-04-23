--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:05:06 04/17/2019
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xkolar74-xalech00/Project/PWM_controller/tb_cnt.vhd
-- Project Name:  PWM_controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cnt
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
 
ENTITY tb_cnt IS
END tb_cnt;
 
ARCHITECTURE behavior OF tb_cnt IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cnt
    PORT(
         clk_i : IN  std_logic;
         out_o : OUT  std_logic_vector(7 downto 0);
         ov_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';

    --Outputs
   signal out_o : std_logic_vector(7 downto 0);
   signal ov_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 1 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: cnt PORT MAP (
          clk_i => clk_i,
          out_o => out_o,
          ov_o => ov_o
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
      -- hold reset state for 100 ns.
      wait for 100 ns;  

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
