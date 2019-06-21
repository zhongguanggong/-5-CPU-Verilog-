module PC(clk,reset,StallF,PCSrcD,JumpD,PCPlus4F,PCBranchD,PCJumpD,PCF,PC);

input clk,reset,PCSrcD,JumpD,StallF;
input [31:0] PCPlus4F,PCBranchD,PCJumpD;
output reg [31:0] PCF;

output reg [31:0] PC;

always @ (posedge clk or posedge reset)
begin
	if(reset)
		PCF <= 0;
	else if(StallF) PCF <= PCF-4;
	else  PCF <= PC;                                                                                                                                                                                                                                  
end

//assign PC = (PCBranchD & {32{PCSrcD}}) + (PCJumpD & {32{JumpD}}) + (PCPlus4F & {32{!PCSrcD}} & {32{!JumpD}});

always @ ( * )//(posedge clk)
begin
	//if(StallF) PC <= PC;
	if(PCSrcD) 
		PC <=  PCBranchD;
	else if(JumpD)
		PC <= PCJumpD;
	else
		PC <= PCPlus4F;
end

endmodule
