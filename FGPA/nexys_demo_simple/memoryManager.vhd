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
			data_read_addr				: in std_logic_vector(15 downto 0);
			current_note				: out std_logic_vector(7 downto 0);
			note_length					: out std_logic_vector(7 downto 0);
		   EppDB							: inout std_logic_vector(7 downto 0);
		   EppAstb 						: in std_logic;
		   EppDstb 						: in std_logic;
		   EppWr 						: in std_logic;
		   EppWait 						: out std_logic
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
				addr 							: in std_logic_vector(7 downto 0);
				data_in 						: in std_logic_vector(15 downto 0);
				data_out 					: out std_logic_vector(15 downto 0));
	end component;
	
	component dpimref is
	    Port (
		  clk 					: in std_logic;
        EppDB					: inout std_logic_vector(7 downto 0);
        EppAstb 				: in std_logic;
        EppDstb 				: in std_logic;
        EppWr 					: in std_logic;
        EppWait 				: out std_logic;
		  ready					: out std_logic;
		  memory_data_bus		: out std_logic_vector(7 downto 0)
	);
	end component;
	
	component memory_access_controller is
    Port ( clk 						: 	in  STD_LOGIC; 		--clock input
			  reset 			 			:  in  STD_LOGIC;
			  ready						:  in  STD_LOGIC;
			  data_read_addr			:  in std_logic_vector(15 downto 0);
			  data_in				  	:  in  std_logic_vector(7 downto 0);
			  data_write_bus			: 	out std_logic_vector(15 downto 0);
			  ready_memory_addr  	:  out std_logic_vector(7 downto 0);
			  write_on					:  out STD_LOGIC
			 );
	end component;
	------------------------------------------------------------------------
	-- Signal Declarations
	------------------------------------------------------------------------	
	signal data_out						: std_logic_vector(15 downto 0);
	signal data_write_bus				: std_logic_vector(15 downto 0);
	signal write_enable					: std_logic;
	signal memory_access_enable		: std_logic;
	signal ready							: std_logic;
	signal memory_data_bus				: std_logic_vector(7 downto 0);
	signal ready_memory_addr			: std_logic_vector(7 downto 0);
begin
	memory_access_enable 	<= '1';
	current_note				<= data_out(7 downto 0);
	note_length					<= data_out(15 downto 8);
	------------------------------------------------------------------------
	-- load module
	------------------------------------------------------------------------
	 blockMemory :  blockRam
	 port map ( clk 								=>	clk,
					reset								=>	reset,
					memory_access_enable 		=>	memory_access_enable,
					write_enable 					=>	write_enable,
					addr 								=>	ready_memory_addr,
					data_in 							=>	data_write_bus,
					data_out 						=> data_out
					);
	 epp_data_transfer :  dpimref
	 port map ( clk  								=>	clk,
				   EppDB 							=>	EppDB,
					EppAstb 							=>	EppAstb,
					EppDstb  						=>	EppDstb,
					EppWr  							=>	EppWr,
					EppWait 	 						=>	EppWait,
					ready	 							=>	ready,
				   memory_data_bus	 			=>	memory_data_bus
					);
		
	controller	: memory_access_controller
	 port map ( clk  								=>	clk,
					reset								=>	reset,
					ready								=> ready,
					data_read_addr					=> data_read_addr,
					data_in							=> memory_data_bus,
					ready_memory_addr 			=>	ready_memory_addr,
					data_write_bus					=> data_write_bus,
					write_on							=> write_enable
					);
end Behavioral;

