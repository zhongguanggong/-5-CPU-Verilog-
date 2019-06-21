module RAM(clk,MemWriteM,ALUOutM,WriteDataM,RD_RAM);

input clk,MemWriteM;
input [31:0] ALUOutM,WriteDataM;
output wire [31:0] RD_RAM;

wire WE;
wire [31:0] A,WD;
reg [31:0] mem_ram [100:0];

initial begin
	$readmemh("RAM_Init.txt",mem_ram);
end

assign WE = MemWriteM;
assign A = ALUOutM;
assign WD = WriteDataM;

assign RD_RAM = mem_ram[A];

always @ (posedge clk)
begin
	if(WE)
		mem_ram[A] <= WD;	
end

endmodule
