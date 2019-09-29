----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:50 09/29/2019 
-- Design Name: 
-- Module Name:    beatsHurdleCalculator - Behavioral 
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

entity beatsHurdleCalculator is
    Port ( clk									: in  std_logic;
			  reset								: in	std_logic;
			  beats_per_second				: in  std_logic_vector(7 downto 0);
			  given_period				: in  std_logic_vector(31 downto 0);
			  times_of_beat_within_period	: out std_logic_vector(31 downto 0);
			  calculation_done				: out std_logic
			  );
end beatsHurdleCalculator;

architecture Behavioral of beatsHurdleCalculator is

signal frequency_runner									: std_logic_vector(7 downto 0);
signal times_of_beat_within_period_counter		: std_logic_vector(31 downto 0);
signal period_counter									: std_logic_vector(31 downto 0);

begin

	times_of_beat_within_period <= times_of_beat_within_period_counter;
	process (clk)
		begin
			if reset = '1' then
				calculation_done <= '0';
				period_counter <= X"00000000";
				frequency_runner <= X"00";
				times_of_beat_within_period_counter <= X"00000000";

			elsif clk = '1' and clk'Event then
				if period_counter < given_period then
					period_counter <= period_counter + 1;
					if frequency_runner < beats_per_second then
						frequency_runner <= frequency_runner + 1;
					else
						times_of_beat_within_period_counter <= times_of_beat_within_period_counter + 1;
						frequency_runner <= X"00";
					end if;
				else
					calculation_done <= '1';
				end if;
			end if;
	end process;

end Behavioral;

