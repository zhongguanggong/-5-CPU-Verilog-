module ROM(PCF,RD_ROM);

input [31:0] PCF;
output wire [31:0] RD_ROM;

wire [31:0] A;
reg [31:0] mem_rom [100:0];

initial begin
	$readmemh("ROM_Init.txt",mem_rom);
end

assign A = PCF>>2;
assign RD_ROM = mem_rom[A];

endmodule
