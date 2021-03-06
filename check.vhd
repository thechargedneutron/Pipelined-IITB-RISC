library ieee;
use ieee.std_logic_1164.all;

entity IITB_Pipelined_RISC is
	port (clock : IN STD_LOGIC;
			clear : IN STD_LOGIC);
end IITB_Pipelined_RISC;


architecture behave of IITB_Pipelined_RISC is

	component InstructionFetch is
		port (PC : IN STD_LOGIC_VECTOR(15 downto 0);
	          PC_new : OUT STD_LOGIC_VECTOR(15 downto 0);
	          instruction: OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component sixteenBitRegister is
		port (d : IN STD_LOGIC_VECTOR(15 downto 0);
					ld : IN STD_LOGIC;
					clr : IN STD_LOGIC;
					clk : IN STD_LOGIC;

					q : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component conditionalsixteenBitRegister is
		port (d : IN STD_LOGIC_VECTOR(15 downto 0);
					e : IN STD_LOGIC_VECTOR(15 downto 0);
					ld1 : IN STD_LOGIC;
					ld2 : IN STD_LOGIC;
					clr : IN STD_LOGIC;
					clk : IN STD_LOGIC;

					q : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component oneBitRegister is
		port (d : IN STD_LOGIC;
					ld : IN STD_LOGIC;
					clr : IN STD_LOGIC;
					clk : IN STD_LOGIC;

					q : OUT STD_LOGIC);
	end component;

	component threeBitRegister is
		port (d : IN STD_LOGIC_VECTOR(2 downto 0);
					ld : IN STD_LOGIC;
					clr : IN STD_LOGIC;
					clk : IN STD_LOGIC;

					q : OUT STD_LOGIC_VECTOR(2 downto 0));
	end component;

	component InstructionDecode is
		port (instruction_in : IN STD_LOGIC_VECTOR(15 downto 0);
	          reg_write: OUT STD_LOGIC;
	          reg_write_add: OUT STD_LOGIC_VECTOR(2 downto 0);
			  reg_read_1:
			  reg_read_2:
			  read_z:
	          z_write: OUT STD_LOGIC;
	          z_available: OUT STD_LOGIC;
	          c_write: OUT STD_LOGIC;
	          c_available: OUT STD_LOGIC;
	          pc_change: OUT STD_LOGIC;
	          pc_available: OUT STD_LOGIC);
	end component;

	component SignalsCheckRR is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);

			  reg_write_available : OUT STD_LOGIC;
			  z_available : OUT STD_LOGIC;
			  pc_available : OUT STD_LOGIC);
	end component;

	component SignalsCheckEX is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);

			  reg_write_available : OUT STD_LOGIC;
			  z_available : OUT STD_LOGIC;
			  pc_available : OUT STD_LOGIC);
	end component;

	component SignalsCheckMA is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);

			  reg_write_available : OUT STD_LOGIC;
			  z_available : OUT STD_LOGIC;
			  pc_available : OUT STD_LOGIC);
	end component;

	component SignalsCheckWB is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);

			  reg_write_available : OUT STD_LOGIC;
			  z_available : OUT STD_LOGIC;
			  pc_available : OUT STD_LOGIC);
	end component;

	component registerFileAccess is
		port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
					Rf_a : IN STD_LOGIC_VECTOR(2 downto 0);

					Rf_d : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component SignExtended6 is
		port (inp : IN STD_LOGIC_VECTOR(5 downto 0);

					op : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component SignExtended9 is
		port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

					op : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component SignExtended9spl is
		port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

					op : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component DataHazardRR is
		port (RR_Reg_Read : IN STD_LOGIC; 	 	--Do you need Reg Data?
		RR_Reg_Read_Add : IN STD_LOGIC_VECTOR(2 downto 0);
		RR_Reg_Data : IN STD_LOGIC_VECTOR(15 downto 0);

		EX_Reg_Write : IN STD_LOGIC;
		EX_Reg_Write_Add : IN STD_LOGIC_VECTOR(2 downto 0);
		EX_Reg_Write_Available: IN STD_LOGIC;
		EX_Reg_Data: IN STD_LOGIC_VECTOR(15 downto 0);

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
	end component;

	component DataSelector is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);
			Reg_Data_1, Reg_Data_2, se6, se9spl, pc, se9: IN STD_LOGIC_VECTOR(15 downto 0);
			op_data_1, op_data_2, op_data_3: OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component ALU is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);
			  condition : IN STD_LOGIC_VECTOR(1 downto 0);
			  c_in, z_in: IN STD_LOGIC;
			  data1, data2 : IN STD_LOGIC_VECTOR(15 downto 0);
			  data_out : OUT STD_LOGIC_VECTOR(15 downto 0);
			  c_out, z_out: OUT STD_LOGIC);
	end component;

	component MemoryAccess is
		port (opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		 	  alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
			  non_alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
			  pc : IN STD_LOGIC_VECTOR(15 downto 0);
			  mem_write_enable : IN STD_LOGIC;
			  clock : IN STD_LOGIC;
			  ma_reg_write_back_data: OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component WriteBack is
		port (ma_reg_write_back_reg_add : IN STD_LOGIC_VECTOR(2 downto 0);
			WB_enable: IN STD_LOGIC;
			  R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable: OUT STD_LOGIC);
	end component;

    --List of all bunch of signals

	------------Instruction Fetch Stage------------------
	signal IF_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal IF_PC_in: STD_LOGIC_VECTOR(15 downto 0);
	signal IF_instruction: STD_LOGIC_VECTOR(15 downto 0);
	-------------Ends Instruction Fetch Stage-----------

	signal Interface_1_enable: STD_LOGIC;

	------------Instruction Decode Stage---------------
	signal ID_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal ID_instruction: STD_LOGIC_VECTOR(15 downto 0);
	--Routine questions
	signal ID_Mem_Write: STD_LOGIC;
	signal ID_Reg_Write: STD_LOGIC;
	signal ID_Reg_Write_Add;
	signal ID_Reg_Write_Available: STD_LOGIC;
	signal ID_Reg_Read_1: STD_LOGIC; --Reading from IR 9-10-11
	signal ID_Reg_Read_2: STD_LOGIC; --Reading from IR 6-7-8
	signal ID_Read_Z: STD_LOGIC;    --Need Z for computation
	signal ID_Read_C: STD_LOGIC;
	signal ID_Z_Write: STD_LOGIC;
	signal ID_C_Write: STD_LOGIC;
	signal ID_Z_Available: STD_LOGIC;
	signal ID_PC_Change: STD_LOGIC;
	signal ID_PC_Available: STD_LOGIC;
	-------------Ends Instruction Decode Stage--------------

	signal Interface_2_enable: STD_LOGIC;


	-------------Register Read Stage----------------------
	signal RR_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal RR_instruction: STD_LOGIC_VECTOR(15 downto 0);
	--Routine questions
	signal RR_Mem_Write: STD_LOGIC;
	signal RR_Reg_Write: STD_LOGIC;
	signal RR_Reg_Write_Add;
	signal RR_Reg_Write_Available: STD_LOGIC;
	signal RR_Reg_Read_1: STD_LOGIC; --Reading from IR 9-10-11
	signal RR_Reg_Read_2: STD_LOGIC; --Reading from IR 6-7-8
	signal RR_Read_Z: STD_LOGIC;    --Need Z for computation
	signal RR_Read_C: STD_LOGIC;
	signal RR_Z_Write: STD_LOGIC;
	signal RR_C_Write: STD_LOGIC;
	signal RR_Z_Available: STD_LOGIC;
	signal RR_PC_Change: STD_LOGIC;
	signal RR_PC_Available: STD_LOGIC;

	signal RR_Stall_Bit: STD_LOGIC;
	signal RR_Valid_Bit: STD_LOGIC;
	--Routine Signals
	signal RR_Z: STD_LOGIC;
	signal RR_C: STD_LOGIC;
	-------------Ends Register Read Stage----------------

	signal Interface_3_enable: STD_LOGIC;

	--------------Execution Stage-----------------------
	signal EX_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal EX_instruction: STD_LOGIC_VECTOR(15 downto 0);
	--Routine questions
	signal EX_Mem_Write: STD_LOGIC;
	signal EX_Reg_Write: STD_LOGIC;
	signal EX_Reg_Write_Add: STD_LOGIC_VECTOR(2 downto 0);
	signal EX_Reg_Write_Available: STD_LOGIC;
	signal EX_Reg_Read_1: STD_LOGIC; --Reading from IR 9-10-11
	signal EX_Reg_Read_2: STD_LOGIC; --Reading from IR 6-7-8
	signal EX_Read_Z: STD_LOGIC;    --Need Z for computation
	signal EX_Z_Write: STD_LOGIC;
	signal EX_C_Write: STD_LOGIC;
	signal EX_Z_Available: STD_LOGIC;
	signal EX_PC_Change: STD_LOGIC;
	signal EX_PC_Available: STD_LOGIC;

	signal EX_Stall_Bit: STD_LOGIC;
	signal EX_Valid_Bit: STD_LOGIC;
	--Routine Signals
	signal EX_Z: STD_LOGIC;
	signal EX_C: STD_LOGIC;
	-------------Ends Execution Stage----------------------

	signal Interface_4_enable: STD_LOGIC;


	-------------Memory Access Stage--------------------
	signal MA_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal MA_instruction: STD_LOGIC_VECTOR(15 downto 0);
	--Routine questions
	signal MA_Mem_Write: STD_LOGIC;
	signal MA_Reg_Write: STD_LOGIC;
	signal MA_Reg_Write_Add: STD_LOGIC_VECTOR(2 downto 0);
	signal MA_Reg_Write_Available: STD_LOGIC;
	signal MA_Z_Write: STD_LOGIC;
	signal MA_C_Write: STD_LOGIC;
	signal MA_Z_Available: STD_LOGIC;
	signal MA_PC_Change: STD_LOGIC;
	signal MA_PC_Available: STD_LOGIC;

	signal MA_Stall_Bit: STD_LOGIC;
	signal MA_Valid_Bit: STD_LOGIC;
	--Routine Signals
	signal MA_Z: STD_LOGIC;
	signal MA_C: STD_LOGIC;
	------------Ends Memory Access Stage----------------

	signal Interface_5_enable: STD_LOGIC;

	------------Write Back Stage-----------------------
	signal WB_PC: STD_LOGIC_VECTOR(15 downto 0);
	signal WB_instruction: STD_LOGIC_VECTOR(15 downto 0);
	--Routine questions
	signal WB_Reg_Write: STD_LOGIC;
	signal WB_Reg_Write_Add: STD_LOGIC_VECTOR(2 downto 0);
	signal WB_Reg_Write_Available: STD_LOGIC;
	signal WB_Z_Write: STD_LOGIC;
	signal WB_C_Write: STD_LOGIC;
	signal WB_Z_Available: STD_LOGIC;
	signal WB_PC_Change: STD_LOGIC;
	signal WB_PC_Available: STD_LOGIC;

	signal WB_Stall_Bit: STD_LOGIC;
	signal WB_Valid_Bit: STD_LOGIC;
	--Routine Signals
	signal WB_Z: STD_LOGIC;
	signal WB_C: STD_LOGIC;
	-----------Ends Write Back Stage------------------

    --Registers
	signal R0 : STD_LOGIC_VECTOR(15 downto 0); signal R0_enable : STD_LOGIC;
    signal R1 : STD_LOGIC_VECTOR(15 downto 0); signal R1_enable : STD_LOGIC;
    signal R2 : STD_LOGIC_VECTOR(15 downto 0); signal R2_enable : STD_LOGIC;
    signal R3 : STD_LOGIC_VECTOR(15 downto 0); signal R3_enable : STD_LOGIC;
    signal R4 : STD_LOGIC_VECTOR(15 downto 0); signal R4_enable : STD_LOGIC;
    signal R5 : STD_LOGIC_VECTOR(15 downto 0); signal R5_enable : STD_LOGIC;
    signal R6 : STD_LOGIC_VECTOR(15 downto 0); signal R6_enable : STD_LOGIC;
    signal R7 : STD_LOGIC_VECTOR(15 downto 0); signal R7_enable : STD_LOGIC;
	signal C : STD_LOGIC;
	signal Z : STD_LOGIC;
    ----------CONTROL SIGNALS ---------------------

    ---MORE TO COME
    ---------END CONTROL SIGNALS-------------------

		begin
    ----------REGISTER PORT MAPPINGS---------------
--	IFStage: InstructionFetch port map (IF_PC, IF_PC_in, IF_instruction);
--	ChangePC: sixteenBitRegister port map(IF_PC_in, Interface_1_enable, clear, clock, IF_PC);

--	Interface1_0: sixteenBitRegister port map(IF_instruction, Interface_1_enable, clear, clock, ID_instruction);
--	Interface1_1: sixteenBitRegister port map(IF_PC, Interface_1_enable, clear, clock, ID_PC);

--	IDStage: InstructionDecode port map(ID_instruction, ID_Reg_Write, ID_Reg_Write_Add, ID_Z_Write, ID_Z_Available, ID_PC_Change, ID_PC_Available);

--	Interface2_0: oneBitRegister port map(ID_Reg_Write, Interface_2_enable, clear, clock, RR_Reg_Write);
--	Interface2_1: threeBitRegister port map(ID_Reg_Write_Add, Interface_2_enable, clear, clock, RR_Reg_Write_Add);
--	Interface2_3: oneBitRegister port map(ID_Z_Write, Interface_2_enable, clear, clock, RR_Z_Write);
--	Interface2_5: oneBitRegister port map(ID_PC_Change, Interface_2_enable, clear, clock, RR_PC_Change);
	--Data
--	Interface2_7: sixteenBitRegister port map(ID_PC, Interface_2_enable, clear, clock, RR_PC);
--	Interface2_8: sixteenBitRegister port map(ID_instruction, Interface_2_enable, clear, clock, RR_instruction);

--	SigCheckRR: SignalsCheckRR port map(RR_instruction(15 downto 12), RR_Reg_Write_Available, RR_Z_Available, RR_PC_Available);

--	RF1: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, RR_PC, RR_instruction(11 downto 9), Rf_d1);
--	RF2: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, RR_PC, RR_instruction(8 downto 6), Rf_d2);

--	SE6: SignExtended6 port map(RR_instruction(5 downto 0), SE6_op);
--	SE9: SignExtended9 port map(RR_instruction(8 downto 0), SE9_op);
--	SE9_spl: SignExtended9spl port map(RR_instruction(8 downto 0), SE9spl_op);

--	DataHazard1: DataHazardRR port map(RR_Reg_Read_1 and RR_Valid_Bit, RR_instruction(11 downto 9), Rf_d1, EX_Valid_Bit and EX_Reg_Write, EX_Reg_Write_Add, EX_Reg_Write_Available, EX_ALU_Data_Out, MA_Valid_Bit and MA_Reg_Write, MA_Reg_Write_Add, MA_Reg_Write_Available, MA_Data_out, WB_Valid_Bit and WB_Reg_Write, WB_Reg_Write_Add, WB_Reg_Write_Available, WB_Data, RR_Valid_Bit, RR_Data_Stall_1, RR_Reg_Data_Out_1);
--	DataHazard2: DataHazardRR port map(RR_Reg_Read_2 and RR_Valid_Bit, RR_instruction(8 downto 6), Rf_d2, EX_Valid_Bit and EX_Reg_Write, EX_Reg_Write_Add, EX_Reg_Write_Available, EX_ALU_Data_Out, MA_Valid_Bit and MA_Reg_Write, MA_Reg_Write_Add, MA_Reg_Write_Available, MA_Data_out, WB_Valid_Bit and WB_Reg_Write, WB_Reg_Write_Add, WB_Reg_Write_Available, WB_Data, RR_Valid_Bit, RR_Data_Stall_2, RR_Reg_Data_Out_2);
	ZeroHazard1: ZeroHazardRR port map(RR_Read_Z and RR_Valid_Bit, Z, EX_Z_Write, EX_Z_Available, EX_Z_out, MA_Z_Write, MA_Z_Available, MA_Z_out, WB_Z_Write, WB_Z_Available, WB_Z, RR_Valid_Bit, RR_Z_Stall, RR_Z_out);
	GetC: GetCarry port map(RR_Read_C and RR_Valid_Bit, C, EX_C_Write and EX_Valid_Bit, EX_C, MA_C_Write and MA_Valid_Bit, MA_C, WB_C_Write and WB_Valid_Bit, WB_C, RR_Valid_Bit, RR_C_out);

--	DataMux: DataSelector port map(RR_instruction(15 downto 12), RR_Reg_Data_Out_1, RR_Reg_Data_Out_2, SE6_op, SE9spl_op, RR_PC, SE9_op, RR_Data_1, RR_Data_2, RR_Data_3);

--	Interface3_0: oneBitRegister port map(RR_Reg_Write, Interface_3_enable, clear, clock, EX_Reg_Write);
--	Interface3_1: threeBitRegister port map(RR_Reg_Write_Add, Interface_3_enable, clear, clock, EX_Reg_Write_Add);
--	Interface3_3: oneBitRegister port map(RR_Z_Write, Interface_3_enable, clear, clock, EX_Z_Write);
--	Interface3_5: oneBitRegister port map(RR_PC_Change, Interface_3_enable, clear, clock, EX_PC_Change);
	--Data
--	Interface3_6: sixteenBitRegister port map(RR_instruction, Interface_3_enable, clear, clock, EX_instruction);
--	Interface3_7: conditionalsixteenBitRegister port map(RR_Data_3, RR_PC, RR_PC_Change and RR_PC_Available and Interface_3_enable, Interface_3_enable, clear, clock, EX_PC);
--	Interface3_8: sixteenBitRegister port map(RR_Data_1, Interface_3_enable, clear, clock, EX_Data_1);
--	Interface3_9: sixteenBitRegister port map(RR_Data_2, Interface_3_enable, clear, clock, EX_Data_2);
--	Interface3_10: sixteenBitRegister port map(RR_Data_3, Interface_3_enable, clear, clock, EX_Data_3);
	Interface3_11: oneBitRegister port map(RR_C_out, Interface_3_enable, clear, clock, EX_C_in);
	Interface3_12: oneBitRegister port map(RR_Z_out, Interface_3_enable, clear, clock, EX_Z_in);

	ALUBlock: ALU port map(EX_instruction(15 downto 12), EX_instruction(1 downto 0), EX_C_in, EX_Z_in, EX_Data_1, EX_Data_2, EX_ALU_Data_Out, EX_C_out, EX_Z_out);

--	SigCheckEX: SignalsCheckEX port map(EX_instruction(15 downto 12), EX_Reg_Write_Available, EX_Z_Available, EX_PC_Available);

--	Interface4_0: oneBitRegister port map(EX_Reg_Write, Interface_4_enable, clear, clock, MA_Reg_Write);
--	Interface4_1: threeBitRegister port map(EX_Reg_Write_Add, Interface_4_enable, clear, clock, MA_Reg_Write_Add);
--	Interface4_3: oneBitRegister port map(EX_Z_Write, Interface_4_enable, clear, clock, MA_Z_Write);
--	Interface4_5: oneBitRegister port map(EX_PC_Change, Interface_4_enable, clear, clock, MA_PC_Change);
	--Data
--	Interface4_6: sixteenBitRegister port map(EX_instruction, Interface_4_enable, clear, clock, MA_instruction);
--	Interface4_7: conditionalsixteenBitRegister port map(EX_ALU_Data_Out, EX_PC, EX_PC_Change and EX_PC_Available and Interface_4_enable, Interface_4_enable, clear, clock, MA_PC);
	--Non ALU Data Transfer missing
	Interface4_9: oneBitRegister port map(EX_C_out, Interface_4_enable, clear, clock, MA_C);
	Interface4_10: oneBitRegister port map(EX_Z_out, Interface_4_enable, clear, clock, MA_Z_in);

--	SigCheckMA: SignalsCheckMA port map(MA_instruction(15 downto 12), MA_Reg_Write_Available, MA_Z_Available, MA_PC_Available);
--	MemAccess: MemoryAccess port map(MA_instruction(15 downto 12), MA_Data_ALU, MA_Data_Non_ALU, MA_PC, MA_Mem_Write_Enable and MA_Mem_Write, clock, MA_Data_out);
	GetMA_Z: GetMAZero port map(MA_Z_in, MA_instruction(15 downto 12), MA_Data_out, MA_Z_out);

--	Interface5_0: oneBitRegister port map(MA_Reg_Write, Interface_5_enable, clear, clock, WB_Reg_Write);
--	Interface5_1: threeBitRegister port map(MA_Reg_Write_Add, Interface_5_enable, clear, clock, WB_Reg_Write_Add);
--	Interface5_3: oneBitRegister port map(MA_Z_Write, Interface_5_enable, clear, clock, WB_Z_Write);
--	Interface5_5: oneBitRegister port map(MA_PC_Change, Interface_5_enable, clear, clock, WB_PC_Change);
	--Data
--	Interface5_6: sixteenBitRegister port map(MA_instruction, Interface_5_enable, clear, clock, WB_instruction);
--	Interface5_7: conditionalsixteenBitRegister port map(MA_Data_out, MA_PC, MA_PC_Change and MA_PC_Available and Interface_5_enable, Interface_5_enable, clear, clock, WB_PC);
	Interface4_9: oneBitRegister port map(MA_C, Interface_5_enable, clear, clock, WB_C);
	Interface4_10: oneBitRegister port map(MA_Z_out, Interface_5_enable, clear, clock, WB_Z);

--	SigCheckWB: SignalsCheckWB port map(WB_instruction(15 downto 12), WB_Reg_Write_Available, WB_Z_Available, WB_PC_Available);

--	RegWriteEnable: WriteBack port map(WB_Reg_Write_Add, WB_Reg_Write and WB_Valid_Bit, R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable_unused);
--	Reg0: sixteenBitRegister port map(WB_Data, R0_enable, clear, clock, R0);
--    Reg1: sixteenBitRegister port map(WB_Data, R1_enable, clear, clock, R1);
--    Reg2: sixteenBitRegister port map(WB_Data, R2_enable, clear, clock, R2);
--    Reg3: sixteenBitRegister port map(WB_Data, R3_enable, clear, clock, R3);
--    Reg4: sixteenBitRegister port map(WB_Data, R4_enable, clear, clock, R4);
--    Reg5: sixteenBitRegister port map(WB_Data, R5_enable, clear, clock, R5);
--    Reg6: sixteenBitRegister port map(WB_Data, R6_enable, clear, clock, R6);
--	Reg7: sixteenBitRegister port map(WB_Updated_PC, WB_Valid_Bit, clear, clock, R7);  --DOUBTFUL
--	PCUpdate: UpdatePC port map(WB_PC, WB_PC_Change and WB_Valid_Bit, WB_Updated_PC);
	CarryFlag: oneBitRegister port map(WB_C, WB_Valid_Bit and WB_C_Write, clear, clock, C);
	ZeroFlag: oneBitRegister port map(WB_Z, WB_Valid_Bit and WB_Z_Write, clear, clock, Z);

	StallCondition: CheckStall port map(ID_Stall_Bit, RR_Stall_Bit, EX_Stall_Bit, MA_Stall_Bit, WB_Stall_Bit, Interface_1_enable, Interface_2_enable, Interface_3_enable, Interface_4_enable, Interface_5_enable);
	ModifyValid: ModifyValidBits

end behave;
