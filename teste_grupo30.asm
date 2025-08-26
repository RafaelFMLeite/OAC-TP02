# Arquivo: teste_grupo30.asm
# Descrição: Código de teste para o processador RISC-V do Grupo 30.
# Instruções: addi, sw, lw, sub, xor, srl, beq

# --- Inicialização ---
addi x5, x0, 10      # x5 <- 10
addi x6, x0, 20      # x6 <- 20

# --- Armazenamento na Memória ---
sw x5, 0(x0)         # Memória[0] <- x5 (10)
sw x6, 4(x0)         # Memória[4] <- x6 (20)

# --- Leitura da Memória ---
lw x7, 0(x0)         # x7 <- Memória[0] (10)
lw x8, 4(x0)         # x8 <- Memória[4] (20)

# --- Operações Aritméticas e Lógicas ---
sub x9, x8, x7       # x9 <- x8 - x7 (20 - 10 = 10)
xor x10, x9, x5      # x10 <- x9 XOR x5 (10 XOR 10 = 0)
srl x11, x5, 1       # x11 <- x5 >> 1 (10 >> 1 = 5)

# --- Desvio Condicional ---
beq x10, x0, FIM     # Salta se 0 == 0 (condição verdadeira)

# --- Código de Erro (não deve ser executado) ---
addi x12, x0, 111    # x12 <- 111 (valor de erro)
sw x12, 8(x0)        # Memória[8] <- 111

FIM:
# Ponto final do programa.
beq x0, x0, FIM