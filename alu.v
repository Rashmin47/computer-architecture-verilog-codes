module ALU4(result,carry,a,b,sel);
  input [3:0] a,b;
  input [1:0] sel;
  output [3:0] result;
  output carry;
  assign {carry,result} = (sel==2'b00) ? a + b :
                          (sel==2'b01) ? a - b :
                          (sel==2'b10) ? {1'b0,(a & b)} :
                          (sel==2'b11) ? {1'b0,(a | b)} :
                          5'b00000;
endmodule
//***Testbench Module***
module alu_tb;
wire [3:0] result;
wire carry;
reg [3:0] a,b;
reg [1:0] sel;
ALU4 uut(result,carry,a,b,sel);
initial
begin	
        $dumpfile("alu.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," a=%b,b=%b,sel=%b,result=%b,carry=%b",
                 a,b,sel,result,carry);	
	a=4'b0101; b=4'b0011;
	sel=2'b00;   // ADD
     #1 sel=2'b01;   // SUB
     #1 sel=2'b10;   // AND
     #1 sel=2'b11;   // OR
     #10 $finish;
end
endmodule