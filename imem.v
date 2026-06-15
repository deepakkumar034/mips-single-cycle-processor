// DESCRIPTION: Instruction Memory (ROM)
// - 64-word (256-byte) ROM, word-addressed
// - Initialized from hex file or inline $readmemh
// - Word-addressable: A[31:2] selects the word


module imem(
    input [31:0]a,
    output [31:0] rd
);

    reg [31:0] RAM [63:0];

    initial begin
        // Simple test program (NOP / ADDI loop)
        // addi $s0, $0, 5         # $s0 = 5
        RAM[0]  = 32'h20100005;
        // addi $s1, $0, 12        # $s1 = 12
        RAM[1]  = 32'h2011000C;
        // addi $s2, $0, -9        # $s2 = -9
        RAM[2]  = 32'h2012FFF7;
        // add  $s3, $s0, $s1      # $s3 = $s0 + $s1
        RAM[3]  = 32'h02119820;
        // sub  $s4, $s3, $s2      # $s4 = $s3 - $s2
        RAM[4]  = 32'h0272A022;
        // and  $s5, $s3, $s4      # $s5 = $s3 & $s4
        RAM[5]  = 32'h0274A824;
        // beq  $s0, $s1, 2        # branch if $s0 == $s1 (not taken)
        RAM[6]  = 32'h12110002;
        // sw   $s4, 4($0)         # Mem[4] = $s4
        RAM[7]  = 32'hAC140004;
        // lw   $s5, 4($0)         # $s5 = Mem[4]
        RAM[8] = 32'h8C150004;
        
        // Fill rest with NOPs
        // nop
        RAM[9] = 32'h00000000;
    end

    assign rd = RAM[a[31:2]]; // PC is byte-addressed, RAM is word-addressed

endmodule