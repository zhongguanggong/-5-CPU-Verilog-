module Sign_Extend(InstrD,SignImmD,SignImmD_J);

input [31:0] InstrD;
output wire [31:0] SignImmD,SignImmD_J;

wire [15:0] Sign16;
wire [27:0] Sign26;

assign Sign16 = InstrD[15:0];
assign Sign26 = InstrD[27:0]<<2;

assign SignImmD = {{16{Sign16[15]}},Sign16};
assign SignImmD_J = {{4{Sign26[27]}},Sign26};

endmodule
