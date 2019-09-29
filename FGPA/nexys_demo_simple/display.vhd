----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:12 09/28/2019 
-- Design Name: 
-- Module Name:    display - Behavioral 
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

entity display is
    Port ( clk						: in std_logic;
			  current_note 		: in  STD_LOGIC_VECTOR (7 downto 0);
           note_length  		: in  STD_LOGIC_VECTOR (7 downto 0);
           anSel 					: out STD_LOGIC_VECTOR (3 downto 0);
			  ssg						: out STD_LOGIC_VECTOR (7 downto 0)
			  );
end display;

architecture Behavioral of display is

component note2segment is
    Port ( current_note : in  STD_LOGIC_VECTOR (7 downto 0);
           note_length	 : in  STD_LOGIC_VECTOR (7 downto 0);
           all_ssgs		 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

constant hurdleOf100Mhz			: STD_LOGIC_VECTOR(16 downto 0) := "10000011010100000";					--100 000
signal counter						: STD_LOGIC_VECTOR(16 downto 0);
signal curr_digit					: STD_LOGIC_VECTOR(1 downto 0);							
signal all_ssgs					: STD_LOGIC_VECTOR(31 downto 0);							

begin
	-- frequency translator
	get_digits : note2segment
		port map  ( current_note  						=> current_note,
						note_length							=> note_length,
						all_ssgs								=> all_ssgs
						);
						
	process (clk)
		begin
			if clk = '1' and clk'Event then
				if counter >= hurdleOf100Mhz then
				    counter <= "00000000000000000";
					 curr_digit <= curr_digit + 1;
				else
				    counter <= counter + 1;
				end if;
			end if;
	end process;
--	anSel <= "0000";
--	ssg 	<= all_ssgs(7 downto 0);

	process (curr_digit)
		begin
			case curr_digit is
				when "00" =>
					anSel <= "1110";
					ssg 	<= all_ssgs(7 downto 0);
				when "01" =>
					anSel <= "1101";
					ssg 	<= all_ssgs(15 downto 8);
				when "10" =>
					anSel <= "1011";
					ssg 	<= all_ssgs(23 downto 16);
				when "11" =>
					anSel <= "0111";
					ssg 	<= all_ssgs(31 downto 24);
				when others =>
					anSel <= "1111";
					ssg 	<= "11111111";
				end case;
	end process;

end Behavioral;

