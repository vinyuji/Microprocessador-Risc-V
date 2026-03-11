module MemoriaIntrucao (
    input  wire [31:0] addr,          
    output wire [31:0] instrucao    
);

    // 256 instrucaes de 32 bits 
    reg [31:0] memoria [0:255];

    // Inicializacao 
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memoria[i] = 32'b0;

        $readmemh("Fibonacci.mem", memoria);
    end
    assign instrucao = memoria[addr[31:2]];

endmodule
