// Arquivo: control_unit.v
module control_unit (
    input [6:0] opcode,
    output reg branch,       // BEQ
    output reg mem_read,     // lw
    output reg mem_to_reg,   // lw
    output reg [1:0] alu_op, // Para o Controle da ALU
    output reg mem_write,    // sw
    output reg alu_src,      // Seleciona entre registrador e imediato para a ALU
    output reg reg_write     // Habilita escrita no banco de registradores
);

    always @(*) begin
        // Valores padrão (para instruções não implementadas/NOP)
        branch = 0; mem_read = 0; mem_to_reg = 0; alu_op = 2'b00;
        mem_write = 0; alu_src = 0; reg_write = 0;

        case (opcode)
            // R-Type (sub, xor)
            7'b0110011: begin
                reg_write = 1;
                alu_src = 0;
                alu_op = 2'b10;
            end
            // I-Type (lw)
            7'b0000011: begin
                reg_write = 1;
                alu_src = 1;
                mem_read = 1;
                mem_to_reg = 1;
                alu_op = 2'b00;
            end
            // I-Type (addi, srli)
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1;
                alu_op = 2'b10; // Usa ALU Control para diferenciar
            end
            // S-Type (sw)
            7'b0100011: begin
                alu_src = 1;
                mem_write = 1;
                alu_op = 2'b00;
            end
            // SB-Type (beq)
            7'b1100011: begin
                branch = 1;
                alu_op = 2'b01;
            end
        endcase
    end
endmodule