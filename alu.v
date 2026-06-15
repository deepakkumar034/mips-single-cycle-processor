module alu(
    input [31:0] a, b,
    input [2:0] alucontrol,
    output reg [31:0] result, 
    output zero 
);
    wire [31:0]condinv, sum;  

    assign condinv = alucontrol[2] ? ~b : b;
    assign sum = a + condinv + alucontrol[2];

    always @(*) begin 
        case(alucontrol[1:0])
            2'b00 : result = a & b;
            2'b01 : result = a | b;
            2'b10 : result = sum;   // add or sub
            2'b11: result = {31'b0, sum[31]}; // SLT: sign of (a-b)
        endcase
    end
    assign zero = (result == 32'b0);

endmodule
