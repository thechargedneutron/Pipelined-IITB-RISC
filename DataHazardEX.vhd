library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataHazardEX is
	port (EX_Reg_Read : IN STD_LOGIC; 	 	--Do you need Reg Data?
	opcode : IN STD_LOGIC_VECTOR(3 downto 0);
	EX_Reg_Read_Add : IN STD_LOGIC_VECTOR(2 downto 0);
	EX_Reg_Data : IN STD_LOGIC_VECTOR(15 downto 0);
	EX_Reg_Data_new : IN STD_LOGIC_VECTOR(15 downto 0);

	MA_Reg_Write : IN STD_LOGIC;
	MA_Reg_Write_Add : IN STD_LOGIC_VECTOR(2 downto 0);
	MA_Reg_Write_Available: IN STD_LOGIC;
	MA_Reg_Data : IN STD_LOGIC_VECTOR(15 downto 0);

	WB_Reg_Write: IN STD_LOGIC;
	WB_Reg_Write_Add: IN STD_LOGIC_VECTOR(2 downto 0);
	WB_Reg_Write_Available: IN STD_LOGIC;
	WB_Reg_Data : IN STD_LOGIC_VECTOR(15 downto 0);

	Valid_Bit: IN STD_LOGIC;
	stall: OUT STD_LOGIC;
	data_out: OUT STD_LOGIC_VECTOR(15 downto 0));
end DataHazardEX;


architecture behave of DataHazardEX is
  begin
      process(EX_Reg_Read, EX_Reg_Data_new, opcode, EX_Reg_Read_Add, EX_Reg_Data, MA_Reg_Write,MA_Reg_Write_Add,MA_Reg_Write_Available, MA_Reg_Data, WB_Reg_Write,WB_Reg_Write_Add,WB_Reg_Write_Available, WB_Reg_Data, Valid_Bit)
      begin
		  if Valid_Bit = '1' and EX_Reg_Read = '1' then
			  if MA_Reg_Write = '1' and MA_Reg_Write_Add = EX_Reg_Read_Add then
					if MA_Reg_Write_Available = '1' then
					  stall <= '0';
					  data_out <= MA_Reg_Data;
				  else
					  stall <= '1';
					  data_out <= x"0000";
				  end if;
				elsif WB_Reg_Write = '1' and WB_Reg_Write_Add = EX_Reg_Read_Add then
					if WB_Reg_Write_Available = '1' then
					  stall <= '0';
					  data_out <= WB_Reg_Data;
				  else
					  stall <= '1';
					  data_out <= x"0000";
				  end if;
				else
					stall <= '0';
					if opcode = "0101" then
						data_out <= EX_Reg_Data_new;
					else
						data_out <= EX_Reg_Data;
					end if;
				end if;
		  else
		  	stall <= '0';
				data_out <= EX_Reg_Data; --Dont care
		end if;
		end process;
end behave;
