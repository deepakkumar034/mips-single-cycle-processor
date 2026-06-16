`timescale 1ns/1ps

module tb_top;

    reg clk, reset;
    wire [31:0] writedata, aluout, pc, instr;
    wire        memwrite;

    // DUT
    top dut (
        .clk       (clk),
        .reset     (reset),
        .writedata (writedata),
        .aluout    (aluout),
        .pc        (pc),
        .instr     (instr),
        .memwrite  (memwrite)
    );

    // Clock
    initial clk = 1;
    always #5 clk = ~clk;

    // Instruction field 
    wire [5:0]  opcode = instr[31:26];
    wire [5:0]  funct  = instr[5:0];
    

    // ALU signals
    wire [31:0] alu_a      = dut.mips_cpu.dp.alu.a;
    wire [31:0] alu_b      = dut.mips_cpu.dp.alu.b;
    wire [2:0]  alucontrol = dut.mips_cpu.dp.alu.alucontrol;
    

    // Control signals
    wire regwrite = dut.mips_cpu.c.regwrite;
    wire regdst   = dut.mips_cpu.c.regdst;
    wire alusrc   = dut.mips_cpu.c.alusrc;
    wire memtoreg = dut.mips_cpu.c.memtoreg;
    wire pcsrc    = dut.mips_cpu.c.pcsrc;
    wire branch   = dut.mips_cpu.c.branch;

    // Register file signals
    wire        rf_we3 = dut.mips_cpu.dp.rf.we3;
    wire [4:0]  rf_ra1 = dut.mips_cpu.dp.rf.ra1;
    wire [4:0]  rf_ra2 = dut.mips_cpu.dp.rf.ra2;
    wire [4:0]  rf_wa3 = dut.mips_cpu.dp.rf.wa3;
    wire [31:0] rf_wd3 = dut.mips_cpu.dp.rf.wd3;
    wire [31:0] rf_rd1 = dut.mips_cpu.dp.rf.rd1;
    wire [31:0] rf_rd2 = dut.mips_cpu.dp.rf.rd2;

    // Data memory signals
    wire        dmem_we = dut.dmem_unit.we;
    wire [31:0] dmem_a  = dut.dmem_unit.a;
    wire [31:0] dmem_wd = dut.dmem_unit.wd;
    wire [31:0] dmem_rd = dut.dmem_unit.rd;

   
    initial begin
        $dumpfile("mips_full.vcd");
        $dumpvars(0, tb_top);
    end

    // Run
    initial begin
        reset = 1;
        @(negedge clk);
        reset = 0;
        repeat (30) @(negedge clk);
        $finish;
    end

    // PC monitor — print every instruction fetch
    always @(negedge clk) begin
        $display("[%0t ns] PC=0x%h  instr=0x%h  memwrite=%b",
                  $time,
                  dut.mips_cpu.pc,
                  dut.mips_cpu.instr,
                  memwrite);
    end

endmodule