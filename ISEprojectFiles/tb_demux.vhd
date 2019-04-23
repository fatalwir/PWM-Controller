--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:42 04/17/2019
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xkolar74-xalech00/Project/PWM_controller/tb_demux.vhd
-- Project Name:  PWM_controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: demux
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
 
ENTITY tb_demux IS
END tb_demux;
 
ARCHITECTURE behavior OF tb_demux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT demux
    PORT(
         inp_i : IN  std_logic;
         addr_i : IN  std_logic_vector(3 downto 0);
         out_o : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inp_i : std_logic := '0';
   signal addr_i : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
   signal out_o : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant inp_i_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: demux PORT MAP (
          inp_i => inp_i,
          addr_i => addr_i,
          out_o => out_o
        );

   -- Clock process definitions
   inp_i_process :process
   begin
        inp_i <= '0';
        wait for inp_i_period/2;
        inp_i <= '1';
        wait for inp_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;  

          addr_i <= x"1";wait for 100 ns;
          addr_i <= x"a";wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
