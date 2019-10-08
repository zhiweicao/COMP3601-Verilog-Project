--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:27:24 10/04/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/epp_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dpimref
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
 
ENTITY epp_test IS
END epp_test;
 
ARCHITECTURE behavior OF epp_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dpimref
    PORT(
         clk : IN  std_logic;
         EppDB : INOUT  std_logic_vector(7 downto 0);
         EppAstb : IN  std_logic;
         EppDstb : IN  std_logic;
         EppWr : IN  std_logic;
         EppWait : OUT  std_logic;
         ready : OUT  std_logic;
         memory_data_bus : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal EppAstb : std_logic := '0';
   signal EppDstb : std_logic := '0';
   signal EppWr : std_logic := '0';

	--BiDirs
   signal EppDB : std_logic_vector(7 downto 0);

 	--Outputs
   signal EppWait : std_logic;
   signal ready : std_logic;
   signal memory_data_bus : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dpimref PORT MAP (
          clk => clk,
          EppDB => EppDB,
          EppAstb => EppAstb,
          EppDstb => EppDstb,
          EppWr => EppWr,
          EppWait => EppWait,
          ready => ready,
          memory_data_bus => memory_data_bus
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		EppAstb <= '1';
		EppDstb <= '1';
		EppWr <= '1';
      wait for 100 ns;
		EppWr <= '0';		
		EppAstb <= '0';
		EppDB <= x"01";
      wait for 50 ns;	
		EppAstb <= '1';
		EppWr <= '1';
      wait for 50 ns;	
		EppWr <= '0';
		EppDstb <= '0';
		EppDB <= x"2f";
      wait for 50 ns;	
		EppDstb <= '1';
		EppWr <= '1';

      wait for 100 ns;
		EppWr <= '0';		
		EppAstb <= '0';
		EppDB <= x"01";
      wait for 50 ns;	
		EppAstb <= '1';
		EppWr <= '1';
      wait for 50 ns;	
		EppWr <= '0';
		EppDstb <= '0';
		EppDB <= x"51";
      wait for 50 ns;	
		EppDstb <= '1';
		EppWr <= '1';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
