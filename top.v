module top (
    input         clk, reset,
    output [31:0] writedata, aluout,
    output        memwrite
);
    wire [31:0] pc, instr, readdata;

    mips mips_cpu (
        .clk       (clk),
        .reset     (reset),
        .pc        (pc),
        .instr     (instr),
        .memwrite  (memwrite),
        .aluout    (aluout),
        .writedata (writedata),
        .readdata  (readdata)
    );

    imem imem_unit (
        .a  (pc),
        .rd (instr)
    );

    dmem dmem_unit (
        .clk (clk),
        .we  (memwrite),
        .a   (aluout),
        .wd  (writedata),
        .rd  (readdata)
    );
endmodule