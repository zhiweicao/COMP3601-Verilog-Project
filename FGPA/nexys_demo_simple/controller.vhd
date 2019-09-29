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
			  download_mode					: in 	std_logic;
			  data_addr							: out std_logic_vector(15 downto 0);
			  speaker_restart					: out std_logic
			  );
end controller;

architecture Behavioral of controller is
	TYPE State_type IS (S0_init, S1_wait, S2_addr_inc_start, S3_addr_inc_end);
	SIGNAL current_state	: State_type;
	SIGNAL next_state	: State_type;
	signal next_addr 				: std_logic_vector(15 downto 0);
	signal addr_increment 		: std_logic;
begin
	data_addr <= next_addr;

	FSM:PROCESS (reset, clk)
	BEGIN
		IF reset = '1' THEN
			current_state 	<= S0_init;
		ELSIF (clk'EVENT AND clk = '1') THEN
			CASE current_state IS
				WHEN S0_init =>
					current_state <= S1_wait;
				WHEN S1_wait =>
					if note_done = '1' then
						current_state <= S2_addr_inc_start;
					else
						current_state <= S1_wait;
					end if;
				WHEN S2_addr_inc_start =>
					current_state <= S3_addr_inc_end;
				WHEN S3_addr_inc_end =>
					if note_done = '0' then
						current_state <= S1_wait;
					else
						current_state <= S3_addr_inc_end;
					end if;
			END CASE;
		END IF;
	END PROCESS;

	FSM_OUT:PROCESS (current_state)
		BEGIN
			addr_increment <= '0';
			CASE current_state IS
				WHEN S0_init =>
					speaker_restart <= '0';
				WHEN S1_wait =>
					speaker_restart <= '0';
				WHEN S2_addr_inc_start =>
					addr_increment <= '1';
				WHEN S3_addr_inc_end =>
					speaker_restart <= '1';
			END CASE;
	END PROCESS;	
	
	address_increment:PROCESS (clk)
		BEGIN	
		IF reset = '1' THEN
			next_addr <= X"0001";
		ELSIF (clk'EVENT AND clk = '1') THEN
			If (addr_increment = '1') THEN
				next_addr <= next_addr + 1;
			END IF;
		END IF;
	END PROCESS;	
	
end Behavioral;

