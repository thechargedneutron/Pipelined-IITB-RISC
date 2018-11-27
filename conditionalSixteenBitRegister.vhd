library ieee;
use ieee.std_logic_1164.all;

entity conditionalsixteenBitRegister is
	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
				e : IN STD_LOGIC_VECTOR(15 downto 0);
				ld1 : IN STD_LOGIC;
				ld2 : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC_VECTOR(15 downto 0));
end conditionalsixteenBitRegister;


architecture description of conditionalsixteenBitRegister is
		begin
			process (clk, clr)
			begin
				if clr = '1' then
					q <= "0000000000000000";
				elsif rising_edge(clk) then
					if ld1 = '1' then
						q <= d;
					elsif ld2 = '1' then
						q <= e;
					end if;
					end if;
			end process;
end description;
