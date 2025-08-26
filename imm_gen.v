// Arquivo: imm_gen.v
module imm_gen (
    input [31:0] instruction,
    output [31:0] immediate
);

    wire [6:0] opcode = instruction[6:0];
    reg [31:0] imm_out;

    always @(*) begin
        case (opcode)
            // I-Type (addi, lw, srli)
            7'b0010011, 7'b0000011:
                imm_out = {{20{instruction[31]}}, instruction[31:20]};
            // S-Type (sw)
            7'b0100011:
                imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            // SB-Type (beq)
            7'b1100011:
                imm_out = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            default:
                imm_out = 32'b0;
        endcase
    end

    assign immediate = imm_out;

endmodule