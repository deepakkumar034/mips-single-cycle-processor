module regfile (
    input clk,
    input we3,
    input [4:0] ra1, ra2, wa3, 
    input [31:0] wd3, 
    output [31:0] rd1, rd2
);

    reg [31:0] rf [31:0];

    always @(posedge clk) begin
        if (we3) begin
            rf[wa3] <= wd3;
        

        case(wa3)
            5'b10000: $display("content of $s0 = %h", wd3);
            5'b10001: $display("content of $s1 = %h", wd3);
            5'b10010: $display("content of $s2 = %h", wd3);
            5'b10011: $display("content of $s3 = %h", wd3);
            5'b10100: $display("content of $s4 = %h", wd3);
            5'b10101: $display("content of $s5 = %h", wd3);
            5'b10110: $display("content of $s6 = %h", wd3);
        endcase
        end
    end

    // Asynchronous read — $zero hardwired to 0
    assign rd1 = (ra1 == 5'b0) ? 32'b0 : rf[ra1];
    assign rd2 = (ra2 == 5'b0) ? 32'b0 : rf[ra2];

endmodule
