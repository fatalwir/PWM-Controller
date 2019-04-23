--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:43:04 04/03/2019
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xkolar74-xalech00/Project/PWM_controller/tb_mem.vhd
-- Project Name:  PWM_controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory_reg
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
 
ENTITY tb_mem IS
END tb_mem;
 
ARCHITECTURE behavior OF tb_mem IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory_reg
    PORT(
         data_i : IN  std_logic_vector(7 downto 0);
         data_o : OUT  std_logic_vector(7 downto 0);
         wr_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_i : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_i : std_logic := '0';

    --Outputs
   signal data_o : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant wr_i_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: memory_reg PORT MAP (
          data_i => data_i,
          data_o => data_o,
          wr_i => wr_i
        );

   -- Clock process definitions
   wr_i_process :process
   begin
        wr_i <= '0';
        wait for wr_i_period/2;
        wr_i <= '1';
        wait for wr_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;  

      wait for wr_i_period*10;

      data_i <= x"16"; wait for wr_i_period*15.5;
        data_i <= x"FF"; wait for wr_i_period*15.5;
        data_i <= x"00"; wait for wr_i_period*15;

      wait;
   end process;

END;
