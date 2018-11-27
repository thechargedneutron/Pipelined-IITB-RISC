library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		  condition : IN STD_LOGIC_VECTOR(1 downto 0);
		  c_in, z_in: IN STD_LOGIC;
		  data1, data2 : IN STD_LOGIC_VECTOR(15 downto 0);
		  data_out : OUT STD_LOGIC_VECTOR(15 downto 0);
		  c_out, z_out: OUT STD_LOGIC);
end ALU;


architecture behave of ALU is
  begin
      process(all)
	  variable temp_answer: STD_LOGIC_VECTOR(15 downto 0);
      begin
		  case opcode is
			  when "0010" =>
				  data_out <= data1 nand data2;
				  temp_answer := data1 nand data2;
				  c_out <= '0';
				  if temp_answer = x"0000" then
					  z_out <= '1';
				  else
					  z_out <= '0';
				  end if;
			  when others  => --ADD
					data_out <= STD_LOGIC_VECTOR(unsigned(data1) + unsigned(data2));
					temp_answer := STD_LOGIC_VECTOR(unsigned(data1) + unsigned(data2));
					c_out <= (data1(15) and data2(15) and (not temp_answer(15))) or ((not data1(15)) and (not data2(15)) and temp_answer(15));
					if temp_answer = x"0000" then
						z_out <= '1';
					else
						z_out <= '0';
					end if;
          end case;
		end process;
end behave;
