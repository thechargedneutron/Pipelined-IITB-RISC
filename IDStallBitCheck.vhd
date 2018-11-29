library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IDStallBitCheck is
	port (opcode: IN STD_LOGIC_VECTOR(3 downto 0);
			pe0: IN STD_LOGIC;
			stall_bit : OUT STD_LOGIC);
end IDStallBitCheck;


architecture behave of IDStallBitCheck is
  begin
      process(opcode, pe0)
      begin
		  case opcode is
			  when "0110" | "0111" =>
			  	if pe0 = '1' then
					stall_bit <= '0';
				else
					stall_bit <= '1';
				end if;
			when others =>
					stall_bit <= '0';
			end case;
		end process;
end behave;
