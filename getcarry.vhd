library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetCarry is
	port (RR_gives_C,RR_C , EX_gives_C, EX_C, MA_gives_C, MA_C, WB_gives_C, WB_C, RR_valid_bit: IN STD_LOGIC;
		  C_out: OUT STD_LOGIC);
end GetCarry;

architecture behave of GetCarry is
  begin
      process(RR_gives_C,RR_C , EX_gives_C, EX_C, MA_gives_C, MA_C, WB_gives_C, WB_C, RR_valid_bit)
			begin
				if RR_valid_bit = '1' then
					if EX_gives_C = '1' then
						C_out <= EX_C;
					elsif MA_gives_C = '1' then
						C_out <= MA_C;
					elsif WB_gives_C = '1' then
						C_out <= WB_C;
					else
						C_out <= RR_C;
					end if;
				else
						C_out <= '0';
				end if;
			end process;
end behave;
