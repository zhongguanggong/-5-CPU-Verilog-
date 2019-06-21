module PC_Beq(SignImmD,PCPlus4D,PCBranchD);

input [31:0] SignImmD,PCPlus4D;
output wire [31:0] PCBranchD;

assign PCBranchD = (SignImmD<<2)+PCPlus4D;

/*always @ ( * )
begin
	PCBranchD <= (SignImmD<<2)+PCPlus4D;
end*/

endmodule
