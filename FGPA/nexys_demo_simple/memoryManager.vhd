----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:18 09/28/2019 
-- Design Name: 
-- Module Name:    memoryManager - Behavioral 
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

-- designed for 50 mhz
entity memoryManager is
	PORT (clk 							: in std_logic;
			reset							: in std_logic;
			download_mode				: in std_logic;
			data_addr					: in std_logic_vector(15 downto 0);
			current_note				: out std_logic_vector(7 downto 0);
			note_length					: out std_logic_vector(7 downto 0)
			);
end memoryManager;
 
architecture Behavioral of memoryManager is

	------------------------------------------------------------------------
	-- Component Declarations
	------------------------------------------------------------------------
	component blockRam is
		PORT (clk 							: in std_logic;
				reset							: in std_logic;
				memory_access_enable 	: in std_logic;
				write_enable 				: in std_logic;
				addr 							: in std_logic_vector(5 downto 0);
				data_in 						: in std_logic_vector(15 downto 0);
				data_out 					: out std_logic_vector(15 downto 0));
	end component;
	------------------------------------------------------------------------
	-- Signal Declarations
	------------------------------------------------------------------------	
	signal data_in							: std_logic_vector(15 downto 0);
	signal data_out						: std_logic_vector(15 downto 0);
	signal memory_position 				: std_logic_vector(5 downto 0);
	signal legit_addr						: std_logic_vector(5 downto 0);
	signal write_enable					: std_logic;
	signal memory_access_enable		: std_logic;
	
begin
	memory_access_enable 	<= '1';
	write_enable				<= '0';
	legit_addr					<= data_addr(5 downto 0);
	current_note				<= data_out(7 downto 0);
	note_length					<= data_out(15 downto 8);
	------------------------------------------------------------------------
	-- load module
	------------------------------------------------------------------------
	 blockMemory :  blockRam
	 port map ( clk 								=>		clk,
					reset								=>		reset,
					memory_access_enable 		=>		memory_access_enable,
					write_enable 					=>		write_enable,
					addr 								=>		legit_addr,
					data_in 							=>		data_in,
					data_out 						=> 	data_out
					);


end Behavioral;

