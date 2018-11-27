library ieee;
use ieee.std_logic_1164.all;

entity InstructionDecode is
	port (instruction_in : IN STD_LOGIC_VECTOR(15 downto 0);
          reg_write: OUT STD_LOGIC;
          reg_write_add: OUT STD_LOGIC_VECTOR(2 downto 0);
				  reg_read_1: OUT STD_LOGIC;
				  reg_read_2: OUT STD_LOGIC;
				  read_c: OUT STD_LOGIC;
				  read_z: OUT STD_LOGIC;
          z_write: OUT STD_LOGIC;
          z_available: OUT STD_LOGIC;
          c_write: OUT STD_LOGIC;
          pc_change: OUT STD_LOGIC;
          pc_available: OUT STD_LOGIC;
					ID_Mem_Write: OUT STD_LOGIC);
end InstructionDecode;


architecture behave of InstructionDecode is
  begin
      process(instruction_in)
      begin
          case instruction_in(15 downto 12) is
              when "0000" => --ADD
                reg_write <= '1';
                reg_write_add <= instruction_in(5 downto 3);
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								if instruction_in(1 downto 0) = "00" then
									read_c <= '0';
									read_z <= '0';
								elsif instruction_in(1 downto 0) = "01" then
									read_c <= '0';
									read_z <= '1';
								elsif instruction_in(1 downto 0) = "10" then
									read_c <= '1';
									read_z <= '0';
								else
									read_c <= '0';
									read_z <= '0';
								end if;
								z_write <='1';
                z_available <= '0';
                c_write <='1';
                pc_available <= '0';
                if instruction_in(5 downto 3) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;
								ID_Mem_Write <= '0';

              when "0001" => --ADI
                reg_write <= '1';
                reg_write_add <= instruction_in(8 downto 6);
								reg_read_1 <= '1';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='1';
                z_available <= '0';
                c_write <='1';
                pc_available <= '0';
                if instruction_in(8 downto 6) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;
								ID_Mem_Write <= '0';

              when "0010" => --NAND
                reg_write <= '1';
                reg_write_add <= instruction_in(5 downto 3);
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								if instruction_in(1 downto 0) = "00" then
									read_c <= '0';
									read_z <= '0';
								elsif instruction_in(1 downto 0) = "01" then
									read_c <= '0';
									read_z <= '1';
								elsif instruction_in(1 downto 0) = "10" then
									read_c <= '1';
									read_z <= '0';
								else
									read_c <= '0';
									read_z <= '0';
								end if;
								z_write <='1';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                if instruction_in(5 downto 3) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;
								ID_Mem_Write <= '0';
              when "0011" => --LHI
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                if instruction_in(11 downto 9) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;
								ID_Mem_Write <='0';

              when "0100" => --LW
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='1';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                if instruction_in(11 downto 9) = "111" then
                    pc_change <= '1';
                else
                    pc_change <= '0';
                end if;
								ID_Mem_Write <= '0';

              when "0101" => --SW
                reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                pc_change <= '0';
								ID_Mem_Write <= '1';

              --when "0110" => --LM
              --when "0111" => --SM
              when "1100" => --BEQ
                reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0'; -- 0 since we are using another zero
                z_write <= '0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                pc_change <= '0';  --Will get 1 in Execution
								ID_Mem_Write <= '0';

              when "1000" => --JAL
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
								pc_change <= '1';
								ID_Mem_Write <= '0';
              when "1001" => --JLR
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
								pc_change <= '1';
								ID_Mem_Write <= '0';

              when others =>
                reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '0';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                z_available <= '0';
                c_write <='0';
                pc_available <= '0';
                pc_change <= '0';
								ID_Mem_Write <= '0';
          end case;
		end process;
end behave;
