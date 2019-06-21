module Hazard_Unit(RegWriteE,RegWriteM,RegWriteW,MemtoRegE,MemtoRegM,BranchD,rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,
									WriteRegW,ForwardAE,ForwardBE,ForwardAD,ForwardBD,StallF,StallD,FlushE);
input RegWriteE,RegWriteM,RegWriteW,MemtoRegE,MemtoRegM,BranchD;
input [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW;
output reg [1:0] ForwardAE,ForwardBE;
output reg ForwardAD,ForwardBD,StallF,StallD,FlushE;

reg lwstall,branchstall;

always @ ( * )
begin
	if((rsE != 0) && (rsE == WriteRegM) && RegWriteM)     //rsE!=0:寄存器0一直为0
		ForwardAE <= 2'b10;    //上一条指令的写回地址与本条指令的操作数地址一致
	else if ((rsE != 0) && (rsE == WriteRegW) && (RegWriteW))
		ForwardAE <= 2'b01;   //上上条指令的写回地址与本条指令的操作数地址一致
	else ForwardAE <= 2'b00;
	if((rtE != 0) && (rtE == WriteRegM) && RegWriteM)     
		ForwardBE <= 2'b10;
	else if ((rtE != 0) && (rtE == WriteRegW) && (RegWriteW)) 
		ForwardBE <= 2'b01;
	else ForwardBE <= 2'b00;
	lwstall <= ((rsD==rtE) || (rtD==rtE)) && MemtoRegE;   //操作数需要等待存储器的值写回寄存器
	ForwardAD <= (rsD!=0) && (rsD==WriteRegM) && RegWriteM;
	ForwardBD <= (rtD!=0) && (rtD==WriteRegM) && RegWriteM;
	branchstall <= (BranchD && RegWriteE && (WriteRegE == rsD || WriteRegE == rtD) )
  || (BranchD && MemtoRegM && (WriteRegM == rsD || WriteRegM == rtD));//beq指令比较的数需要等待前一条指令执行完成！
	FlushE <= lwstall || branchstall;
	//if(branchstall) PC = PC
	StallF <= StallD;
	StallD <= FlushE;
end

endmodule
