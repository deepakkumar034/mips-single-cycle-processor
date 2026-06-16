module tb_top;

    // -------------------------------------------------------
    // Inputs to DUT
    // -------------------------------------------------------
    reg clk, reset;

    // -------------------------------------------------------
    // Outputs for checking (expose from top)
    // -------------------------------------------------------
    wire [31:0] writedata, aluout;
    wire        memwrite;

    // -------------------------------------------------------
    // Instantiate system under test
    // -------------------------------------------------------
    top dut (
        .clk       (clk),
        .reset     (reset),
        .writedata (writedata),
        .aluout    (aluout),
        .memwrite  (memwrite)
    );

    // -------------------------------------------------------
    // Clock: toggle every 5ns → 10ns period = 100MHz
    // -------------------------------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // -------------------------------------------------------
    // VCD dump for GTKWave
    // -------------------------------------------------------
    initial begin
        $dumpfile("mips_tb.vcd");
        $dumpvars(0, tb_top);
    end

    // -------------------------------------------------------
    // Reset + run
    // -------------------------------------------------------
    initial begin
        $display("===========================================");
        $display("   Single-Cycle MIPS Testbench");
        $display("   Harris & Harris DDCA Chapter 7");
        $display("===========================================");

        // Hold reset for one full clock cycle
        reset = 1;
        @(posedge clk); #1;
        reset = 0;

        // Run for 200ns (20 clock cycles — enough for all instructions)
        #200;

        $display("===========================================");
        $display("   Simulation complete");
        $display("===========================================");
        $finish;
    end

    // -------------------------------------------------------
    // Self-checking: watch every SW instruction
    // Your program: sw $s4, 4($0)
    // $s4 = $s3 - $s2 = (5+12) - (-9) = 26 = 0x1a
    // So we expect: memwrite=1, aluout=4, writedata=0x1a
    // -------------------------------------------------------
    always @(negedge clk) begin
        if (memwrite) begin
            $display("[%0t ns] SW detected → Mem[0x%h] = 0x%h (%0d)",
                      $time, aluout, writedata, $signed(writedata));

            if (aluout === 32'h4 && writedata === 32'h1a)
                $display("        *** PASSED *** expected aluout=4, writedata=26");
            else
                $display("        *** FAILED *** got aluout=%0d writedata=%0d",
                          aluout, writedata);
        end
    end

    // -------------------------------------------------------
    // PC monitor — print every instruction fetch
    // -------------------------------------------------------
    always @(negedge clk) begin
        $display("[%0t ns] PC=0x%h  instr=0x%h  memwrite=%b",
                  $time,
                  dut.mips_cpu.pc,
                  dut.mips_cpu.instr,
                  memwrite);
    end

endmodule