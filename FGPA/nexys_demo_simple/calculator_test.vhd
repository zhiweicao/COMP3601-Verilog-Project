--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:59:48 09/29/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/calculator_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: beatsHurdleCalculator
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
 
ENTITY calculator_test IS
END calculator_test;
 
ARCHITECTURE behavior OF calculator_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT beatsHurdleCalculator
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         beats_per_second : IN  std_logic_vector(7 downto 0);
         given_period : IN  std_logic_vector(31 downto 0);
         times_of_beat_within_period : OUT  std_logic_vector(31 downto 0);
         calculation_done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal beats_per_second : std_logic_vector(7 downto 0) := (others => '0');
   signal given_period : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal times_of_beat_within_period : std_logic_vector(31 downto 0);
   signal calculation_done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: beatsHurdleCalculator PORT MAP (
          clk => clk,
          reset => reset,
          beats_per_second => beats_per_second,
          given_period => given_period,
          times_of_beat_within_period => times_of_beat_within_period,
          calculation_done => calculation_done
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
		beats_per_second <= X"ff";
		given_period	  <= X"0005f5e1";
      wait for 100 ns;	
		reset <= '0';
      wait for 1000 ms;	

      -- insert stimulus here 

      wait;
   end process;

END;
