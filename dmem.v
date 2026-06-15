// DESCRIPTION: Data Memory (RAM)
// REF: Harris & Harris, DDCA, Chapter 7
//
// - 64-word synchronous write, asynchronous read
// - Word-addressable (byte address >> 2)
// - Write on rising clock edge when we=1


module dmem(
    input clk, we,
    input [31:0]a, wd,
    output [31:0] rd
);
    reg [31:0] RAM [63:0];

    always @(posedge clk) begin 
        if (we)
            RAM[a[31:2]] <= wd;
            
    end

    assign rd = RAM[a[31:2]];

    endmodule
            
