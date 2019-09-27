----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:37 09/25/2019 
-- Design Name: 
-- Module Name:    clock2pulse - Behavioral 
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

entity clock2pulse is
    Port ( hurdle : in  STD_LOGIC_VECTOR (19 downto 0);
			  noise_on_trigger   : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           pulse : out  STD_LOGIC);
end clock2pulse;

architecture Behavioral of clock2pulse is

signal clock_counter        : std_logic_vector(19 downto 0);
signal last						 : std_logic_vector(1 downto 0);

begin
	process(clock)
		begin
			if noise_on_trigger = '1' then
				if clock = '1' and clock'Event then
					if clock_counter > hurdle then
						clock_counter <= "00000000000000000000";
						last <= last + 1;
					else 
						clock_counter <= clock_counter + 1;
						pulse <= last(0);
					end if;
				end if;
			else
				pulse <= '0';
				clock_counter <= "00000000000000000000";
			end if;
	end process;

end Behavioral;

