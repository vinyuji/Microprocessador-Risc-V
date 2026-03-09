module UnidadeJump (
    input  wire        jump,       
    input  wire        jalr,       
    input  wire [31:0] pc,
    input  wire [31:0] rs1,
    input  wire [31:0] imediato,
    output reg  [31:0] jumpTarget,
    output wire        link
);

    assign link = jump | jalr;  

    always @(*) begin
        if (jalr)
            jumpTarget = (rs1 + imediato) & 32'hFFFFFFFE;
        else if (jump)
            jumpTarget = pc + imediato;
        else
            jumpTarget = 32'b0; 
    end

endmodule