module RiscV_CPU (
    input wire clk,
    input wire reset
);

    // ==============================
    // WIRES INTERNOS
    // ==============================

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] immediate;

    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] alu_result;
    wire [31:0] memory_read;

    wire RegWrite;
    wire ALUSrc;
    wire MemRead;
    wire MemWrite;
    wire MemToReg;
    wire Branch;
    wire Jump;
    wire jalr;

    wire [1:0] ALUOp;

    wire branchTaken;
    wire zero;

    // ==============================
    // PC
    // ==============================

    Pc pcouter (
        .clk(clk),
        .reset(reset),
        .halt(1'b0),
        .branch(branchTaken),
        .zero(zero),
        .jump(Jump),
        .jalr(jalr),
        .rs1(rs1_data),
        .immediate(immediate),
        .pc(pc)
    );

    // ==============================
    // Instruction Memory
    // ==============================

    MemoriaIntrucao imem (
        .addr(pc),
        .instrucao(instruction)
    );

    // ==============================
    // Control Unit
    // ==============================

    UnidadeControle control (
        .Opcode(instruction[6:0]),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    // ==============================
    // REGISTER FILE
    // ==============================

    wire [31:0] writeBackData;

    assign writeBackData = (MemToReg) ? memory_read : alu_result;

    Registradores regfile (
        .clk(clk),
        .regWrite(RegWrite),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .writeData(writeBackData),
        .readData1(rs1_data),
        .readData2(rs2_data)
    );

    // ==============================
    // IMMEDIATE GENERATOR
    // ==============================

    GeradorImediato immGen (
        .instrucoes(instruction),
        .imediato(immediate)
    );

    // ==============================
    // AluControl
    // ==============================

    ALUControl alu_control_unit (
        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .aluControl(aluControl)
    );

    // ==============================
    // ALU
    // ==============================

    wire [31:0] srcB;
    wire [3:0] aluControl;

    assign srcB = (ALUSrc) ? immediate : rs2_data;

    ALU alu (
        .A(rs1_data),
        .B(srcB),
        .ALUControl(aluControl),
        .Resultado(alu_result),
        .Zero(zero)
    );

    // ==============================
    // BRANCH UNIT
    // ==============================

    UnidadeBranch branch_unit (
        .branch(Branch),
        .funct3(instruction[14:12]),
        .rs1(rs1_data),
        .rs2(rs2_data),
        .branchTaken(branchTaken)
    );

    // ==============================
    // DATA MEMORY
    // ==============================

    DataMemoria dmem (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(alu_result),
        .writeData(rs2_data),
        .readData(memory_read)
    );

endmodule