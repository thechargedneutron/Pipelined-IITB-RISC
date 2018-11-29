library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
entity CodeMemory is
  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
        din: IN STD_LOGIC_VECTOR(15 downto 0);
		    we: IN STD_LOGIC;
        clk: IN STD_LOGIC;

        dout: OUT STD_LOGIC_VECTOR(15 downto 0)
		  );
end CodeMemory;


architecture behave of CodeMemory is
type mem_array is array	(0	to 2**7 -1) of
	std_logic_vector(15 downto 0);
signal RAM : mem_array :=
  (
0  =>   "0001000011000101",  --r3= 000101
1  =>   "0001000100000011", -- r4= 000011
2  =>   "0001000010000111", -- r2= 000111
3  =>   "0001000101001111", -- r5= 001111
4  =>   "0001000110110000", -- r6= 110000
5  =>   "0001000001011111", -- r1= 011111
6  =>   "0001000000000001", -- r0= 000001
7  =>   "0111010011111111",  --sm
8  =>   "0100001000000110", 
9  =>   "0100001000000111",
10  =>  "0100001000001000",
11  =>  "0100001000001001",
12  =>  "0100001000001010",
13  =>  "0100001000001011",
14  =>  "0100001000001100",
15  =>  "0100001000001101",

--  
--  
--0  =>   "0011001000111000", -- r1 == 000111000 0000000
--1  =>   "0011010000111100", -- r2 == 000111100 0000000
--2  =>   "0001000011000101",  --r3= 000101
--3  =>   "0011011000111110", -- r3 == 000111110 0000000

others => x"0000"
  -- 0  =>   "0001000011000011",  --r3= 000011
  -- 1  =>   "0001000010000111", -- r2=000111
  -- 2  =>   "0001000010000111", -- r2=000111
  -- 3  =>   "0001000010000111", -- r2=000111
  -- 4  =>   "0001000010000111", -- r2=000111
  -- 5  =>   "0001000010000111", -- r2=000111
  -- 6  =>   "0001000010000111", -- r2=000111
  -- 7  =>   "0000011010000000", --r0 = r3 + r2
  -- 8  =>   "0001000001000001",
  -- 9  =>   "0000000000000111",
  -- 10  =>   "0000000000001111",
  --others => x"0000"

  ) ;

begin
process(clk, addr, din)
	begin
	if rising_edge(clk) then
		if we = '1' then
			RAM(to_integer(unsigned(addr(6 downto 0)))) <= din;
		end if;
  end if;
end process;
			dout <= RAM (to_integer (unsigned(addr(6 downto 0))));
end behave;
