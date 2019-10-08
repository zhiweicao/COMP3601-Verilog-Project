--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:30:04 10/01/2019
-- Design Name:   
-- Module Name:   Z:/comp3601/nexys_demo_simple/pwm_test.vhd
-- Project Name:  Nexysdemo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PWM
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
 
ENTITY pwm_test IS
END pwm_test;
 
ARCHITECTURE behavior OF pwm_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM
		Port ( clk : 	in  STD_LOGIC; 		--clock input
				reset : in STD_LOGIC;
           cmpPwm : 	in  STD_LOGIC_VECTOR(7 downto 0); 	--switch input
           pwm_out : 	out  STD_LOGIC	--pwm_out output
			 );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal cmpPwm : std_logic_vector(7 downto 0) := (others => '0');
   signal reset : std_logic := '0';
 	--Outputs
   signal pwm_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PWM PORT MAP (
          clk => clk,
			 reset => reset,
          cmpPwm => cmpPwm,
          pwm_out => pwm_out
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
		cmpPwm <="00001111";
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
