library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY blockRam IS
	PORT (clk 							: in std_logic;
			reset							: in std_logic;
			memory_access_enable 	: in std_logic;
			write_enable 				: in std_logic;
			addr 							: in std_logic_vector(7 downto 0);
			data_in 						: in std_logic_vector(15 downto 0);
			data_out 					: out std_logic_vector(15 downto 0));
END blockRam;

ARCHITECTURE syn OF blockRam IS
-- signals
	TYPE ram_type IS array (63 downto 0) OF std_logic_vector (15 downto 0);
	SIGNAL RAM: ram_type;
BEGIN
	PROCESS (clk)
	BEGIN
--		IF reset = '1' THEN
--			RAM(0)  <= X"0000";
--			RAM(1)  <= X"0101";
--			RAM(2)  <= X"0202";
--			RAM(3)  <= X"0303";
--			RAM(4)  <= X"0404";
--			RAM(5)  <= X"0505";
--			RAM(6)  <= X"0606";
--			RAM(7)  <= X"0107";
--			RAM(8)  <= X"0208";
--			RAM(9)  <= X"0309";
--			RAM(10)  <= X"040a";
--			RAM(11)  <= X"050b";
--			RAM(12)  <= X"060c";
--			RAM(13)  <= X"010d";
--			RAM(14)  <= X"020e";
--			RAM(15)  <= X"030f";
--			RAM(16)  <= X"0410";
--			RAM(17)  <= X"0511";
--			RAM(18)  <= X"0612";
--			RAM(19)  <= X"0113";
--			RAM(20)  <= X"0214";
--			RAM(21)  <= X"0315";
--			RAM(22)  <= X"0416";
--			RAM(23)  <= X"0517";
--			RAM(24)  <= X"0618";
--			RAM(25)  <= X"0119";
--
--			ELS
		IF rising_edge(clk) THEN
			IF memory_access_enable = '1' THEN
				IF write_enable = '1' THEN
					RAM(conv_integer(addr)) <= data_in;
				END IF;
			data_out <= RAM(conv_integer(addr)) ;
			END IF;
		END IF;
	END PROCESS;
END SYN;