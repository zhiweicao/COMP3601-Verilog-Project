----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:05 10/03/2019 
-- Design Name: 
-- Module Name:    memory_access_controller - Behavioral 
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

entity memory_access_controller is
    Port ( clk 						: 	in  STD_LOGIC; 		--clock input
			  reset 			 			:  in  STD_LOGIC;
			  ready						:  in  STD_LOGIC;
			  data_read_addr			:  in std_logic_vector(15 downto 0);
			  data_in				  	:  in  std_logic_vector(7 downto 0);
			  data_write_bus			: 	out std_logic_vector(15 downto 0);
			  ready_memory_addr  	:  out std_logic_vector(7 downto 0);
			  write_on					:  out STD_LOGIC
			 );
end memory_access_controller;

architecture Behavioral of memory_access_controller is
	signal current_addr				: 			std_logic_vector(7 downto 0);
	signal addr_add_trigger			:			std_logic;
	signal addr_reset_trigger		:			std_logic;
	signal data_in_buffer			:			std_logic_vector(7 downto 0);


	TYPE State_type IS (S0_reset, S1_loading_wait, S2_data_write, S3_reading_wait);
	signal state : State_type;

begin
	data_load_to_buffer: PROCESS(clk)
	BEGIN
		if (clk'EVENT and clk = '1') then
			data_in_buffer <= data_in;
		end if;
	end process;
	
	FSM: PROCESS(clk)
	BEGIN
		if (clk'EVENT and clk = '1') then
			CASE state is
				WHEN S0_reset =>
					state <= S1_loading_wait;
				WHEN S1_loading_wait =>
					if reset = '0' then
						state <= S3_reading_wait;
					elsif ready = '1' then
						state <= S2_data_write;
					else
						state <= S1_loading_wait;
					end if;
				WHEN S2_data_write  =>
					state <= S1_loading_wait;
				WHEN S3_reading_wait =>
					if reset = '1' then
						state <= S0_reset;				
					else
						state <= S3_reading_wait;				
					end if;
			END CASE;
		end if;
	END PROCESS;


	FSM_OUT: PROCESS(state)
	BEGIN
		addr_add_trigger <= '0';
		addr_reset_trigger <= '0';
		data_write_bus <= x"0000";
		write_on <= '0';
--		ready_memory_addr <= X"00";
		CASE state is
			WHEN S0_reset =>
				addr_reset_trigger <= '1';
			WHEN S1_loading_wait =>

			WHEN S2_data_write  =>
				data_write_bus(4 downto 0) <= data_in_buffer(4 downto 0);
				data_write_bus(7 downto 5) <= "000";
				data_write_bus(10 downto 8) <= data_in_buffer(7 downto 5);
				data_write_bus(15 downto 11) <= "00000";
				write_on <= '1';
				addr_add_trigger <= '1';
				ready_memory_addr <= current_addr;
			WHEN S3_reading_wait =>
				ready_memory_addr <= data_read_addr(7 downto 0);
			END CASE;
	END PROCESS;
	
	address_change: PROCESS(state)
	BEGIN
		if addr_reset_trigger = '1' then
			current_addr <= x"00";
		elsif (clk'EVENT and clk = '1') then
			if addr_add_trigger = '1' then
				current_addr <= current_addr + 1;
			end if;
		end if;
	END PROCESS;
end Behavioral;

