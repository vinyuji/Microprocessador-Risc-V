module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] aluControl
);

always @(*) begin
    case(ALUOp)

        2'b00: aluControl = 4'b0000; // ADD (lw, sw, addi)

        2'b01: aluControl = 4'b0001; // SUB (branch)

        2'b10: begin
            case(funct3)

                3'b000: begin
                    if (funct7 == 7'b0100000)
                        aluControl = 4'b0001; // SUB
                    else
                        aluControl = 4'b0000; // ADD
                end

                3'b111: aluControl = 4'b0010; // AND
                3'b110: aluControl = 4'b0011; // OR
                3'b100: aluControl = 4'b0100; // XOR

                default: aluControl = 4'b0000;

            endcase
        end

        default: aluControl = 4'b0000;

    endcase
end

endmodule