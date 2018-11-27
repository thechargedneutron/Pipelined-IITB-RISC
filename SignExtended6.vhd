library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtended6 is
	port (inp : IN STD_LOGIC_VECTOR(5 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end SignExtended6;


architecture description of SignExtended6 is
		begin
			process (inp)
			begin
				op <= std_logic_vector(resize(signed(inp), 16));
			end process;
end description;
