module ParityGenerator(p,a,b,c);
  input a,b,c;
  output p;
  assign p = a ^ b ^ c;   // Even parity
endmodule
module ParityChecker(error,a,b,c,p);
  input a,b,c,p;
  output error;
  assign error = a ^ b ^ c ^ p;   // 0 = No error, 1 = Error
endmodule
//***Testbench Module***
module parity_combined_tb;
wire p,error;
reg a,b,c;
ParityGenerator uut1(p,a,b,c);
ParityChecker  uut2(error,a,b,c,p);
initial
begin	
        $dumpfile("parity_combined.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," a=%b,b=%b,c=%b,p=%b,error=%b",a,b,c,p,error);	

	a=0; b=0; c=0;
     #1 a=0; b=0; c=1;
     #1 a=0; b=1; c=0;
     #1 a=0; b=1; c=1;
     #1 a=1; b=0; c=0;
     #1 a=1; b=1; c=1;
     #10 $finish;
end
endmodule