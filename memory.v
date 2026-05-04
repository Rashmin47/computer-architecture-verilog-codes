module Memory4x4(data_out,data_in,addr,we,clk);
  input clk,we;
  input [1:0] addr;
  input [3:0] data_in;
  output [3:0] data_out;
  reg [3:0] mem [3:0];
  always @(posedge clk)
  begin
      if(we)
          mem[addr] <= data_in;
  end
  assign data_out = mem[addr];
endmodule
//***Testbench Module***
module memory_tb;
reg clk,we;
reg [1:0] addr;
reg [3:0] data_in;
wire [3:0] data_out;
Memory4x4 uut(data_out,data_in,addr,we,clk);
initial
begin	
        $dumpfile("memory.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," clk=%b,we=%b,addr=%b,data_in=%b,data_out=%b",
                 clk,we,addr,data_in,data_out);	
	clk=0; we=1; addr=2'b00; data_in=4'b1010;
     #1 clk=1;
     #1 clk=0;
     #1 addr=2'b01; data_in=4'b1100;
     #1 clk=1;
     #1 clk=0;
     we=0;
     #1 addr=2'b00;
     #1 addr=2'b01;
     #10 $finish;
end
endmodule