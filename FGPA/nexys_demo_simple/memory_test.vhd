--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:36:09 10/04/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/memory_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoryManager
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
 
ENTITY memory_test IS
END memory_test;
 
ARCHITECTURE behavior OF memory_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memoryManager
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         download_mode : IN  std_logic;
         data_read_addr : IN  std_logic_vector(15 downto 0);
         current_note : OUT  std_logic_vector(7 downto 0);
         note_length : OUT  std_logic_vector(7 downto 0);
         EppDB : INOUT  std_logic_vector(7 downto 0);
         EppAstb : IN  std_logic;
         EppDstb : IN  std_logic;
         EppWr : IN  std_logic;
         EppWait : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal download_mode : std_logic := '0';
   signal data_read_addr : std_logic_vector(15 downto 0) := (others => '0');
   signal EppAstb : std_logic := '0';
   signal EppDstb : std_logic := '0';
   signal EppWr : std_logic := '0';

	--BiDirs
   signal EppDB : std_logic_vector(7 downto 0);

 	--Outputs
   signal current_note : std_logic_vector(7 downto 0);
   signal note_length : std_logic_vector(7 downto 0);
   signal EppWait : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoryManager PORT MAP (
          clk => clk,
          reset => reset,
          download_mode => download_mode,
          data_read_addr => data_read_addr,
          current_note => current_note,
          note_length => note_length,
          EppDB => EppDB,
          EppAstb => EppAstb,
          EppDstb => EppDstb,
          EppWr => EppWr,
          EppWait => EppWait
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
		reset <= '1';
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

      wait for 1000 ns;
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
		
		
      wait for 1000 ns;
		EppWr <= '0';		
		EppAstb <= '0';
		EppDB <= x"01";
      wait for 50 ns;	
		EppAstb <= '1';
		EppWr <= '1';
      wait for 50 ns;	
		EppWr <= '0';
		EppDstb <= '0';
		EppDB <= x"73";
      wait for 50 ns;	
		EppDstb <= '1';
		EppWr <= '1';
		
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
