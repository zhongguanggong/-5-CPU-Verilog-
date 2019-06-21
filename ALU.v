module ALU(RD1E,RD2E,ALUCtrE,ResultW,SignImmE,ALUOutM,ForwardAE,ForwardBE,ALUSrcE,ALUOutE,WriteDataE);
input ALUSrcE;
input [31:0] RD1E,RD2E,ResultW,SignImmE,ALUOutM;
input [1:0] ForwardAE,ForwardBE;
input [3:0] ALUCtrE;
output reg [31:0] ALUOutE,WriteDataE;

reg [31:0] SrcAE;
wire [31:0] SrcBE;

assign SrcBE = (WriteDataE&{32{!ALUSrcE}}) + (SignImmE&{32{ALUSrcE}});

always @ ( * )
begin
	case(ForwardAE)
		2'b00: SrcAE <= RD1E;
		2'b01: SrcAE <= ResultW;
		2'b10: SrcAE <= ALUOutM;
		default;
	endcase
	case(ForwardBE)
		2'b00: WriteDataE <= RD2E;
		2'b01: WriteDataE <= ResultW;
		2'b10: WriteDataE <= ALUOutM;
		default;
	endcase
end

always @( * )
begin
	case(ALUCtrE)
		4'b0000: ALUOutE <= SrcAE + SrcBE;
		4'b0001: ALUOutE <= SrcAE - SrcBE;
		4'b0010: ALUOutE <= SrcAE & SrcBE;
		4'b0011: ALUOutE <= SrcAE | SrcBE;
		4'b0100: ALUOutE <= SrcAE ^ SrcBE;
		4'b0101: ALUOutE <= ~(SrcAE | SrcBE);
		4'b0110: begin if(SrcAE<SrcBE) ALUOutE <= 1;else ALUOutE <= 0; end
		4'b0111: ALUOutE <= SrcAE << SrcBE;
		4'b1000: ALUOutE <= SrcAE >> SrcBE;
		default;
	endcase
end

endmodule