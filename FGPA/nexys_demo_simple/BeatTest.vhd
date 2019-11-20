--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:26:22 11/19/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/BeatTest.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Nexysdemo
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
 
ENTITY BeatTest IS
END BeatTest;
 
ARCHITECTURE behavior OF BeatTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Nexysdemo
    PORT(
         mclk : IN  std_logic;
         btn : IN  std_logic_vector(3 downto 0);
         swt : IN  std_logic_vector(7 downto 0);
         led : OUT  std_logic_vector(7 downto 0);
         an : OUT  std_logic_vector(3 downto 0);
         ssg : OUT  std_logic_vector(7 downto 0);
         speaker_signal : OUT  std_logic;
         EppDB : INOUT  std_logic_vector(7 downto 0);
         EppAstb : IN  std_logic;
         EppDstb : IN  std_logic;
         EppWr : IN  std_logic;
         EppWait : OUT  std_logic;
         UART_RXD : IN  std_logic;
         PMODBT_RST : OUT  std_logic;
         PMODBT_CTS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal mclk : std_logic := '0';
   signal btn : std_logic_vector(3 downto 0) := (others => '0');
   signal swt : std_logic_vector(7 downto 0) := (others => '0');
   signal EppAstb : std_logic := '0';
   signal EppDstb : std_logic := '0';
   signal EppWr : std_logic := '0';
   signal UART_RXD : std_logic := '0';

	--BiDirs
   signal EppDB : std_logic_vector(7 downto 0);

 	--Outputs
   signal led : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);
   signal ssg : std_logic_vector(7 downto 0);
   signal speaker_signal : std_logic;
   signal EppWait : std_logic;
   signal PMODBT_RST : std_logic;
   signal PMODBT_CTS : std_logic;

   -- Clock period definitions
   constant mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Nexysdemo PORT MAP (
          mclk => mclk,
          btn => btn,
          swt => swt,
          led => led,
          an => an,
          ssg => ssg,
          speaker_signal => speaker_signal,
          EppDB => EppDB,
          EppAstb => EppAstb,
          EppDstb => EppDstb,
          EppWr => EppWr,
          EppWait => EppWait,
          UART_RXD => UART_RXD,
          PMODBT_RST => PMODBT_RST,
          PMODBT_CTS => PMODBT_CTS
        );

   -- Clock process definitions
   mclk_process :process
   begin
		mclk <= '0';
		wait for mclk_period/2;
		mclk <= '1';
		wait for mclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		swt(7) <= '0';
      wait for 1000 ns;	
		swt(7) <= '1';
      wait for 1000 ns;	
		swt(7) <= '0';
      wait for 1000 ns;	
		swt(7) <= '1';
      wait for 1000 ns;	
		swt(7) <= '0';
      wait for 1000 ns;	
		swt(7) <= '1';
      wait for 1000 ns;	

      wait for mclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
