library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetWBIndex is
	port (data_alu: IN STD_LOGIC_VECTOR(15 downto 0);
		  data_non_alu: IN STD_LOGIC_VECTOR(15 downto 0);
		  opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		  out_data : OUT STD_LOGIC_VECTOR(15 downto 0));
end GetWBIndex;

architecture behave of GetWBIndex is
  begin
      process(data_alu, data_non_alu, opcode)
			begin
				case opcode is
					when "1000" | "1001" =>
						out_data <= data_non_alu;
					when others =>
						out_data <= data_alu;
					end case;
			end process;
end behave;
