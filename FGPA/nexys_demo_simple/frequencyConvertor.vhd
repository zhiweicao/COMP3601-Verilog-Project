----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:34 09/29/2019 
-- Design Name: 
-- Module Name:    frequencyConvertor - Behavioral 
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

entity frequencyConvertor is
end frequencyConvertor;

architecture Behavioral of frequencyConvertor is
    Port ( clk 					: in  STD_LOGIC;
			  hurdle 				: in  STD_LOGIC_VECTOR (31 downto 0);
			  noise_on_trigger   : in  STD_LOGIC;
           pulse 					: out  STD_LOGIC);
begin


end Behavioral;

