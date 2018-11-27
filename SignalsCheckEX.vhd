library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignalsCheckEX is
	port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);

		  reg_write_available : OUT STD_LOGIC;
		  z_available : OUT STD_LOGIC;
		  pc_available : OUT STD_LOGIC);
end SignalsCheckEX;


architecture behave of SignalsCheckEX is
  begin
      process(opcode)
      begin
		  case opcode is
			  when "0000" => --ADD
		      reg_write_available <= '1';
					z_available <= '1';
					pc_available <= '1';

        when "0001" => --ADI
          reg_write_available <= '1';
					z_available <= '1';
					pc_available <= '1';

        when "0010" => --NAND
          reg_write_available <= '1';
					z_available <= '1';
					pc_available <= '1';

        when "0011" => --LHI
          reg_write_available <= '1';
					z_available <= '0';
					pc_available <= '0';

        when "0100" => --LW
          reg_write_available <= '0';
					z_available <= '0';
					pc_available <= '0';

        when "0101" => --SW
          reg_write_available <= '0';
					z_available <= '0';
					pc_available <= '0';

        --when "0110" => --LM
        --when "0111" => --SM
        when "1100" => --BEQ
          reg_write_available <= '1';
					z_available <= '0';
					pc_available <= '1';

        when "1000" => --JAL
          reg_write_available <= '1';
					z_available <= '0';
					pc_available <= '1';

        when "1001" => --JLR
          reg_write_available <= '1';
					z_available <= '0';
					pc_available <= '0';

        when others =>
          reg_write_available <= '0';
					z_available <= '0';
					pc_available <= '0';
      end case;
		end process;
end behave;
