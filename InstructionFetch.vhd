library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionFetch is
	port (PC : IN STD_LOGIC_VECTOR(15 downto 0);
			MA_PC_Change : IN STD_LOGIC;
			MA_PC_Available : IN STD_LOGIC;
			MA_Valid_Bit : IN STD_LOGIC;
			MA_Stall_Bit : IN STD_LOGIC;
			MA_Data_out : IN STD_LOGIC_VECTOR(15 downto 0);
			EX_PC_Change : IN STD_LOGIC;
			EX_PC_Available : IN STD_LOGIC;
			EX_Valid_Bit : IN STD_LOGIC;
			EX_Stall_Bit : IN STD_LOGIC;
			EX_ALU_Data_Out : IN STD_LOGIC_VECTOR(15 downto 0);
			RR_PC_Change : IN STD_LOGIC;
			RR_PC_Available : IN STD_LOGIC;
			RR_Valid_Bit : IN STD_LOGIC;
			RR_Stall_Bit : IN STD_LOGIC;
			RR_Data_3 : IN STD_LOGIC_VECTOR(15 downto 0);
          PC_new : OUT STD_LOGIC_VECTOR(15 downto 0);
          instruction: OUT STD_LOGIC_VECTOR(15 downto 0));
end InstructionFetch;


architecture behave of InstructionFetch is

      component CodeMemory is
      port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
        din: IN STD_LOGIC_VECTOR(15 downto 0);
		we: IN STD_LOGIC;
        clk: IN STD_LOGIC;
        dout: OUT STD_LOGIC_VECTOR(15 downto 0));
      end component;

  constant one: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";
  begin
      CodeMem: CodeMemory port map(PC, x"0000", '0', '0', instruction);
      process(PC)
      begin
		  if (MA_Valid_Bit = '1') and (MA_Stall_Bit = '0') and (MA_PC_Available = '1') and (MA_PC_Change = '1') then
			  PC_new <= MA_Data_out;
		  elsif (EX_Valid_Bit = '1') and (EX_Stall_Bit = '0') and (EX_PC_Available = '1') and (EX_PC_Change = '1') then
			  PC_new <= EX_ALU_Data_Out;
		  elsif (RR_Valid_Bit = '1') and (RR_Stall_Bit = '0') and (RR_PC_Available = '1') and (RR_PC_Change = '1') then
			  PC_new <= EX_Data_3;
		  else
			  PC_new <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
		  end if;
		end process;
end behave;
