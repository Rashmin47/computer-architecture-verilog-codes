module AddSub #(parameter N = 8)(
    input  signed [N-1:0] A,
    input  signed [N-1:0] B,
    input  SUB,                      // 0 = Add, 1 = Subtract
    output signed [N-1:0] Result,
    output Overflow
);
    wire signed [N-1:0] B_mod;
    wire signed [N:0] temp;
    // Modify B for subtraction (2's complement)
    assign B_mod = (SUB) ? (~B + 1'b1) : B;
    // Perform operation
    assign temp = A + B_mod;
    assign Result = temp[N-1:0];
    // Signed overflow detection
    assign Overflow = (A[N-1] == B_mod[N-1]) &&
                      (Result[N-1] != A[N-1]);
endmodule
// Testbench
module tb_AddSub;
    parameter N = 8;
    reg signed [N-1:0] A, B;
    reg SUB;
    wire signed [N-1:0] Result;
    wire Overflow;
    AddSub #(N) uut (
        .A(A),
        .B(B),
        .SUB(SUB),
        .Result(Result),
        .Overflow(Overflow)
    );

    initial begin
        $dumpfile("add_sub.vcd");
        $dumpvars(0, tb_AddSub);
        // Addition
        A = 20;  B = 10;  SUB = 0; #10;
        $display("ADD: A=%0d B=%0d Result=%0d Overflow=%b", A, B, Result, Overflow);
        A = 127; B = 1;   SUB = 0; #10;
        $display("ADD: A=%0d B=%0d Result=%0d Overflow=%b", A, B, Result, Overflow);
        // Subtraction
        A = 20;  B = 10;  SUB = 1; #10;
        $display("SUB: A=%0d B=%0d Result=%0d Overflow=%b", A, B, Result, Overflow);
        A = -128; B = 1;  SUB = 1; #10;
        $display("SUB: A=%0d B=%d Result=%0d Overflow=%b", A, B, Result, Overflow);
        #20;
        $finish;
    end
endmodule