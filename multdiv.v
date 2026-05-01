//=============================
// Unsigned 8-bit Multiplier
//=============================
module Multiplier8(
    input [8:0] A, B,
    output reg [16:0] Product
);
    integer i;
    always @(*) begin
        Product = 0;
        for(i=0;i<9;i=i+1)
            if(B[i]) Product = Product + (A << i);
    end
endmodule

//=============================
// Unsigned 8-bit Divider
//=============================
module Divider8(
    input [8:0] Dividend, Divisor,
    output reg [8:0] Quotient,
    output reg [8:0] Remainder
);
    integer i;
    reg [16:0] rem;
    always @(*) begin
        rem = Dividend; Quotient = 0;
        for(i=8;i>=0;i=i-1) begin
            if(rem >= (Divisor << i)) begin
                rem = rem - (Divisor << i);
                Quotient = Quotient | (1<<i);
            end
        end
        Remainder = rem[8:0];
    end
endmodule

//=============================
// Testbench
//=============================
module tb_MultDiv;
    reg [8:0] A, B;
    wire [16:0] Product;
    wire [8:0] Quotient, Remainder;

    Multiplier8 mult(.A(A), .B(B), .Product(Product));
    Divider8   div(.Dividend(A), .Divisor(B), .Quotient(Quotient), .Remainder(Remainder));

    initial begin
        $dumpfile("multdiv.vcd");
        $dumpvars(0, tb_MultDiv);

        A=8'd15; B=8'd3; #5;
        $display("%d * %d = %d", A,B,Product);
        $display("%d / %d = %d, Remainder=%d", A,B,Quotient,Remainder);

        A=8'd50; B=8'd7; #5;
        $display("%d * %d = %d", A,B,Product);
        $display("%d / %d = %d, Remainder=%d", A,B,Quotient,Remainder);

        $finish;
    end
endmodule
