--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:05:46 10/04/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/controller_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
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
 
ENTITY controller_test IS
END controller_test;
 
ARCHITECTURE behavior OF controller_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         note_done : IN  std_logic;
         increase_tempo : IN  std_logic;
         decrease_tempo : IN  std_logic;
         raw_data_in : IN  std_logic_vector(7 downto 0);
         data_addr : OUT  std_logic_vector(15 downto 0);
         beats_per_second : OUT  std_logic_vector(7 downto 0);
         speaker_reset : OUT  std_logic;
         tempo_reset : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal note_done : std_logic := '0';
   signal increase_tempo : std_logic := '0';
   signal decrease_tempo : std_logic := '0';
   signal raw_data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_addr : std_logic_vector(15 downto 0);
   signal beats_per_second : std_logic_vector(7 downto 0);
   signal speaker_reset : std_logic;
   signal tempo_reset : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant note_done_period : time := 500 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          clk => clk,
          reset => reset,
          note_done => note_done,
          increase_tempo => increase_tempo,
          decrease_tempo => decrease_tempo,
          raw_data_in => raw_data_in,
          data_addr => data_addr,
          beats_per_second => beats_per_second,
          speaker_reset => speaker_reset,
          tempo_reset => tempo_reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	note_done_process :process
   begin
		note_done <= '0';
		wait for note_done_period/2;
		note_done <= '1';
		wait for note_done_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period;	
		raw_data_in <= x"40";
      wait for clk_period;	
		raw_data_in <= x"b7";
      wait for 10000 ns;	
		decrease_tempo <= '1';
      wait for 10000 ns;	
		decrease_tempo <= '0';


      wait for 10000 ns;	
		increase_tempo <= '1';
      wait for 10000 ns;	
		increase_tempo <= '0';
      wait for 10000 ns;	
		increase_tempo <= '1';
      wait for 10000 ns;	
		increase_tempo <= '0';

      wait for 10000 ns;	
		decrease_tempo <= '1';
      wait for 10000 ns;	
		decrease_tempo <= '0';


      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
