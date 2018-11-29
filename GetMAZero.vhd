library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetMAZero is
	port (z_in: IN STD_LOGIC;
		opcode: IN STD_LOGIC_VECTOR(3 downto 0);
		z_mod: IN STD_LOGIC;
		data: IN STD_LOGIC_VECTOR(15 downto 0);

		z_out: OUT STD_LOGIC);
end GetMAZero;


architecture description of GetMAZero is
		begin
			process (z_in, opcode, data, z_mod)
			begin
				case opcode is
					when "0100" =>
						if z_mod = '1' then
							if data = x"0000" then
								z_out <= '1';
							else
								z_out <= '0';
							end if;
						else
							z_out <= z_in;
						end if;
					when others =>
						z_out <= z_in;
					end case;
			end process;
end description;
