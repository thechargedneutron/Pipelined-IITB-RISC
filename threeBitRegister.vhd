library ieee;
use ieee.std_logic_1164.all;

entity threeBitRegister is
	port (d : IN STD_LOGIC_VECTOR(2 downto 0);
				ld : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC_VECTOR(2 downto 0));
end threeBitRegister;


architecture description of threeBitRegister is
		begin
			process (clk, clr)
			begin
				if clr = '1' then
					q <= "000";
				elsif rising_edge(clk) then
					if ld = '1' then
						q <= d;
					end if;
					end if;
			end process;
end description;
