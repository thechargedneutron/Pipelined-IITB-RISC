library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetBEQStatus is
	port (opcode: IN STD_LOGIC_VECTOR(3 downto 0);
			data : IN STD_LOGIC_VECTOR(15 downto 0);
			op : OUT STD_LOGIC);
end GetBEQStatus;


architecture behave of GetBEQStatus is
  begin
      process(opcode, data)
      begin
		  if opcode = "1100" and data = x"FFFF" then
			  op <= '1';
		  else
		  	op <= '0';
		end if;
		end process;
end behave;
