// Arquivo: riscv_processor_top.v
module riscv_processor_top (
    input clk,
    input rst
);

    // Sinais e Fios
    wire reg_write, alu_src, mem_to_reg, mem_read, mem_write, branch, zero_flag, branch_control;
    wire [1:0] alu_op;
    wire [3:0] alu_control_signal;
    wire [31:0] pc_current, pc_next, pc_plus_4, pc_branch;
    wire [31:0] instruction, immediate;
    wire [31:0] reg_read_data1, reg_read_data2, alu_b_operand, alu_result;
    wire [31:0] mem_read_data, reg_write_data;

    // --- Lógica do PC (Program Counter) ---
    assign pc_plus_4 = pc_current + 4;
    assign pc_branch = pc_current + immediate;
    assign branch_control = branch & zero_flag;
    assign pc_next = branch_control ? pc_branch : pc_plus_4;

    // Registrador PC
    reg [31:0] pc_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) pc_reg <= 32'b0;
        else pc_reg <= pc_next;
    end
    assign pc_current = pc_reg;

    // --- Módulos Instanciados ---
    instruction_memory imem (
        .read_address(pc_current),
        .instruction(instruction)
    );

    control_unit ctrl (
        .opcode(instruction[6:0]),
        .branch(branch), .mem_read(mem_read), .mem_to_reg(mem_to_reg),
        .alu_op(alu_op), .mem_write(mem_write), .alu_src(alu_src), .reg_write(reg_write)
    );

    register_file rf (
        .clk(clk), .rst(rst), .reg_write_en(reg_write),
        .read_reg1(instruction[19:15]), .read_reg2(instruction[24:20]),
        .write_reg(instruction[11:7]), .write_data(reg_write_data),
        .read_data1(reg_read_data1), .read_data2(reg_read_data2)
    );

    imm_gen ig (
        .instruction(instruction),
        .immediate(immediate)
    );

    alu_control ac (
        .alu_op(alu_op), .funct3(instruction[14:12]), .funct7_bit5(instruction[30]),
        .alu_signal(alu_control_signal)
    );

    // MUX para a segunda entrada da ALU
    assign alu_b_operand = alu_src ? immediate : reg_read_data2;

    alu main_alu (
        .a(reg_read_data1), .b(alu_b_operand), .alu_control(alu_control_signal),
        .result(alu_result), .zero(zero_flag)
    );

    data_memory dmem (
        .clk(clk), .mem_write(mem_write), .mem_read(mem_read),
        .address(alu_result), .write_data(reg_read_data2),
        .read_data(mem_read_data)
    );

    // MUX para selecionar o dado a ser escrito no banco de registradores
    assign reg_write_data = mem_to_reg ? mem_read_data : alu_result;

endmodule