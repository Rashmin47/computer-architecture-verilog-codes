
// 4-to-2 Encoder Module
module Encoder4to2 (
    input  [3:0] D,
    output reg [1:0] Y
);
always @(*) begin
    case (D)
        4'b0001: Y = 2'b00;
        4'b0010: Y = 2'b01;
        4'b0100: Y = 2'b10;
        4'b1000: Y = 2'b11;
        default: Y = 2'b00;   // invalid input
    endcase
end
endmodule
// 2-to-4 Decoder Module
module Decoder2to4 (
    input  [1:0] Y,
    output reg [3:0] D
);
always @(*) begin
    case (Y)
        2'b00: D = 4'b0001;
        2'b01: D = 4'b0010;
        2'b10: D = 4'b0100;
        2'b11: D = 4'b1000;
        default: D = 4'b0000;
    endcase
end
endmodule
// Testbench
module tb_EncoderDecoder;
    reg  [3:0] D_in;
    wire [1:0] Y_wire;
    wire [3:0] D_out;
    integer i;
    // Instantiate Encoder
    Encoder4to2 ENC (
        .D(D_in),
        .Y(Y_wire)
    );
    // Instantiate Decoder
    Decoder2to4 DEC (
        .Y(Y_wire),
        .D(D_out)
    );
    initial begin
        $dumpfile("encoder_decoder.vcd");
        $dumpvars(0, tb_EncoderDecoder);
        // Test all one-hot inputs
        for (i = 0; i < 4; i = i + 1) begin
            D_in = 4'b0001 << i;
            #10;
            $display("Input: %b | Encoded: %b | Decoded: %b",
                      D_in, Y_wire, D_out);
        end
        #10;
        $finish;
    end
endmodule