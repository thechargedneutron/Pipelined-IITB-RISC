library ieee;
use ieee.std_logic_1164.all;

entity PriorityEncoder is
	port (PriorityEncoderReg : STD_LOGIC_VECTOR(7 downto 0);

				PE_out : OUT STD_LOGIC_VECTOR(2 downto 0);
        PE0 : OUT STD_LOGIC);
end PriorityEncoder;


architecture behave of PriorityEncoder is

  begin
    process (PriorityEncoderReg)
    begin
      if PriorityEncoderReg(0) = '1' then
        PE_out <= "000";
        PE0 <= '0';
      elsif PriorityEncoderReg(1) = '1' then
        PE_out <= "001";
        PE0 <= '0';
      elsif PriorityEncoderReg(2) = '1' then
        PE_out <= "010";
        PE0 <= '0';
      elsif PriorityEncoderReg(3) = '1' then
        PE_out <= "011";
        PE0 <= '0';
      elsif PriorityEncoderReg(4) = '1' then
        PE_out <= "100";
        PE0 <= '0';
      elsif PriorityEncoderReg(5) = '1' then
        PE_out <= "101";
        PE0 <= '0';
      elsif PriorityEncoderReg(6) = '1' then
        PE_out <= "110";
        PE0 <= '0';
      elsif PriorityEncoderReg(7) = '1' then
        PE_out <= "111";
        PE0 <= '0';
      else
        PE_out <= "000";
        PE0 <= '1';
      end if;
    end process;
end behave;
