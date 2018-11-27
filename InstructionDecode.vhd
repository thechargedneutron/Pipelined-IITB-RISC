library ieee;
use ieee.std_logic_1164.all;

entity InstructionDecode is
	port (instruction_in : IN STD_LOGIC_VECTOR(15 downto 0);
          reg_write: OUT STD_LOGIC;
          reg_write_add: OUT STD_LOGIC_VECTOR(2 downto 0);
		  reg_read_1:
		  reg_read_2:
		  read_z:
          z_write: OUT STD_LOGIC;
          z_available: OUT STD_LOGIC;
          c_write: OUT STD_LOGIC;
          c_available: OUT STD_LOGIC;
          pc_change: OUT STD_LOGIC;
          pc_available: OUT STD_LOGIC);
end InstructionDecode;


architecture behave of InstructionDecode is
  begin
      process(instruction_in)
      begin
          case instruction_in(15 downto 12) is
              when "0000" => --ADD
                reg_write <= '1';
                reg_write_add <= instruction_in(5 downto 3);
                z_write <='1';
                z_available <= '0';
                c_write <='1';
                c_available <= '0';
                pc_available <= '0';
                if instruction_in(5 downto 3) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;

              when "0001" => --ADI
                reg_write <= '1';
                reg_write_add <= instruction_in(8 downto 6);
                z_write <='1';
                z_available <= '0';
                c_write <='1';
                c_available <= '0';
                pc_available <= '0';
                if instruction_in(8 downto 6) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;

              when "0010" => --NAND
                reg_write <= '1';
                reg_write_add <= instruction_in(5 downto 3);
                z_write <='1';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                if instruction_in(5 downto 3) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;

              when "0011" => --LHI
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                if instruction_in(11 downto 9) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;

              when "0100" => --LW
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
                z_write <='1';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                if instruction_in(11 downto 9) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;

              when "0101" => --SW
                reg_write <= '0';
                reg_write_add <= "000";
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                pc_change <= '0';

              --when "0110" => --LM
              --when "0111" => --SM
              when "1100" => --BEQ
                reg_write <= '0';
                reg_write_add <= "000";
                z_write <= '0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                pc_change <= '0';  --Will get 1 in Execution

              when "1000" => --JAL
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
				pc_change <= '1';

              when "1001" => --JLR
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
				pc_change <= '1';

              when others =>
                reg_write <= '0';
                reg_write_add <= "000";
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                c_available <= '0';
                pc_available <= '0';
                pc_change <= '0';
          end case;
		end process;
end behave;
