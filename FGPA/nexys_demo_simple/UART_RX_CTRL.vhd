library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity UART_RX_CTRL is
    Port ( UART_RX : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           DATA : out  STD_LOGIC_VECTOR (7 downto 0));
end UART_RX_CTRL;

architecture Behavioral of UART_RX_CTRL is


constant BIT_TMR_MAX : std_logic_vector(13 downto 0) := "10100010110000"; --10416 = (round(100MHz / 9600)) - 1
constant VALUE_ONE_THRESHOLD : std_logic_vector(13 downto 0) := "01010001011000"; --5208
constant BIT_INDEX_MAX : std_logic_vector(3 downto 0) := "1000";
signal stable_value_counter : std_logic_vector(13 downto 0) := (others => '0');

--Counter that keeps track of the number of clock cycles the current bit has been held stable over the
--UART TX line. It is used to signal when the ne
signal bitTmr : std_logic_vector(13 downto 0) := (others => '0');

--combinatorial logic that goes high when bitTmr has counted to the proper value to ensure
--a 9600 baud rate
signal bitDone : std_logic;

signal bitIndex : std_logic_vector(3 downto 0);

signal rxData : std_logic_vector(15 downto 0):= (others => '0');

signal rx_bit : std_logic;

type RX_STATE_TYPE is (S0_reset, LOAD, STABLE, SAVE, DATA_READY);

signal rxState : RX_STATE_TYPE := S0_reset;

signal UART_RX_Reg : std_logic:= '1';

begin

input_letch : process (CLK)
begin
	if (rising_edge(CLK)) then
		UART_RX_Reg <= UART_RX;
	end if;
end process;



next_rxState_process : process (CLK)
begin
	if rising_edge(CLK) then
		case rxState is 
			when S0_reset =>
				if UART_RX_Reg = '0' then
					rxState <= LOAD;
				end if;
			when LOAD =>
				rxState <= STABLE;
			when STABLE =>
				if bitDone = '1' then
					rxState <= SAVE;
				end if;
			when SAVE =>
				if (bitIndex = BIT_INDEX_MAX) then
					rxState <= DATA_READY;
				else
					rxState <= LOAD;
				end if;
			when DATA_READY =>
				if bitDone = '1' then
					rxState <= S0_reset;
				end if;
			when others=> --should never be reached
				rxState <= S0_reset;
		end case;
	end if;
end process;


FSM_OUT:  process(rxState)
begin
	case rxState is 
		when S0_reset =>
			READY <= '0';
		when LOAD =>
			READY <= '0'; 
		when STABLE =>
		when SAVE =>
		when DATA_READY =>
			READY <= '1';
		when others =>
		end case;
end process;





bit_timing_process : process (CLK)
begin
	if rising_edge(CLK) then
		if rxState = S0_reset then
			bitTmr <= (others => '0');
		else
			if bitDone = '1' then
				bitTmr <= (others => '0');
			else
				bitTmr <= bitTmr + 1;
			end if;
		end if;
	end if;
end process;

stable_counter_process:  process(CLK)
begin
	if rising_edge(CLK) then
		if rxState =  S0_reset then
				stable_value_counter <= (others => '0');
		elsif rxState =  LOAD then
				stable_value_counter <= (others => '0');
		elsif rxState =  STABLE then
			if UART_RX_Reg = '1' then
				stable_value_counter <= stable_value_counter + 1;
			end if;
			if stable_value_counter > VALUE_ONE_THRESHOLD then
				rx_bit <= '1';
			else 
				rx_bit <= '0';
			end if;
		end if;
	end if;
end process;


bitDone <= '1' when (bitTmr = BIT_TMR_MAX) else
				'0';

bit_counting_process : process (CLK)
begin
	if rising_edge(CLK) then
		if rxState = S0_reset then
			bitIndex <= "0000";
		elsif rxState = SAVE then
			bitIndex <= bitIndex + 1;
		end if;
	end if;
end process;

rx_data_latch_process : process (CLK)
begin
	if rising_edge(CLK) then
		if rxState = SAVE then
			rxData(conv_integer(bitIndex)) <= rx_bit;
		end if;
	end if;
end process;



DATA <= rxData(8 downto 1);

end Behavioral;

