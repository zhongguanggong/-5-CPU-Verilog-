module CLK3(clk,RegWriteE,MemtoRegE,MemWriteE,ALUOutE,WriteDataE,WriteRegE,RegWriteM,MemtoRegM,MemWriteM,ALUOutM,WriteDataM,WriteRegM);

input clk,RegWriteE,MemtoRegE,MemWriteE;
input [4:0] WriteRegE;
input [31:0] ALUOutE,WriteDataE;

output reg RegWriteM,MemtoRegM,MemWriteM;
output reg [4:0] WriteRegM;
output reg [31:0] ALUOutM,WriteDataM;

always @ (posedge clk)
begin
	RegWriteM <= RegWriteE;
	MemtoRegM <= MemtoRegE;
	MemWriteM <= MemWriteE;
	WriteRegM <= WriteRegE;
	ALUOutM <= ALUOutE;
	WriteDataM <= WriteDataE;
end

endmodule
