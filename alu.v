// Arquivo: alu.v
module alu (
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control, // Sinal que define a operação
    output [31:0] result,
    output zero              // Flag que é 1 se o resultado for zero
);

    reg [31:0] res_temp;

    always @(*) begin
        case (alu_control)
            4'b0010: res_temp = a + b;   // ADD
            4'b0110: res_temp = a - b;   // SUB
            4'b0111: res_temp = a & b;   // AND (Não usado pelo G30, mas comum)
            4'b0001: res_temp = a | b;   // OR (Não usado pelo G30, mas comum)
            4'b0100: res_temp = a ^ b;   // XOR
            4'b0101: res_temp = a >> b[4:0]; // SRL (Shift Right Logical)
            default: res_temp = 32'b0;
        endcase
    end

    assign result = res_temp;
    assign zero = (result == 32'b0);

endmodule