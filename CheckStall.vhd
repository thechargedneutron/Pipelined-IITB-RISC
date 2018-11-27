library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CheckStall is
	port (id_stall, rr_stall, ex_stall, ma_stall, wb_stall: IN STD_LOGIC;
		  interface1, interface2, interface3, interface4, interface5: OUT STD_LOGIC);
end CheckStall;


architecture behave of CheckStall is
  begin
      process(id_stall, rr_stall, ex_stall, ma_stall, wb_stall)
      begin
		  interface1 <= ((not id_stall) and ((not rr_stall) and (not ex_stall))) and ((not ma_stall) and (not wb_stall));
		  interface2 <= ((not rr_stall) and (not ex_stall)) and ((not ma_stall) and (not wb_stall));
		  interface3 <= (not ex_stall) and ((not ma_stall) and (not wb_stall));
		  interface4 <= (not ma_stall) and (not wb_stall);
		  interface5 <= not wb_stall;
		end process;
end behave;
