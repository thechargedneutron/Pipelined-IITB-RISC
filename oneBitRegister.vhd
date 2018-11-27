library ieee;
use ieee.std_logic_1164.all;

entity oneBitRegister is
	port (d : IN STD_LOGIC;
				ld : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC);
end oneBitRegister;


architecture description of oneBitRegister is
		begin
			process (clk, clr)
			begin
				if clr = '1' then
					q <= '0';
				elsif rising_edge(clk) then
					if ld = '1' then
						q <= d;
					end if;
					end if;
			end process;
end description;
