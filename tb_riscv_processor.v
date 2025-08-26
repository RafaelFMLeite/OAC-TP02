// Arquivo: tb_riscv_processor.v
`timescale 1ns/1ps

module tb_riscv_processor;

    reg clk;
    reg rst;

    // Instancia o processador
    riscv_processor_top uut (
        .clk(clk),
        .rst(rst)
    );

    // Geração de Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock de 100MHz (período de 10ns)
    end

    // Processo de Simulação
    initial begin
        $display("--- Iniciando a Simulacao do RISC-V (Grupo 30) em Verilog ---");
        rst = 1;
        #20; // Mantém o reset por 20ns
        rst = 0;

        // O programa de teste tem 13 instruções.
        // Esperamos 15 ciclos (150ns) para garantir que termine, incluindo o loop final.
        #150;

        $display("\n--- Simulacao Concluida. Estado Final dos Registradores: ---");
        // Imprime o estado final dos 32 registradores
        for (integer i = 0; i < 32; i = i + 1) begin
            // Acessa hierarquicamente o banco de registradores dentro do UUT
            $display("Register[%2d]: %d (0x%h)", i, uut.rf.registers[i], uut.rf.registers[i]);
        end

        // Adicional: Exibir a memória de dados
        $display("\n--- Estado Final da Memoria de Dados (posicoes nao nulas) ---");
        for (integer j = 0; j < 10; j = j + 1) begin
            if (uut.dmem.memory[j] != 0) begin
                $display("Endereco[%2d]: %d", j*4, uut.dmem.memory[j]);
            end
        end

        $finish; // Termina a simulação
    end

endmodule