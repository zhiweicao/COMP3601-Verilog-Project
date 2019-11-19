----------------------------------------------------------------------------
--	DPIMREF.VHD -- Digilent Parallel Interface Module Reference Design
----------------------------------------------------------------------------
-- Author:  Gene Apperson
--          Copyright 2004 Digilent, Inc.
----------------------------------------------------------------------------
-- IMPORTANT NOTE ABOUT BUILDING THIS LOGIC IN ISE
--
-- Before building the Dpimref logic in ISE:
-- 	1.  	In Project Navigator, right-click on "Synthesize-XST"
--		(in the Process View Tab) and select "Properties"
--	2.	Click the "HDL Options" tab
--	3. 	Set the "FSM Encoding Algorithm" to "None"
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
--	This module contains an example implementation of Digilent Parallel
--	Interface Module logic. This interface is used in conjunction with the
--	DPCUTIL DLL and a Digilent Communications Module (USB, EtherNet, Serial)
--	to exchange data with an application running on a host PC and the logic
--	implemented in a gate array.
--
--	See the Digilent document, Digilent Parallel Interface Model Reference
--	Manual (doc # 560-000) for a description of the interface.
--
--	This module also conforms with the Digilent Asynchronous Parallel
--	Interface (DEPP) specification, as outlined in the document titled 
--	"Digilent Asynchronous Parallel Interface(DEPP)" (doc # 564-000). This
--	allows for the host to make calls to the DEPP API, as introduced in 
--	Adept SDK 2. 
--
--	This design uses a state machine implementation to respond to transfer
--	cycles. It implements an address register, 8 internal data registers
--	that merely hold a value written, and interface registers to communicate
--	with a Digilent FPGA board. There is an LED output register whose value 
--	drives the 8 discrete leds on the board. There are two input registers.
--	One reads the 8 switches on the board and the other reads the buttons.
--
--	The top level port names conform with the master .ucf files provided 
--	on the Digilent website, www.digilentinc.com. If your Digilent board
--	is compatible with this project, then the master .ucf file available
--	for it there will contain ports with these names. 
--
--	Interface signals used in top level entity port:
--		clk      - master clock, generally 50Mhz osc on system board
--		DB       - port data bus
--		EppASTB  - address strobe
--		EppDSTB  - data strobe
--		EppWRITE - data direction (described in reference manual as WRITE)
--		EppWAIT  - transfer synchronization (described in reference manual
--		          as WAIT)
--		Led      - LED outputs
--		sw       - switch inputs
--		btn      - button inputs
--		
----------------------------------------------------------------------------
-- Revision History:
--  06/09/2004(GeneA): created
--	 08/10/2004(GeneA): initial public release
--	 04/25/2006(JoshP): comment addition  
--	 01/30/2012(SamB) : Removed debugging led logic and ldb signal
--	                    Changed signal names to conform with General UCFs
--	                    Updated comments for DEPP and multiple boards
--	 08/02/2012(JoshS): Net names in general UCFs updated, applied changes
--							  to demo to keep up to date.
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dpimref is
    Port (
		  clk 					: in std_logic;
        EppDB					: inout std_logic_vector(7 downto 0);
        EppAstb 				: in std_logic;
        EppDstb 				: in std_logic;
        EppWr 					: in std_logic;
        EppWait 				: out std_logic;
		  ready					: out std_logic;
		  memory_data_bus		: out std_logic_vector(7 downto 0)
--		  sw	: in std_logic_vector(7 downto 0);
--		  led	: out std_logic_vector(7 downto 0);
--		  btn	: in std_logic_vector(3 downto 0)
	);
end dpimref;

  architecture Behavioral of dpimref is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Local Type Declarations
------------------------------------------------------------------------

------------------------------------------------------------------------
--  Constant Declarations
------------------------------------------------------------------------

	-- The following constants define state codes for the EPP port interface
	-- state machine. The high order bits of the state number give a unique
	-- state identifier. The low order bits are the state machine outputs for
	-- that state. This type of state machine implementation uses no
	-- combination logic to generate outputs which should produce glitch
	-- free outputs.
	---------------------------------------------------------------------
	-- bit 4 - 7 make these constant distinguishable
	-- bit 0 - 3 is used to control the behaviours
	-- ctlEppWait <= stEppCur(0);
	-- ctlEppDir  <= stEppCur(1);			ctlEppDir == 1 and EPPwr == 1  ----> DB =  busEppOut  ||   ctrlEppDir = 1 is only happened during read mode
	-- ctlEppAwr  <= stEppCur(2);
	-- ctlEppDwr  <= stEppCur(3);
	--
	-- (ctlEppDwr, ctlEppAwr, ctlEppDir, ctlEppWait)
	constant	stEppReady	: std_logic_vector(7 downto 0) := "0000" & "0000";
	constant	state_Epp_Address_Write_A	: std_logic_vector(7 downto 0) := "0001" & "0100";
	constant	state_Epp_Address_Write_B	: std_logic_vector(7 downto 0) := "0010" & "0001";
	constant	state_Epp_Address_Read_A	: std_logic_vector(7 downto 0) := "0011" & "0010";
	constant	state_Epp_Address_Read_B	: std_logic_vector(7 downto 0) := "0100" & "0011";
	constant	state_Epp_Data_Write_A	: std_logic_vector(7 downto 0) := "0101" & "1000";
	constant	state_Epp_Data_Write_B	: std_logic_vector(7 downto 0) := "0110" & "0001";
	constant	state_Epp_Data_Read_A	: std_logic_vector(7 downto 0) := "0111" & "0010";
	constant	state_Epp_Data_Read_B	: std_logic_vector(7 downto 0) := "1000" & "0011";

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------

	-- State machine current state register
	signal	stEppCur	: std_logic_vector(7 downto 0) := stEppReady;

	signal	stEppNext	: std_logic_vector(7 downto 0);

	signal	clkMain		: std_logic;

	-- Internal control signales
	signal	ctlEppWait	: std_logic;
	signal	ctlEppAstb	: std_logic;
	signal	ctlEppDstb	: std_logic;
	signal	ctlEppDir	: std_logic;
	signal	controlEppWrite	: std_logic;
	signal	ctlEppAwr	: std_logic;
	signal	ctlEppDwr	: std_logic;
	signal	busEppOut	: std_logic_vector(7 downto 0);
	signal	busEppIn	: std_logic_vector(7 downto 0);
	signal	busEppData	: std_logic_vector(7 downto 0);

	-- Registers
	signal	regEppAdr	: std_logic_vector(3 downto 0);
	signal	regData0	: std_logic_vector(7 downto 0);
	signal	regData1	: std_logic_vector(7 downto 0);
    signal  regData2	: std_logic_vector(7 downto 0);
    signal  regData3	: std_logic_vector(7 downto 0);
    signal  regData4	: std_logic_vector(7 downto 0);
	signal	regData5	: std_logic_vector(7 downto 0);
	signal	regData6	: std_logic_vector(7 downto 0);
	signal	regData7	: std_logic_vector(7 downto 0);
	signal	regLed		: std_logic_vector(7 downto 0);

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------

-------------------modifications
---interface(blck box output):
--ready
--data(8 bits)
--addr(8 bits)

--data will be written into register 2 & address will be written into register 3





begin

    ------------------------------------------------------------------------
	-- Map basic status and control signals
    ------------------------------------------------------------------------
	

	clkMain <= clk;

	ctlEppAstb <= EppASTB;
	ctlEppDstb <= EppDSTB;
	controlEppWrite   <= EppWr;
	EppWAIT    <= ctlEppWait;	-- drive WAIT from state machine output

	-- Data bus direction control. The internal input data bus always
	-- gets the port data bus. The port data bus drives the internal
	-- output data bus onto the pins when the interface says we are doing
	-- a read cycle and we are in one of the read cycles states in the
	-- state machine.
	busEppIn <= EppDB;
	EppDB <= busEppOut when controlEppWrite = '1' and ctlEppDir = '1' else "ZZZZZZZZ";

	-- Select either address or data onto the internal output data bus.
	busEppOut <= "0000" & regEppAdr when ctlEppAstb = '0' else busEppData;
	memory_data_bus <= busEppData;
--	Led <= regLed;

	-- Decode the address register and select the appropriate data register
	busEppData <=	regData0 when regEppAdr = "0000" else
					   regData1 when regEppAdr = "0001" else
					   regData2 when regEppAdr = "0010" else
					   regData3 when regEppAdr = "0011" else
					   regData4 when regEppAdr = "0100" else
					   regData5 when regEppAdr = "0101" else
					   regData6 when regEppAdr = "0110" else
					   regData7 when regEppAdr = "0111" else
--					   sw    when regEppAdr = "1000" else
--					   "0000" & btn when regEppAdr = "1001" else
					   "00000000";

    ------------------------------------------------------------------------
	-- EPP Interface Control State Machine
    ------------------------------------------------------------------------

	-- Map control signals from the current state
	ctlEppWait <= stEppCur(0);
	ctlEppDir  <= stEppCur(1);
	ctlEppAwr  <= stEppCur(2);
	ctlEppDwr  <= stEppCur(3);

	-- This process moves the state machine to the next state
	-- on each clock cycle
	process (clkMain)
		begin
			if clkMain = '1' and clkMain'Event then
				stEppCur <= stEppNext;
			end if;
		end process;

	-- This process determines the next state machine state based
	-- on the current state and the state machine inputs.
	process (stEppCur, stEppNext, ctlEppAstb, ctlEppDstb, controlEppWrite)
		begin
			case stEppCur is
				-- Idle state waiting for the beginning of an EPP cycle
				when stEppReady =>
					if ctlEppAstb = '0' then
						-- Address read or write cycle
						if controlEppWrite = '0' then
							stEppNext <= state_Epp_Address_Write_A;
						else
							stEppNext <= state_Epp_Address_Read_A;
						end if;

					elsif ctlEppDstb = '0' then
						-- Data read or write cycle
						if controlEppWrite = '0' then
							stEppNext <= state_Epp_Data_Write_A;
						else
							stEppNext <= state_Epp_Data_Read_A;
						end if;

					else
						-- Remain in ready state
						stEppNext <= stEppReady;
					end if;											

				-- Write address register
				when state_Epp_Address_Write_A =>
					stEppNext <= state_Epp_Address_Write_B;

				when state_Epp_Address_Write_B =>
					if ctlEppAstb = '0' then
						stEppNext <= state_Epp_Address_Write_B;
					else
						stEppNext <= stEppReady;
					end if;		

				-- Read address register
				when state_Epp_Address_Read_A =>
					stEppNext <= state_Epp_Address_Read_B;

				when state_Epp_Address_Read_B =>
					if ctlEppAstb = '0' then
						stEppNext <= state_Epp_Address_Read_B;
					else
						stEppNext <= stEppReady;
					end if;

				-- Write data register
				when state_Epp_Data_Write_A =>
					stEppNext <= state_Epp_Data_Write_B;

				when state_Epp_Data_Write_B =>
					if ctlEppDstb = '0' then
						stEppNext <= state_Epp_Data_Write_B;
					else
 						stEppNext <= stEppReady;
					end if;

				-- Read data register
				when state_Epp_Data_Read_A =>
					stEppNext <= state_Epp_Data_Read_B;
										
				when state_Epp_Data_Read_B =>
					if ctlEppDstb = '0' then
						stEppNext <= state_Epp_Data_Read_B;
					else
				  		stEppNext <= stEppReady;
					end if;

				-- Some unknown state				
				when others =>
					stEppNext <= stEppReady;

			end case;
		end process;
		
    ------------------------------------------------------------------------
	-- EPP Address register
    ------------------------------------------------------------------------

	process (clkMain, ctlEppAwr)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppAwr = '1' then
					regEppAdr <= busEppIn(3 downto 0);
				end if;
			end if;
		end process;

    ------------------------------------------------------------------------
	-- EPP Data registers
    ------------------------------------------------------------------------
 	-- The following processes implement the interface registers. These
	-- registers just hold the value written so that it can be read back.
	-- In a real design, the contents of these registers would drive additional
	-- logic.
	-- The ctlEppDwr signal is an output from the state machine that says
	-- we are in a 'write data register' state. This is combined with the
	-- address in the address register to determine which register to write.

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0000" then
					regData0 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0001" then
					regData1 <= busEppIn;
					ready <= '1';
--					led <= busEppIn;
				else
					ready <= '0';
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0010" then
					regData2 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0011" then
					regData3 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0100" then
					regData4 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0101" then
					regData5 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0110" then
					regData6 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "0111" then
					regData7 <= busEppIn;
				end if;
			end if;
		end process;

	process (clkMain, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if clkMain = '1' and clkMain'Event then
				if ctlEppDwr = '1' and regEppAdr = "1010" then
	--				regLed <= busEppIn;
				end if;
			end if;
		end process;

----------------------------------------------------------------------------

end Behavioral;