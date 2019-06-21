module Register(clk,RegWriteW,ForwardAD,ALUOutM,ForwardBD,WriteRegW,InstrD,ResultW,RD1,RD2,EqualD,r1,r2,r4);

input clk,RegWriteW,ForwardAD,ForwardBD;
input [4:0] WriteRegW;
input [31:0] InstrD,ResultW,ALUOutM;
output wire EqualD;
output wire [31:0] RD1,RD2,r1,r2,r4;

wire WE3;
wire [4:0] A1,A2,A3;
wire [31:0] WD3,S1,S2;
reg [31:0] mem_reg [31:0];

initial begin
	$readmemh("Register_Init.txt",mem_reg);
end

assign A1 = InstrD[25:21];
assign A2 = InstrD[20:16];
assign A3 = WriteRegW;
assign WE3 = RegWriteW;
assign WD3 = ResultW;

assign RD1 = mem_reg[A1];
assign RD2 = mem_reg[A2];
assign r1 = mem_reg[1];
assign r2 = mem_reg[2];
assign r4 = mem_reg[4];

assign S1 = (RD1 & {32{!ForwardAD}}) + (ALUOutM & {32{ForwardAD}});
assign S2 = (RD2 & {32{!ForwardBD}}) + (ALUOutM & {32{ForwardBD}});

assign EqualD = !(S1^S2);

always @ (posedge clk)
begin
	if(WE3)
		mem_reg[A3] <= WD3;
end

endmodule
