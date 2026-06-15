module control (
    input [5:0] opcode, funct, 
    input zero,
    output regwrite, regdst, alusrc, pcsrc, memwrite, memtoreg, 
    output [2:0] alucontrol
);

    wire branch;
    wire [1:0] aluop;

    maindec maindecoder(
        .opcode(opcode), 
        .regwrite(regwrite), 
        .regdst(regdst),
        .alusrc(alusrc),
        .branch(branch), 
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .aluop(aluop)
    );

    aludec aludecoder(
        .aluop(aluop),
        .funct(funct), 
        .alucontrol(alucontrol)
    );

    assign pcsrc = branch & zero ;
    endmodule