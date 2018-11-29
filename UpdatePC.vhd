library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpdatePC is
	port (PC : IN STD_LOGIC_VECTOR(15 downto 0);
				Old_PC: IN STD_LOGIC_VECTOR(15 downto 0);
          PC_change : IN STD_LOGIC;
					lm_or_sm : IN STD_LOGIC;
          PC_new: OUT STD_LOGIC_VECTOR(15 downto 0));
end UpdatePC;


architecture behave of UpdatePC is
  constant one: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";
  begin
      process(PC, PC_change, Old_PC, lm_or_sm)
      begin
		  if PC_change = '1' then
			  PC_new <= PC;
			elsif lm_or_sm = '1' and PC = Old_PC then
				PC_new <= PC;
		  else
			  PC_new <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
		  end if;
		end process;
end behave;
