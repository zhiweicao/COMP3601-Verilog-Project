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
           hurdle : out  STD_LOGIC_VECTOR (31 downto 0));
end word2hurdle;

architecture Behavioral of word2hurdle is

begin
	hurdle <=	X"0002ea9b" when word = "00001" else
					X"0002c097" when word = "00010" else
					X"00029901" when word = "00011" else
					X"000273d0" when word = "00100" else
					X"00025093" when word = "00101" else
					X"00022f50" when word = "00110" else
					X"00020fdf" when word = "00111" else
					X"0001f23f" when word = "01000" else
					X"0001d64a" when word = "01001" else
					X"0001bbe4" when word = "01010" else
					X"0001a2f2" when word = "01011" else
					X"00018b73" when word = "01100" else
					X"0001753b" when word = "01101" else
					X"0001604b" when word = "01110" else
					X"00014c8f" when word = "01111" else
					X"000139db" when word = "10000" else
					X"0001283e" when word = "10001" else
					X"0001179d" when word = "10010" else
					X"000107ef" when word = "10011" else
					X"0000f91f" when word = "10100" else
					X"0000eb25" when word = "10101" else
					X"0000ddf2" when word = "10110" else
					X"0000d17e" when word = "10111" else
					X"0000c5b9" when word = "11000" else
					X"0000baa2" when word = "11001" else
					X"ffffffff";


end Behavioral;

