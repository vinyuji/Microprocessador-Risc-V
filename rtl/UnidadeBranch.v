module UnidadeBranch (
    input  wire        branch,
    input  wire [2:0]  funct3,
    input  wire [31:0] rs1,
    input  wire [31:0] rs2,
    output reg         branchTaken
);

    always @(*) begin
        branchTaken = 1'b0;

        if (branch) begin
            case (funct3)
                3'b000: branchTaken = (rs1 == rs2);                       // BEQ
                3'b001: branchTaken = (rs1 != rs2);                       // BNE
                3'b100: branchTaken = ($signed(rs1) < $signed(rs2));      // BLT
                3'b101: branchTaken = ($signed(rs1) >= $signed(rs2));     // BGE
                3'b110: branchTaken = (rs1 < rs2);                        // BLTU
                3'b111: branchTaken = (rs1 >= rs2);                       // BGEU
                default: branchTaken = 1'b0;
            endcase
        end
    end

endmodule