module tb_cpu;

    reg clk;
    reg reset;

    RiscV_CPU cpu (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10;
        reset = 0;

        #500;
        $finish;
    end

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_cpu);
    end
    initial begin
        #500;
        $display("x1 = %d", cpu.regfile.registradores[1]);
        $display("x2 = %d", cpu.regfile.registradores[2]);
        $display("x3 = %d", cpu.regfile.registradores[3]);
        $display("x4 = %d", cpu.regfile.registradores[4]);
        $display("x5 = %d", cpu.regfile.registradores[5]);
        $display("O valor de fibonacci eh: %d", cpu.regfile.registradores[4]);
    end
endmodule