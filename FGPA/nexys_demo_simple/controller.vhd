----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:48:40 09/29/2019 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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

entity controller is
    Port ( clk									: in  std_logic;
			  reset								: in	std_logic;
			  note_done							: in 	std_logic;
			  increase_tempo					: in 	std_logic;
			  decrease_tempo					: in 	std_logic;
			  raw_data_in						: in  std_logic_vector(7 downto 0);
			  bluetooth_ready					: in 	std_logic;
			  bluetooth_data_bus				: in  std_logic_vector(7 downto 0);
			  data_addr							: out std_logic_vector(15 downto 0);
			  beats_per_second				: out std_logic_vector(7 downto 0);
			  speaker_reset					: out std_logic;
			  tempo_reset						: out std_logic;
			  led_debug							: out std_logic_vector(7 downto 0)			  
			  );
end controller;

architecture Behavioral of controller is


	component bluetoothDecoder is
		 Port (clk									: in  std_logic;
				 bluetooth_ready					: in 	std_logic;
				 bluetooth_data_bus				: in  std_logic_vector(7 downto 0);
				 increase_tempo					: out std_logic;
				 decrease_tempo					: out std_logic
				 );
	end component;



	TYPE State_type IS (S0_init, S1_predefined_tempo_reading, S1_wait, S2_addr_inc_start, S3_addr_inc_end, 
								S5_tempo_increase_start, S6_tempo_increase_done,
								S7_tempo_decrease_start, S8_tempo_decrease_done);
	SIGNAL current_state				: State_type;
--	SIGNAL next_state					: State_type;
	signal next_addr 					: std_logic_vector(15 downto 0);
	signal addr_increment 			: std_logic;
	signal curr_tempo					: std_logic_vector(6 downto 0);
	signal next_tempo					: std_logic_vector(6 downto 0);
	signal tempo_change_event		: std_logic;
	signal speaker_restart			: std_logic;
	signal set_predefined_tempo	: std_logic;
	signal increase_tempo_event	: std_logic;
	signal decrease_tempo_event	: std_logic;
	signal increase_tempo_reg		: std_logic;
	signal decrease_tempo_reg		: std_logic;
	signal note_done_reg				: std_logic;
	
	constant upper_tempo				: std_logic_vector(6 downto 0) := "1111000";
	constant lower_tempo				: std_logic_vector(6 downto 0) := "0000001";
begin
	data_addr <= next_addr;
	speaker_reset <= speaker_restart or reset;
	tempo_reset <= tempo_change_event or reset;
	beats_per_second(7) <= '0';
	beats_per_second(6 downto 0) <= curr_tempo;
	
	led_debug(7) <= bluetooth_ready;
	led_debug(6) <= '0';
	led_debug(5) <= increase_tempo_reg;
	led_debug(4) <= decrease_tempo_event;
	
	
	state_syn:PROCESS (reset, clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
--			current_state <= next_state;
--			increase_tempo_reg <= increase_tempo;
--			decrease_tempo_reg <= decrease_tempo;
			note_done_reg <= note_done;
		end if;
	END PROCESS;
	bluetooth_Decoder :  bluetoothDecoder
	 port map ( clk								=>	clk,
					bluetooth_ready				=>	bluetooth_ready,
					bluetooth_data_bus			=>	bluetooth_data_bus,
					increase_tempo					=>	increase_tempo_reg,
					decrease_tempo					=>	decrease_tempo_reg
					);
						


	FSM:PROCESS (reset, clk)
	BEGIN
		IF reset = '1' THEN
			current_state 	<= S0_init;
		ELSIF (clk'EVENT AND clk = '1') THEN
			CASE current_state IS
				WHEN S0_init =>
					current_state <= S1_predefined_tempo_reading;
				WHEN S1_predefined_tempo_reading =>
					current_state <= S1_wait;
				WHEN S1_wait =>
					if increase_tempo_reg = '1' then
						current_state <= S5_tempo_increase_start;
					elsif decrease_tempo_reg = '1' then
						current_state <= S7_tempo_decrease_start;
					elsif note_done_reg = '1' then
						current_state <= S2_addr_inc_start;
					else
						current_state <= S1_wait;
					end if;
				WHEN S2_addr_inc_start =>
					current_state <= S3_addr_inc_end;
				WHEN S3_addr_inc_end =>
					if note_done_reg = '0' then
						current_state <= S1_wait;
					else
						current_state <= S3_addr_inc_end;
					end if;
				when S5_tempo_increase_start =>
					current_state <= S6_tempo_increase_done;
				when S6_tempo_increase_done =>
					if increase_tempo_reg = '0' then
						current_state <= S1_wait;
					else
						current_state <= S6_tempo_increase_done;
					end if;
				when S7_tempo_decrease_start =>
					current_state <= S8_tempo_decrease_done;
				when S8_tempo_decrease_done =>
					if decrease_tempo_reg = '0' then
						current_state <= S1_wait;
					else
						current_state <= S8_tempo_decrease_done;
					end if;

			END CASE;
		END IF;
	END PROCESS;

	FSM_OUT:PROCESS (current_state)
		BEGIN
			increase_tempo_event <= '0';
			decrease_tempo_event <= '0';
			addr_increment <= '0';
			speaker_restart <= '0';
			set_predefined_tempo <= '0';
			CASE current_state IS
				WHEN S0_init =>
--					led_debug(3 downto 0) <= X"0";
				WHEN S1_predefined_tempo_reading =>
--					led_debug(3 downto 0) <= X"1";
					set_predefined_tempo <= '1';
					addr_increment <= '1';
				WHEN S1_wait =>
--					led_debug(3 downto 0) <= X"2";
					speaker_restart <= '0';
				WHEN S2_addr_inc_start =>
--					led_debug(3 downto 0) <= X"3";
					addr_increment <= '1';
				WHEN S3_addr_inc_end =>
--					led_debug(3 downto 0) <= X"4";
					addr_increment <= '0';
					speaker_restart <= '1';
				when S5_tempo_increase_start =>
--					led_debug(3 downto 0) <= X"5";
					increase_tempo_event <= '1';
				when S6_tempo_increase_done =>
--					led_debug(3 downto 0) <= X"6";
				when S7_tempo_decrease_start =>
--					led_debug(3 downto 0) <= X"7";
					decrease_tempo_event <= '1';
				when S8_tempo_decrease_done =>
--					led_debug(3 downto 0) <= X"8";
			END CASE;
	END PROCESS;	
	

	tempo_change_process:PROCESS (reset, clk)
		BEGIN	
		IF reset = '1' THEN
			tempo_change_event <= '1';
			curr_tempo <= "0000000";
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF set_predefined_tempo = '1' then
				curr_tempo <= raw_data_in(6 downto 0);
				tempo_change_event <= '1';
			elsif increase_tempo_event = '1' then
				if (upper_tempo > curr_tempo) then
					curr_tempo <= curr_tempo + 1;
					tempo_change_event <= '1';
				else
					tempo_change_event <= '0';				
				end if;
			elsif decrease_tempo_event = '1' then
				if (curr_tempo > lower_tempo) then
					curr_tempo <= curr_tempo - 1;
					tempo_change_event <= '1';
				else
					tempo_change_event <= '0';
				end if;
			else
				tempo_change_event <= '0';
			end if;
		END IF;
	END PROCESS;	
	
	
	address_increment:PROCESS (clk)
		BEGIN	
		IF reset = '1' THEN
			next_addr <= X"0000";
		ELSIF (clk'EVENT AND clk = '1') THEN
			If (addr_increment = '1') THEN
				next_addr <= next_addr + 1;
			END IF;
		END IF;
	END PROCESS;	
	
end Behavioral;

