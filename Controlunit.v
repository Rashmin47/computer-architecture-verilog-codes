module ControlUnit(RegWrite,ALUSrc,ALUOp,opcode);
  input [1:0] opcode;
  output RegWrite,ALUSrc;
  output [1:0] ALUOp;
  assign RegWrite = (opcode==2'b00) ? 1 :
                    (opcode==2'b01) ? 1 :
                    (opcode==2'b10) ? 1 :
                    (opcode==2'b11) ? 1 : 0;
  assign ALUSrc = 0;   // Using register source
  assign ALUOp = (opcode==2'b00) ? 2'b00 :   // ADD
                 (opcode==2'b01) ? 2'b01 :   // SUB
                 (opcode==2'b10) ? 2'b10 :   // AND
                 (opcode==2'b11) ? 2'b11 :   // OR
                 2'b00;
endmodule
//***Testbench Module***
module control_tb;
wire RegWrite,ALUSrc;
wire [1:0] ALUOp;
reg [1:0] opcode;
ControlUnit uut(RegWrite,ALUSrc,ALUOp,opcode);
initial
begin	
        $dumpfile("control_unit.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," opcode=%b,RegWrite=%b,ALUSrc=%b,ALUOp=%b",
                 opcode,RegWrite,ALUSrc,ALUOp);	
	opcode=2'b00;   // ADD
     #1 opcode=2'b01;   // SUB
     #1 opcode=2'b10;   // AND
     #1 opcode=2'b11;   // OR
     #10 $finish;
end
endmodule