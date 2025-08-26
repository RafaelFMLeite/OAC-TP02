// Arquivo: alu_control.v
module alu_control (
    input [1:0] alu_op,      // Sinal da Unidade de Controle principal
    input [2:0] funct3,      // Campo da instrução
    input funct7_bit5,     // Bit 30 da instrução (para SUB vs ADD)
    output reg [3:0] alu_signal // Sinal final para a ALU
);

    always @(*) begin
        case (alu_op)
            // lw, sw
            2'b00: alu_signal = 4'b0010; // ADD
            // beq
            2'b01: alu_signal = 4'b0110; // SUB
            // R-Type e I-Type (addi, srli, sub, xor)
            2'b10: begin
                case (funct3)
                    3'b000: alu_signal = funct7_bit5 ? 4'b0110 : 4'b0010; // SUB : ADD(i)
                    3'b100: alu_signal = 4'b0100; // XOR
                    3'b101: alu_signal = 4'b0101; // SRL(i)
                    default: alu_signal = 4'b0000; // NOP
                endcase
            end
            default: alu_signal = 4'b0000; // NOP
        endcase
    end
endmodule