module Pc (
    input  wire        clk,
    input  wire        reset,
    input  wire        halt,
    input  wire        branch,
    input  wire        zero,
    input  wire        jump,       // JAL
    input  wire        jalr,       // JALR
    input  wire [31:0] immediate,
    input  wire [31:0] rs1,
    output reg  [31:0] pc
);

    reg [31:0] nextPc;

    always @(*) begin
        if (halt)
            nextPc = pc;
        else if (jalr)
            nextPc = rs1 + immediate;
        else if (jump)
            nextPc = pc + immediate;
        else if (branch && zero)
            nextPc = pc + immediate;
        else
            nextPc = pc + 32'd4;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'd0;
        else
            pc <= nextPc;
    end

endmodule