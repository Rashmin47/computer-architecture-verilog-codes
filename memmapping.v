module MemoryMapping(data_out,data_in,addr,we,clk);
  input clk,we;
  input [2:0] addr;          // 3-bit address
  input [3:0] data_in;
  output [3:0] data_out;

  reg [3:0] mem0 [3:0];      // Memory block 0
  reg [3:0] mem1 [3:0];      // Memory block 1

  wire select;
  assign select = addr[2];   // MSB selects memory

  always @(posedge clk)
  begin
      if(we)
      begin
          if(select==0)
              mem0[addr[1:0]] <= data_in;
          else
              mem1[addr[1:0]] <= data_in;
      end
  end

  assign data_out = (select==0) ? 
                    mem0[addr[1:0]] : 
                    mem1[addr[1:0]];

endmodule


//***Testbench Module***
module memory_map_tb;

reg clk,we;
reg [2:0] addr;
reg [3:0] data_in;
wire [3:0] data_out;

MemoryMapping uut(data_out,data_in,addr,we,clk);

initial
begin	
        $dumpfile("memory_mapping.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," clk=%b,we=%b,addr=%b,data_in=%b,data_out=%b",
                 clk,we,addr,data_in,data_out);	

	clk=0; we=1;

	// Write in mem0 (addr MSB=0)
     addr=3'b000; data_in=4'b1010;
     #1 clk=1; #1 clk=0;

	// Write in mem1 (addr MSB=1)
     addr=3'b100; data_in=4'b1100;
     #1 clk=1; #1 clk=0;

	// Read from mem0
     we=0; addr=3'b000;
     #1;

	// Read from mem1
     addr=3'b100;
     #10 $finish;

end
endmodule