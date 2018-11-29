library ieee;
use ieee.std_logic_1164.all;

entity MemoryAccess is
	port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);
	 	  alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
		  non_alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
		  pc : IN STD_LOGIC_VECTOR(15 downto 0);
		  mem_write_enable : IN STD_LOGIC;
		  clock : IN STD_LOGIC;
		  ma_reg_write_back_data: OUT STD_LOGIC_VECTOR(15 downto 0));
end MemoryAccess;


architecture behave of MemoryAccess is
	component DataMemory is
	  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
	        din: IN STD_LOGIC_VECTOR(15 downto 0);
			we: IN STD_LOGIC;
	        clk: IN STD_LOGIC;

	        dout: OUT STD_LOGIC_VECTOR(15 downto 0)
			  );
	end component;

	signal mem_d_op : STD_LOGIC_VECTOR(15 downto 0);
  begin
	  mem1: DataMemory port map(alu_out, non_alu_out, mem_write_enable, clock, mem_d_op);
      process(alu_out, mem_d_op, non_alu_out, pc, mem_write_enable, opcode, clock) --Doubtful about the inputs !!
      begin
		  case opcode is
			  when "0000"  => --ADD
                ma_reg_write_back_data <= alu_out;

              when "0001" => --ADI
                ma_reg_write_back_data <= alu_out;

              when "0010" => --NAND
                ma_reg_write_back_data <= alu_out;

              when "0011" => --LHI
                ma_reg_write_back_data <= non_alu_out;

              when "0100" => --LW
                ma_reg_write_back_data <= mem_d_op;

              when "0101" => --SW
                ma_reg_write_back_data <= x"0000";--dont care

              --when "0110" => --LM
              --when "0111" => --SM
              when "1100" => --BEQ
                ma_reg_write_back_data <= x"0000";

              when "1000" => --JAL
                ma_reg_write_back_data <= non_alu_out;

              when "1001" => --JLR
                ma_reg_write_back_data <= alu_out;

              when others =>
                ma_reg_write_back_data <= x"0000";
          end case;
		  end process;
end behave;
