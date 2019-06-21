module CLK1(clk,StallD,PCPlus4F,CLR,RD_ROM,InstrD,RsD,RtD,RdD,PCPlus4D);

input clk,StallD,CLR;
input [31:0] RD_ROM,PCPlus4F;
output reg [31:0] InstrD,PCPlus4D;
output wire [4:0] RsD,RtD,RdD;

always @ (posedge clk)
begin
	if(StallD) InstrD <= InstrD;
	else if(CLR) 
	begin
		InstrD <= 32'h0000_0001;
	end
	else InstrD <= RD_ROM;
end

always @ ( posedge clk )
begin
	if(CLR) PCPlus4D <= PCPlus4D;//********************?
	else PCPlus4D <= PCPlus4F;
end

assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RdD = InstrD[15:11];

endmodule
