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
        mclk    : in std_logic;
        btn     : in std_logic_vector(3 downto 0);
        swt     : in std_logic_vector(7 downto 0);
        led     : out std_logic_vector(7 downto 0);
        an      : out std_logic_vector(3 downto 0);
        ssg     : out std_logic_vector(7 downto 0);
		  aout	 : out std_logic);
end Nexysdemo;

architecture Behavioral of Nexysdemo is

	------------------------------------------------------------------------
	-- Component Declarations
	------------------------------------------------------------------------
	component word2hurdle is
		Port ( word : in  STD_LOGIC_VECTOR (4 downto 0);
				 hurdle : out  STD_LOGIC_VECTOR (19 downto 0));
	end component;
	
	component clock2pulse is
		Port ( hurdle : in  STD_LOGIC_VECTOR (19 downto 0);
				 noise_on_trigger   : in  STD_LOGIC;
				 clock : in  STD_LOGIC;
				 pulse : out  STD_LOGIC);
	end component;
	------------------------------------------------------------------------
	-- Signal Declarations
	------------------------------------------------------------------------

	signal clkdiv  : std_logic_vector(24 downto 0);
	signal cntr    : std_logic_vector(3 downto 0);
	signal cclk    : std_logic;
	signal dig     : std_logic_vector(6 downto 0);
	signal wave	   : std_logic;

	signal note_choice_switch   : std_logic_vector(4 downto 0);
	signal note_on_hurdle       : std_logic_vector(19 downto 0);
	signal noise_on_trigger     : std_logic;
	signal test_pulse           : std_logic_vector(7 downto 0);
	------------------------------------------------------------------------
	-- Module Implementation
	------------------------------------------------------------------------

	begin

	
	dig <=    
         "0111111" when cntr = "0000" else
			"0000110" when cntr = "0001" else
			"1011011" when cntr = "0010" else
			"1001111" when cntr = "0011" else
			"1100110" when cntr = "0100" else
			"1101101" when cntr = "0101" else
			"1111101" when cntr = "0110" else
			"0000111" when cntr = "0111" else
			"1111111" when cntr = "1000" else
			"1101111" when cntr = "1001" else
			"0000000";

   ssg(6 downto 0) <= not dig;
	led <= test_pulse;
	an <= btn;
	aout <= wave;
	ssg(7) <= '0';
	note_choice_switch <= swt(4 downto 0);
	noise_on_trigger <= swt(7);
	-- Divide the master clock (100Mhz) down to a lower frequency.
	process (mclk)
		begin
			if mclk = '1' and mclk'Event then
				clkdiv <= clkdiv + 1;
			end if;
		end process;

	-- The hurdle for triggering speaker
	word_mapping :  word2hurdle
	 port map ( word      			   => note_choice_switch,
					hurdle  				   => note_on_hurdle
					);

--	 pulse generator
	pulse_generator :  clock2pulse
	 port map ( hurdle 					=> note_on_hurdle,
				   noise_on_trigger     => noise_on_trigger,
				   clock                => mclk,
				   pulse                => wave
					);	
				
	process(wave)
		begin
			if wave = '1' and wave'Event then
				test_pulse <= test_pulse + 1;
			end if;
	end process;
--	process(mclk)
--		begin
--			if mclk = '1' and mclk'Event then
--				if noise_on = '1' then
--					if clock_counter > note_on_hurdle then
--						clock_counter <= "000000000000";
--						wave <= '1';
--					end if;
--				else 
--					wave <= '0';
--					clock_counter <= clock_counter + 1;
--				end if;
--			end if;
--	end process;
--	process (swt) 
--		begin
--		case swt is 
--			when "00000000" =>
--				wave <= clkdiv(0);
--			when "00000001" =>
--				wave <= clkdiv(10);
--			when "00000011" =>
--				wave <= clkdiv(15);
--			when others =>
--				wave <= clkdiv(25);
--		end case;
--	end process;
	

	
	
	
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

