----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:07 09/29/2019 
-- Design Name: 
-- Module Name:    mux_3_to_8 - Behavioral 
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

entity mux_3_to_8 is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end mux_3_to_8;

architecture Behavioral of mux_3_to_8 is

begin
	output <="00000000" when input = "0000" else
				"00000001" when input = "0001" else
				"00000011" when input = "0010" else
				"00000111" when input = "0011" else
				"00001111" when input = "0100" else
				"00011111" when input = "0101" else
				"00111111" when input = "0110" else
				"01111111" when input = "0111" else
				"11111111" when input = "1000" else
				"00000000";
end Behavioral;

