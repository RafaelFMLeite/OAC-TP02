// Arquivo: instruction_memory.v
module instruction_memory (
    input [31:0] read_address,
    output [31:0] instruction
);

    // Memória para armazenar 256 instruções de 32 bits
    reg [31:0] memory [0:255];

    initial begin
        // Carrega o código de máquina do arquivo para a memória
        $readmemh("instructions.mem", memory);
    end

    // A leitura é combinacional. O endereço é em bytes, então dividimos por 4.
    assign instruction = memory[read_address[9:2]];

endmodule