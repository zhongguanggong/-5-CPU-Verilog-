module PC_Jump(SignImmD_J,PCPlus4D,PCJumpD);

input [31:0] SignImmD_J,PCPlus4D;
output wire [31:0] PCJumpD;

assign PCJumpD = {PCPlus4D[31:28],SignImmD_J[27:0]};

endmodule
