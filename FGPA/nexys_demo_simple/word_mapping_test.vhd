--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:27:34 09/29/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/word_mapping_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: word2hurdle
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
 
ENTITY word_mapping_test IS
END word_mapping_test;
 
ARCHITECTURE behavior OF word_mapping_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT word2hurdle
    PORT(
         word : IN  std_logic_vector(4 downto 0);
         hurdle : OUT  std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal word : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal hurdle : std_logic_vector(19 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: word2hurdle PORT MAP (
          word => word,
          hurdle => hurdle
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		word <= "01010";
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
