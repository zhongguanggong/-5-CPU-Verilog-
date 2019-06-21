`timescale 1ns/10ps
module Top(clk);

output reg clk;
reg reset;

wire StallD,FlushE,ALUSrcE,RegDstE,ForwardAD,ForwardBD,
RegWriteE,MemtoRegE,MemWriteE,MemWriteM,RegWriteM,MemtoRegM,
RegWriteW,MemtoRegW,EqualD,RegWriteD,RegDstD,ALUSrcD,BranchD,MemWriteD,MemtoRegD,PCSrcD,JumpD,StallF;
wire [1:0] ForwardAE,ForwardBE;
wire [3:0] ALUCtrE,ALUCtrD;
wire [4:0] RsD,RtD,RdD,RsE,RtE,RdE,WriteRegE,WriteRegM,WriteRegW;
wire [5:0] Op,Func;
wire [31:0] RD_ROM,RD1E,RD2E,SignImmE,SignImmD,RD1,RD2,
ALUOutE,WriteDataE,WriteDataM,RD_RAM,ALUOutM,ReadDataW,ALUOutW,ResultW
,InstrD,PCPlus4F,PCBranchD,PCJumpD,PCF,PCPlus4D,SignImmD_J,r1,r2,r4,PC;
wire CLR;

initial begin
	clk <= 0;
	reset <= 1;
	#2;reset <= 0;
	$monitor("%t : r1 = %d",$time,r1);
	#500; $stop;
end

always #1 clk <= ~clk;

always @ ( * )
begin
	if(RD_ROM === 32'bx)
	begin
		#15;
			$stop;
	end
end

ALU ALU(RD1E,RD2E,ALUCtrE,ResultW,SignImmE,ALUOutM,ForwardAE,ForwardBE,ALUSrcE,ALUOutE,WriteDataE);
CLK1 CLK1(clk,StallD,PCPlus4F,CLR,RD_ROM,InstrD,RsD,RtD,RdD,PCPlus4D);
CLK2 CLK2(clk,FlushE,RegWriteD,MemtoRegD,MemWriteD,ALUCtrD,ALUSrcD,RegDstD,RsD,RtD,RdD,SignImmD,RD1,RD2,
						RegWriteE,MemtoRegE,MemWriteE,ALUCtrE,ALUSrcE,RegDstE,RsE,RtE,RdE,RD1E,RD2E,SignImmE,WriteRegE);
CLK3 CLK3(clk,RegWriteE,MemtoRegE,MemWriteE,ALUOutE,WriteDataE,WriteRegE,RegWriteM,MemtoRegM,MemWriteM,ALUOutM,WriteDataM,WriteRegM);
CLK4 CLK4(clk,RegWriteM,MemtoRegM,RD_RAM,ALUOutM,WriteRegM,
RegWriteW,MemtoRegW,ReadDataW,ALUOutW,WriteRegW,ResultW);
CU CU(InstrD,EqualD,RegWriteD,RegDstD,ALUSrcD,BranchD,MemWriteD,MemtoRegD,JumpD,ALUCtrD,PCSrcD,CLR,Op,Func);
Hazard_Unit Hazard_Unit(RegWriteE,RegWriteM,RegWriteW,MemtoRegE,MemtoRegM,BranchD,RsD,RtD,RsE,RtE,WriteRegE,WriteRegM,
									WriteRegW,ForwardAE,ForwardBE,ForwardAD,ForwardBD,StallF,StallD,FlushE);
PC PC_init(clk,reset,StallF,PCSrcD,JumpD,PCPlus4F,PCBranchD,PCJumpD,PCF,PC);
PC_Beq PC_Beq(SignImmD,PCPlus4D,PCBranchD);
PC_Jump PC_Jump(SignImmD_J,PCPlus4D,PCJumpD);
PC_Plus4 PC_Plus4(PCF,PCPlus4F);
RAM RAM(clk,MemWriteM,ALUOutM,WriteDataM,RD_RAM);
Register Register(clk,RegWriteW,ForwardAD,ALUOutM,ForwardBD,WriteRegW,InstrD,ResultW,RD1,RD2,EqualD,r1,r2,r4);
ROM ROM(PCF,RD_ROM);
Sign_Extend Sign_Extend(InstrD,SignImmD,SignImmD_J);

endmodule
