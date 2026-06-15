module maindec (
    input  [5:0] opcode,
    output       regwrite, regdst, alusrc,
    output       branch, memwrite, memtoreg,
    output [1:0] aluop
);
    reg [7:0] controls;

    assign {regwrite, regdst, alusrc, branch,
            memwrite, memtoreg, aluop} = controls;

    always @(*) begin
        case (opcode)
            6'b000000: controls = 8'b11000010; // R-type
            6'b100011: controls = 8'b10100100; // lw
            6'b101011: controls = 8'b00100000; // sw
            6'b000100: controls = 8'b00010001; // beq
            6'b001000: controls = 8'b10100000; // addi
            default:   controls = 8'bxxxxxxxx;
        endcase
    end
endmodule