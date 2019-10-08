--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:05:20 10/04/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/memory_controller_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory_loading_controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY memory_controller_test IS
END memory_controller_test;
 
ARCHITECTURE behavior OF memory_controller_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory_loading_controller
    Port ( clk 						: 	in  STD_LOGIC; 		--clock input
			  reset 			 			:  in  STD_LOGIC;
			  ready						:  in  STD_LOGIC;
			  data_in				  	:  in  std_logic_vector(7 downto 0);
			  ready_memory_addr  	:  out std_logic_vector(7 downto 0);
			  data_out					: 	out std_logic_vector(15 downto 0);
			  write_on					:  out STD_LOGIC
			 );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal ready_memory_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal ready : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(15 downto 0);
   signal write_on : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memory_loading_controller PORT MAP (
          clk => clk,
          reset => reset,
          ready => ready,
          data_in => data_in,
          ready_memory_addr => ready_memory_addr,
          data_out => data_out,
          write_on => write_on
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		ready <= '1';
		data_in <= "10100111";
      wait for clk_period;	
		ready <= '0';
      wait for 50 ns;	
		ready <= '1';
		data_in <= "00111111";
      wait for clk_period;	
		ready <= '0';
      wait for clk_period;	
		reset <= '0';
      wait for clk_period;	
		reset <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
