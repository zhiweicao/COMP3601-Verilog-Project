----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:48 09/25/2019 
-- Design Name: 
-- Module Name:    word2hurdle - Behavioral 
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

entity word2hurdle is
    Port ( word : in  STD_LOGIC_VECTOR (4 downto 0);
           hurdle : out  STD_LOGIC_VECTOR (19 downto 0));
end word2hurdle;

architecture Behavioral of word2hurdle is

begin
	process (word)
		begin
		case word is
			when "00001" =>
				hurdle <= "00101110101010011011";
			when "00010" =>
				hurdle <= "00101100000010010111";
			when "00011" =>
				hurdle <= "00101001100100000001";
			when "00100" =>
				hurdle <= "00100111001111010000";
			when "00101" =>
				hurdle <= "00100101000010010011";
			when "00110" =>
				hurdle <= "00100010111101010000";
			when "00111" =>
				hurdle <= "00100000111111011111";
			when "01000" =>
				hurdle <= "00011111001000111111";
			when "01001" =>
				hurdle <= "00011101011001001010";
			when "01010" =>
				hurdle <= "00011011101111100100";
			when "01011" =>
				hurdle <= "00011010001011110010";
			when "01100" =>
				hurdle <= "00011000101101110011";
			when "01101" =>
				hurdle <= "00010111010100111011";
			when "01110" =>
				hurdle <= "00010110000001001011";
			when "01111" =>
				hurdle <= "00010100110010001111";
			when "10000" =>
				hurdle <= "00010011100111011011";
			when "10001" =>
				hurdle <= "00010010100000111110";
			when "10010" =>
				hurdle <= "00010001011110011101";
			when "10011" =>
				hurdle <= "00010000011111101111";
			when "10100" =>
				hurdle <= "00001111100100011111";
			when "10101" =>
				hurdle <= "00001110101100100101";
			when "10110" =>
				hurdle <= "00001101110111110010";
			when "10111" =>
				hurdle <= "00001101000101111110";
			when "11000" =>
				hurdle <= "00001100010110111001";
			when "11001" =>
				hurdle <= "00001011101010100010";
			when others =>
				hurdle <= "11111111111111111111";
		end case;
	end process;

end Behavioral;

