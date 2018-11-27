library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionFetch is
	port (PC : IN STD_LOGIC_VECTOR(15 downto 0);
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
          PC_new <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
		end process;
end behave;
