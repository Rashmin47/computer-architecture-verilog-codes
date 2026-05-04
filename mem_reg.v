
// 4-bit Register
module register4 (
    input clk,
    input reset,
    input load,
    input [3:0] d,
    output reg [3:0] q
);
always @(posedge clk or posedge reset)
begin
    if (reset)
        q <= 4'b0000;
    else if (load)
        q <= d;
end
endmodule
// 8x4 RAM
module memory8x4 (
    input clk,
    input we,
    input [2:0] addr,
    input [3:0] data_in,
    output reg [3:0] data_out
);
reg [3:0] mem [7:0];

always @(posedge clk)
begin
    if (we)
        mem[addr] <= data_in;   // Write
    else
        data_out <= mem[addr];  // Read
end
endmodule
// Testbench
module system_tb;
reg clk;
reg reset;
reg load;
reg we;
reg [2:0] addr;
reg [3:0] d;
wire [3:0] q;
wire [3:0] data_out;
// Instantiate Register
register4 U1 (
    .clk(clk),
    .reset(reset),
    .load(load),
    .d(d),
    .q(q)
);
// Instantiate Memory
memory8x4 U2 (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(q),     // Register output connected to memory input
    .data_out(data_out)
);
// Clock generation
always #5 clk = ~clk;
initial
begin
    $dumpfile("system.vcd");
    $dumpvars(0, system_tb);
    clk = 0;
    reset = 1;
    load = 0;
    we = 0;
    addr = 0;
    d = 0;
    #10 reset = 0;
    // Load data into register
    #10 load = 1; d = 4'b1010;
    #10 load = 0;
    // Write register data to memory location 3
    #10 we = 1; addr = 3'b011;
    #10 we = 0;
    // Read from memory location 3
    #10 addr = 3'b011;
    #20 $finish;
end
endmodule