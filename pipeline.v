module Pipeline4Stage(
    input clk, rst,
    input [7:0] instr_in,
    output [7:0] out
);
    reg [7:0] IF_ID, ID_EX, EX_WB;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            IF_ID <= 0;
            ID_EX <= 0;
            EX_WB <= 0;
        end else begin
            IF_ID <= instr_in;
            ID_EX <= IF_ID;
            EX_WB <= ID_EX;
        end
    end

    assign out = EX_WB;
endmodule


//=============================
// Testbench
//=============================
module tb_Pipeline4Stage;
    reg clk, rst;
    reg [7:0] instr_in;
    wire [7:0] out;

    Pipeline4Stage pipe(.clk(clk), .rst(rst), .instr_in(instr_in), .out(out));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("pipeline4.vcd");
        $dumpvars(0, tb_Pipeline4Stage);

        rst = 1; #10; rst = 0;

        instr_in = 8'd10; #10;
        instr_in = 8'd20; #10;
        instr_in = 8'd30; #10;
        instr_in = 8'd40; #10;

        $finish;
    end
endmodule
