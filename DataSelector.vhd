library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataSelector is
	port (ins : IN STD_LOGIC_VECTOR(15 downto 0);
		RR_LM_Detect : IN STD_LOGIC;
		Reg_Data_1, Reg_Data_2, se6, se9spl, pc, se9, Temp_Reg: IN STD_LOGIC_VECTOR(15 downto 0);
		op_data_1, op_data_2, op_data_3: OUT STD_LOGIC_VECTOR(15 downto 0));
end DataSelector;


architecture behave of DataSelector is
  begin
      process(ins, Reg_Data_1, Reg_Data_2, se6, se9spl, pc, se9, RR_LM_Detect, Temp_Reg)
      begin
		  case ins(15 downto 12) is
			  when "0000" => --ADD
                op_data_1 <= Reg_Data_1;
				op_data_2 <= Reg_Data_2;
				op_data_3 <= x"0000"; --dont care

              when "0001" => --ADI
                op_data_1 <= Reg_Data_1;
				op_data_2 <= se6;
				op_data_3 <= x"0000";

              when "0010" => --NAND
                op_data_1 <= Reg_Data_1;
				op_data_2 <= Reg_Data_2;
				op_data_3 <= x"0000";

              when "0011" => --LHI
                op_data_1 <= x"0000";
				op_data_2 <= x"0000";
				op_data_3 <= se9spl;

              when "0100" => --LW
                op_data_1 <= se6;
				if RR_LM_Detect = '1' then
					if ins(5 downto 0) = "000000" then
						op_data_2 <= Reg_Data_2;
					else
						op_data_2 <= Temp_Reg;
					end if;
				else
					op_data_2 <= Reg_Data_2;
				end if;
				op_data_3 <= x"0000";

              when "0101" => --SW
                op_data_1 <= se6;
				op_data_2 <= Reg_Data_2;
				op_data_3 <= Reg_Data_1;

              --when "0110" => --LM
              --when "0111" => --SM
              when "1100" => --BEQ
                op_data_1 <= pc;
				op_data_2 <= se6;
				op_data_3 <= Reg_Data_1 xnor Reg_Data_2;

              when "1000" => --JAL
                op_data_1 <= pc;
				op_data_2 <= se9;
				op_data_3 <= pc;

              when "1001" => --JLR
                op_data_1 <= x"0000";
				op_data_2 <= pc;
				op_data_3 <= Reg_Data_2;

              when others =>
                op_data_1 <= x"0000";
				op_data_2 <= x"0000";
				op_data_3 <= x"0000";
          end case;

		end process;
end behave;
