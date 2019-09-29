----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:34 09/28/2019 
-- Design Name: 
-- Module Name:    note2segment - Behavioral 
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

entity note2segment is
    Port ( current_note : in  STD_LOGIC_VECTOR (7 downto 0);
           note_length	 : in  STD_LOGIC_VECTOR (7 downto 0);
           all_ssgs : out  STD_LOGIC_VECTOR (31 downto 0));
end note2segment;


architecture Behavioral of note2segment is

component segment7 is
 Port ( digit  : in  std_logic_vector(3 downto 0);
			ssg    : out std_logic_vector(7 downto 0));
end component;

signal digit_first 					: STD_LOGIC_VECTOR (3 downto 0);
signal digit_second 					: STD_LOGIC_VECTOR (3 downto 0);
signal digit_third 					: STD_LOGIC_VECTOR (3 downto 0);
signal digit_fourth 					: STD_LOGIC_VECTOR (3 downto 0);

begin

	digit_first <= 	"0001" when current_note = "00000001" else
							"0010" when current_note = "00000010" else
							"0011" when current_note = "00000011" else
							"0100" when current_note = "00000100" else
							"0101" when current_note = "00000101" else
							"0110" when current_note = "00000110" else
							"0111" when current_note = "00000111" else
							"1000" when current_note = "00001000" else
							"1001" when current_note = "00001001" else
							"0000" when current_note = "00001010" else
							"0001" when current_note = "00001011" else
							"0010" when current_note = "00001100" else
							"0011" when current_note = "00001101" else
							"0100" when current_note = "00001110" else
							"0101" when current_note = "00001111" else
							"0110" when current_note = "00010000" else
							"0111" when current_note = "00010001" else
							"1000" when current_note = "00010010" else
							"1001" when current_note = "00010011" else
							"0000" when current_note = "00010100" else
							"0001" when current_note = "00010101" else
							"0010" when current_note = "00010110" else
							"0011" when current_note = "00010111" else
							"0100" when current_note = "00011000" else
							"0101" when current_note = "00011001" else
							"0000";
						
	digit_second <= 	"0000" when current_note = "00000001" else
							"0000" when current_note = "00000010" else
							"0000" when current_note = "00000011" else
							"0000" when current_note = "00000100" else
							"0000" when current_note = "00000101" else
							"0000" when current_note = "00000110" else
							"0000" when current_note = "00000111" else
							"0000" when current_note = "00001000" else
							"0000" when current_note = "00001001" else
							"0001" when current_note = "00001010" else
							"0001" when current_note = "00001011" else
							"0001" when current_note = "00001100" else
							"0001" when current_note = "00001101" else
							"0001" when current_note = "00001110" else
							"0001" when current_note = "00001111" else
							"0001" when current_note = "00010000" else
							"0001" when current_note = "00010001" else
							"0001" when current_note = "00010010" else
							"0001" when current_note = "00010011" else
							"0010" when current_note = "00010100" else
							"0010" when current_note = "00010101" else
							"0010" when current_note = "00010110" else
							"0010" when current_note = "00010111" else
							"0010" when current_note = "00011000" else
							"0010" when current_note = "00011001" else
							"0000";
	
	digit_third <= 	note_length(3 downto 0);
							
	digit_fourth <= 	"0000";
	
	segment_mapping_first_digit 	: segment7
    port map  ( digit  					=> digit_first,
					 ssg						=> all_ssgs(7 downto 0)
					 );
					 
	segment_mapping_second_digit 	: segment7
    port map  ( digit  					=> digit_second,
					 ssg						=> all_ssgs(15 downto 8)
					 );
					 
	segment_mapping_third_digit 	: segment7
    port map  ( digit  					=> digit_third,
					 ssg						=> all_ssgs(23 downto 16)
					 );
					 
	segment_mapping_fourth_digit 	: segment7
    port map  ( digit  					=> digit_fourth,
					 ssg						=> all_ssgs(31 downto 24)
					 );
					 
					
end Behavioral;

