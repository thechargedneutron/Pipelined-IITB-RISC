library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CalculateOffset is
	port (offset : IN STD_LOGIC_VECTOR(5 downto 0);
		  opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		  PE0 : IN STD_LOGIC;
		  offset_in: OUT STD_LOGIC_VECTOR(5 downto 0));
end CalculateOffset;

architecture behave of CalculateOffset is
	constant one_six_bit: STD_LOGIC_VECTOR(5 downto 0) := "000001";
  begin
      process(opcode, offset, PE0)
			begin
				case opcode is
					when "0110" | "0111" =>
						if PE0 ='1' then
							offset_in <= "000000";
						else
							offset_in <= STD_LOGIC_VECTOR(unsigned(offset) + unsigned(one_six_bit));
						end if;
					when others =>
						offset_in <= "000000";
					end case;
			end process;
end behave;
