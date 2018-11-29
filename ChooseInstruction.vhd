library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ChooseInstruction is
	port (actual_ins : IN STD_LOGIC_VECTOR(15 downto 0);
			dummy_ins_SM: IN STD_LOGIC_VECTOR(15 downto 0);
			dummy_ins_LM: IN STD_LOGIC_VECTOR(15 downto 0);
			final: OUT STD_LOGIC_VECTOR(15 downto 0));
end ChooseInstruction;

architecture behave of ChooseInstruction is
  begin
      process(actual_ins, dummy_ins_LM, dummy_ins_SM)
			begin
				case actual_ins(15 downto 12) is
					when "0111" =>
						final <= dummy_ins_SM;
					when "0110" =>
						final <= dummy_ins_LM;
					when others =>
						final <= actual_ins;
					end case;
			end process;
end behave;
