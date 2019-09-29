----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:55:29 09/29/2019 
-- Design Name: 
-- Module Name:    speakerPulseGenerator - Behavioral 
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

entity speakerPulseGenerator is
	Port (clk							: in  std_logic;
			beat_pluse					: in  std_logic;
			reset							: in 	std_logic;
			current_note				: in  std_logic_vector(7 downto 0);
			note_length					: in  std_logic_vector(7 downto 0);
			note_pass_led				: out std_logic_vector(7 downto 0);
			note_done					: out std_logic;
			pulse 						: out std_logic);
end speakerPulseGenerator;

architecture Behavioral of speakerPulseGenerator is
	component word2hurdle is
		Port ( word : in  std_logic_vector(4 downto 0);
				 hurdle : out  std_logic_vector(31 downto 0));
				 
	end component;
	
	component clock2pulse is
    Port ( clk 					: in  STD_LOGIC;
			  hurdle 				: in  STD_LOGIC_VECTOR (31 downto 0);
			  noise_on_trigger   : in  STD_LOGIC;
           pulse 					: out  STD_LOGIC);
	end component;
	
	component mux_3_to_8 is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	------------------------------------------------------------------------
	-- signal Declarations
	------------------------------------------------------------------------
	signal note_pass_length 		: std_logic_vector(7 downto 0);
	signal note_pass_out	 		: std_logic_vector(7 downto 0);
	signal note_on_hurdle			: STD_LOGIC_VECTOR(31 downto 0);
	signal pulse_on					: std_logic;
	
begin
	pulse_on	 <= not reset;
	note_pass_led <= note_pass_out;
	
	-- Hurdle Mapping of Note
	word_mapping :  word2hurdle
	port map ( word      			   	=> current_note(4 downto 0),
				  hurdle  				   	=> note_on_hurdle
				);

	--	Pulse generator
	pulse_generator :  clock2pulse
	port map ( clk                		=> clk,
				  hurdle 						=> note_on_hurdle,
				  noise_on_trigger     		=> pulse_on,
				  pulse                		=> pulse
				);	
	mux_to_8:  mux_3_to_8
	port map ( input							=> note_pass_length(3 downto 0),
				  output 						=> note_pass_out
				);	
	
	process(beat_pluse)
		begin
			if reset ='1' then
				note_pass_length <= X"00";
				note_done <= '0';
			elsif beat_pluse = '1' and beat_pluse'Event then
				if note_pass_length < note_length then
					note_pass_length <= note_pass_length + 1;
				else 
					note_done <= '1';
				end if;
			end if;
	end process;

end Behavioral;

