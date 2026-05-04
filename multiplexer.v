module Mux4_1(out,s1,s0,i0,i1,i2,i3);
  input s1,s0,i0,i1,i2,i3;
  output out;
  assign out = (~s1 & ~s0 & i0) |
               (~s1 &  s0 & i1) |
               ( s1 & ~s0 & i2) |
               ( s1 &  s0 & i3);
endmodule
//***Testbench Module***
module mux4tb;
wire out;
reg s1,s0,i0,i1,i2,i3;
Mux4_1 uut(out,s1,s0,i0,i1,i2,i3);
initial
begin	
        $dumpfile("mux4.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," out=%b,s1=%b,s0=%b,i0=%b,i1=%b,i2=%b,i3=%b",
                 out,s1,s0,i0,i1,i2,i3);	
	i0=0; i1=1; i2=0; i3=1;
	s1=0; s0=0;
     #1 s1=0; s0=1;
     #1 s1=1; s0=0;
     #1 s1=1; s0=1;
     #10 $finish;
end
endmodule