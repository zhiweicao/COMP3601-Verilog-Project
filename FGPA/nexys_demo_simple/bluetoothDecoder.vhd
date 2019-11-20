----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:04 11/19/2019 
-- Design Name: 
-- Module Name:    bluetoothDecoder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bluetoothDecoder is
Port ( clk									: in  std_logic;
		 bluetooth_ready					: in 	std_logic;
	    bluetooth_data_bus				: in  std_logic_vector(7 downto 0);
	    increase_tempo					: out std_logic;
	    decrease_tempo					: out std_logic
		 );
end bluetoothDecoder;

architecture Behavioral of bluetoothDecoder is
	signal increase_tempo_reg		: std_logic;
	signal decrease_tempo_reg		: std_logic;

begin
	
	docoder:PROCESS (clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			if (bluetooth_ready = '1') then
				if (bluetooth_data_bus = X"2B") then
					increase_tempo_reg <= '1';
				elsif (bluetooth_data_bus = X"2D") then
					decrease_tempo_reg <= '1';
				else
					increase_tempo_reg <= '0';
					decrease_tempo_reg <= '0';	
				end if;
			else
				increase_tempo_reg <= '0';
				decrease_tempo_reg <= '0';			
			end if;
		end if;
	END PROCESS;
increase_tempo <= increase_tempo_reg;
decrease_tempo <= decrease_tempo_reg;

end Behavioral;

