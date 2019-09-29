--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:06:56 09/29/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/pulseGeneratorTest.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: speakerPulseGenerator
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
 
ENTITY pulseGeneratorTest IS
END pulseGeneratorTest;
 
ARCHITECTURE behavior OF pulseGeneratorTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT speakerPulseGenerator
    PORT(
         clk : IN  std_logic;
         beat_pluse : IN  std_logic;
         reset : IN  std_logic;
         current_note : IN  std_logic_vector(7 downto 0);
         note_length : IN  std_logic_vector(7 downto 0);
         note_pass_led : OUT  std_logic_vector(7 downto 0);
         note_done : OUT  std_logic;
         pulse : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal beat_pluse : std_logic := '0';
   signal reset : std_logic := '0';
   signal current_note : std_logic_vector(7 downto 0) := (others => '0');
   signal note_length : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal note_pass_led : std_logic_vector(7 downto 0);
   signal note_done : std_logic;
   signal pulse : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant pulse_period : time := 1000 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: speakerPulseGenerator PORT MAP (
          clk => clk,
          beat_pluse => beat_pluse,
          reset => reset,
          current_note => current_note,
          note_length => note_length,
          note_pass_led => note_pass_led,
          note_done => note_done,
          pulse => pulse
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
 beat_pluse_process :process
   begin
		beat_pluse <= '0';
		wait for pulse_period/2;
		beat_pluse <= '1';
		wait for pulse_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
		current_note <= x"0a";
		note_length	<= x"04";
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
