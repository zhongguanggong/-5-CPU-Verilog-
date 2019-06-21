module PC_Plus4(PCF,PCPlus4F);

input [31:0] PCF;
output reg [31:0] PCPlus4F;

//assign PCPlus4F = PCF + 4;

always @ ( * )
begin
	PCPlus4F <= PCF + 4;
end

endmodule