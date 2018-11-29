library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LMDetectEnable is
	port (lm_detect: IN STD_LOGIC;
			interface_enable: IN STD_LOGIC;
			offset: IN STD_LOGIC_VECTOR(5 downto 0);
		  op: OUT STD_LOGIC);
end LMDetectEnable;


architecture behave of LMDetectEnable is
  begin
      process(lm_detect, interface_enable, offset)
      begin
		  if lm_detect = '1' and offset = "000000" and interface_enable = '1' then
			  op <= '1';
		  else
		  	op <= '0';
		end if;
		end process;
end behave;
