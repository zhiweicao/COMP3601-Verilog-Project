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

	component nodeLengtMapping is
    Port ( note_length					: in  std_logic_vector(7 downto 0);
			  note_length_beats			: out  std_logic_vector(7 downto 0)
			  );
	end component;

	------------------------------------------------------------------------
	-- signal Declarations
	------------------------------------------------------------------------
	
	TYPE State_types IS (S0_init, S1_wait_pulse, S2_get_pulse, S3_pulse_length_increase, S4_pulse_done);
	SIGNAL current_state				: State_types;
	
	signal note_pass_length 		: std_logic_vector(7 downto 0);
	signal next_length		 		: std_logic_vector(7 downto 0);
	signal note_length_beats 		: std_logic_vector(7 downto 0);
	signal note_pass_out	 		: std_logic_vector(7 downto 0);
	signal note_on_hurdle			: STD_LOGIC_VECTOR(31 downto 0);
	signal pulse_on					: std_logic;
	signal pulse_increase					: std_logic;
begin
	pulse_on	 <= not reset;
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
	node_lengt_mapping:  nodeLengtMapping
	port map ( note_length							=> note_length,
				  note_length_beats 					=> note_length_beats
				);	
				
	FSM:PROCESS (reset, clk)
	BEGIN
		IF reset = '1' THEN
			current_state 	<= S0_init;
		ELSIF (clk'EVENT AND clk = '1') THEN
			CASE current_state IS
				WHEN S0_init =>
					current_state <= S1_wait_pulse;
				WHEN S1_wait_pulse =>
					if beat_pluse = '1' then
						current_state <= S2_get_pulse;
					end if;
				WHEN S2_get_pulse =>
					if beat_pluse = '0' then
						current_state <= S3_pulse_length_increase;
					end if;
				WHEN S3_pulse_length_increase =>
					current_state <= S4_pulse_done;
				WHEN S4_pulse_done =>
					current_state <= S1_wait_pulse;
			END CASE;
		END IF;
	END PROCESS;
--				note_pass_led(3 downto 0) <= X"1";
	FSM_OUT:PROCESS (current_state)
	BEGIN
		pulse_increase <= '0';
		CASE current_state IS
			WHEN S0_init =>
				note_pass_led(3 downto 0) <= X"1";
			WHEN S1_wait_pulse =>
				note_pass_led(3 downto 0) <= X"2";
			WHEN S2_get_pulse =>
				note_pass_led(3 downto 0) <= X"3";
			WHEN S3_pulse_length_increase =>
				note_pass_led(3 downto 0) <= X"4";
				pulse_increase <= '1';
			WHEN S4_pulse_done =>
				note_pass_led(3 downto 0) <= X"5";

			END CASE;
	END PROCESS;
	node_done_process:PROCESS (reset, clk)
	BEGIN
		IF reset = '1' THEN
			note_done <= '0';
		ELSIF (clk'EVENT AND clk = '1') THEN
			if note_pass_length >= note_length_beats then
				note_done <= '1';
			else 
				note_done <= '0';
			end if;
		END IF;
	END PROCESS;

	pulse_increase_process:PROCESS (reset, clk)
	BEGIN
		IF reset = '1' THEN
			note_pass_length <= X"00";
		ELSIF (clk'EVENT AND clk = '1') THEN
			if pulse_increase = '1' then
				note_pass_length <= note_pass_length + 1;
			end if;
		END IF;
	END PROCESS;

end Behavioral;

