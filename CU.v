module CU(InstrD,EqualD,RegWriteD,RegDstD,ALUSrcD,BranchD,MemWriteD,MemtoRegD,JumpD,ALUCtrD,PCSrcD,CLR,Op,Func);

input EqualD;
input  [31:0]InstrD;
output reg RegWriteD,RegDstD,ALUSrcD,BranchD,MemWriteD,MemtoRegD,JumpD,PCSrcD;
output reg [3:0] ALUCtrD;
output wire CLR;
output wire [5:0]Op,Func;

assign Op = InstrD[31:26];
assign Func = InstrD[5:0];
assign CLR = PCSrcD | JumpD;

always @( * )
begin
	case(Op)
		6'b000000:begin  //寄存器形式指令
			case(Func)
				6'b100000:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0000;end //add
				6'b100010:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0001;end //sub
				6'b100100:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0010;end //and
				6'b100101:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0011;end //or
				6'b100110:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0100;end //xor
				6'b100111:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0101;end //nor
				6'b101010:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0110;end //slt
				6'b000000:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0111;end //sll
				6'b000010:begin RegWriteD <= 1;RegDstD <= 1;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b1000;end //srl
				default: begin RegWriteD <= 0;RegDstD <= 0;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0000;end  //NOP
			endcase
		end
		
		/*************************     立即数形式指令    ***********************************/
		6'b001000:begin RegWriteD <= 1;RegDstD <= 0;ALUSrcD <= 1;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0000;end //addi
		6'b001100:begin RegWriteD <= 1;RegDstD <= 0;ALUSrcD <= 1;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0010;end //andi
		6'b001101:begin RegWriteD <= 1;RegDstD <= 0;ALUSrcD <= 1;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0011;end //ori
		6'b001110:begin RegWriteD <= 1;RegDstD <= 0;ALUSrcD <= 1;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0100;end //xori
		6'b100011:begin RegWriteD <= 1;RegDstD <= 0;ALUSrcD <= 1;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 1;JumpD <= 0;ALUCtrD <= 4'b0000;end //lw
		6'b101011:begin RegWriteD <= 0;BranchD <= 0;ALUSrcD <= 1;MemWriteD <= 1;JumpD <= 0;ALUCtrD <= 4'b0000;end //sw
		6'b000100:begin RegWriteD <= 0;BranchD <= 1;MemWriteD <= 0;JumpD <= 0;end //beq
		
		6'b000010:begin RegWriteD <= 0;BranchD <= 0;MemWriteD <= 0;JumpD <= 1;end //j

		default: begin RegWriteD <= 0;RegDstD <= 0;ALUSrcD <= 0;BranchD <= 0;MemWriteD <= 0;MemtoRegD <= 0;JumpD <= 0;ALUCtrD <= 4'b0000;end  //NOP
	endcase
	PCSrcD <= EqualD & BranchD;
end

endmodule
