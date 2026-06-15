module mips (
    input         clk, reset,
    output [31:0] pc,
    input  [31:0] instr,
    output        memwrite,
    output [31:0] aluout, writedata,
    input  [31:0] readdata
);
    wire        memtoreg, pcsrc;
    wire        alusrc, regdst, regwrite;
    wire        zero;
    wire [2:0]  alucontrol;

    control c (
        .opcode     (instr[31:26]),  // ← opcode not op
        .funct      (instr[5:0]),
        .zero       (zero),
        .memtoreg   (memtoreg),
        .memwrite   (memwrite),
        .pcsrc      (pcsrc),
        .alusrc     (alusrc),
        .regdst     (regdst),
        .regwrite   (regwrite),
        .alucontrol (alucontrol)
    );

    datapath dp (
        .clk        (clk),
        .reset      (reset),
        .memtoreg   (memtoreg),
        .pcsrc      (pcsrc),
        .alusrc     (alusrc),
        .regdst     (regdst),
        .regwrite   (regwrite),
        .alucontrol (alucontrol),
        .zero       (zero),
        .pc         (pc),
        .instr      (instr),
        .aluout     (aluout),
        .writedata  (writedata),
        .readdata   (readdata)
    );
endmodule