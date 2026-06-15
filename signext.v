// DESCRIPTION: 16-to-32-bit Sign Extender

module signext (
    input  [15:0] a,
    output [31:0] y
);
    assign y = {{16{a[15]}}, a};  // Replicate sign bit 16 times
endmodule
