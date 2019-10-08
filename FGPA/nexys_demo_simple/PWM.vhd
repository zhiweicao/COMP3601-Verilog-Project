----------------------------------------------------------------------------------
-- Company: Digilent Ro
-- Engineer: Tudor Armand Ciuleanu
-- 
-- Create Date:   18:10:04 01/12/2008 
-- Module Name:   PWM - Behavioral 
-- Project Name: 	PWM Reference Design	
-- Target Devices: 
-- Tool versions: Xilinx ISE 9.2i
-- Description: Generates a PWM wave on pwm_out output using a 50 MHz input 
-- clock and a switch signal.
--
-- Dependencies: 
--
-- Revision: 0.01 - File Created
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
    Port ( clk : 	in  STD_LOGIC; 		--clock input
				reset : in STD_LOGIC;
           cmpPwm : 	in  STD_LOGIC_VECTOR(7 downto 0); 	--switch input
           pwm_out : 	out  STD_LOGIC	--pwm_out output
			 );
end PWM;

architecture Behavioral of PWM is

--signal cntDiv: std_logic_vector(15 downto 0); 
	-- general clock div/cnt

constant ckPwmRange: integer:= 5;
   -- LSB in the cntPwm alias of cntDiv
signal cntPwm: std_logic_vector(ckPwmRange+8 downto 0);
   -- the superior 8 bits are used for PW Modulator:
   -- cntPwm counts 50MHz/2^ckPwmRange



begin

	PwmCounter: process(clk)
		begin
			if reset = '1' then 
				cntPwm <= (others => '0');
			elsif clk'event and clk='1' then
				cntPwm <= cntPwm + '1';
			end if;
		end process;

	PWM: process(cntPwm, cmpPwm)
		begin
			if cntPwm(ckPwmRange+8 downto ckPwmRange) < cmpPwm then
				-- counter value less than reference
				pwm_out <= '1';          -- Output HIGH
			else 
				-- counter value greater than reference
				pwm_out <= '0';          -- Output LOW
			end if;
		end process;

end Behavioral;

