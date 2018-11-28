library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetEXRegReadSignal is
	port (opcode: IN STD_LOGIC_VECTOR(3 downto 0);
		inp : IN STD_LOGIC;
		  op: OUT STD_LOGIC);
end GetEXRegReadSignal;


architecture behave of GetEXRegReadSignal is
  begin
      process(opcode, inp)
      begin
		  case opcode is
			  when "0101" => --SW
			  	op <= '1';
			when others =>
				op <= inp;
			end case;
		end process;
end behave;
