# Projeto: Processador RISC-V Simplificado - CSI211

Este repositório contém a implementação de um caminho de dados simplificado para a arquitetura RISC-V[cite: 7]. [cite_start]O projeto foi desenvolvido para a disciplina de Fundamentos de Organização e Arquitetura de Computadores (CSI211) do curso de Sistemas de Informação da Universidade Federal de Ouro Preto (UFOP)

O processador foi projetado para executar um subconjunto específico de instruções, incluindo `lw`, `sw`, `sub`, `xor`, `addi`, `srl` e `beq`.

## Estrutura do Repositório

O projeto está organizado nos seguintes arquivos:

* **`/` (Raiz)**
    * `teste_grupo30.asm`: O código de teste em linguagem Assembly.
    * `instructions.mem`: O código de máquina (em hexadecimal) traduzido do Assembly, que serve de entrada para o processador.
    * `initial_registers.txt`: Documentação do estado inicial (zerado) dos registradores.
    * `initial_data_memory.txt`: Documentação do estado inicial (zerado) da memória de dados.
    * `README.md`: Este arquivo.
* **`/verilog` (Código Fonte)**
    * `riscv_processor_top.v`: Módulo principal que conecta todos os componentes do datapath.
    * `control_unit.v`: Unidade de Controle principal que gera os sinais com base no opcode.
    * `alu_control.v`: Lógica que define a operação específica da ULA.
    * `alu.v`: Unidade Lógica e Aritmética que realiza os cálculos.
    * `register_file.v`: Banco com os 32 registradores.
    * `instruction_memory.v`: Módulo de memória que carrega o programa (`instructions.mem`).
    * `data_memory.v`: Módulo de memória para operações de load e store.
    * `imm_gen.v`: Gera os valores imediatos a partir da instrução.
    * `tb_riscv_processor.v`: O testbench responsável por simular o processador e verificar os resultados.

## Como Simular o Projeto

Para compilar e executar este projeto, você precisará de um simulador Verilog. Este guia utiliza o **Icarus Verilog (`iverilog`)**, uma ferramenta de código aberto e multiplataforma.

### Pré-requisitos

1.  **Icarus Verilog:** Certifique-se de que o `iverilog` está instalado e acessível no PATH do seu sistema.
2.  **Git:** Para clonar o repositório.

### Passos para Execução

1.  **Clone o Repositório**
    Abra um terminal e clone este repositório para a sua máquina local.
    ```sh
    git clone <URL_DO_SEU_REPOSITORIO>
    cd <NOME_DA_PASTA_DO_REPOSITORIO>
    ```

2.  **Compile todos os arquivos Verilog**
    Navegue até a pasta `verilog` e execute o comando de compilação abaixo. Este comando agrupa todos os módulos Verilog, começando pelo testbench, e cria um arquivo executável de simulação chamado `simulacao`.
    ```sh
    iverilog -o simulacao tb_riscv_processor.v riscv_processor_top.v control_unit.v alu_control.v alu.v register_file.v imm_gen.v instruction_memory.v data_memory.v
    ```
    *É fundamental que o arquivo `instructions.mem` esteja na mesma pasta onde este comando é executado.*

3.  **Execute a Simulação**
    Após a compilação bem-sucedida, execute o arquivo gerado usando o comando `vvp`.
    ```sh
    vvp simulacao
    ```

### Resultado Esperado

Se tudo ocorrer corretamente, a saída no seu terminal será idêntica à mostrada abaixo, exibindo o estado final dos registradores e da memória de dados após a execução do programa de teste.

```
--- Iniciando a Simulacao do RISC-V (Grupo 30) em Verilog ---

--- Simulacao Concluida. Estado Final dos Registradores: ---
Register[ 0]:          0 (0x00000000)
Register[ 1]:          0 (0x00000000)
Register[ 2]:          0 (0x00000000)
Register[ 3]:          0 (0x00000000)
Register[ 4]:          0 (0x00000000)
Register[ 5]:         10 (0x0000000a)
Register[ 6]:         20 (0x00000014)
Register[ 7]:         10 (0x0000000a)
Register[ 8]:         20 (0x00000014)
Register[ 9]:         10 (0x0000000a)
Register[10]:          0 (0x00000000)
Register[11]:          5 (0x00000005)
Register[12]:          0 (0x00000000)
Register[13]:          0 (0x00000000)
Register[14]:          0 (0x00000000)
Register[15]:          0 (0x00000000)
Register[16]:          0 (0x00000000)
Register[17]:          0 (0x00000000)
Register[18]:          0 (0x00000000)
Register[19]:          0 (0x00000000)
Register[20]:          0 (0x00000000)
Register[21]:          0 (0x00000000)
Register[22]:          0 (0x00000000)
Register[23]:          0 (0x00000000)
Register[24]:          0 (0x00000000)
Register[25]:          0 (0x00000000)
Register[26]:          0 (0x00000000)
Register[27]:          0 (0x00000000)
Register[28]:          0 (0x00000000)
Register[29]:          0 (0x00000000)
Register[30]:          0 (0x00000000)
Register[31]:          0 (0x00000000)

--- Estado Final da Memoria de Dados (posicoes nao nulas) ---
Endereco[ 0]:         10
Endereco[ 4]:         20
```
