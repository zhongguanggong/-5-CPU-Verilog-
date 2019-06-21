module CLK4(clk,RegWriteM,MemtoRegM,RD_RAM,ALUOutM,WriteRegM,
RegWriteW,MemtoRegW,ReadDataW,ALUOutW,WriteRegW,ResultW);

input clk,RegWriteM,MemtoRegM;
input [4:0] WriteRegM;
input [31:0] RD_RAM,ALUOutM;

output reg RegWriteW,MemtoRegW;
output reg [4:0] WriteRegW;
output reg [31:0] ReadDataW,ALUOutW;
output wire [31:0] ResultW;

always @ (posedge clk)
begin
	RegWriteW <= RegWriteM;
	MemtoRegW <= MemtoRegM;
	WriteRegW <= WriteRegM;
	ReadDataW <= RD_RAM;
	ALUOutW <= ALUOutM;
end

assign ResultW = (ReadDataW & {32{MemtoRegW}})+(ALUOutW & {32{!MemtoRegW}});

endmodule
 