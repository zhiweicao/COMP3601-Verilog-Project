------------------------------------------------------------------------
--     Nexysdemo.vhd -- Demonstrate basic Nexys function
------------------------------------------------------------------------
-- Author:  Clint Cole
--          Copyright 2006 Digilent, Inc.
------------------------------------------------------------------------
-- This module tests basic device function and connectivity on the Nexys
-- board. It was developed using the Xilinx WebPack tools.
--
--  Inputs:
--		mclk		- system clock (100Mhz Oscillator on Pegasus board)
--		bn			- buttons on the Pegasus board
--		swt		- switches on the Pegasus board (8 switches)
--
--  Outputs:
--		led		- discrete LEDs on the Pegasus board (8 leds)
--		an			- anode lines for the 7-seg displays on Pegasus
--		ssg		- cathodes (segment lines) for the displays on Pegasus
--
------------------------------------------------------------------------
-- Revision History:
--  01/15/2004(ClintC): created
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Nexysdemo is
    Port (
        mclk   						: in std_logic;
        btn   						 	: in std_logic_vector(3 downto 0);
        swt    				 		: in std_logic_vector(7 downto 0);
        led     						: out std_logic_vector(7 downto 0);
        an      						: out std_logic_vector(3 downto 0);
        ssg     						: out std_logic_vector(7 downto 0);
		  speaker_signal	 			: out std_logic;
		  EppDB							: inout std_logic_vector(7 downto 0);
	     EppAstb 						: in std_logic;
		  EppDstb 						: in std_logic;
	 	  EppWr 							: in std_logic;
		  EppWait 						: out std_logic
		  );
end Nexysdemo;

architecture Behavioral of Nexysdemo is

	------------------------------------------------------------------------
	-- Component Declarations
	------------------------------------------------------------------------
	
	component speakerPulseGenerator is
	Port (clk							: in  std_logic;
			beat_pluse					: in  std_logic;
			reset							: in 	std_logic;
			current_note				: in  std_logic_vector(7 downto 0);
			note_length					: in  std_logic_vector(7 downto 0);
			note_pass_led				: out std_logic_vector(7 downto 0);
			note_done					: out std_logic;
			pulse 						: out std_logic);
	end component;
	
	component display is
    Port ( clk						: in std_logic;
			  current_note 		: in  STD_LOGIC_VECTOR (7 downto 0);
           note_length  		: in  STD_LOGIC_VECTOR (7 downto 0);
           anSel 					: out STD_LOGIC_VECTOR (3 downto 0);
			  ssg						: out STD_LOGIC_VECTOR (7 downto 0)
			  );
	end component;
	
	component memoryManager is
	PORT (clk 							: in std_logic;
			reset							: in std_logic;
			data_read_addr				: in std_logic_vector(15 downto 0);
			current_note				: out std_logic_vector(7 downto 0);
			note_length					: out std_logic_vector(7 downto 0);
		   EppDB							: inout std_logic_vector(7 downto 0);
		   EppAstb 						: in std_logic;
		   EppDstb 						: in std_logic;
		   EppWr 						: in std_logic;
		   EppWait 						: out std_logic
			);
	end component;
	
	component beatsManager is
	Port (  clk								: in  std_logic;
			  reset							: in	std_logic;
			  beats_per_second			: in  std_logic_vector(7 downto 0);
			  beat_pluse					: out std_logic
			  );
	end component;
	
	component controller is
       Port ( clk									: in  std_logic;
			  reset								: in	std_logic;
			  note_done							: in 	std_logic;
			  increase_tempo					: in 	std_logic;
			  decrease_tempo					: in 	std_logic;
			  raw_data_in						: in  std_logic_vector(7 downto 0);
			  data_addr							: out std_logic_vector(15 downto 0);
			  beats_per_second				: out std_logic_vector(7 downto 0);
			  speaker_reset					: out std_logic;
			  tempo_reset						: out std_logic			
			  );
	end component;
	------------------------------------------------------------------------
	-- Signal Declarations
	------------------------------------------------------------------------

	signal clkdiv  				 : std_logic_vector(24 downto 0);
	signal cntr    				 : std_logic_vector(3 downto 0);
	signal cclk    				 : std_logic;

	signal reset					 : std_logic;
	
	signal current_note 			 : STD_LOGIC_VECTOR(7 downto 0);
	signal note_length			 : STD_LOGIC_VECTOR(7 downto 0);
	
	signal beats_per_second		 : STD_LOGIC_VECTOR(7 downto 0);
	signal note_done				 : std_logic;
	signal beat_pluse		 		 : std_logic;
	
	signal speaker_reset			 : std_logic;
	signal tempo_reset			 : std_logic;
	signal data_addr				 : std_logic_vector(15 downto 0);
	signal temp_led				 : STD_LOGIC_VECTOR(7 downto 0);
	signal ready_memory_addr_led: STD_LOGIC_VECTOR(7 downto 0);
  ------------------------------------------------------------------------
	-- Module Implementation
	------------------------------------------------------------------------

	begin

	reset <= not swt(7);
	led			<= beats_per_second;
	-- Divide the master clock (100Mhz) down to a lower frequency.
	process (mclk)
		begin
			if mclk = '1' and mclk'Event then
				clkdiv <= clkdiv + 1;
			end if;
	end process;

	------------------------------------------------------------------------
	-- load module
	------------------------------------------------------------------------
	-- The hurdle for triggering speaker

	--	 pulse generator
	pulse_generator :  speakerPulseGenerator
	 port map ( clk							=>	mclk,
					beat_pluse					=>	beat_pluse,
					reset							=>	speaker_reset,
					current_note				=>	current_note,
					note_length					=>	note_length,
					note_pass_led				=>	open,
					note_done					=> note_done,
					pulse 						=>	speaker_signal 
					);
						
	-- display mapping
	display_map : display
    port map  (  clk							=>	mclk,
					  current_note 			=> current_note,
					  note_length  			=> note_length,
					  anSel 						=> an,
					  ssg							=> ssg
					 );
	-- Memory Manager
	memory_Manager : memoryManager
    port map  (  clk							=>	mclk,
					  reset						=> reset,
					  data_read_addr			=> data_addr,
					  current_note				=> current_note,
					  note_length				=> note_length,
					  EppDB						=> EppDB,
					  EppAstb 					=> EppAstb,
					  EppDstb 					=> EppDstb,
					  EppWr 						=> EppWr,
					  EppWait 					=> EppWait
					);
	beats_Manager : beatsManager
    port map  ( clk							=> mclk,
					reset							=> tempo_reset,
					beats_per_second			=> beats_per_second,
					beat_pluse					=> beat_pluse
					);
	signal_controller : controller
    port map  (clk							=> mclk,
					reset							=> reset,
					note_done					=> note_done,
					increase_tempo				=> swt(0),
					decrease_tempo				=> swt(3),
					data_addr					=> data_addr,
					raw_data_in					=> current_note,
					beats_per_second			=> beats_per_second,
					speaker_reset				=> speaker_reset,
					tempo_reset					=> tempo_reset
					);
			  


	
	cclk <= clkdiv(24);
	process (cclk)
		begin
			if cclk = '1' and cclk'Event then
				if cntr = "1001" then
				    cntr <= "0000";
				else
				    cntr <= cntr + 1;
				end if;
			end if;
			
		end process;
		


end Behavioral;

