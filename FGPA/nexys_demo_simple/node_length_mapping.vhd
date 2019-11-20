----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:36 11/19/2019 
-- Design Name: 
-- Module Name:    nodeLengtMapping - Behavioral 
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

entity nodeLengtMapping is
    Port ( note_length					: in  std_logic_vector(7 downto 0);
			  note_length_beats			: out std_logic_vector(7 downto 0)
			  );
end nodeLengtMapping;

architecture Behavioral of nodeLengtMapping is

begin

	note_length_beats <=	X"01" when note_length = X"01" else
								X"02" when note_length = X"02" else
								X"04" when note_length = X"03" else
								X"08" when note_length = X"04" else
								X"0c" when note_length = X"05" else
								X"10" when note_length = X"06" else
								X"01";
					
end Behavioral;

