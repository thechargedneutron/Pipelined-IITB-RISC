library ieee;
use ieee.std_logic_1164.all;

entity SignExtended9spl is
	port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end SignExtended9spl;


architecture description of SignExtended9spl is
		begin
			process (inp)
			begin
        op <= (inp & "0000000");
			end process;
end description;
