----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:50 09/28/2019 
-- Design Name: 
-- Module Name:    beatsManager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity beatsManager is
    Port ( clk								: in  std_logic;
			  reset							: in	std_logic;
			  beats_per_second			: in  std_logic_vector(7 downto 0);
			  beat_pluse					: out std_logic
			  );
end beatsManager;

architecture Behavioral of beatsManager is

	component beatsHurdleCalculator is
    Port ( clk									: in  std_logic;
			  reset								: in	std_logic;
			  beats_per_second				: in  std_logic_vector(7 downto 0);
			  given_period						: in  std_logic_vector(31 downto 0);
			  times_of_beat_within_period	: out std_logic_vector(31 downto 0);
			  calculation_done				: out std_logic
			  );
	end component;
	
	component clock2pulse is
    Port ( clk 					: in  STD_LOGIC;
			  hurdle 				: in  STD_LOGIC_VECTOR (31 downto 0);
			  noise_on_trigger   : in  STD_LOGIC;
           pulse 					: out  STD_LOGIC);
	end component;

	
--	TYPE State_type IS (S0_beat_hurdle_calculation, S1_beat_generator);
--	SIGNAL current_state: State_type;
	signal clkHurdle						: std_logic_vector(31 downto 0);

	signal given_period							: std_logic_vector(31 downto 0) := (others => '0');
	signal times_of_beat_within_period		: std_logic_vector(31 downto 0) := (others => '0');
	signal one_beats_taken_clk_frequency	: std_logic_vector(31 downto 0) := (others => '0');
	signal half_beats_taken_clk_frequency	: std_logic_vector(31 downto 0) := (others => '0');
	signal calculation_done						: std_logic;
	constant sixty 								: std_logic_vector(7 downto 0) := X"3c"; --60
	
	
begin
	clkHurdle <= X"59682f00";
	given_period(20 downto 0)	<= clkHurdle(31 downto 11);
	-- frequency hurdle/4
	one_beats_taken_clk_frequency(31 downto 11) 	<=  	times_of_beat_within_period(20 downto 0);
	half_beats_taken_clk_frequency(30 downto 0) 	<= 	one_beats_taken_clk_frequency(31 downto 1);
	half_beats_taken_clk_frequency(31) <= '0';
	
	
	-- hurdle_calculation
	beats_Hurdle_Calculator : beatsHurdleCalculator
    port map  (  clk												=> clk,
					  reset											=> reset,
					  beats_per_second							=>	beats_per_second,
					  given_period									=>	given_period,
					  times_of_beat_within_period				=>	times_of_beat_within_period,
					  calculation_done							=>	calculation_done
					);

	
	pulse_generator :  clock2pulse
	port map ( clk                							=> clk,
				  hurdle 											=> half_beats_taken_clk_frequency,
				  noise_on_trigger     							=> calculation_done,
				  pulse                							=> beat_pluse
				);	
				
end Behavioral;

