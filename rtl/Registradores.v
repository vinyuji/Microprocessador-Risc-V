module Registradores (
    input wire clk,
    input wire regWrite,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] writeData,
    output wire [31:0] readData1,
    output wire [31:0] readData2
);

    
    reg [31:0] registradores [0:31];

    integer i;

    // Inicializando
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registradores[i] = 32'd0;
    end

    // Leitura 
    assign readData1 = (rs1 == 5'd0) ? 32'd0 : registradores[rs1];
    assign readData2 = (rs2 == 5'd0) ? 32'd0 : registradores[rs2];

    // Escrita 
    always @(posedge clk) begin
        if (regWrite && rd != 5'd0)
            registradores[rd] <= writeData;
    end

endmodule
