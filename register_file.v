// Arquivo: register_file.v
module register_file (
    input clk,
    input rst,
    input reg_write_en,      // Habilita a escrita no registrador de destino
    input [4:0] read_reg1,   // Endereço do primeiro registrador a ser lido (rs1)
    input [4:0] read_reg2,   // Endereço do segundo registrador a ser lido (rs2)
    input [4:0] write_reg,   // Endereço do registrador de destino (rd)
    input [31:0] write_data, // Dado a ser escrito
    output [31:0] read_data1, // Dado lido de rs1
    output [31:0] read_data2  // Dado lido de rs2
);

    // Banco de 32 registradores de 32 bits
    reg [31:0] registers [0:31];
    integer i;

    // A escrita ocorre na borda de subida do clock (síncrona)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Zera todos os registradores no reset
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write_en && (write_reg != 5'b0)) begin
            // Escreve no registrador de destino se a escrita estiver habilitada
            // e o destino não for x0 (registrador zero)
            registers[write_reg] <= write_data;
        end
    end

    // As leituras são combinacionais (assíncronas)
    assign read_data1 = (read_reg1 == 5'b0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 5'b0) ? 32'b0 : registers[read_reg2];

endmodule