library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ZeroHazardRR is
	port (RR_Need_Z : IN STD_LOGIC; 	 	--Do you need Reg Data?
	RR_Z_data : IN STD_LOGIC;

	EX_Mod_Z : IN STD_LOGIC;
	EX_Z_available: IN STD_LOGIC;
	EX_Z_Data: IN STD_LOGIC;

	MA_Mod_Z : IN STD_LOGIC;
	MA_Z_available: IN STD_LOGIC;
	MA_Z_Data: IN STD_LOGIC;

	WB_Mod_Z : IN STD_LOGIC;
	WB_Z_available: IN STD_LOGIC;
	WB_Z_Data: IN STD_LOGIC;

	Valid_Bit: IN STD_LOGIC;
	stall: OUT STD_LOGIC;
	Z_out: OUT STD_LOGIC);
end ZeroHazardRR;


architecture behave of ZeroHazardRR is
  begin
      process(RR_Z_data, RR_Need_Z)
      begin
		  if Valid_Bit = '1' and RR_Need_Z = '1' then
			  if EX_Mod_Z = '1' then
				  if EX_Z_available then
					  stall <= '0';
					  Z_out <= EX_Z_Data;
				  else
					  stall <= '1';
					  Z_out <= '0'
				  end if;
				elsif MA_Mod_Z = '1' then
				  if MA_Z_available then
					  stall <= '0';
					  Z_out <= MA_Z_Data;
				  else
					  stall <= '1';
					  Z_out <= '0'
				  end if;
				elsif WB_Mod_Z = '1' then
				  if WB_Z_available then
					  stall <= '0';
					  Z_out <= WB_Z_Data;
				  else
					  stall <= '1';
					  Z_out <= '0'
				  end if;
				else
					stall <= '0';
					Z_out <= RR_Z_data;
				end if;
		  else
		  	stall <= '0';
				Z_out <= '0'; --Dont care
		end if;
		end process;
end behave;
