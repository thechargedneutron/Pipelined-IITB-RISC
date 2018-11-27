library ieee;
use ieee.std_logic_1164.all;

entity WriteBack is
	port (ma_reg_write_back_reg_add : IN STD_LOGIC_VECTOR(2 downto 0);
		WB_enable: IN STD_LOGIC;
		  R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable: OUT STD_LOGIC);
end WriteBack;


architecture behave of WriteBack is
  begin
      process(ma_reg_write_back_reg_add, WB_enable)
      begin
		  if WB_enable = '1' then
			  case ma_reg_write_back_reg_add is
				when "000" =>
				  		R0_enable <= '1'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				when "001" =>
					  	R0_enable <= '0'; R1_enable <= '1'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				when "010" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '1'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				when "011" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '1'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				when "100" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '1'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				when "101" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '1'; R6_enable <= '0'; R7_enable <= '0';
				when "110" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '1'; R7_enable <= '0';
				when "111" =>
					  	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '1';
				when others =>
						R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
				end case;
		else
		 	R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
		end if;
		end process;
end behave;

--NOTE: Connect data of this part always to Rf-d3
