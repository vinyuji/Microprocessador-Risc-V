module DataMemoria (
    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] addr,
    input  wire [31:0] writeData,
    output reg  [31:0] readData
);

    // 256 palavras de 32 bits
    reg [31:0] memory [0:255];


    always @(*) begin
        if (MemRead)
            readData = memory[addr[31:2]];
        else
            readData = 32'b0;
    end

    always @(posedge clk) begin
        if (MemWrite)
            memory[addr[31:2]] <= writeData;
    end

endmodule