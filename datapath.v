module datapath (
    input         clk, reset,
    // control signals
    input         memtoreg, pcsrc,
    input         alusrc, regdst,
    input         regwrite,
    input  [2:0]  alucontrol,
    // outputs to controller
    output        zero,
    // memory interfaces
    output [31:0] pc,
    input  [31:0] instr,
    output [31:0] aluout, writedata,
    input  [31:0] readdata
);

    wire [31:0] pcnext, pcplus4, pcbranch;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] result;
    wire [ 4:0] writereg;

    // PC register
    reg [31:0] pcreg;

    always @(posedge clk, posedge reset) begin
        if (reset) pcreg <= 32'b0;
        else        pcreg <= pcnext;
    end
 
    assign pc = pcreg;

    // PC + 4
    adder pcadd1 (
        .a (pc),
        .b (32'd4),
        .y (pcplus4)
    );

    // Sign extend immediate [15:0] → [31:0]
    signext se (
        .a (instr[15:0]),
        .y (signimm)
    );

    // Shift left 2 for branch offset
    sl2 immsh (
        .a (signimm),
        .y (signimmsh)
    );

    // Branch target = PC+4 + (signimm << 2)
    adder pcadd2 (
        .a (pcplus4),
        .b (signimmsh),
        .y (pcbranch)
    );

    // PC next mux: PC+4 or branch target
    mux #(32) pcmux (
        .d0 (pcplus4),
        .d1 (pcbranch),
        .s  (pcsrc),
        .y  (pcnext)
    );

    // Register file
    regfile rf (
        .clk (clk),
        .we3 (regwrite),
        .ra1 (instr[25:21]),   // rs
        .ra2 (instr[20:16]),   // rt
        .wa3 (writereg),
        .wd3 (result),
        .rd1 (srca),
        .rd2 (writedata)
    );

    // Write register mux: rt or rd
    mux #(5) wrmux (
        .d0 (instr[20:16]),    // rt  (I-type)
        .d1 (instr[15:11]),    // rd  (R-type)
        .s  (regdst),
        .y  (writereg)
    );

    // ALU source B mux: register or immediate
    mux #(32) srcbmux (
        .d0 (writedata),       // rt from regfile
        .d1 (signimm),         // sign-extended immediate
        .s  (alusrc),
        .y  (srcb)
    );

    // ALU
    alu alu (
        .a          (srca),
        .b          (srcb),
        .alucontrol (alucontrol),
        .result     (aluout),
        .zero       (zero)
    );

    // Write-back mux: ALU result or memory read data
    mux #(32) resmux (
        .d0 (aluout),
        .d1 (readdata),
        .s  (memtoreg),
        .y  (result)
    );

endmodule