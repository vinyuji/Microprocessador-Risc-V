module GeradorImediato(
    input  [31:0] instrucoes,
    output reg [31:0] imediato
);

    wire [6:0] opcode = instrucoes[6:0];

    always @(*) begin
        case(opcode)

            // I-type
            7'b0010011, 
            7'b0000011,
            7'b1100111: begin
                imediato = {{20{instrucoes[31]}}, instrucoes[31:20]};
            end

            // S-type
            7'b0100011: begin
                imediato = {{20{instrucoes[31]}},
                       instrucoes[31:25],
                       instrucoes[11:7]};
            end

            // B-type
            7'b1100011: begin
                imediato = {{19{instrucoes[31]}},
                       instrucoes[31],
                       instrucoes[7],
                       instrucoes[30:25],
                       instrucoes[11:8],
                       1'b0};
            end

            // U-type
            7'b0110111,
            7'b0010111: begin
                imediato = {instrucoes[31:12], 12'b0};
            end

            // J-type
            7'b1101111: begin
                imediato = {{11{instrucoes[31]}},
                       instrucoes[31],
                       instrucoes[19:12],
                       instrucoes[20],
                       instrucoes[30:21],
                       1'b0};
            end

            default: imediato = 32'b0;

        endcase
    end

endmodule