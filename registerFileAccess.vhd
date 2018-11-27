library ieee;
use ieee.std_logic_1164.all;

entity registerFileAccess is
	port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				Rf_a : IN STD_LOGIC_VECTOR(2 downto 0);

				Rf_d : OUT STD_LOGIC_VECTOR(15 downto 0));
end registerFileAccess;


architecture description of registerFileAccess is
		begin
			process (Rf_a, R0, R1, R2, R3, R4, R5, R6, R7)
			begin
				case Rf_a is
	        when "000" =>
	                Rf_d <= R0;
					when "001" =>
	                Rf_d <= R1;
					when "010" =>
	                Rf_d <= R2;
					when "011" =>
	                Rf_d <= R3;
					when "100" =>
	                Rf_d <= R4;
					when "101" =>
	                Rf_d <= R5;
					when "110" =>
	                Rf_d <= R6;
					when "111" =>
	                Rf_d <= R7;
					when others =>
									Rf_d <= R0;
	      end case;
			end process;
end description;
