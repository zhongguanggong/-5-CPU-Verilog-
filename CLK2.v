module CLK2(clk,FlushE,RegWriteD,MemtoRegD,MemWriteD,ALUCtrD,ALUSrcD,RegDstD,RsD,RtD,RdD,SignImmD,RD1,RD2,
						RegWriteE,MemtoRegE,MemWriteE,ALUCtrE,ALUSrcE,RegDstE,RsE,RtE,RdE,RD1E,RD2E,SignImmE,WriteRegE);

input clk,FlushE,RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,RegDstD;
input [3:0] ALUCtrD;
input [4:0] RsD,RtD,RdD;
input [31:0] SignImmD,RD1,RD2;

output reg RegWriteE,MemtoRegE,MemWriteE,ALUSrcE,RegDstE;
output reg [3:0] ALUCtrE;
output reg [4:0] RsE,RtE,RdE;
output reg [31:0] RD1E,RD2E,SignImmE;
output wire [4:0] WriteRegE;

always @ (posedge clk)
begin
	RegWriteE <= RegWriteD;
	MemtoRegE <= MemtoRegD;
	MemWriteE <= MemWriteD;
	ALUSrcE <= ALUSrcD;
	RegDstE <= RegDstD;
	ALUCtrE <= ALUCtrD;
	if(FlushE) ;
	else begin
		
		RsE <= RsD;
		RtE <= RtD;
		RdE <= RdD;
		RD1E <= RD1;
		RD2E <= RD2;
		SignImmE <= SignImmD;
	end
end

assign WriteRegE = (RtE & {5{!RegDstE}}) + (RdE & {5{RegDstE}});

endmodule
