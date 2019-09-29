----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:03 09/28/2019 
-- Design Name: 
-- Module Name:    segment7 - Behavioral 
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

entity segment7 is
    Port (
        digit   : in  std_logic_vector(3 downto 0);
        ssg     : out std_logic_vector(7 downto 0));
end segment7;

architecture Behavioral of segment7 is

signal temp : std_logic_vector(6 downto 0);

begin
	temp <=    
         "0111111" when digit = "0000" else
			"0000110" when digit = "0001" else
			"1011011" when digit = "0010" else
			"1001111" when digit = "0011" else
			"1100110" when digit = "0100" else
			"1101101" when digit = "0101" else
			"1111101" when digit = "0110" else
			"0000111" when digit = "0111" else
			"1111111" when digit = "1000" else
			"1101111" when digit = "1001" else
			"0000000";

   ssg(6 downto 0) <= not temp;
	ssg(7) <= '1';

end Behavioral;

