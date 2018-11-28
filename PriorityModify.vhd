library ieee;
use ieee.std_logic_1164.all;

entity PriorityModify is
	port (PriorityEncoderReg : IN STD_LOGIC_VECTOR(7 downto 0);
				PE_out : IN STD_LOGIC_VECTOR(2 downto 0);
				opcode : IN STD_LOGIC_VECTOR(3 downto 0);

				PE_zero_enable : OUT STD_LOGIC;
				ModifiedPriorityReg : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
end PriorityModify;


architecture description of PriorityModify is
		begin
			process (PriorityEncoderReg, PE_out, current_state)
			begin
				case opcode is
					when "0110" | "0111" =>
							if PE_out = "000" then
								ModifiedPriorityReg(7 downto 1) <= PriorityEncoderReg(7 downto 1);
								ModifiedPriorityReg(0) <= '0';
								PE_zero_enable <= '1';

							elsif PE_out = "001" then
								ModifiedPriorityReg(7 downto 2) <= PriorityEncoderReg(7 downto 2);
								ModifiedPriorityReg(1) <= '0';
								ModifiedPriorityReg(0) <= PriorityEncoderReg(0);
								PE_zero_enable <= '1';

							elsif PE_out = "010" then
								ModifiedPriorityReg(7 downto 3) <= PriorityEncoderReg(7 downto 3);
								ModifiedPriorityReg(2) <= '0';
								ModifiedPriorityReg(1 downto 0) <= PriorityEncoderReg(1 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "011" then
								ModifiedPriorityReg(7 downto 4) <= PriorityEncoderReg(7 downto 4);
								ModifiedPriorityReg(3) <= '0';
								ModifiedPriorityReg(2 downto 0) <= PriorityEncoderReg(2 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "100" then
								ModifiedPriorityReg(7 downto 5) <= PriorityEncoderReg(7 downto 5);
								ModifiedPriorityReg(4) <= '0';
								ModifiedPriorityReg(3 downto 0) <= PriorityEncoderReg(3 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "101" then
								ModifiedPriorityReg(7 downto 6) <= PriorityEncoderReg(7 downto 6);
								ModifiedPriorityReg(5) <= '0';
								ModifiedPriorityReg(4 downto 0) <= PriorityEncoderReg(4 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "110" then
								ModifiedPriorityReg(7 downto 7) <= PriorityEncoderReg(7 downto 7);
								ModifiedPriorityReg(6) <= '0';
								ModifiedPriorityReg(5 downto 0) <= PriorityEncoderReg(5 downto 0);
								PE_zero_enable <= '1';

							else
								ModifiedPriorityReg(7) <= '0';
								ModifiedPriorityReg(6 downto 0) <= PriorityEncoderReg(6 downto 0);
								PE_zero_enable <= '1';
							end if;

					when others =>
							PE_zero_enable <= '0';
							ModifiedPriorityReg(7 downto 0) <= PriorityEncoderReg(7 downto 0);
	      end case;
			end process;
end description;
