// Arquivo: data_memory.v
module data_memory (
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);

    // Memória de 64 palavras de 32 bits (256 Bytes)
    reg [31:0] memory [0:63];
    integer i;

    // Escrita síncrona
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[7:2]] <= write_data;
        end
    end
    
    // Zera a memória no início da simulação
    initial begin
      for (i=0; i < 64; i=i+1)
        memory[i] = 32'b0;
    end

    // Leitura combinacional
    assign read_data = mem_read ? memory[address[7:2]] : 32'b0;

endmodule