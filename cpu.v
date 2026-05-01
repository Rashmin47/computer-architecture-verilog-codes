`timescale 1ns/1ps

//====================================================
// Simple 8-bit CPU (Non-Pipelined)
//====================================================
module SimpleCPU(
    input clk,
    input rst,
    output [7:0] out
);

    reg [3:0] PC;                // Program Counter
    reg [7:0] IMEM [0:15];       // Instruction Memory
    reg [7:0] REG [0:3];         // Register File (R0-R3)
    reg [7:0] instr;             // Current Instruction

    integer i;

    // Program initialization
    initial begin
        IMEM[0] = 8'b10_00_00_01; // MOVI R0,1
        IMEM[1] = 8'b10_01_00_10; // MOVI R1,2
        IMEM[2] = 8'b00_00_01_00; // ADD R0,R1
        IMEM[3] = 8'b01_01_00_00; // SUB R1,R0
        IMEM[4] = 8'b11_00_00_00; // NOP
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC <= 0;
            instr <= 0;
            for (i = 0; i < 4; i = i + 1)
                REG[i] <= 0;
        end
        else begin
            // FETCH
            instr <= IMEM[PC];
            PC <= PC + 1;

            // DECODE + EXECUTE
            case (instr[7:6])
                2'b00: REG[instr[5:4]] <= REG[instr[5:4]] + REG[instr[3:2]]; // ADD
                2'b01: REG[instr[5:4]] <= REG[instr[5:4]] - REG[instr[3:2]]; // SUB
                2'b10: REG[instr[5:4]] <= instr[1:0];                       // MOVI
                default: ;                                                  // NOP
            endcase
        end
    end

    assign out = REG[0];  // Observe R0 in waveform

endmodule


//====================================================
// Testbench
//====================================================
module tb_SimpleCPU;

    reg clk;
    reg rst;
    wire [7:0] out;

    // Instantiate CPU
    SimpleCPU uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    // Clock (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_SimpleCPU);

        // Apply reset
        rst = 1;
        #12;
        rst = 0;

        // Let program run
        #100;

        $finish;
    end

endmodule
