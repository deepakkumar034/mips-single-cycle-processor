// FILE: sl2.v  (included here)
// DESCRIPTION: Shift Left by 2 (multiply by 4)
 
module sl2 (
    input  [31:0] a,
    output [31:0] y
);
    assign y = {a[29:0], 2'b00};  // Logical left shift by 2
endmodule