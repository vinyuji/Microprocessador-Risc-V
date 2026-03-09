module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    output reg [31:0] Resultado,
    output Zero
);

    always @(*) begin
        case(ALUControl)
            4'b0000: Resultado = A + B;               // ADD
            4'b0001: Resultado = A - B;               // SUB
            4'b0010: Resultado = A & B;               // AND
            4'b0011: Resultado = A | B;               // OR
            4'b0100: Resultado = A ^ B;               // XOR
            4'b0101: Resultado = (A < B) ? 1 : 0;     // SLT
            4'b0110: Resultado = A << B[4:0];         // SLL
            4'b0111: Resultado = A >> B[4:0];         // SRL
            4'b1000: Resultado = $signed(A) >>> B[4:0]; // SRA
            default: Resultado = 0;
        endcase
    end

    assign Zero = (Resultado == 0);

endmodule